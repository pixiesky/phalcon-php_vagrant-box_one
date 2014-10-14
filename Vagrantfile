# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"


# Options that you can change by your own-self.

#################################################################################################################################
# Set your VirtualBox name.
HOST_NAME               = "phalcon.local"

# She canni take much more captin!
MEMORY                  = 2048
CPU_CORES               = 2

# Each box must have it's own port to forward on in order to use the IP address below.
# NOT PORT 80. WARNING: Turn off Skype also or change the default port on Skype.
PORT                    = 4755 

# Such as, 192.168.33.xxx.
IP_ADDRESS              = "192.168.33.110"

# Run a Bootstrap Shell Script? true or false.
# This is normally for installing and setup. If unsure then it's probably false.
LOAD_BOOTSTRAP          = true
BOOTSTRAP_NAME          = "bootstrap.sh"

# Which Box? You must 'vagrant box add --name {org/name} [LOCATION]' first for in house boxes.
# e.g. chef/centos-6.5
VM_BOX                  = "chef/centos-6.5"

# Set this to false if not needed
VM_LOCATION             = false

#################################################################################################################################




# Don't touch unless you know what you're doing!
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # The Base box
  config.vm.box = VM_BOX

  if VM_LOCATION != false
    config.vm.box_url = VM_LOCATION
  end
  
  # host: 0000 must be diferent for each host you fire up so you can select different IP addresses
  config.vm.network "forwarded_port", guest: 80, host: PORT

  # Set your IP address 192.168.33.xx
  config.vm.network "private_network", ip: IP_ADDRESS

  # Run a shell script after loading the box. Should be in the root folder.
  if LOAD_BOOTSTRAP == true
    config.vm.provision :shell, path: BOOTSTRAP_NAME
  end

  config.vm.hostname = HOST_NAME

  config.vm.provider :virtualbox do |vb|
      # Vbox setup
      vb.name = HOST_NAME
      vb.memory = MEMORY
      vb.cpus = CPU_CORES
  end
end