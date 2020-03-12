
# Question: Is there some way to do this with [CursorPosition].Column?

function Get-Indention
{
    [OutputType([void])]
    param (
        [Parameter()]
        [int] $Indention = 1
    );

    return "$(' ' * ($Script:TabWidth * $Indention))";
}
