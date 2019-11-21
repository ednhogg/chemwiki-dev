$PROJ="c:\Users\ehogg\Documents\PROJ\IC_CHEMWIKI\vagrant"
cd $PROJ
#Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy RemoteSigned -Force
Install-Module PowerShellGet -Force -SkipPublisherCheck
Install-Module posh-git -Scope CurrentUser -Force
Install-Module posh-git -Scope CurrentUser -Force #-AllowPrerelease -Force # Newer beta version with PowerShell Core support

Import-Module ".\PSVirtualBox\PSVirtualBox.psm1"
Get-Command -Module PSVirtualBox | Select-Object -Property CommandType, Name

#Import-Module posh-git
#Add-PoshGitToProfile -AllHosts # add to profile

if (-not (Test-Path ".\PSVirtualBox")) {
    git clone https://github.com/jdhitsolutions/PSVirtualBox.git
}
cd PSVirtualBox
git pull
cd ..


$VMName=(Get-VBoxMachine -All | Select-Object -Property Name -OutVariable VM).Name

VBoxManage snapshot  $VMName list --details


