
. 'utilities\Get-WrappedText.ps1';
. 'utilities\Get-LineCount.ps1';

$AvailableLineCount = 34;
$DisplayTextLineCount = 0;

$DisplayText = @"
      ____                  _   _                ___
     / __ \                | | (_)              |__ \
    | |  | |_   _  ___  ___| |_ _  ___  _ __  ___  ) |
    | |  | | | | |/ _ \/ __| __| |/ _ \| '_ \/ __|/ /
    | |__| | |_| |  __/\__ \ |_| | (_) | | | \__ \_|
     \___\_\\__,_|\___||___/\__|_|\___/|_| |_|___(_)

    ================================================================
    ================================================================

    __          __        _           _____ _ _           _
    \ \        / /       | |         / ____(_) |         | |_
     \ \  /\  / /__  _ __| | _____  | |     _| |_ ___  __| (_)
      \ \/  \/ / _ \| '__| |/ / __| | |    | | __/ _ \/ _`` |
       \  /\  / (_) | |  |   <\__ \ | |____| | ||  __/ (_| |_
        \/  \/ \___/|_|  |_|\_\___/  \_____|_|\__\___|\__,_(_)

"@;

$WorksCited = [HashTable] @{
    'ASCII Art Generator: Text' = 'http://bit.ly/ASCIIArt-Text';
    'Azure Automation: Services' = 'http://bit.ly/AzAcct-Services';
    'Azure Automation: Documentation' = 'http://bit.ly/AzAcct-Docs';
    'Create a Microsoft Azure Account' = 'http://bit.ly/CreateAzureAccount';
    'Netchex is Hiring!' = 'http://www.netchex.com/jobs';
    'Azure Automation: Demo Documentation' = 'http://bit.ly/AzAutomationExample';
};

$LongestString = ($WorksCited.Keys | Measure-Object -Maximum -Property Length).Maximum + 4;

$DisplayText += @"

    Notable Resources:

      $('Name'.PadRight($LongestString, ' '))Value
      $('----'.PadRight($LongestString, ' '))-----
"@;

foreach ($Key in $WorksCited.Keys | Sort-Object)
{
    $DisplayText += "`n$(' ' * 6)$($Key.PadRight($LongestString, ' '))$($WorksCited.$Key)";
}

Write-Host $DisplayText -NoNewline;

$DisplayTextLineCount += $DisplayText.Split("`n").Count;
Write-Host ("`n" * ($AvailableLineCount - $DisplayTextLineCount) + 'Press any key to continue...') -NoNewline;
Read-Host;
