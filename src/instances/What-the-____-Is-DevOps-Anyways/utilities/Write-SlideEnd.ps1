
function Write-SlideEnd
{
    [OutputType([void])]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int] $Available,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int] $Used,

        [Parameter()]
        [string] $Text = 'Press any key to continue...',

        [Parameter()]
        [switch] $NewLine
    );

    Write-Host ("`n" * ($Available - $Used) + $Text) -NoNewline:$(-not $NewLine.IsPresent);

    Read-Host;
}
