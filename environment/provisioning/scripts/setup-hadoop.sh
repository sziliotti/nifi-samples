#!/bin/bash

wget -O /etc/yum.repos.d/cloudera-manager.repo http://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo 
yum -y update

yum -y install oracle-j2sdk1.7 cloudera-manager-server-db cloudera-manager-server cloudera-manager-daemons

service cloudera-scm-server-db initdb
service cloudera-scm-server-db start
service cloudera-scm-server start
