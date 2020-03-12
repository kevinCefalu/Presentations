
. "$PSScriptRoot\..\utilities\Get-IndentedText.ps1";
. "$PSScriptRoot\..\utilities\Get-WrappedText.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideEnd.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideSection.ps1";
. "$PSScriptRoot\..\utilities\Write-SlideTable.ps1";

$LineCounts = [PSCustomObject] @{
    Available = 34;
    Used = 0;
};

$SlideTitle = @"
                   _                        _   _                                                 _
        /\        | |                      | | (_)                 /\                            | |
       /  \  _   _| |_ ___  _ __ ___   __ _| |_ _  ___  _ __      /  \   ___ ___ ___  _   _ _ __ | |_ ___
      / /\ \| | | | __/ _ \| '_ `` _ \ / _`` | __| |/ _ \| '_ \    / /\ \ / __/ __/ _ \| | | | '_ \| __/ __|
     / ____ \ |_| | || (_) | | | | | | (_| | |_| | (_) | | | |  / ____ \ (_| (_| (_) | |_| | | | | |_\__ \
    /_/    \_\__,_|\__\___/|_| |_| |_|\__,_|\__|_|\___/|_| |_| /_/    \_\___\___\___/ \__,_|_| |_|\__|___/

    Benefits:
"@;

$SlideSections = @(
    [PSCustomObject] @{
        Header = 'Save Time & Lower Overhead Costs';
        Detail = 'Automate all of those frequent, time-consuming, & error-prone cloud management tasks. Azure Automation Accounts help you focus on work that adds bisuness value. By reducing errors & boosting efficiency, it also helps to lower your operational costs.';
    },
    [PSCustomObject] @{
        Header = 'Update Windows & Linux Systems Across Hybrid Environments';
        Detail = 'Monitor update compliance across Azure, on-premise, & other cloud platforms for Windows & Linux. Schedule deployments to orchestrate the installation of updates within a defined maintenance window.';
    },
    [PSCustomObject] @{
        Header = 'Simplify Configuration Management in the Cloud';
        Detail = 'Author & manage PowerShell configurations, import configuration scripts, & generate node configurations in the cloud. Use Azure Configuration Management to monitor & automatically update machine configuration across physical & virtual machines, windows, or Linux - in the cloud and on-premise.';
    }
);

$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle) + 1;

for ($i = 0; $i -lt $SlideSections.Count; $i++)
{
    $LineCounts.Used = $LineCounts | Write-SlideSection `
        -Title ($SlideSections[$i].Header | Get-IndentedText -IncreaseIndentBy 2) `
        -Text ($SlideSections[$i].Detail | Get-WrappedText -IncreaseIndentBy 4) `
        -Complete:($i -eq ($SlideSections.Count - 1));
}
