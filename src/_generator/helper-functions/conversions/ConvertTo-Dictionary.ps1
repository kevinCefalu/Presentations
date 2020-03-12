
function ConvertTo-Dictionary
{
    [CmdletBinding()]

    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [hashtable] $InputObject,

        [Parameter()]
        [Type] $KeyType = [string],

        [Parameter()]
        [Type] $ValueType = [string]
    )

    process
    {
        $OutputObject = New-Object (
            "System.Collections.Generic.Dictionary[" +
            "[$($KeyType.FullName)],[$($ValueType.FullName)]]"
        );

        foreach ($KeyValuePair in $InputObject.GetEnumerator())
        {
            $NewKey = $KeyValuePair.Key -as $KeyType

            if ($null -eq $NewKey)
            {
                throw 'Could not convert key "{0}" of type "{1}" to type "{2}"' -f
                    $KeyValuePair.Key, $KeyValuePair.Key.GetType().FullName, $KeyType.FullName;
            }
            elseif ($OutputObject.ContainsKey($NewKey))
            {
                throw "Duplicate key `"$NewKey`" detected in input object.";
            }

            $OutputObject.Add($NewKey, $KeyValuePair.Value);
        }

        return $OutputObject;
    }
}
