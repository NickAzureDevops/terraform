Param(
        [Parameter(Mandatory=$false)][ValidateNotNullOrEmpty()] 
        [String]
        $RunAsConnectionName = "AzureRunAsConnection",
         
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] 
        [String]
        $Application_Gateway_name,

        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] 
        [String]
        $Application_Gateway_ResourceGroup        
)
 
try {
    # Get the connection "AzureRunAsConnection "
    $servicePrincipalConnection = Get-AutomationConnection -Name $RunAsConnectionName
    "Logging in to Azure..."
    $connectionResult =  Connect-AzAccount -Tenant $servicePrincipalConnection.TenantID `
                             -ApplicationId $servicePrincipalConnection.ApplicationID   `
                             -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint `
                             -ServicePrincipal
    "Logged in."
}

catch {
    if (!$servicePrincipalConnection) {
        $ErrorMessage = "Connection $RunAsConnectionName not found."
        throw $ErrorMessage
    } else{
        Write-Error -Message $_.Exception
        throw $_.Exception
    }
}

$Health = Get-AzApplicationGatewayBackendHealth -Name $Application_Gateway_name -ResourceGroupName $Application_Gateway_ResourceGroup | 
Select-Object -ExpandProperty BackendAddressPools | Select-Object -ExpandProperty BackendHttpSettingsCollection | 
Select-Object -ExpandProperty servers | Select-Object -Property "Address", "Health" | Where-Object -Property Health -eq "Unhealthy" 

Write-Output ( $Health | ConvertTo-Json)