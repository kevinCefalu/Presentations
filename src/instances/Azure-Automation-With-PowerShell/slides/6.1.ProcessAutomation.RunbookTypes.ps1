
. 'utilities\Get-WrappedText.ps1';
. 'utilities\Get-LineCount.ps1';

$AvailableLineCount = 34;
$DisplayTextLineCount = 0;

$DisplayText = @"
     _____                                             _                        _   _
    |  __ \                                 /\        | |                      | | (_)            _
    | |__) | __ ___   ___ ___  ___ ___     /  \  _   _| |_ ___  _ __ ___   __ _| |_ _  ___  _ __ (_)
    |  ___/ '__/ _ \ / __/ _ \/ __/ __|   / /\ \| | | | __/ _ \| '_ `` _ \ / _`` | __| |/ _ \| '_ \
    | |   | | | (_) | (_|  __/\__ \__ \  / ____ \ |_| | || (_) | | | | | | (_| | |_| | (_) | | | |_
    |_|   |_|  \___/ \___\___||___/___/ /_/    \_\__,_|\__\___/|_| |_| |_|\__,_|\__|_|\___/|_| |_(_)

    Summary:

      Azure Automation supports several types of runbooks. Tgey are as follows:
"@;

$RunbookTypes = @(
    @{
        Name = 'PowerShell & PowerShell Workflow';
        Description = @(
            'Text runbook written in Windows PowerShell & Windows PowerShell Workflow.'
        );
    },
    @{
        Name = 'Graphical & Graphical PowerShell Workflow';
        Description = @(
            'Based on Windows PowerShell & Windows PowerShell Workflow, created and',
            'edited completely in the graphical editor in Azure portal.'
        );
    },
    @{
        Name = 'Python';
        Description = @(
            'Text runbook written in Python.'
        );
    }
);

Write-Host $DisplayText -NoNewline;

$DisplayTextLineCount += $DisplayText.Split("`n").Count + 1;

Read-Host;

$DisplayText = @"
    Runbook Types:

"@;

for ($i = 0; $i -lt $RunbookTypes.Count; $i++)
{
    $Description = $RunbookTypes[$i].Description -join "`n$(' ' * 8)"
    $DisplayText += "`n$(' ' * 6)$($RunbookTypes[$i].Name):`n`n$(' ' * 8)$Description";

    Write-Host $DisplayText -NoNewline;

    $DisplayTextLineCount += $DisplayText.Split("`n").Count;
    $DisplayText = [String]::Empty;

    if ($i -lt ($RunbookTypes.Count - 1))
    {
        Read-Host | Out-Null;
    }
}

$DisplayText += "`n`n$(' ' * 4)References:`n`n";
$DisplayText += "$(' ' * 6)$('Runbook Types'.PadRight(35, ' ')) http://bit.ly/AzAcct-RunbookTypes`n";

Write-Host $DisplayText;

$DisplayTextLineCount += $DisplayText.Split("`n").Count;
Write-Host ("`n" * ($AvailableLineCount - $DisplayTextLineCount) + 'Press any key to continue...') -NoNewline;
Read-Host;
