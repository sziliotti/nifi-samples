# Apache NiFi Samples
The objetive of this project is show some examples of data ingestion using [Apache NiFi](https://nifi.apache.org/). Apache NiFi supports powerful and scalable directed graphs of data routing, transformation, and system mediation logic.

The descriptions of samples are detailed in the sections below.

## Prerequisites
Experienced Linux user, knowledge in Java, containers, Big Data concept and tools, and that you have Ansible, Vagrant and Virtualbox installed on your machine. 

### Installed on your desktop
* macOS High Sierra (v10.13.6) (My host Operating System)
* Vagrant 2.1.1
* Virtualbox 5.1.24
* [Ansible 2.6.2](https://www.ansible.com/)
* [Spring Tool Suite](https://spring.io/tools/sts)
* [VS Code](https://code.visualstudio.com/)

### Will be installed by the automation
* [CentOS 7](https://www.centos.org/)
* [Java 8 (OpenJDK)](http://openjdk.java.net/projects/jdk8/)
* [Docker](https://www.docker.com/)
* [Maven](https://maven.apache.org/)
* [Hadoop](http://hadoop.apache.org/)
* [Kafka](http://kafka.apache.org/) (by Docker [image](https://hub.docker.com/r/wurstmeister/kafka/))
* [Kafka Manager](https://github.com/yahoo/kafka-manager) (by Docker [image](https://hub.docker.com/r/sheepkiller/kafka-manager/)) 
* [Elasticsearch](https://www.elastic.co/) (by Docker [image](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html))
* [kibana](https://www.elastic.co/products/kibana) (by Docker [image](https://www.elastic.co/guide/en/kibana/current/docker.html))
* [Apache NiFi](https://nifi.apache.org/) (by Docker [image](https://hub.docker.com/r/apache/nifi/))
<!-- * [Apache MiNiFi](https://nifi.apache.org/minifi/) (by Docker [image](https://hub.docker.com/r/apache/nifi-minifi/)) -->

## Topology
TODO

## Features
* Create and boot VirtualBox instances.
* Provisioning of hosts with all necessary tools.
* Provisioning of a cluster for Hadoop.
* Provisioning of Kafka, Kafka Manager, Apache NiFi, Elasticsearch and Kibana containers images by Docker Compose.
* You can SSH into the instances using ```vagrant ssh <host>```.
* Automatic SSH key generation to access your hosts through vagrant commands.


The Hadoop cluster consists of 3 nodes:

* Master node with 1GB of RAM (Running the NameNode, Hue, ResourceManager etc. after installing the Hadoop services)
* 2 slaves with 512MB of RAM each (Running DataNodes)

As you can see, you'll need at least 8GB of free RAM to run this lab. If you have less, you can try to remove one machine from the Vagrantfile, or using Hadoop in a single node. This will lead to worse performance though!

## Ansible playbook structure
This is how the provisioning´s scripts, ansible playbooks and roles are organized:

```bash
$ tree provisioning/
provisioning/
├── ansible
│   ├── nifi-dev-playbook.yml
│   └── roles
│       ├── docker
│       │   ├── handlers
│       │   │   └── main.yml
│       │   └── tasks
│       │       └── main.yml
│       ├── general
│       │   ├── handlers
│       │   │   ├── main.yml
│       │   │   └── restart-mdns.yml
│       │   └── tasks
│       │       ├── main.yml
│       │       ├── packages.yml
│       │       └── security.yml
│       └── java
│           └── tasks
│               └── main.yml
├── docker-compose
│   └── docker-compose.yml
└── scripts
    ├── setup-hadoop-slaves.sh
    └── setup-hadoop.sh

12 directories, 12 files
```

## Usage
Depending on the hardware of your computer and specifications choice in the Hadoop cluster configuration, installation will probably take between 5 and 15 minutes.

1. [Download and install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Download and install Vagrant](http://www.vagrantup.com/).
3. Install the Vagrant [Hostmanager plugin](https://github.com/smdahlen/vagrant-hostmanager)
    ```bash
    $ vagrant plugin install vagrant-hostmanager
    ```

4. Clone this repository.
    ```bash
    $ git clone https://github.com/sziliotti/nifi-samples.git
    ```

5. Provision the bare cluster. It will ask you to enter your password, so it can modify your `/etc/hosts` file for easy access in your browser. It uses the Vagrant Hostmanager plugin to do this.

6. Change directory (cd) into this project (directory).
    ```bash
    $ cd nifi-samples
    ```
7. Make sure you are in the right directory and Vagrantfile is on the same path where you type the command to start the provisioning, and run ```vagrant up``` to create the VM.
8. Run ```vagrant ssh``` to get into your VM.
9. Run ```vagrant destroy``` when you want to destroy and get rid of the VM.


## Web UI
Once built, the Web UIs are available at:
* JobTracker web interface: (http://127.0.0.1:50030/jobtracker.jsp)
* NameNode web interface: (http://127.0.0.1:50070/dfshealth.html) (only when HDFS is enabled)
* Nifi web interface: (http://192.168.50.30:9090/nifi)
* Kafka Manager web interface: (http://192.168.50.30:9000/)
* Elasticsearch web interface: (http://192.168.50.30:9200/_cat/health)
* Kibana web interface: (http://192.168.50.30:5601/)

**Note:** Hadoop will use a lot of disk space for the slaves when building a cluster.

<br><br>
****************************************************************************************************
## NiFi Samples Descriptions

### Data Flow 1 - Twitter to Elasticsearch
TODO - General Description

More details [here](SAMPLES/Twitter_Elasticsearch/README.md).

### Data Flow 2 - Mainframe Simulator to HDFS
TODO - General Description

More details [here](xxxx).

### Data Flow 3 - Database Table to Hive
TODO - General Description

More details [here](xxxx).

### Data Flow 4 - IoT to Cloud
TODO - General Description

More details [here](xxxx).


<br><br>
:warning: **Keep in mind that this is a personal and basic laboratory, with simple examples to demonstrate DataFlows working in the Apache NiFi.**
