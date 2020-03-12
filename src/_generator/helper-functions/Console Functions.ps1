
$escapeChar = [char]27

function Set-CursorForRightBlockWrite
{
    param (
        [int] $TextLength
    );

    $RawUI = $Host.UI.RawUI;
    $Width = $RawUI.BufferSize.Width;
    $space = $Width - $TextLength;

    Write-Prompt "$escapeChar[$($space)G"
}

function Reset-CursorPosition
{
    $Postion = $Host.UI.RawUI.CursorPosition;

    $Postion.X = 0;

    $Host.UI.RawUI.CursorPosition = $Postion;
}

function Set-CursorUp
{
    param (
        [int] $Lines
    );

    return "$escapeChar[$($Lines)A"
}

function Set-Newline
{
    return Write-Prompt "`n";
}


function Write-Prompt($Object, $ForegroundColor = $null, $BackgroundColor = $null) {
    $s = $global:GitPromptSettings
    if ($s -and ($null -eq $ForegroundColor)) {
        $ForegroundColor = $s.DefaultForegroundColor
    }

    if ($BackgroundColor -is [string]) {
        $BackgroundColor = [ConsoleColor]$BackgroundColor
    }
    if ($ForegroundColor -is [string]) {
        $ForegroundColor = [ConsoleColor]$ForegroundColor
    }

    $writeHostParams = @{
        Object = $Object;
        NoNewLine = $true;
    }
    if (($BackgroundColor -ge 0) -and ($BackgroundColor -le 15)) {
        $writeHostParams.BackgroundColor = $BackgroundColor
    }
    if (($ForegroundColor -ge 0) -and ($ForegroundColor -le 15)) {
        $writeHostParams.ForegroundColor = $ForegroundColor
    }
    Write-Host @writeHostParams
}

# Override some of the normal colors if the background color is set to the default DarkMagenta.
if ($Host.UI.RawUI.BackgroundColor -eq [ConsoleColor]::DarkMagenta) {
    $s.LocalDefaultStatusForegroundColor    = $s.LocalDefaultStatusForegroundBrightColor
    $s.LocalWorkingStatusForegroundColor    = $s.LocalWorkingStatusForegroundBrightColor

    $s.BeforeIndexForegroundColor           = $s.BeforeIndexForegroundBrightColor
    $s.IndexForegroundColor                 = $s.IndexForegroundBrightColor

    $s.WorkingForegroundColor               = $s.WorkingForegroundBrightColor
}
