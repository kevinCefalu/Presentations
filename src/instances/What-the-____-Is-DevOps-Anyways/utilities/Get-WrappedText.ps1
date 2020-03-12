
function Get-WrappedText
{
    [CmdletBinding(DefaultParameterSetName = 'AsString')]
    [OutputType([string], ParameterSetName = 'AsString')]
    [OutputType([System.Collections.Generic.List[string]], ParameterSetName = 'AsCollection')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'AsString')]
        [Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'AsCollection')]
        [string] $Text,

        [Parameter(ParameterSetName = 'AsString')]
        [Parameter(ParameterSetName = 'AsCollection')]
        [int] $Width = 100,

        [Parameter(ParameterSetName = 'AsString')]
        [Parameter(ParameterSetName = 'AsCollection')]
        [int] $IndentBy = 4,

        [Parameter(ParameterSetName = 'AsString')]
        [Parameter(ParameterSetName = 'AsCollection')]
        [int] $IncreaseIndentBy = 0,

        [Parameter(ParameterSetName = 'AsString')]
        [Parameter(ParameterSetName = 'AsCollection')]
        [int] $IncreaseIndentOnNewLinesBy = 2,

        [Parameter(ParameterSetName = 'AsCollection')]
        [switch] $AsCollection
    );

    $Lines = [System.Collections.Generic.List[string]]::new();

    $Words = $text -split "\s+";

    $IndentBy += $IncreaseIndentBy;
    $Column = $IndentBy;

    $Line = "$(' ' * $IndentBy)";

    foreach ($Word in $Words)
    {
        $Column += $Word.Length + 1;

        if ($Column -gt $Width)
        {
            $Lines.Add($Line.TrimEnd());
            $Line = "$(' ' * ($IndentBy + $IncreaseIndentOnNewLinesBy))";
            $Column = $Word.Length + 1 + ($IndentBy + $IncreaseIndentOnNewLinesBy);
        }

        $Line += "$Word ";
    }

    $Lines.Add($Line.TrimEnd());

    if ($AsCollection.IsPresent)
    {
        return $Lines;
    }
    else
    {
        return $Lines -join "`n";
    }
}
