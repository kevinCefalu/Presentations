
function Get-LineCount
{
    [CmdLetBinding()]
    [OutputType([int])]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [string] $Text
    );

    return [int] ($Text.Split("`n").Count);
}
