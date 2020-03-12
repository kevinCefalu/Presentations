
function Test-PSPipe
{
    <#
        .SYNOPSIS
            Tests if a pipe is open.

        .DESCRIPTION
            Tests if a pipe is open.

        .INPUTS
            Name of pipe to test if open or not.

        .PARAMETER Name
            Name of pipe to test if open or not.

        .OUTPUTS
            Returns $true if pipe is active or $false if its not.

        .EXAMPLE
            C:\> Test-PSPipe -Name "TestPipe"

        .EXAMPLE
            c:\> "TestPSPipe" | Test-Pipe
    #>

    [CmdletBinding()]
    [OutputType([bool])]

    param (
        [Parameter(
            Mandatory,
            ValueFromPipeline
        )]
        [string] $Name
    );

    process
    {
        return ($null -ne (Get-PSPipes).
            Where({ $_.Name -eq $Name }));
    }
}

function New-PSPipe
{
    <#
        .SYNOPSIS
            Creates a new named pipe.

        .DESCRIPTION
            Creates a named pipe and waits for a client to connect.

        .PARAMETER Name
            Name to give to pipe.

        .OUTPUTS
            Custom pipe object that can be passed to other cmdlets in this module.

        .EXAMPLE
            $pipe = new-PSPipe -Name
    #>

    [CmdletBinding()]
    [OutputType([PSCustomObject])]

    param (
        [Parameter(Mandatory)]
        [string] $Name
    );

    process
    {
        Write-Verbose "Creating pipe server for pipe named $Name";

        $RD = [PSCustomObject] @{
            Pipe = [IO.Pipes.NamedPipeServerStream]::new(
                $Name, [IO.Pipes.PipeDirection]::InOut);
            Name = $Name;
            Reader = $null;
            Writer = $null;
        };

        Write-Verbose 'Waiting for client to connect...';

        $RD.Pipe.WaitForConnection();

        Write-Verbose 'Client connect.';

        $RD.Reader = [IO.StreamReader]::new($RD.Pipe);
        $RD.Writer = [IO.StreamWriter]::new($RD.Pipe);
        $RD.Writer.AutoFlush = $true;

        Write-Verbose 'Attached Stream writer and reader';
        Write-Verbose 'Pipe ready!';

        return $RD;
    }
}

function Write-PSPipe
{
    <#
        .SYNOPSIS
            Writes a PSObject to pipe.

        .DESCRIPTION
            Serialises a PSObject and sends it over a pipe. PSObject will be
            reconstructed with Read-PSPipe.

        .INPUTS
            PSObject to be serialised.

            Note: Usual psobject serialisation requirements apply.

        .PARAMETER Object
            Object to be seriealised.

        .PARAMETER Pipe
            Pipe object to write the object to. This can be created by
            New-PSPipe or Connect-PSPipe.

        .EXAMPLE
            C:\> "Hi how are you?" | Write-PSPipe -Pipe $pipe

        .EXAMPLE
            C:\> Write-PSPipe -Object (Get-Process) -Pipe $pipe
    #>

    [CmdletBinding()]
    [OutputType([void])]

    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [object] $Object,

        [Parameter(Mandatory)]
        [object] $Pipe
    );

    process
    {
        $Pipe.Writer.WriteLine((
            $Object | ConvertTo-Base64
        ));
    }
}

function Read-PSPipe
{
    <#
        .SYNOPSIS
            Reads a PSObject from a pipe.

        .DESCRIPTION
            deserialises psobject from a pipe and returns it.
            Note: Usual psobject serialisation requirements apply.

        .PARAMETER Pipe
            The pipe object to retrive the object from. If no pipe object exists in pipe powershell will wait.

        .OUTPUTS
            PSObject deseriealised from pipe.

        .EXAMPLE
            C:\> $Data = Read-PSPipe -Pipe $Pipe
    #>

    [CmdletBinding()]
    [OutputType([string])]

    param (
        [Parameter(Mandatory)]
        [object] $Pipe
    );

    process
    {
        return ($Pipe.Reader.ReadLine() | ConvertFrom-Base64);
    }
}

function Disconnect-PSPipe
{
    <#
        .SYNOPSIS
            Closes pipe.

        .DESCRIPTION
            Closes a pipe connection. Works on pipes created by either
            New-PSPipe or Connect-PSPipe
    #>

    [CmdletBinding()]
    [OutputType([void])]

    param (
        [Parameter(
            Mandatory,
            ValueFromPipeline
        )]
        [object] $Object
    );

    process
    {
        $Object.Pipe.Dispose();
    }
}

function Connect-PSPipe
{
    <#
        .SYNOPSIS
            Connects to an existing pipe.

        .DESCRIPTION
            Connects to an existing pipe created by New-PSPipe.
            Warning: Do not connect to other processes pipes or
                     you will get unexpected results.

        .PARAMETER Name
            Name of the pipe to connect to.
            Note: You don't need to pass in the full path. For pipe
                  \\.\pipes\mypipe you would only need to pass in mypipe.

        .PARAMETER ComputerName
            The name of the computer you want to connect to. If not specified
            localhost is used.

        .OUTPUTS
            Returns a customobject which can be used with Read-PSPipe and
            Write-PSPipe to interact with the pipe.

        .EXAMPLE
            C:\> $pipe = Connect-PSPipe -Name MyPipe

        .EXAMPLE
            C:\> $pipe = Connect-PSPipe -Name MyPipe -ComputerName RemoteHost01
    #>

    [CmdletBinding()]

    param (
        [Parameter(Mandatory)]
        [string] $Name,

        [Parameter()]
        [string] $ComputerName = "."
    );

    process
    {
        $RD = [pscustomobject] @{
            Pipe = [IO.Pipes.NamedPipeClientStream]::new(
                $ComputerName, $Name, [IO.Pipes.PipeDirection]::InOut,
                [IO.Pipes.PipeOptions]::None,
                [Security.Principal.TokenImpersonationLevel]::Impersonation
            );
            Name = $PipeName;
            Reader = $null;
            Writer = $null;
        }

        $RD.Pipe.Connect()
        $RD.Reader = new-object IO.StreamReader($RD.Pipe)
        $RD.Writer = New-Object IO.StreamWriter($RD.Pipe)
        $RD.Writer.AutoFlush = $true
        $RD
    }
}

function Get-PSPipe
{
    <#
        .SYNOPSIS
            Returns current active pipes on the

        .DESCRIPTION
            Returns a list of open pipes on the  This includes pipes opened
            by other processes.

        .OUTPUTS
            Custom objects that contain the name of the pipe and its path.

        .EXAMPLE
            C:\> Get-PSPipe
    #>

    [CmdletBinding()]

    param ();

    process
    {
        $Pipes = [IO.Directory]::GetFiles("\\.\pipe\");

        foreach ($Pipe in $Pipes)
        {
            [PSCustomObject] @{
                Name = $Pipe.Replace("\\.\pipe\", "");
                Path = $Pipe;
            }
        }
    }
}

function ConvertTo-Base64
{
    <#
        .SYNOPSIS
            Converts a PSObject ot Base64 string.

        .DESCRIPTION
            This function is used internally by the module to convert a
            psobject to a base64 string.

        .INPUTS
            PSObject to serialise.

        .PARAMETER Object
            PSObject to serailise

        .OUTPUTS
            A base64 string that can be deserialised by ConvertFrom-Base64
            back into a psobject.

        .EXAMPLE
            C:\> $Text = Get-Process | ConvertTo-Base64
    #>

    [CmdletBinding()]
    [OutputType([string])]

    param (
        [Parameter(
            Mandatory,
            ValueFromPipeline
        )]
        [object] $Object
    );

    process
    {
        $Data = $Object | ConvertTo-Json -Compress;
        $Bytes = [Text.Encoding]::Unicode.GetBytes($Data);

        return [Convert]::ToBase64String($Bytes);
    }
}

function ConvertFrom-Base64
{
    <#
        .SYNOPSIS
            Converts Base64 string back into a PSObject.

        .DESCRIPTION
            Converts string created by ConvertTo-Base64 back into its
            deserialised PSObject.

        .PARAMETER Text
            Base64 encoded string of PSObject created by ConvertTo-Base64.

        .INPUTS
            Base64 encoded string of PSObject created by ConvertTo-Base64.

        .OUTPUTS
            object

        .EXAMPLE
            C:\> $myvar = $Text | ConvertFrom-Base64
    #>

    [CmdletBinding()]
    [OutputType([object])]

    param (
        [Parameter(
            Mandatory,
            ValueFromPipeline
        )]
        [string] $Text
    );

    process
    {
        $JSON = [Text.Encoding]::Unicode.GetString(
            [Convert]::FromBase64String($Text)
        );

        return $JSON | ConvertFrom-Json;
    }
}

<#
Export-ModuleMember Connect-PSPipe
Export-ModuleMember ConvertFrom-Base64
Export-ModuleMember ConvertTo-Base64
Export-ModuleMember Disconnect-PSPipe
Export-ModuleMember Get-PSPipe
Export-ModuleMember New-PSPipe
Export-ModuleMember Read-PSPipe
Export-ModuleMember Test-Pipe
Export-ModuleMember Write-PSPipe
#>
