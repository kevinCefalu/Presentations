
. "$PSScriptRoot\..\utilities\Get-LineCount.ps1";
. "$PSScriptRoot\..\utilities\Get-WrappedText.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideEnd.ps1";

function Write-SlideSection
{
    [CmdletBinding(DefaultParameterSetName = 'NotComplete')]
    [OutputType([int], ParameterSetName = 'NotComplete')]
    [OutputType([void], ParameterSetName = 'Complete')]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'NotComplete')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Complete')]
        [int] $Available,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'NotComplete')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Complete')]
        [int] $Used,

        [Parameter(ParameterSetName = 'NotComplete')]
        [Parameter(ParameterSetName = 'Complete')]
        [string] $Title,

        [Parameter(Mandatory, ParameterSetName = 'NotComplete')]
        [Parameter(Mandatory, ParameterSetName = 'Complete')]
        [string] $Text,

        [Parameter(ParameterSetName = 'NotComplete')]
        [Parameter(ParameterSetName = 'Complete')]
        [switch] $NoNewLine,

        [Parameter(ParameterSetName = 'NotComplete')]
        [Parameter(ParameterSetName = 'Complete')]
        [switch] $NoWait,

        [Parameter(Mandatory, ParameterSetName = 'Complete')]
        [switch] $Complete
    );

    if (-not [String]::IsNullOrEmpty($Title))
    {
        $Used += 3;
        Write-Host "${Title}:`n";
    }

    $Used += $Text | Get-LineCount;
    Write-Host $Text -NoNewline:($NoNewLine.IsPresent);

    if (-not $Complete.IsPresent)
    {
        if (-not $NoWait.IsPresent)
        {
            Read-Host | Out-Null;
        }
        else
        {
            $Used--;
            Write-Host;
        }

        return $Used;
    }
    else
    {
        ([PSCustomObject] @{
            Available = $Available;
            Used = $Used;
        }) | Write-SlideEnd;
    }
}
