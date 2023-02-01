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

echo "Doing prerequisites"
for ii in {0..3..1}
do
  pc=${devs[$ii]}
  if [ $ii = 3 ];
  then
    #ssh alexbp@pc${pc}.emulab.net ifconfig eno1 | awk '$1 == "inet" {print $2}'
    #echo $pc
    ./prerequisites.sh $pc
  else
    #ssh alexbp@pc${pc}.emulab.net ifconfig eno1 | awk '$1 == "inet" {print $2}' &
    #echo $pc
    ./prerequisites.sh $pc &
  fi
done

ssh alexbp@pc${epc}.emulab.net ./config_open5gs.sh &
ssh alexbp@pc${enb1}.emulab.net ./compile_all.sh 0 &
ssh alexbp@pc${proxy}.emulab.net ./compile_all.sh 0 &
ssh alexbp@pc${enb2}.emulab.net ./compile_all.sh 0

ssh alexbp@pc${enb1}.emulab.net ./modify_enb1.sh ${myips[1]} ${myips[0]} ${myips[3]}
ssh alexbp@pc${enb2}.emulab.net ./modify_enb2.sh ${myips[1]} ${myips[2]} ${myips[0]} ${myips[3]} 


ssh alexbp@pc${proxy}.emulab.net ./do_sim.sh


