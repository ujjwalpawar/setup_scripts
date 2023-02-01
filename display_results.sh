#!/bin/bash
for ii in {1..6..1}
do
  tshark -n -r automatic/$ii/epc.pcap -Y 'gtp' -T fields -e frame.number  -e frame.time_relative -e ip.src -e ip.dst -e _ws.col.Info
  echo "------------------------"
  tshark -n -r automatic/$ii/enb.pcap -Y 'x2ap or s1ap'
  echo "------------------------"

  sleep 20
done

