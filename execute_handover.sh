#!/bin/bash
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


# killing everything
#ssh alexbp@pc${epc}.emulab.net '~/./kill_epc.sh'
#ssh alexbp@pc${enb1}.emulab.net '~/./kill_all.sh'
#ssh alexbp@pc${enb2}.emulab.net '~/./kill_all.sh'
#ssh alexbp@pc${proxy}.emulab.net '~/./kill_all.sh'


cd "$(dirname "$0")"

folder=logs_epc

#if [ "$folder" = "" ]; then
#  echo "Missing the folder to save the logs"
#  exit 1
#fi
ssh alexbp@pc${epc}.emulab.net "rm -rf ~/$folder" &
ssh alexbp@pc${enb1}.emulab.net "rm -rf ~/$folder" &
ssh alexbp@pc${enb2}.emulab.net "rm -rf ~/$folder" &
ssh alexbp@pc${proxy}.emulab.net "rm -rf ~/$folder"

ssh alexbp@pc${epc}.emulab.net "mkdir ~/$folder" &
ssh alexbp@pc${enb1}.emulab.net "mkdir ~/$folder" &
ssh alexbp@pc${enb2}.emulab.net "mkdir ~/$folder" &
ssh alexbp@pc${proxy}.emulab.net "mkdir ~/$folder"

echo "getting the ips"
myips=(" " " " " " " ")
devs=($epc $enb1 $enb2 $proxy)
for ii in {0..3..1}
do
  echo ${devs[$ii]}
  dev=${devs[$ii]}
  myips[$ii]=$(ssh alexbp@pc${dev}.emulab.net ifconfig eno1 | awk '$1 == "inet" {print $2}')

  echo ${myips[$ii]}
done

echo "Running epc"
#ssh alexbp@pc${epc}.emulab.net "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
#ssh alexbp@pc${epc}.emulab.net "/local/repository/scripts/core/./core_run.sh | tee ~/$folder/epc.log" &

echo "Capturing by tcpdump"
ssh alexbp@pc${epc}.emulab.net "sudo /usr/sbin/tcpdump -i any -w ~/$folder/epc.pcap" &

sleep 5
echo "Executing the eNBs"
ssh alexbp@pc${enb1}.emulab.net "bash -l ~/./execute_enb12.sh $folder" &
ssh alexbp@pc${enb1}.emulab.net "sudo /usr/sbin/tcpdump -i any -w ~/$folder/enb1.pcap" &
sleep 5
ssh alexbp@pc${enb2}.emulab.net "bash -l ~/./execute_enb2.sh $folder" &
ssh alexbp@pc${enb2}.emulab.net "sudo /usr/sbin/tcpdump -i any -w ~/$folder/enb2.pcap" &

sleep 5
echo "Executing proxy"

ssh alexbp@pc${proxy}.emulab.net "sudo /usr/sbin/tcpdump -i any -w ~/$folder/proxy.pcap" &
ssh alexbp@pc${proxy}.emulab.net "~/./execute_proxy.sh ${myips[1]} ${myips[2]} ${myips[3]} $folder" &

sleep 5 
echo "Executing UE"
ssh alexbp@pc${proxy}.emulab.net "~/./execute_ue_s1.sh $folder" &
ssh alexbp@pc${proxy}.emulab.net "~/./check_interface.sh $folder" &

sleep 30 

echo "Killing"
# killing everything
#ssh alexbp@pc${epc}.emulab.net '~/./kill_epc.sh'
ssh alexbp@pc${enb1}.emulab.net '~/./kill_all.sh'
ssh alexbp@pc${enb2}.emulab.net '~/./kill_all.sh'
ssh alexbp@pc${proxy}.emulab.net '~/./kill_all.sh'
ssh alexbp@pc$epc.emulab.net sudo pkill -f tcpdump
ssh alexbp@pc$enb1.emulab.net sudo pkill -f tcpdump
ssh alexbp@pc$enb2.emulab.net sudo pkill -f tcpdump
ssh alexbp@pc$proxy.emulab.net sudo pkill -f tcpdump
ssh alexbp@pc$proxy.emulab.net sudo pkill -f ping
ssh alexbp@pc$proxy.emulab.net 'sudo pkill -f check_interface.sh'
#ssh alexbp@pc${proxy}.emulab.net "cat ~/$folder/ping.txt"

sleep 5
ssh alexbp@pc${proxy}.emulab.net "cat ~/$folder/ping.txt"
ssh alexbp@pc${enb1}.emulab.net "tshark -n -r ~/$folder/enb1.pcap -Y 'gtp' -T fields -e frame.number  -e frame.time_relative -e ip.src -e ip.dst -e _ws.col.Info"
echo "------------------------"
ssh alexbp@pc${enb2}.emulab.net "tshark -n -r ~/$folder/enb2.pcap -Y 'gtp' -T fields -e frame.number  -e frame.time_relative -e ip.src -e ip.dst -e _ws.col.Info"
echo "------------------------"
ssh alexbp@pc${enb1}.emulab.net "tshark -n -r ~/$folder/enb1.pcap -Y 'x2ap or s1ap or gtp'"
echo "------------------------"
