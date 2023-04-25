
<#
    .DESCRIPTION
        An example runbook which gets all the ARM resources using the Run As Account (Service Principal)
#>

$connectionName = 'AzureRunAsConnection';

try
{
    # Get the connection "AzureRunAsConnection "
    $servicePrincipalConnection = Get-AutomationConnection -Name $connectionName;

    'Logging in to Azure...';

    $null = Add-AzureRmAccount -ServicePrincipal `
        -TenantId $servicePrincipalConnection.TenantId `
        -ApplicationId $servicePrincipalConnection.ApplicationId `
        -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint;
}
catch
{
    if (-not $servicePrincipalConnection)
    {
        $ErrorMessage = "Connection $connectionName not found.";
        throw $ErrorMessage;
    }
    else
    {
        Write-Error -Message $_.Exception;

        throw $_.Exception;
    }
}

#Get all ARM resources from all resource groups
$ResourceGroups = Get-AzureRmResourceGroup;

foreach ($ResourceGroup in $ResourceGroups)
{
    Write-Output "`nShowing resources in resource group $($ResourceGroup.ResourceGroupName)";

    $Resources = Get-AzureRmResource `
            -ResourceGroupName $ResourceGroup.ResourceGroupName `
        | Select-Object Name, ResourceType;

    foreach ($Resource in $Resources)
    {
        Write-Output "  - $($Resource.Name) of type $($Resource.ResourceType)";
    }
}
