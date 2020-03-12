
function Format-TimeSpan
{
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [TimeSpan] $TimeSpan,

        [Parameter()]
        [string] $Prefix,

        [Parameter()]
        [string] $Format = 'hh\h\ mm\m\ ss\.ff\s',

        [Parameter()]
        [string] $Suffix
    );

    return "$Prefix$($TimeSpan.ToString($Format))$Suffix";
}
