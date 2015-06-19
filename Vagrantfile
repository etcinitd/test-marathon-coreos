# -*- mode: ruby -*-
# # vi: set ft=ruby :

require 'fileutils'

Vagrant.require_version ">= 1.6.0"

require_relative 'common'

Vagrant.configure("2") do |config|
  # always use Vagrants insecure key
  config.ssh.insert_key = false

  config.vm.box = "test/coreos"

  master_ips = Common.get_ips(Common::MASTER_BOX)
  [Common::MASTER_BOX, Common::WORKER_BOX].each do |box|
    Common.get_ips(box).each_with_index do |ip, index|
      instance_name = box[:name] + "-#{index+1}"
      config.vm.define instance_name do |node|
        node.vm.provider :virtualbox do |v|
          # On VirtualBox, we don't have guest additions or a functional vboxsf
          # in CoreOS, so tell Vagrant that so it can be smarter.
          v.check_guest_additions = false
          v.functional_vboxsf     = false
        end

        # plugin conflict
        if Vagrant.has_plugin?("vagrant-vbguest") then
          config.vbguest.auto_update = false
        end

        # Inject the cloud config
        if File.exist?(Common::CLOUD_CONFIG_PATH)
          node.vm.provision :file, :source => "#{Common::CLOUD_CONFIG_PATH}", :destination => "/tmp/vagrantfile-user-data"
          node.vm.provision :shell, :inline => "cp /tmp/vagrantfile-user-data /var/lib/coreos-vagrant/", :privileged => true
        end

        node.vm.hostname = instance_name
        node.vm.provider :virtualbox do |vb|
          vb.gui = false
          vb.memory = box[:memory]
          vb.cpus = box[:cpus]
        end

        node.vm.network :private_network, ip: ip

        # Get our environment variables
        environment_variables = {
            :ncp_unique_cloud_id => (index+1).to_s,
            :ncp_ip => ip.to_s,
            :ncp_masters => "\\\"" + master_ips.join(' ') + "\\\"",
            :ncp_num_masters => master_ips.length.to_s
        }.map { |key, value| "#{key.upcase}=#{value}" }.join("\n")

        # Inject our environment variables.
        node.vm.provision :shell, inline: "echo \"#{environment_variables}\" | tee -a /etc/ncp_environment", :privileged => true



        # We need to restart our system to make cloud config take effect before we try and run a script it creates.
        node.vm.provision :reload

        # Start (TODO: Make this start on boot instead of via vagrant)
        node.vm.provision :shell, :inline => "/home/core/#{box[:script]}", :privileged => true
      end
    end
  end
end
