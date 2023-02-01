#!/bin/bash
cd "$(dirname "$0")"

ipenb=$1

if [ "$ipenb" = "" ]; then
  echo "Missing the enb ip" 
  exit 1
fi

ipepc=$2

if [ "$ipepc" = "" ]; then
  echo "Missing the epc ip"
  exit 1
fi

ipproxy=$3

if [ "$ipproxy" = "" ]; then
  echo "Missing the proxy ip"
  exit 1
fi

cp -a openairinterface5g/ci-scripts/conf_files/episci/proxy_rcc.band7.tm1.nfapi.conf ~/enb.conf

sed -i -e 's:"lo":"eno1":g' ~/enb.conf 
sed -i -e "s:192.168.61.3:$ipepc:g" ~/enb.conf 
sed -i -e "s:127.0.0.1:$ipenb:g" ~/enb.conf
str1=\""$ipenb"\"
str2="remote_s_address = "$str1
echo $str2

str3=\""$ipproxy"\"
str4="remote_s_address = "$str3
echo $str4


sed -i -e "s:$str2:$str4:g" ~/enb.conf 
#sed -i -e 's:192.168.61.3:127.0.0.100:g' openairinterface5g/ci-scripts/conf_files/episci/proxy_rcc.band7.tm1.nfapi.conf

sed -i -e 's:320:208:g' ~/enb.conf 
sed -i -e 's:230:93:g' ~/enb.conf
sed -i -e 's:mnc_length = 3:mnc_length = 2:g' ~/enb.conf
