
function Get-Timestamp
{
    [OutputType([string])]
    param (
        [Parameter()]
        [string] $Prefix,

        [Parameter()]
        [string] $Format = 'HH:mm:ss.fffffff',

        [Parameter()]
        [string] $Suffix
    );

    return "$Prefix$(Get-Date -Format $Format)$Suffix";
}
