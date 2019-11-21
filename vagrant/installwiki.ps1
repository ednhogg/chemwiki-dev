vagrant destroy -f
$Env:VAGRANT_VAGRANTFILE = "Vagrantfile.firstuse"; vagrant up --provision ; vagrant ssh -c "df -vh"
$Env:VAGRANT_VAGRANTFILE = "Vagrantfile.bau"; vagrant up --provision ; vagrant ssh -c "df -vh"
$Env:VAGRANT_VAGRANTFILE = "Vagrantfile.dbsetup"; vagrant up --provision ; vagrant ssh -c "df -vh"
