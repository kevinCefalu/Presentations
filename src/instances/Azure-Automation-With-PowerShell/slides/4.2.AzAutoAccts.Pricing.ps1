
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
     _____      _      _               _____       _        _ _
    |  __ \    (_)    (_)             |  __ \     | |      (_) |    _
    | |__) | __ _  ___ _ _ __   __ _  | |  | | ___| |_ __ _ _| |___(_)
    |  ___/ '__| |/ __| | '_ \ / _`` | | |  | |/ _ \ __/ _`` | | / __|
    | |   | |  | | (__| | | | | (_| | | |__| |  __/ || (_| | | \__ \_
    |_|   |_|  |_|\___|_|_| |_|\__, | |_____/ \___|\__\__,_|_|_|___(_)
                                __/ |
                               |___/
"@;

$DetailPart1 = 'Configuration management includes the configuration pull service and change tracking capabilities. Billing is based on the number of nodes that are registered with the service and the log data stored in the Azure Log Analytics service.';

$DetailPart2 = 'Charges for configuration management start when a node is registered with the service and stop when the node is unregistered from the service. A node is any machine whose configuration is managed by configuration management. This could be an Azure VM, on-premise VM, physical host, or a VM in another public cloud. Billing for nodes is prorated hourly.';

$Table = @{
    Title = 'Pricing Information';
    Headers = @(
        [PSCustomObject] @{
            Display = 'Type';
            MapTo = 'Type';
        },
        [PSCustomObject] @{
            Display = 'Free Units Included (Per Month)*';
            MapTo = 'IncludedUnits';
        },
        [PSCustomObject] @{
            Display = 'Price';
            MapTo = 'After';
        }
    );
    Rows = @(
        [PSCustomObject] @{
            Type = 'Azure Node';
            IncludedUnits = 'N/A';
            After = 'Free';
        },
        [PSCustomObject] @{
            Type = 'Non-Azure Node';
            IncludedUnits = '5 nodes';
            After = '$6.00 / node';
        }
    );
};

$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle -NoWait) + 1;

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Title ('Configuration Management' | Get-IndentedText) `
    -Text ($DetailPart1 | Get-WrappedText -IncreaseIndentBy 2);

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ($DetailPart2 | Get-WrappedText -IncreaseIndentBy 2);

# TODO: Shouldn't have needed the '+ 2'
$LineCounts.Used = ($LineCounts | Write-SlideTable @Table -IndentBy 6) + 2;

$Detail = '* These free units are not available to subscribers using rate plans providing a flat discount or a fixed monthly credit amount.';

$LineCounts | Write-SlideSection `
    -Text ($Detail | Get-WrappedText -IncreaseIndentBy 4) -Complete;
