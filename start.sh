#!/usr/bin/env bash
version="1.0"

read -r -d '' usage_cmd << EndUsageText
Version: ${version}
Usage:
  $(basename $0) [--server <ServerAddress>] --topic-name [--help]
EndUsageText

echo -e "$usage_cmd"

## PARAMETER READ SECTION
if [ $# -eq 0 ]; then
  echo -e "" >&2
  echo -e "No parameters provided." >&2
  echo -e "Required parameters are: --server"
  echo -e ""
  echo -e "For help run:"
  echo -e "  $(basename $0) --help" >&2
  echo -e "" >&2
  exit 1
fi

while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    --server)
    server_address="$2"
    shift
    ;;
    --topic-name)
    topic_name="$2"
    shift
    ;;
    --help)
    help=true
    ;;
    *)
    echo "Unknown parameter: ${key}">&2
    echo
    echo -e $usage_cmd >&2
    exit 1
    ;;
esac
shift
done


## HELP command section. Describe your command here
if [ "$help" = true ]; then
cat << EndHelpText
Description:
 Create Kafka topic and consumer

Parameters:
 --server (String)
   Server IP:PORT

 --topic-name (String)
   Name of topic 
    
 --help
    This help information
EndHelpText
echo
exit
fi

if [ -z "$server_address" ]; then
   echo "Error: --server-address is compulsory">&2
   echo
   exit 2
fi

if [ -z "$topic_name" ]; then
  echo "Error: --topic-name is compulsory">&2
  echo
  exit 2
fi


#topic_name="twitter_tweets"
#server_address="localhost:9092"


echo "Starting ZooKeeper service";
result=$(/bin/bash bin/zookeeper-server-start.sh config/zookeeper.properties)

if [ $? -ne 0 ]; then

  st=$(echo ${result} | grep "Address already in use")
  if [ -n "$st" ]; then
      echo "ZooKeeper service is started*******"
  else 
	echo "Error: Failed to start ZooKeeper">&2
     exit 2
	echo "Error: Failed to start ZooKeeper">&2
  exit 2
   fi
fi
echo  "Start the Kafka broker service"

/bin/bash bin/kafka-server-start.sh config/server.properties

echo "Creating topic"
# Start the Kafka broker service
echo "Creating Kafka topic";

/bin/bash bin/kafka-topics.sh --create --topic ${topic_name} --bootstrap-server ${server_address}
echo "Creating Kafka consumer";
/bin/bash bin/kafka-console-consumer.sh --topic ${topic_name} --from-beginning --bootstrap-server ${server_address}

echo "Running.............";

