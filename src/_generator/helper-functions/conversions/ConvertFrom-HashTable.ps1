
function ConvertFrom-HashTable
{
    <#
        .SYNOPSIS
            Used to convert a HashTable, to a PSCustomObject

        .DESCRIPTION
            This function is used to convert a HashTable to a PSCustomObject.

        .PARAMETER HashTable
            An hashtable to convert to a PSCustomObject

        .INPUTS
            You can pipe a Hashtable to the function to attempt it's conversion
            to a PSCustomObject.

        .OUTPUTS
            A PSCustomObject representation of the HashTable passed as input.

        .EXAMPLE
            PS> $HashTable = @{
            >>     name = 'test';
            >>     id = 1;
            >> };
            PS> $PSCustomObject = $HashTable | ConvertFrom-HashTable;
    #>

    [OutputType([PSCustomObject])]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [HashTable] $HashTable
    );

    if ($null -eq $HashTable)
    {
        return $null;
    }

    $ResultingPSCustomObject = New-Object PSCustomObject -Property $HashTable;

    return $ResultingPSCustomObject;
}
