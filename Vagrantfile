Vagrant.configure("2") do |config|

	config.vm.box = "puppet_box_python"	
	config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210-nocm.box"

	if defined? VagrantVbguest
	  config.vbguest.auto_update = true
	end

	config.vm.provider :virtualbox do |vb|
	  vb.customize ["modifyvm", :id, "--memory", "1024"]
	end

	#puppet bootstrap
	config.vm.provision "shell", path: "scripts/bootstrap.sh"

	config.vm.provision :puppet do |puppet|
		puppet.manifests_path = "manifests"
		puppet.manifest_file = "init.pp"
		puppet.module_path = "modules"
		puppet.options = "--verbose --debug"
	end
end