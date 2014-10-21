Vagrant.configure("2") do |config|

	config.vm.box = "puppet_box_python"	
	config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210-nocm.box"

	if defined? VagrantVbguest
	  config.vbguest.auto_update = true
	end

	config.vm.provider :virtualbox do |vb|
	  vb.customize ["modifyvm", :id, "--memory", "1024"]
	end

	config.vm.provision "shell", inline: "ls /vagrant/scripts"

	#this is working now
	config.vm.provision "shell", path: "scripts/bootstrap.sh"

	config.vm.provision :puppet do |puppet|
		puppet.manifests_path = "manifests"
		puppet.manifest_file = "init.pp"
		puppet.module_path = "modules"
		puppet.options = "--verbose --debug"
	end

	#sudo apt-get install libxerces-c-samples
	#end run around puppet's handling of env vars (not so hot)
	#export PATH="$PATH:/home/vagrant/xerces-c-3.1.1-x86_64-linux-gcc-3.4/bin"
    #export LD_LIBRARY_PATH=/home/vagrant/xerces-c-3.1.1-x86_64-linux-gcc-3.4/lib:$LD_LIBRARY_PATH
    #/usr/bin/xerces

    config.vm.provision "shell", inline: "export PATH=$PATH:/usr/bin/xerces/bin" 
    config.vm.provision "shell", inline: "export LD_LIBRARY_PATH=/usr/bin/xerces/lib:$LD_LIBRARY_PATH"

    config.vm.provision "shell", inline: "ls /usr/bin/xerces"

    config.vm.provision "shell", inline: "echo $PATH"

end