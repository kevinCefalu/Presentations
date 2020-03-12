
function Invoke-Step
{
    param (
        [Parameter()]
        [string] $Title,

        [Parameter()]
        [TimeSpan] $TimeOut = [TimeSpan]::new(0, 0, 15),

        [Parameter(Mandatory)]
        [string] $ScriptFile,

        [Parameter()]
        [object[]] $Arguments
    );

    if (-not (Test-Path $ScriptFile))
    {
        Write-Error "Could not find step defintion: $ScriptFile";

        return;
    }

    if ($null -ne $Arguments)
    {
        [HashTable] $ArgumentsHashTable = $Arguments | ConvertTo-HashTable;
    }
    else
    {
        [HashTable] $ArgumentsHashTable = $null;
    }

    $Timestamp = Get-Timestamp -Prefix '[' -Suffix '] :: ';
    $Script:ConsoleWriter = $Script:ConsoleWriter.WriteWithPrefixLines($Timestamp, 1, $Script:TimestampColor);

    $Script:ConsoleWriter = $Script:ConsoleWriter.
        Write('Requesting to ').
        Write($Title, $Script:DefaultChoiceColor).
        WriteWithSuffixLines(':', 1);

    $Indention = 1;

    $Script:ConsoleWriter = $Script:ConsoleWriter.Write((
        (Get-Indention -Indention $Indention) + 'Would you like to proceed?'),
        1, 2, $Script:QuestionColor);

    $PreviousIndention = $Indention;
    $Indention += 1;

    # TODO: Convert this to a [ChoiceCollection] and put write-choice in [Choice]
    Write-Choice -Key 'Y' -Description $Title -Indention $Indention -IsDefault;
    Write-Choice -Key 'N' -Description 'Skip this step' -Indention $Indention;
    Write-Choice -Key 'Q' -Description 'Quit/Cancel the execution of this script' -Indention $Indention;

    $Indention = $PreviousIndention;

    $Script:ConsoleWriter = $Script:ConsoleWriter.WriteWithPrefixLines((
        (Get-Indention -Indention $Indention) +
        'Timeout to default choice in: '), 1);

    $TimerPosition = [CursorPosition]::new();

    $Script:ConsoleWriter = $Script:ConsoleWriter.WriteEmptyLines(1);

    $EndPosition = [CursorPosition]::new();

    $UserInput = Write-CountdownTimer `
        -TimeSpan $TimeOut `
        -TimerPosition $TimerPosition `
        -EndPosition $EndPosition `
        -AcceptedInterruptKeys @('y', 'n', 'q');

    $Script:ConsoleWriter = $Script:ConsoleWriter.WriteEmptyLines(1);

    if ($null -eq $UserInput -or $UserInput -eq 'y')
    {
        $Script:ConsoleWriter = $Script:ConsoleWriter.
            Write(((Get-Indention -Indention $Indention) + 'Executing Step: ')).
            WriteLineWithSuffixLines($Title, 1, $Script:DefaultChoiceColor);

        if ($null -ne $ArgumentsHashTable)
        {
            . $ScriptFile @ArgumentsHashTable;
        }
        else
        {
            . $ScriptFile;
        }
    }
    elseif ($UserInput -eq 'n')
    {
        $Script:ConsoleWriter = $Script:ConsoleWriter.WriteLineWithSuffixLines((
            (Get-Indention -Indention $Indention) + 'Skipping this step.'), 1);

        return;
    }
    elseif ($UserInput -eq 'q')
    {
        $Script:ConsoleWriter = $Script:ConsoleWriter.WriteLineWithSuffixLines((
            (Get-Indention -Indention $Indention) +
            'Quitting/Canceling the execution of this script.'), 1);

        exit;
    }

    $Script:ConsoleWriter = $Script:ConsoleWriter.WriteEmptyLines(1);
}
