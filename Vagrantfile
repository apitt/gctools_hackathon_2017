# -*- mode: ruby -*-
# vi: set ft=ruby :

# warning the below vagrant command does not give the most up to date of docker-compose 
## vagrant up --provider=docker 


Vagrant.configure(2) do |config|
	config.vm.box = "ubuntu/trusty64"
  	config.vm.hostname = "gctools-host"
	config.vm.box_check_update = true
	config.vm.provision :docker
	config.vm.synced_folder "C:\\temp\\gctools.hackathon.2017\\web-content", "/web-content" 
	config.vm.synced_folder "C:\\temp\\gctools.hackathon.2017\\downloads", "/downloads"
	config.vm.synced_folder "C:\\temp\\gctools.hackathon.2017\\junk", "/junk"
	config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true
	config.vm.network :private_network, ip: "192.168.68.8"

	# todo copy your hosts gitconfig
	## config.vm.provision "file", source: "~/.gitconfig", destination: "~/.gitconfig"

	# todo add second monitor support
	## https://stackoverflow.com/questions/33667800/configure-multiple-monitors-with-vagrant
	## vb.customize ["modifyvm", :id, "--monitorcount", "2"]

	## Not sure how to get make sure the following lines aren't fragile.
	#config.vm.box_url = "https://atlas.hashicorp.com/ubuntu/boxes/trusty64/versions/20170302.0.0/providers/virtualbox.box"
	#config.vm.box_download_checksum = ""
	#config.vm.box_download_checksum_type = "sha256"
	
	config.vm.post_up_message = <<-MSG
		Welcome to your Docker development workstation.

		FAQ
		Q: How to I set up up multi-monitor mode using virtualbox?
		A: Follow the instructions here: http://xmodulo.com/how-to-set-up-dual-monitors-for-ubuntu-guest-on-virtualbox.html


	MSG

	# TODO - sync to static website folder
	# 
	# config.vm.synced_folder = ""
	# config.vm.synced_folder "/my-workspace/project", "/project"
	# config.vm.synced_folder "/my-workspace", "/workspace"

  	config.vm.provider "virtualbox" do |vb|
    	vb.gui = true
     	vb.memory = "4096"

  	end
    
  # configure the box with all the tools you need. 
  ## config.vm.provision "shell", inline: <<-SHELL
  config.vm.provision :shell, :path => "bootstrap.sh"
end