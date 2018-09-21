#!/bin/bash

cat > /etc/yum.repos.d/cloudera-manager.repo <<EOF
[cloudera-manager]
name = Cloudera Manager, Version 5.10.1
baseurl = https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/5.10.1/
gpgkey = https://archive.cloudera.com/redhat/cdh/RPM-GPG-KEY-cloudera
gpgcheck = 1
EOF

yum -y update

yum -y install oracle-j2sdk1.7 
yum -y install cloudera-manager-server
yum -y install cloudera-manager-server-db-2
yum -y install cloudera-manager-daemons
yum -y install cloudera-manager-agent

service cloudera-scm-server-db initdb
service cloudera-scm-server-db start
service cloudera-scm-server start
#service cloudera-scm-agent start
