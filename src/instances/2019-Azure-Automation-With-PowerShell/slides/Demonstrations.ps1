
$AvailableLineCount = 34;
$DisplayTextLineCount = 0;

$DisplayText = @"
     _____                                 _             _   _
    |  __ \                               | |           | | (_)
    | |  | | ___ _ __ ___   ___  _ __  ___| |_ _ __ __ _| |_ _  ___  _ __  ___
    | |  | |/ _ \ '_ `` _ \ / _ \| '_ \/ __| __| '__/ _`` | __| |/ _ \| '_ \/ __|
    | |__| |  __/ | | | | | (_) | | | \__ \ |_| | | (_| | |_| | (_) | | | \__ \
    |_____/ \___|_| |_| |_|\___/|_| |_|___/\__|_|  \__,_|\__|_|\___/|_| |_|___/
"@;

Write-Host $DisplayText;

$DisplayTextLineCount += $DisplayText.Split("`n").Count + 1;

Write-Host ("`n" * ($AvailableLineCount - $DisplayTextLineCount) + 'Press any key to continue...') -NoNewline;
Read-Host;
