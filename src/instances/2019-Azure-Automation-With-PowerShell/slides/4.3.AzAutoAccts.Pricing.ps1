
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

$Detail = 'Update management includes visibility and deployment of updates in your environment. There are no charges for the service, you only pay for log data stored in the Azure Log Analytics Service.';

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
        }
    );
};

$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle -NoWait) + 1;

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Title ('Update Management' | Get-IndentedText) `
    -Text ($Detail | Get-WrappedText -IncreaseIndentBy 2);

# TODO: Shouldn't have needed the '+ 1'
$LineCounts.Used = ($LineCounts | Write-SlideTable @Table -IndentBy 6) + 1;

$Detail = '* These free units are not available to subscribers using rate plans providing a flat discount or a fixed monthly credit amount.';

$LineCounts | Write-SlideSection `
    -Text ($Detail | Get-WrappedText -IncreaseIndentBy 4) -Complete;
