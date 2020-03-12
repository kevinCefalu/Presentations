
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
        Header = 'Collect Inventory & Track Changes';
        Detail = 'Get an inventory of operating system resources including installed applications & other configuration items. Use rich reporting & search to quickly find detailed information on everything that''s configured within the operating system. Track changes across services, daemons, software, registry, & files to promptly investigate issues and turn on diagnostics & alerting to monitor for unwanted changes.';
    },
    [PSCustomObject] @{
        Header = 'Integrate with the Services you depend on';
        Detail = 'Write runbooks graphically, in PowerShell or in Python to integrate Azure services & other public systems required for deploying, configuring, & managing your end-to-end processes. Orchestrate across on-premise & cloud environments using a hybrid runbook worker to deliver on-demand services. Trigger automation from ITSM, DevOps, & monitoring systems to fulfill requests & ensure continuous deliver & management.';
    }
);

# TODO: Shouldn't needed to have bumped this to '+ 2'
$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle -NoWait) + 2;

for ($i = 0; $i -lt $SlideSections.Count; $i++)
{
    $LineCounts.Used = $LineCounts | Write-SlideSection `
        -Title ($SlideSections[$i].Header | Get-IndentedText -IncreaseIndentBy 2) `
        -Text ($SlideSections[$i].Detail | Get-WrappedText -IncreaseIndentBy 4) `
        -Complete:($i -eq ($SlideSections.Count - 1));
}
