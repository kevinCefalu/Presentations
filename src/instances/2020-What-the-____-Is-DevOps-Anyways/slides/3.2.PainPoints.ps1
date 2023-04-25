
. "$PSScriptRoot\..\utilities\Get-IndentedText.ps1";
. "$PSScriptRoot\..\utilities\Get-WrappedText.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideEnd.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideSection.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideTable.ps1";

$LineCounts = [PSCustomObject] @{
    Available = [Console]::WindowHeight - 4;
    Used = 0;
};

$SlideTitle = "
         _____      _         _____      _       _
        |  __ \    (_)       |  __ \    (_)     | |        _
        | |__) |_ _ _ _ __   | |__) |__  _ _ __ | |_ ___  (_)
        |  ___/ _`` | | '_ \  |  ___/ _ \| | '_ \| __/ __|
        | |  | (_| | | | | | | |  | (_) | | | | | |_\__ \  _
        |_|   \__,_|_|_| |_| |_|   \___/|_|_| |_|\__|___/ (_)";

$SlideSections = @(
    [PSCustomObject] @{
        Detail = '- "Big Bang" releases';
    },
    [PSCustomObject] @{
        Detail = '- No experimentation due to infrequent releaqses';
    },
    [PSCustomObject] @{
        Detail = '- Shadown IT & One-Off contracts';
    },
    [PSCustomObject] @{
        Detail = '- Teams having their own incentives';
    },
    [PSCustomObject] @{
        Detail = '- Turnover and problems retaining talent';
    },
    [PSCustomObject] @{
        Detail = '- Repeated instances of the same issues (?!?!)';
    }
);

$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle -NoWait) + 1;

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ('What are the symptoms?' | Get-IndentedText -IncreaseIndentBy 8);

for ($i = 0; $i -lt $SlideSections.Count; $i++)
{
    $LineCounts.Used = ($LineCounts | Write-SlideSection `
        -Text ($SlideSections[$i].Detail | Get-WrappedText -IncreaseIndentBy 10) `
        -Complete:($i -eq ($SlideSections.Count - 1))) + 1;
}
