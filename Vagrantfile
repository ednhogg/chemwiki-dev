
# Run VAGRANT_VAGRANTFILE=Vagrantfile.bau vagrant up


Vagrant.configure("2") do |config|
    workstation_ip       = '10.0.0.33'
    workstation_hostname = 'chemwiki'
#######################################################################
  config.vm.define :chemwiki do |node|
 
    node.vm.box              = "bento/centos-7.6"
    node.vm.box_check_update = false
    node.vm.hostname         = workstation_hostname
    node.vm.network :private_network, :ip => workstation_ip
    node.vm.network "forwarded_port", guest: 443, host: 1443
    node.vm.network "forwarded_port", guest: 8140, host: 18141
   
    node.vm.synced_folder    ".", "/vagrant", disabled: false
	  node.vm.synced_folder    'C:\Users\ehogg\Documents\PROJ\IC_CHEMWIKI\vagrant\_DATA', '/var/www/html', disabled: false

    node.vm.provider "virtualbox" do |vb|
      vb.memory = "2000"
      vb.cpus = "2"
      
    end
  
  end

end
