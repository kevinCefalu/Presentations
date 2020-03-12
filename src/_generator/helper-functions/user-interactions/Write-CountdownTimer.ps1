
function Write-CountdownTimer
{
    [OutputType([void], ParameterSetName = 'NoInput')]
    [OutputType([char], ParameterSetName = 'Input')]
    param (
        [Parameter()]
        [TimeSpan] $TimeSpan = [TimeSpan]::new(0, 0, 30),

        [Parameter()]
        [string] $TimerFormat = 'hh\h\ mm\m\ ss\s',

        [Parameter(HelpMessage = 'Amount of time to sleep in milliseconds')]
        [int] $SleepTimer = 250,

        [Parameter()]
        [int] $Indention = 1,

        [Parameter(Mandatory)]
        [CursorPosition] $TimerPosition,

        [Parameter(Mandatory)]
        [CursorPosition] $EndPosition,

        [Parameter(Mandatory, ParameterSetName = 'Input')]
        [char[]] $AcceptedInterruptKeys
    );

    # Question: Is this necessary?
    $Host.UI.RawUI.FlushInputBuffer();

    do
    {
        if ($null -ne $AcceptedInterruptKeys -and $Host.UI.RawUI.KeyAvailable)
        {
            $KeyInput = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyUp');

            if ($AcceptedInterruptKeys -contains $KeyInput.Character)
            {
                [string] $UserInterrupt = $KeyInput.Character;

                break;
            }
        }

        $TimerPosition.Restore();

        $Script:ConsoleWriter = $Script:ConsoleWriter.
            Write(($TimeSpan | Format-TimeSpan -Format $TimerFormat));

        $TimeSpan = $TimeSpan.Subtract("00:00:00:00.$SleepTimer");
        Start-Sleep -MilliSeconds $SleepTimer;
    }
    until ($TimeSpan -eq 0);

    $TimerPosition.Restore();

    $Script:ConsoleWriter = $Script:ConsoleWriter.Write(
        ($TimeSpan | Format-TimeSpan -Format $TimerFormat));

    $EndPosition.Restore();

    if ((Get-Variable -Name 'UserInterrupt' -ErrorAction:SilentlyContinue) -and
        -not [String]::IsNullOrEmpty($UserInterrupt))
    {
        $Script:ConsoleWriter = $Script:ConsoleWriter.WriteWithPrefixLines(
            ((Get-Indention -Indention $Indention) +
            'You entered: '), 1, $Script:DefaultChoiceColor);

        $Script:ConsoleWriter = $Script:ConsoleWriter.
            WriteWithSuffixLines(($UserInterrupt), 1);

        return $UserInterrupt;
    }
    else
    {
        $Script:ConsoleWriter = $Script:ConsoleWriter.WriteLineWithPrefixLines(
            ((Get-Indention -Indention $Indention) +
            'Timed Out! Auto-selecting default option.'),
            1, $Script:DefaultChoiceColor);

    }
}
