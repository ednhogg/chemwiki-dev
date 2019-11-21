param ( [Parameter(Mandatory=$true)][string]$customvagrantfile )

# https://stackoverflow.com/questions/2157554/how-to-handle-command-line-arguments-in-powershell
#param ( [switch]$build=$true, $setup=$true, dbimport=$true )
#Set-Variable -Name VAGRANT_VAGRANTFILE -Value "Vagrantfile.firstuse"
#Set-Variable -Name VAGRANT_VAGRANTFILE -Value "Vagrantfile.bau"
#Set-Variable -Name VAGRANT_VAGRANTFILE -Value "Vagrantfile.dbsetup"


# Set-Variable -Name VAGRANT_VAGRANTFILE -Value $customvagrantfile

# or

$Env:VAGRANT_VAGRANTFILE = $customvagrantfile

Get-ChildItem "Env:" | Where-Object { $_.Name -like "VAGRANT*" }

Write-Host "______________"
vagrant up --provision
#vagrant ssh -c "sudo poweroff"