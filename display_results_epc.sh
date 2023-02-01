#!/bin/bash

grep HANDOVER logs_epc/eNB1.log 
grep handover logs_epc/eNB2.log
echo "------------------------"
tshark -n -r logs_epc/enb.pcap -Y 'x2ap or s1ap'
echo "------------------------"
tshark -n -r logs_epc/epc.pcap -Y 'gtp' -T fields -e frame.number  -e frame.time_relative -e ip.src -e ip.dst -e _ws.col.Info
#grep handover initiated logs_epc/UE.log
