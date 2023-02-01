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


#epc=$1
#if [ "$epc" = "" ]; then
#  echo "Missing epc id"
#  exit 1
#fi

myips=(" " " " " " " ")

echo "Checking ssh"
devs=$epc" "$enb1" "$enb2" "$proxy
#for dev in $devs ; do
#  echo ${dev}
#  result=$(ssh alexbp@pc${dev}.emulab.net ifconfig eno1 | awk '$1 == "inet" {print $2}')
#  echo $result 
#done
devs=($epc $enb1 $enb2 $proxy)
for ii in {0..3..1}
do
  echo ${devs[$ii]}
  dev=${devs[$ii]}
  myips[$ii]=$(ssh alexbp@pc${dev}.emulab.net ifconfig eno1 | awk '$1 == "inet" {print $2}')
  
  echo ${myips[$ii]}
done
echo ${myips[1]}
ssh alexbp@pc${proxy}.emulab.net ./modify_proxy_ue.sh ${myips[1]} ${myips[2]} ${myips[3]}
