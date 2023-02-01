#!/bin/bash


grep 'Alex:\|Generating Measurement Report\|Handover triggered\|RRC handover initiated\| rsrp_filtered\|pfram\|State = RRC_RECONFIGURED during HO' logs_epc/UE.log
#grep 'Handover triggered' logs_epc/UE.log
#grep 'State = RRC_RECONFIGURED during HO (eNB 1)' logs_epc/UE.log
#grep 'Handover triggered\|State = RRC_RECONFIGURED during HO (eNB 1)' logs_epc/UE.log
#grep handover initiated logs_epc/UE.log
