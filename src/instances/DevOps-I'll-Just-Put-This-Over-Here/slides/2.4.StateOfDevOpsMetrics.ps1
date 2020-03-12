
. "$PSScriptRoot\..\utilities\Get-IndentedText.ps1";
. "$PSScriptRoot\..\utilities\Get-WrappedText.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideEnd.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideSection.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideTable.ps1";

$LineCounts = [PSCustomObject] @{
    Available = [Console]::WindowHeight - 6;
    Used = 0;
};

$SlideTitle = "
         ______ _ _ _           _____           __
        |  ____| (_) |         |  __ \         / _|                                    _
        | |__  | |_| |_ ___    | |__) |__ _ __| |_ ___  _ __ _ __ ___   ___ _ __ ___  (_)
        |  __| | | | __/ _ \   |  ___/ _ \ '__|  _/ _ \| '__| '_ `` _ \ / _ \ '__/ __|
        | |____| | | ||  __/   | |  |  __/ |  | || (_) | |  | | | | | |  __/ |  \__ \  _
        |______|_|_|\__\___|   |_|   \___|_|  |_| \___/|_|  |_| |_| |_|\___|_|  |___/ (_)
";

$LineCounts.Used = $LineCounts | Write-SlideSection -Text $SlideTitle;

$Summary = ('The State of DevOps report defines a grouping of "Elite Performers." Those companies that set the curve by out-performing everyone else. This group unilaterally employ DevOps practices with a devotion that lead researchers to believe that DevOps is the secret to their success, and the metrics are STUNNING:');

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Title ('Elite Performers' | Get-IndentedText -IndentBy 8) `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6);

$Summary = ('- 2604x Faster Recovery');

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6);

$Summary = ('- 46x More Frequent Releases');

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6);

$Summary = ('- 1.53x more instances of meeting or exceeding defined business goals');

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6);

$Summary = ('- 1.8x More internal recruitment & team recommendations');

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6) `
    -Complete;
