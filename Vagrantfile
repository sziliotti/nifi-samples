# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    
    # Define base image
    config.vm.box = "centos/7"
        
    # Manage /etc/hosts on host and VMs
    config.hostmanager.enabled = false
    config.hostmanager.manage_host = true
    config.hostmanager.include_offline = true
    config.hostmanager.ignore_private_ip = false
      

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine and only allow access
    # via 127.0.0.1 to disable public access
    # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
      
    # Kafka´s Ports mapping:
    config.vm.network "forwarded_port", guest: 3030, host: 3030, host_ip: "127.0.0.1"
    config.vm.network "forwarded_port", guest: 2181, host: 2181, host_ip: "127.0.0.1"
    config.vm.network "forwarded_port", guest: 9092, host: 9092, host_ip: "127.0.0.1"

    ## Kafka Manager Ports mapping:
    config.vm.network "forwarded_port", guest: 9000, host: 9000, host_ip: "127.0.0.1"

    ## Docker Ports mapping:
    config.vm.network "forwarded_port", guest: 2375, host: 2375, host_ip: "127.0.0.1"

    ## Apache NiFi Ports mapping:
    config.vm.network "forwarded_port", guest: 9090, host: 9090, host_ip: "127.0.0.1"

    ## ELK stack (Elasticsearch e Kibana) Ports mapping:
    config.vm.network "forwarded_port", guest: 9200, host: 9200, host_ip: "127.0.0.1"
    config.vm.network "forwarded_port", guest: 9300, host: 9300, host_ip: "127.0.0.1"
    config.vm.network "forwarded_port", guest: 5601, host: 5601, host_ip: "127.0.0.1"

    ## Hadoop Cluster Ports mapping:
    config.vm.network "forwarded_port", guest: 50070, host: 50070, host_ip: "127.0.0.1"

   

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.        
    config.vm.synced_folder ".", "/vagrant", type: "rsync",
      rsync__auto: true,
      rsync__exclude: ".git/"
  
  
    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.   
    config.vm.provider "virtualbox" do |vb|
    #   # Synchronize clocks each time when desync becomes > 1s (1000ms) between host and guest.
        vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000 ]
  
    #   # Customize the amount of memory on the VM:
        vb.memory = "4048"
    end

  
    # Enable provisioning with a shell script and Ansible playbook.
    #
    # Softwares instalation: JDK8, Docker, Hadoop Cluster. 
    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "environment/provisioning/ansible/nifi-dev-playbook.yml"
        ansible.verbose = "v"
    end
    
  end
  