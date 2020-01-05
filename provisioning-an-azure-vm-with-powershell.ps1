# Provisioning an Azure Virtual Machine with PowerShell
 
#1 Authenticate your Azure subscription

    Connect-AzAccount

#2 Create an Azure resource group
    $parameters = @{
        Name               = 'azvm-demo-rg'
        Location           = 'northeurope'
}
    New-AzResourceGroup @parameters

#3 Provisioning a New Azure VM. To provision a new VM, run the New-AzVm with the following parameters:

        $Username   = "azvmadmin"
        $Password   = "pa$$w@rd1" | ConvertTo-SecureString -AsPlainText -Force
        $Cred       =  New-Object System.Management.Automation.PSCredential($Username,$Password)

    $parameters = @{
        ResourceGroupName               = 'azvm-demo-rg'
        Name                            = 'win-vm-demo-01'
        Location                        = 'northeurope'
        Size                            = 'Standard_B1s' 
        Image                           = 'MicrosoftWindowsServer:WindowsServer:2016-Datacenter-with-Containers:latest'
        VirtualNetworkName              = 'vmdemoVnet'
        SubnetName                      = 'vmdemoSubnet'
        SecurityGroupName               = 'vmdemoNSG'
        PublicIpAddressName             = 'vmdemoPublicIP'
        Credential                      = $Cred

        }
        New-AZvm @parameters

#4 List the properties of a VM

    Get-AzVM -Name 'win-vm-demo-01'

#5. Connect to the VM using PowerShell

    Get-AzRemoteDesktopFile -ResourceGroupName "azvm-demo-rg" -Name "win-vm-demo-01" -Launch

#Decrypt PowerShell Secure String Password
# $cred.GetNetworkCredential().password
  
#remove vm resource group

    Remove-AzResourceGroup -ResourceGroupName 'azvm-demo-rg'

