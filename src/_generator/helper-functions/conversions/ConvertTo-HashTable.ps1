
function ConvertTo-HashTable
{
    <#
        .SYNOPSIS
            Used to convert a PSObject, or an array of PSObjects, to
            HashTable(s), recursively

        .DESCRIPTION
            This function is used to convert a PSObject, or an array of
            PSObjects, to HashTable(s), recursively. This function can also be
            passed a one-based depth stop to halt the recursion, at any level.
            Note that passing a 0 to the Depth parameter will cause the function
            to completely recurse InputObject's value(s).

        .PARAMETER InputObject
            An object to convert to a hashtable

        .PARAMETER Depth
            The depth to which you wish to represent in the resulting hashtable.

        .INPUTS
            You can pipe a value to the function to attempt it's conversion to a
            HashTable.

        .OUTPUTS
            Depending on the InputObjects' type, the output will either be a
            HashTable, an array of HashTable(s), or whatever other type you've
            passed in, if the InputObjects' type does not fit in the
            aforementioned criteria.

        .EXAMPLE
            PS> $SinglePSObject = [PSCustomObject] @{
            >>     name = 'test';
            >>     id = 1;
            >>     inner = [PSCustomObject] @{
            >>         yes = $true;
            >>         meh = 12
            >>     };
            >>  };
            PS> $SinglePSObject | ConvertTo-HashTable;

        .EXAMPLE
            PS> $SinglePSObject = [PSCustomObject] @{
            >>     name = 'test';
            >>     id = 1;
            >>     inner = [PSCustomObject] @{
            >>         yes = $true;
            >>         meh = 12
            >>     };
            >> };
            PS> $SinglePSObject `
            >>     | ConvertTo-HashTable -Depth 1;

        .EXAMPLE
            PS> $ArrayOfPSCustomObjects = @(
            >>     [PSCustomObject] @{
            >>         name = 'test';
            >>         id = 1;
            >>         inner = [PSCustomObject] @{
            >>             yes = $true;
            >>             meh = 12
            >>         };
            >>     },
            >>     [PSCustomObject] @{
            >>         name = 'testi';
            >>         id = 2;
            >>         inner = [PSCustomObject] @{
            >>             yes = $false;
            >>             meh = 181;
            >>         };
            >>     }
            >> );
            PS> ConvertTo-HashTable -InputObject $ArrayOfPSCustomObjects;

        .EXAMPLE
            PS> $ArrayOfPSCustomObjects = @(
            >>     [PSCustomObject] @{
            >>         name = 'test';
            >>         id = 1;
            >>         inner = [PSCustomObject] @{
            >>             yes = $true;
            >>             meh = 12;
            >>         };
            >>     },
            >>     [PSCustomObject] @{
            >>         name = 'testi';
            >>         id = 2;
            >>         inner = [PSCustomObject] @{
            >>             yes = $false;
            >>             meh = 181;
            >>         };
            >>     }
            >> );
            PS> $ArrayOfPSCustomObjects | ConvertTo-HashTable -Depth 1;
    #>

    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        $InputObject,

        [Parameter()]
        [int] $Depth = 0
    );

    process
    {
        if ($null -eq $InputObject)
        {
            return $null;
        }

        if ($InputObject -is [PSObject])
        {
            $Result = [HashTable] @{ };

            $InputObject.PSObject.Properties.foreach(
                {
                    if ($_.Value -is [PSObject] -or $_.Value -is [Array] -and $Depth -gt 0)
                    {
                        $Value = $_.Value | ConvertTo-HashTable -Depth (--$Depth);
                    }
                    else
                    {
                        $Value = $_.Value;
                    };

                    $Result[$_.Name] = $Value;
                }
            );

            return $Result;
        }
        elseif ($InputObject -is [Array])
        {
            $Result = [object[]]::new($InputObject.Count);

            for ($PropertyIndex = 0; $PropertyIndex -lt $InputObject.Count; $PropertyIndex++)
            {
                if ($Depth -gt 0)
                {
                    $Result[$PropertyIndex] = $InputObject[$PropertyIndex] | ConvertTo-HashTable -Depth (--$Depth);
                }
                else
                {
                    $Result[$PropertyIndex] = $InputObject[$PropertyIndex];
                }
            }

            return , $Result;
        }
        else
        {
            return $InputObject;
        }
    }
}
