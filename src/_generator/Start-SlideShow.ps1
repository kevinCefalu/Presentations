
[CmdletBinding(DefaultParameterSetName = 'UsingPSCore')]

param (
    [Parameter(Mandatory, ParameterSetName = 'UsingPSv5')]
    [switch] $PSv5,

    [Parameter()]
    [object[]] $Arguments = @('-NoProfile'),

    [Parameter()]
    [switch] $DontMaximize
);

$StartProcessParameters = @{
    ArgumentList = $Arguments
    FilePath = if ($PSv5.IsPresent) { 'PowerShell' } else { 'PwSh' }
    PassThru = $true
};

if (-not $DontMaximize.IsPresent)
{
    $StartProcessParameters.WindowStyle = 'Maximized'
}

$PresentationProcess = start-process $StartProcessParameters;
