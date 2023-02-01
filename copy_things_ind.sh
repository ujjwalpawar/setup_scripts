#!/bin/bash

cd "$(dirname "$0")"

epc=$1
if [ "$epc" = "" ]; then
  echo "Missing epc id"
  exit 1
fi
enb1=$2
if [ "$enb1" = "" ]; then
  echo "Missing enb1 id"
  exit 1
fi

enb2=$3
if [ "$enb2" = "" ]; then
  echo "Missing enb2 id"
  exit 1
fi

proxy=$4
if [ "$proxy" = "" ]; then
  echo "Missing proxy id"
  exit 1
fi


folder=$5
if [ "$folder" = "" ]; then
  echo "Missing folder 1"
  exit 1
fi

mkdir $folder
scp -r alexbp@pc${epc}.emulab.net:~/logs_epc/epc.pcap $folder/epc.pcap &
scp -r alexbp@pc${enb1}.emulab.net:~/logs_epc/enb1.pcap $folder/enb1.pcap &
scp -r alexbp@pc${enb2}.emulab.net:~/logs_epc/enb2.pcap $folder/enb2.pcap &
scp -r alexbp@pc${proxy}.emulab.net:~/logs_epc/proxy.pcap $folder/proxy.pcap &
scp -r alexbp@pc${enb1}.emulab.net:~/logs_epc/eNB1.log $folder/ &
scp -r alexbp@pc${enb2}.emulab.net:~/logs_epc/eNB2.log $folder/ &
scp -r alexbp@pc${proxy}.emulab.net:~/logs_epc/UE.log $folder/ &
scp -r alexbp@pc${proxy}.emulab.net:~/logs_epc/ping.txt $folder/ &

sleep 40

