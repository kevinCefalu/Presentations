
function Write-SlideTable
{
    [CmdletBinding(DefaultParameterSetName = 'NotComplete')]
    [OutputType([int], ParameterSetName = 'NotComplete')]
    [OutputType([void], ParameterSetName = 'Complete')]
    param (
        [Parameter(ParameterSetName = 'NotComplete')]
        [Parameter(ParameterSetName = 'Complete')]
        [int] $IndentBy = 4,

        [Parameter(ParameterSetName = 'NotComplete')]
        [Parameter(ParameterSetName = 'Complete')]
        [int] $IncreaseIndentBy = 2,

        [Parameter(ParameterSetName = 'NotComplete')]
        [Parameter(ParameterSetName = 'Complete')]
        [int] $SpaceColumnBy = 4,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'NotComplete')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Complete')]
        [int] $Available,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'NotComplete')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Complete')]
        [int] $Used,

        [Parameter(ParameterSetName = 'NotComplete')]
        [Parameter(ParameterSetName = 'Complete')]
        [string] $Title,

        [Parameter(Mandatory, ParameterSetName = 'NotComplete')]
        [Parameter(Mandatory, ParameterSetName = 'Complete')]
        [PSCustomObject[]] $Headers,

        [Parameter(Mandatory, ParameterSetName = 'NotComplete')]
        [Parameter(Mandatory, ParameterSetName = 'Complete')]
        [PSCustomObject[]] $Rows,

        [Parameter()]
        [switch] $WaitBetweenRows,

        [Parameter(Mandatory, ParameterSetName = 'Complete')]
        [switch] $Complete
    );

    if (-not [String]::IsNullOrEmpty($Title))
    {
        $Used += 3;
        Write-Host "$(' ' * $IndentBy)${Title}:`n";

        $IndentBy += $IncreaseIndentBy;
    }

    $ColumnNames = $Rows[0] | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name;

    $ColumnLengths = @{ };

    foreach ($ColumnName in $ColumnNames)
    {
        $ColumnLengths.$ColumnName = ($Rows | Select-Object -ExpandProperty $ColumnName `
            | Measure-Object -Maximum -Property Length).Maximum;

        $HeaderLength = ($Headers | Where-Object { $_.MapTo -eq $ColumnName }).Display.Length;

        if ($ColumnLengths.$ColumnName -lt $HeaderLength)
        {
            $ColumnLengths.$ColumnName = $HeaderLength;
        }

        $ColumnLengths.$ColumnName += $SpaceColumnBy
    }

    $TableRowIndent = "$(' ' * $IndentBy)";

    Write-Host $TableRowIndent -NoNewLine;
    $TableHeaderBorderLine = $TableRowIndent;

    for ($h = 0; $h -lt $Headers.Count; $h++)
    {
        Write-Host "$($Headers[$h].Display.PadRight($ColumnLengths[$Headers[$h].MapTo], ' '))" -NoNewline:$($h -ne ($Headers.Count - 1));
        $TableHeaderBorderLine += "$('-' * $Headers[$h].Display.Length)".PadRight($ColumnLengths[$Headers[$h].MapTo], ' ');
    }

    Write-Host $TableHeaderBorderLine;

    for ($r = 0; $r -lt $Rows.Count; $r++)
    {
        $ColumnStart = $IndentBy;

        Write-Host $TableRowIndent -NoNewLine;

        for ($h = 0; $h -lt $Headers.Count; $h++)
        {
            $Output = $Rows[$r].$($Headers[$h].MapTo);

            if ($Output -is [string])
            {
                Write-Host $Rows[$r].$($Headers[$h].MapTo).PadRight($ColumnLengths[$Headers[$h].MapTo], ' ') -NoNewline:$($h -ne ($Headers.Count - 1) -or $WaitBetweenRows.IsPresent);
                $ColumnStart += $Rows[$r].$($Headers[$h].MapTo).PadRight($ColumnLengths[$Headers[$h].MapTo], ' ').Length;
            }
            elseif ($Output -is [object[]])
            {
                $CombinedText = $Output -join "`n$(' ' * $ColumnStart)";
                $Used += $Output.Count + 2;
                Write-Host $CombinedText;
            }
        }

        if ($WaitBetweenRows.IsPresent -and $r -ne ($Rows.Count - 1))
        {
            $Used--;
            Read-Host | Out-Null;
        }
    }

    $Used += 3 + $Rows.Count;

    if (-not $Complete.IsPresent)
    {
        Read-Host | Out-Null;
        return $Used;
    }
    else
    {
        ([PSCustomObject] @{
            Available = $Available;
            Used = $Used;
        }) | Write-SlideEnd;
    }
}
