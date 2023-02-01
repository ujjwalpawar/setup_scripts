#!/bin/bash
for ii in {1..20..1}
do
  echo "------------------------"
  echo $ii
  tshark -n -r prueba_delay_target/$ii/epc.pcap -Y 'gtp' -T fields -e frame.number  -e frame.time_relative -e ip.src -e ip.dst -e _ws.col.Info | wc -l
  tshark -n -r prueba_delay_target/$ii/enb1.pcap -Y 'x2ap' | wc -l
  echo "------------------------"

  #sleep 20
done

