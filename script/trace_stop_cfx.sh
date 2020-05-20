#!/bin/bash

cd /tmp

mkdir CIF 
mkdir TDCORE
cif_ip=$(cat cif_ip_list)


echo "$cif"
echo
echo
sleep 5s
echo
echo
echo


ssh $cif << EOF
	
	echo
	echo
	echo
	echo
	killall -9 tcpdump	
	echo
	echo
	echo
	sleep 5s
EOF

cat tdcore_list | while read line 
do
   
	echo
	echo
	echo
	echo
	mkdir $line"_TDCORE"



ssh $line << EOF
	
	echo
        echo
        echo
        echo
		killall -9 tcpdump
        echo
        echo
        echo
	sleep 5s
EOF

sleep 5s
echo
echo
echo
scp $line:/tmp/TDCORE_TRACE.pcap /tmp/TDCORE/$line"_TDCORE"
echo
echo
echo
echo
sleep 5s
echo
echo
echo
ssh $line "rm -rf /tmp/TDCORE_TRACE.pcap"

done
sleep 5s
echo 
echo
echo
echo "#########################COPYING FILeS#########################"

scp $cif:/tmp/CFX_Trace.pcap /tmp/CIF/


ssh $cif "rm -rf /tmp/CFX_Trace.pcap"


tar -xvf TDCORE.tar TDCORE
tar -xvf CIF.tar CIF