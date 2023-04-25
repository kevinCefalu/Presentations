
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
         _____              ____
        |  __ \            / __ \             _
        | |  | | _____   _| |  | |_ __  ___  (_)
        | |  | |/ _ \ \ / / |  | | '_ \/ __|
        | |__| |  __/\ V /| |__| | |_) \__ \  _
        |_____/ \___| \_/  \____/| .__/|___/ (_)
                                 | |
                                 |_|
";

$LineCounts.Used = $LineCounts | Write-SlideSection -Text $SlideTitle;

$Summary = (
    'Put simply, DevOps is the inter-team "bridge" between Development and ' +
    'Operations. DevOps was conceptualized by Patrick Dubois in 2008, during a ' +
    'discussion regarding agile infrastructure with Andrew Clay Shafer.'
);

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6);

$Summary = (
    'By 2009, the idea had begun to take root thanks to the first "DevOpsDays" ' +
    'conference in Belguim. In 2012 the "State of DevOps" report was created by ' +
    'Alanna Brown, to track the performance of companies, based on their usage ' +
    'of these newly-founded ideals. It has since been published by several ' +
    'notable IT visionaries like Dr. Nicole Foregram, Gene Kim, Jez Humble, and ' +
    'many others.'
);

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6) `
    -Complete;
