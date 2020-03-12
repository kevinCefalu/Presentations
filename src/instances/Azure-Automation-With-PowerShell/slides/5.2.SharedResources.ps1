
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
      _____ _                        _   _____
     / ____| |                      | | |  __ \                                        _
    | (___ | |__   __ _ _ __ ___  __| | | |__) |___  ___  ___  _   _ _ __ ___ ___  ___(_)
     \___ \| '_ \ / _`` | '__/ _ \/ _`` | |  _  // _ \/ __|/ _ \| | | | '__/ __/ _ \/ __|
     ____) | | | | (_| | | |  __/ (_| | | | \ \  __/\__ \ (_) | |_| | | | (_|  __/\__ \_
    |_____/|_| |_|\__,_|_|  \___|\__,_| |_|  \_\___||___/\___/ \__,_|_|  \___\___||___(_)
"@;

$Summary = 'Azure Automation consists of a set of shared resources that make it easier to automate and configure your environments at scale.';

$SlideSections = @(
    [PSCustomObject] @{
        Header = 'Python 2 Packages';
        Detail = 'Add Python 2 packages to your automation account to use in your Python runbooks.';
    },
    [PSCustomObject] @{
        Header = 'Credentials';
        Detail = 'Securely store sensitive information that can be used by runbooks and configurations at runtime.';
    },
    [PSCustomObject] @{
        Header = 'Connections';
        Detail = 'Store a name / value pairs of information that contains common information when connecting to systems in connection resources. Connections are defined by the module author for use at runtime in runbooks and configurations.';
    }
);

$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle -NoWait) + 1;

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Title ('Summary' | Get-IndentedText) `
    -Text ($Summary | Get-WrappedText -IncreaseIndentBy 2);

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ('Shared Resources:' | Get-IndentedText);

for ($i = 0; $i -lt $SlideSections.Count; $i++)
{
    $LineCounts.Used = ($LineCounts | Write-SlideSection `
        -Title ($SlideSections[$i].Header | Get-IndentedText -IncreaseIndentBy 2) `
        -Text ($SlideSections[$i].Detail | Get-WrappedText -IncreaseIndentBy 4) `
        -Complete:($i -eq ($SlideSections.Count - 1))) + 1;
}
