#!/bin/bash
cd "$(dirname "$0")"
cd openairinterface5g

source oaienv
cd cmake_targets/

echo "Compiling"
./build_oai --eNB --UE 
cd
./do_sim.sh
#./execute_handover_s1.sh
