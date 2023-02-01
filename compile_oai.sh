#!/bin/bash
cd "$(dirname "$0")"

oaiexist=$1

if [ "$oaiexist" = "" ]; then
  echo "Missing the variable to either clone the repository or use an existing one. 0 means cloning and 1 using the existing"
  exit 1
fi
if [ "$oaiexist" = "0" ]; then
  echo "Cloning"
  git clone https://github.com/alejandroBlancoPizarro/openairinterface5g.git
  #mv OAI_alex openairinterface5g
  #echo "Taking the branch episys-lte-handover"
  #cd openairinterface5g
  #git checkout episys-lte-handover
fi

cd ~/openairinterface5g
source oaienv
cd cmake_targets/

echo "Compiling"
./build_oai -I --eNB --UE -C

