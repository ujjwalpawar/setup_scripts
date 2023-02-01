#!/bin/bash
cd "$(dirname "$0")"

cp -a sim.conf openairinterface5g/cmake_targets/ran_build/build/
cd openairinterface5g/cmake_targets/ran_build/build/
../../../targets/bin/conf2uedata -c sim.conf -o .
../../../targets/bin/usim -g -c sim.conf -o .
../../../targets/bin/nvram -g -c sim.conf -o .
