# -*- mode: ruby -*-
# vi: set ft=ruby :

$hosts_script = <<SCRIPT
cat > /etc/hosts <<EOF
127.0.0.1       localhost
EOF
SCRIPT

Vagrant.configure("2") do |config|

    # Provider type
    VAGRANT_VM_PROVIDER = "virtualbox"

    # Use "ansible_local" to executing ansible-playbook directly on the guest machine; 
    # or Use "ansible" to executing ansible-playbook directly on the host machine.
    VAGRANT_ANSIBLE_TYPE_PROVISIONER = "ansible_local"  
    

    # Define base image
    config.vm.box = "centos/7"

    if Vagrant.has_plugin?("vagrant-cachier")
        config.cache.scope = :box
    end
    
    # Manage /etc/hosts on host and VMs(guests)
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = false
    config.hostmanager.manage_guest = true
    config.hostmanager.include_offline = true
    config.hostmanager.ignore_private_ip = false

    # Share an additional folder to the guest VM. The first argument is the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third argument is a set of non-required options.        
    config.vm.synced_folder ".", "/vagrant", type: "rsync", 
        rsync__auto: true, 
        rsync__exclude: ".git/"
    
    # Provider-specific configuration so you can fine-tune various backing providers for Vagrant. These expose provider-specific options.   
    config.vm.provider "virtualbox" do |vb|
        # Synchronize clocks each time when desync becomes > 1s (1000ms) between host and guest.
        vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000 ]      
    end
      

    ## CONFIG HADOOP CLUSTER
    ##***************************************
    ansible_hadoop_playbook_name = ""

    # Total Hadoop nodes
    numNodes = 3
    
    r = 1..numNodes
    (r.first).upto(r.last).each do |i|
        # Hadoop Nodes configurations.
        config.vm.define "hadoop-node#{i}" do |node|
            node.vm.network "private_network", ip: "192.168.50.#{i+10}"
            
            node.vm.provider "virtualbox" do |v|
                v.customize ["modifyvm", :id, "--cpus", 1]
            end
           
            if i == r.first
                node.vm.hostname = "vm-cluster-hadoop-master"
                node.vm.provider "virtualbox" do |v|
                    v.name ="hadoop-master"
                    v.customize ["modifyvm", :id, "--memory", 2048]                    
                end

                ansible_hadoop_playbook_name = "environment/provisioning/ansible/hadoop-master-playbook.yml"

                ## Hadoop Cluster Ports mapping:
                node.vm.network "forwarded_port", guest: 50070, host: 50070, host_ip: "127.0.0.1"

                ## Cloudera Manager web console Ports mapping:
                node.vm.network "forwarded_port", guest: 7180, host: 7180, host_ip: "127.0.0.1"

            else
                node.vm.hostname = "vm-cluster-hadoop-slave#{i-1}"
                node.vm.provider "virtualbox" do |v|
                    v.name = "hadoop-slave#{i-1}"
                    v.customize ["modifyvm", :id, "--memory", 1024]                    
                end
                ansible_hadoop_playbook_name = "environment/provisioning/ansible/hadoop-slave-playbook.yml"
            end

            # Config hosts scripts with hostmanager plugin.
            node.vm.provision "hosts-config", type: "shell", inline: $hosts_script            
            node.vm.provision :hostmanager


            # Enable provisioning with a shell script and Ansible playbook.
            node.vm.provision "#{VAGRANT_ANSIBLE_TYPE_PROVISIONER}" do |ansible|
                ansible.playbook = "#{ansible_hadoop_playbook_name}"
                ansible.verbose = "vv"
            end

        end
    end


    ## CONFIG NIFI ENVIRONMENT
    ##***************************************  
    config.vm.define "nifi-env" do |nifi_env|
        nifi_env.vm.hostname = "vm-nifi-env"
        nifi_env.vm.network "private_network", ip: "192.168.50.30"
        nifi_env.vm.provider "virtualbox" do |v|
            v.name = "nifi-env"
            v.customize ["modifyvm", :id, "--memory", 4096]
            v.customize ["modifyvm", :id, "--cpus", 1]
        end
        

        # Create a forwarded port mapping which allows access to a specific port within the machine from a port on the host
        # machine and only allow access via 127.0.0.1 to disable public access.
        #         
        # Kafka´s Ports mapping:
        nifi_env.vm.network "forwarded_port", guest: 3030, host: 3030, host_ip: "127.0.0.1"
        nifi_env.vm.network "forwarded_port", guest: 2181, host: 2181, host_ip: "127.0.0.1"
        nifi_env.vm.network "forwarded_port", guest: 9092, host: 9092, host_ip: "127.0.0.1"

        ## Kafka Manager Ports mapping:
        nifi_env.vm.network "forwarded_port", guest: 9000, host: 9000, host_ip: "127.0.0.1"

        ## Docker Ports mapping:
        nifi_env.vm.network "forwarded_port", guest: 2375, host: 2375, host_ip: "127.0.0.1"

        ## Apache NiFi Ports mapping:
        nifi_env.vm.network "forwarded_port", guest: 8080, host: 8080, host_ip: "127.0.0.1"

        ## ELK stack (Elasticsearch e Kibana) Ports mapping:
        nifi_env.vm.network "forwarded_port", guest: 9200, host: 9200, host_ip: "127.0.0.1"
        nifi_env.vm.network "forwarded_port", guest: 9300, host: 9300, host_ip: "127.0.0.1"
        nifi_env.vm.network "forwarded_port", guest: 5601, host: 5601, host_ip: "127.0.0.1"

        
        nifi_env.vm.provision "hosts-config", type: "shell", inline: $hosts_script
        nifi_env.vm.provision :hostmanager

        # Enable provisioning with a shell script and Ansible playbook.
        #
        # Softwares instalation: JDK8, Docker and NiFi environment. 
        nifi_env.vm.provision "#{VAGRANT_ANSIBLE_TYPE_PROVISIONER}" do |ansible|
            ansible.playbook = "environment/provisioning/ansible/nifi-env-playbook.yml"
            ansible.verbose = "vv"
        end
    end
    
  end
