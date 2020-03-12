
function Write-Choice
{
    [OutputType([void])]
    param (
        [Parameter(Mandatory)]
        [char] $Key,

        [Parameter(Mandatory)]
        [string] $Description,

        [Parameter()]
        [int] $Indention = 1,

        [Parameter()]
        [switch] $IsDefault,

        [Parameter()]
        [ConsoleColor] $DefaultChoiceColor = $Script:DefaultChoiceColor
    );

    $Indent = Get-Indention -Indention $Indention;

    if ($IsDefault.IsPresent)
    {
        $Key = $Key.ToString().ToUpper();

        $Script:ConsoleWriter = $Script:ConsoleWriter.
            Write("$Indent[$Key] ", $DefaultChoiceColor);
    }
    else
    {
        $Key = $Key.ToString().ToLower();

        $Script:ConsoleWriter = $Script:ConsoleWriter.Write("$Indent[$Key] ");
    }

    $Script:ConsoleWriter = $Script:ConsoleWriter.WriteLine(": $Description");
}
