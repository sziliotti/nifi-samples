#!/bin/bash

echo "======== Create Kafka Topics ==================="
echo "== (*) Mainframe Topic:"
docker exec -it kafka-wurstmeister kafka-topics.sh --create --topic MainframeTopicIn --replication-factor 1 --partitions 1 --zookeeper zookeeper:2181    

