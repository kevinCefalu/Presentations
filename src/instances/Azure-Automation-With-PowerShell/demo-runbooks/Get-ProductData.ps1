
param (
    [Parameter()]
    [string] $NameFilter,

    [Parameter()]
    [string] $ModelFilter
);

$SQLCredential = Get-AutomationPSCredential -Name 'sqlsaturday-demo-creds';
$SQLServerAddress = Get-AutomationVariable -Name 'sqlsaturday-demo-server';

$SQLConnectionString = "Server=tcp:$SQLServerAddress,1433;";
$SQLConnectionString += 'Database=sqlsaturday-demo;';
$SQLConnectionString += "User ID=$($SQLCredential.UserName);";
$SQLConnectionString += "Password=$($SQLCredential.GetNetworkCredential().Password);";
$SQLConnectionString += 'Trusted_Connection=False;Encrypt=True;';
$SQLConnectionString += 'Connection Timeout=30;';

$SQLConnection = [System.Data.SqlClient.SqlConnection]::new($SQLConnectionString);

$SQLConnection.Open();

$SQLQuery = "
    select
        [ProductID],
        [Name],
        [ProductModel],
        [Description]
    from [SalesLT].[vProductAndDescription]
    where [Culture] = 'en'";

if (-not [String]::IsNullOrEmpty($NameFilter))
{
    $SQLQuery += " and Name like @NameFilter";
}

if (-not [String]::IsNullOrEmpty($ModelFilter))
{
    $Filters += "and ProductModel like @ModelFilter";
}

$SQLCommand = [System.Data.SqlClient.SqlCommand]::new($SQLQuery, $SQLConnection);

if (-not [String]::IsNullOrEmpty($NameFilter))
{
    $SQLCommand.Parameters.Add("@NameFilter", "%$NameFilter%") | Out-Null;
}

if (-not [String]::IsNullOrEmpty($ModelFilter))
{
    $SQLCommand.Parameters.Add("@ModelFilter", "%$ModelFilter%") | Out-Null;
}

$SQLCommand.CommandTimeout = 120;

$DataSet = [System.Data.DataSet]::new();
$DataAdapter = [system.Data.SqlClient.SqlDataAdapter]::new($SQLCommand);

$DataAdapter.Fill($DataSet) | Out-Null;

# $ProductDetails = [System.Collections.Generic.List[PSCustomObject]]::new();

for ($i = 0; $i -lt $DataSet.Tables[0].Rows.Count; $i++)
{
    "ID: $($DataSet.Tables[0].Rows[$i].ProductID)";
    "Name: $($DataSet.Tables[0].Rows[$i].Name)";
    "Model: $($DataSet.Tables[0].Rows[$i].ProductModel)";
    "Description: $($DataSet.Tables[0].Rows[$i].Description)";
    '';

    # $ProductDetails.Add([PSCustomObject] @{
    #     ID = $DataSet.Tables[0].Rows[$i].ProductID;
    #     Name = $DataSet.Tables[0].Rows[$i].Name;
    #     Model = $DataSet.Tables[0].Rows[$i].ProductModel;
    #     Description = $DataSet.Tables[0].Rows[$i].Description;
    # });
}

$SQLCommand.Dispose();
$SQLConnection.Close();
$SQLConnection.Dispose();

# Write-Output ($ProductDetails | ConvertTo-Json);
