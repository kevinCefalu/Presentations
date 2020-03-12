
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

$Detail = 'Process automation includes runbook jobs and watchers. Billing for jobs is based on the number of job run time minutes used in the month and for watchers is based on the number of hours used in a month. Charges for process automation are incurred whenever a job or watcher runs. You will be billed only for minutes/hours that exceed the free included units.';

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
            Type = 'Job run time';
            IncludedUnits = '500 minutes';
            After = '$0.002 / minute';
        },
        [PSCustomObject] @{
            Type = 'Watchers';
            IncludedUnits = '744 hours';
            After = '$0.002 / hour';
        }
    );
};

$LineCounts.Used = ($LineCounts | Write-SlideSection -Text $SlideTitle -NoWait) + 1;

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Title ('Process Automation' | Get-IndentedText) `
    -Text ($Detail | Get-WrappedText -IncreaseIndentBy 2);

# TODO: Shouldn't have needed the '+ 1'
$LineCounts.Used = ($LineCounts | Write-SlideTable @Table -IndentBy 6) + 1;

$Detail = '* These free units are not available to subscribers using rate plans providing a flat discount or a fixed monthly credit amount.';

$LineCounts.Used = $LineCounts | Write-SlideSection `
    -Text ($Detail | Get-WrappedText -IncreaseIndentBy 4) `
    -Complete;
