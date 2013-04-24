#!/bin/bash
#
# Packet generation tool.
# Captures a pcap file from a payload file (dat)
#

if [ "$1" == "" ]
then
	echo "Usage: $0 <dat file>"
	exit 1
fi

PORT=47123

tcpdump -l -nn -c 1 -i lo port $PORT -w $1.pcap &
sleep 1
hping3 -2 -p $PORT -E $1 -d `stat -c %s $1` -c 1 127.0.0.1
