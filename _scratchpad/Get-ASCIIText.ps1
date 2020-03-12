
function Get-ASCIIText
{
    [CmdletBinding()]
    [OutputType([string])]

    param (
        [Parameter(Mandatory)]
        [string] $Title
    );

    $Title = [Web.HTTPUtility]::UrlEncode($Title);
    return Invoke-RestMethod -Uri "http://artii.herokuapp.com/make?text=$Title&font=big";
}
