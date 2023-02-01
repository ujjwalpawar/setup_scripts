#!/bin/bash
cd "$(dirname "$0")"

mkdir /local/repository/scripts/core
mkdir /local/repository/config
mkdir /local/repository/config/core

ip=$(ifconfig eno1 | awk '$1 == "inet" {print $2}')
echo $ip
./modify_ip_proxy.sh $ip
cp -a open5gs_setup.sh /local/repository/scripts/core/
cp -a core_run.sh /local/repository/scripts/core/
cp -a config.yaml /local/repository/config/core/

cd /local/repository/scripts/core/
sudo ./open5gs_setup.sh
