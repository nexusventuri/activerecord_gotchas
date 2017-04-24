# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

Vagrant.configure('2') do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = 'ubuntu/xenial64'

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", '512']
    vb.customize ["modifyvm", :id, "--cpus", '1']
    vb.customize ["modifyvm", :id, "--acpi", "off"]

    # This should help with time desync, from StackOverflow: http://stackoverflow.com/questions/19490652/how-to-sync-time-on-host-wake-up-within-virtualbox
    vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000 ]

    vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    vb.name = "activerecord_gotchas"
  end

  config.vm.network :forwarded_port, guest: 3000, host: 5000

  config.vm.network :private_network, ip: '33.33.33.11'
  config.vm.synced_folder '.', '/vagrant', nfs: true

  config.vm.synced_folder 'activerecord_gotchas', '/activerecord_gotchas', type: 'nfs'

  # Forward X11
  config.ssh.forward_x11 = true

  config.vm.provision 'shell', path: 'provision/provision.sh'

  config.ssh.insert_key = false
  config.ssh.forward_agent = true
end
