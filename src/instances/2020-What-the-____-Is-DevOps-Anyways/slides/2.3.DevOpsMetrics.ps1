
. "$PSScriptRoot\..\utilities\Get-IndentedText.ps1";
. "$PSScriptRoot\..\utilities\Get-WrappedText.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideEnd.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideSection.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideTable.ps1";

$LineCounts = [PSCustomObject] @{
    Available = [Console]::WindowHeight - 7;
    Used = 0;
};

$SlideTitle = "
         _____              ____                __  __      _        _
        |  __ \            / __ \              |  \/  |    | |      (_)           _
        | |  | | _____   _| |  | |_ __  ___    | \  / | ___| |_ _ __ _  ___ ___  (_)
        | |  | |/ _ \ \ / / |  | | '_ \/ __|   | |\/| |/ _ \ __| '__| |/ __/ __|
        | |__| |  __/\ V /| |__| | |_) \__ \   | |  | |  __/ |_| |  | | (__\__ \  _
        |_____/ \___| \_/  \____/| .__/|___/   |_|  |_|\___|\__|_|  |_|\___|___/ (_)
                                 | |
                                 |_|
";

$LineCounts.Used = $LineCounts | Write-SlideSection -Text $SlideTitle;

$Summary = ('Throughput can be further defined by deployment frequency & lead time to iterations and bug fixes. While stability can be measured by time to recover. It is well-documented by the "State of DevOps" report that investing in DevOps practices and procedures has results that span the entire delivery pipeline:');

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Title ('An IT Departments efficacy can be measured by throughput & stability.' | Get-IndentedText -IndentBy 8) `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6);

$Summary = ('- Improved deployment frequency');

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6);

$Summary = ('- Faster time to market');

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6);

$Summary = ('- Lower Failure rates of new deployments');

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6);

$Summary = ('- Faster time of recovery from failures');

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6);

$Summary = ('- Shortened lead-time of bug fixes & new development');

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 6) `
    -Complete;
