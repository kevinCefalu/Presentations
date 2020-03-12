
. 'utilities\Get-WrappedText.ps1';
. 'utilities\Get-LineCount.ps1';

$AvailableLineCount = 34;
$DisplayTextLineCount = 0;

$DisplayText = @"
      _____      _   _   _                _____ _             _           _
     / ____|    | | | | (_)              / ____| |           | |         | |
    | |  __  ___| |_| |_ _ _ __   __ _  | (___ | |_ __ _ _ __| |_ ___  __| |
    | | |_ |/ _ \ __| __| | '_ \ / _`` |  \___ \| __/ _`` | '__| __/ _ \/ _`` |
    | |__| |  __/ |_| |_| | | | | (_| |  ____) | || (_| | |  | ||  __/ (_| |
     \_____|\___|\__|\__|_|_| |_|\__, | |_____/ \__\__,_|_|   \__\___|\__,_|
                                 __/  |
                                |____/

    Create a Runbook:


"@;

$Steps = @(
    'Open your Automation account and click "Runbooks" under "Process Automation."',
    'Click the "Create a runbook" in the runbooks blade.',
    'Give the runbook a name.',
    'Select a runbook type.',
    'Give the runbook a description (optional).',
    'Click "Create" and await Azure to navigate you to the "Edit Runbook" blade.',
    'Edit your runbook and click "Save". You can also test the runbook from this blade.',
    'Click "Publish" to make your runbook available for execution.'
);

for ($i = 0; $i -lt $Steps.Count; $i++)
{
    $DisplayText += "$(' ' * 6)$($i + 1). $($Steps[$i])`n"
}

$DisplayText += "`n`n$(' ' * 6)References:`n`n";
$DisplayText += "$(' ' * 8)$('Name'.PadRight(35, ' ')) Value`n";
$DisplayText += "$(' ' * 8)$('----'.PadRight(35, ' ')) -----`n";
$DisplayText += "$(' ' * 8)$('Create a Runbook'.PadRight(35, ' ')) http://bit.ly/AzAccount-CreateRunbook`n";
$DisplayText += "$(' ' * 8)$('Start a Runbook'.PadRight(35, ' ')) http://bit.ly/AzAccount-StartRunbook`n";

Write-Host $DisplayText -NoNewline;

$DisplayTextLineCount += $DisplayText.Split("`n").Count;
Write-Host ("`n" * ($AvailableLineCount - $DisplayTextLineCount) + 'Press any key to continue...') -NoNewline;
Read-Host;
