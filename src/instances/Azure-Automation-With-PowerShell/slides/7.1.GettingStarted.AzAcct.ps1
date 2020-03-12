
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

    Create an Automation Account:


"@;

$Steps = @(
    'If you haven''t already, create a free Microsoft Azure account.',
    'After logging into Azure Portal, click "Create a Resource" and search for "Automation Accounts".',
    'Click the "Add" or "Create automation account" in the blade.',
    'Give the Automation Account a unique name.',
    'Select an Azure Subscription.',
    'Select, or create a new, resource group.',
    'Select an Azure Location.',
    'Decide whether you will require an "Azure Run As" account.',
    'Click the "Create" button and await Azure to notify you that the resources and group has been created.'
);

for ($i = 0; $i -lt $Steps.Count; $i++)
{
    $DisplayText += "$(' ' * 6)$($i + 1). $($Steps[$i])`n"
}

$DisplayText += "`n`n$(' ' * 6)References:`n`n";
$DisplayText += "$(' ' * 8)$('Name'.PadRight(35, ' ')) Value`n";
$DisplayText += "$(' ' * 8)$('----'.PadRight(35, ' ')) -----`n";
$DisplayText += "$(' ' * 8)$('Create a Microsoft Azure Account'.PadRight(35, ' ')) http://bit.ly/CreateAzureAccount`n";
$DisplayText += "$(' ' * 8)$('Run As Accounts'.PadRight(35, ' ')) http://bit.ly/AzAcct-RunAsAcct`n";

Write-Host $DisplayText -NoNewline;

$DisplayTextLineCount += $DisplayText.Split("`n").Count;
Write-Host ("`n" * ($AvailableLineCount - $DisplayTextLineCount) + 'Press any key to continue...') -NoNewline;
Read-Host;
