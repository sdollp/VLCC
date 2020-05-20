#!/bin/bash

cd /tmp

su - rtp99 <<EOF

cif-a=$(IcmAdminTool.pl PrintRoutingTable | grep 'ActiveNode' | awk '{print $1}' | cut -d "=" -f 2 | cut -d, --output-delimiter ' ' -f 1,2)

IcmAdminTool.pl PrintRoutingTable | grep $( IcmAdminTool.pl PrintRoutingTable | grep 'ActiveNode' | awk '{print $1}' | cut -d "=" -f 2 | cut -d, --output-delimiter ' ' -f 1,2) | grep "::" | awk '{print $3}' | cut -d ":" -f 4 > cif_ip_list

IcmAdminTool.pl PrintRoutingTable | grep 'tdc' | awk '{print $3}' | cut -d ":" -f 4 > tdcore_list


cif_ip=$(cat cif_ip_list)
echo "$cip_ip"

cat tdcore_list
EOF


sleep 5s


echo
echo
logout
echo
echo


ssh $cif_ip << EOF
	
	echo
	echo
	echo
	echo
	chmod +x /usr/sbin/tcpdump
	nohup tcpdump -vvv -i eth1  -w /tmp/CFX_Trace.pcap >normal.log 2>/dev/null &
	echo
	echo
	echo
	sleep 5s
EOF

echo
echo
echo
echo


cat tdcore_list | while read line 
do
   
	echo
	echo
	echo
	echo


	ssh $line << EOF
		
		echo
			echo
			echo
			echo
			nohup tcpdump -vvv -i eth1  -w /tmp/TDCORE_TRACE.pcap >normal.log 2>/dev/null &
			echo
			echo
			echo
		sleep 5s
EOF


echo
echo
echo
echo

done


