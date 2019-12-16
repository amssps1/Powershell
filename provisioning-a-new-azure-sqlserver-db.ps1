# Provisioning an Azure SQL Server Database
#region
# 1. Authenticate your Azure subscription
```powershell
Connect-AzAccount
```

#endRegion

#region
# 2. Create a new resource group
 ```powershell
$parameters = @{
    Name           = 'azsqldb-demo-rg'
    Location       = 'northeurope'
}
New-AzResourceGroup @parameters
```
#endRegion

#region
# 3. Create a Azure SQL Server
 ```powershell
    $Username   = "cloudstksql"
    $Password   = "pa$$w@rd1" | ConvertTo-SecureString -AsPlainText -Force
    $Cred       =  New-Object System.Management.Automation.PSCredential($Username,$Password)

$parameters = @{
    ResourceGroupName               = 'azsqldb-demo-rg'
    ServerName                      = 'cloudstksqlserver'
    Location                        = 'northeurope'
    SqlAdministratorCredentials     = $cred
    ServerVersion                   = '12.0'
}

New-AzSqlServer @parameters
```
#endRegion

#region
# 4. Create an Azure SQL Database 
# create an Azure SQL Database, we used the following parameters:
```powershell
$parameters = @{
    ResourceGroupName               = 'azsqldb-demo-rg'
    ServerName                      = 'cloudstksqlserver'
    DatabaseName                    = 'cloudstkdemodb'
    RequestedServiceObjectiveName   = 'S0'  
  }
New-AzSqlDatabase @parameters
```
#endregion

#region
# 5. Setting up Firewall rules  
# In this demo, we're going to define a specific IP address(your machine's IP) to connect SQL Azure. 

```powershell
$parameters = @{
    ResourceGroupName = 'azsqldb-demo-rg'
    ServerName        = 'cloudstksqlserver'
    FirewallRuleName  = 'AllowedClientIP'
    StartIpAddress    = 'xxx.xxx.xxx.xxx'
    EndIpAddress      = 'xxx.xxx.xxx.xxx'
}

New-AzSqlServerFirewallRule @parameters
```
#endRegion

#region
# 6. Clean up delopment
# To remove the resource group and all resouces associated with it.
 ```powershell
Remove-AzResourceGroup -ResourceGroupName 'azsqldb-demo-rg'
```
#endRegion

