
function Get-IndentedText
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
        [int] $IndentBy = 4,

        [Parameter(ParameterSetName = 'AsString')]
        [Parameter(ParameterSetName = 'AsCollection')]
        [int] $IncreaseIndentBy = 0
    );

    $IndentBy += $IncreaseIndentBy;

    return "$(' ' * $IndentBy)$Text";
}
