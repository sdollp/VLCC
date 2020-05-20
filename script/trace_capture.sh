#!/bin/bash
True="T"
cfed_status=$1
dfed_status=$2
bgc_status=$3
fw_status=$4
sc_status=$5
if [[ "$cfed_status" == "$True" ]]; then
        cfed=$(lcp_status | grep -i 'CFED.*ENABLEDUNLOCKED' | awk '{print $5}')

        if [ "$cfed" == "ENABLEDUNLOCKED" ]
        then
	       cfed=$(lcp_status | grep -i 'CFED.*ENABLEDUNLOCKED' | awk '{print $6}')
        fi
        echo "$cfed" > vm_status
        ssh $cfed << EOF
        
        echo
        echo
        echo
        echo
        
        nohup tcpdump -i any -s 0 -w /storage/cfed25.pcap >normal.log 2>/dev/null &
        echo
        echo
        echo
        sleep 5s
EOF


fi

if [[ "$dfed_status" == "$True" ]]; then
        dfed=$(lcp_status | grep -i 'DFED.*ENABLEDUNLOCKED' | awk '{print $5}')
        if [ "$dfed" == "ENABLEDUNLOCKED" ]
        then
	       dfed=$(lcp_status | grep -i 'DFED.*ENABLEDUNLOCKED' | awk '{print $6}')
        fi
        echo "$dfed" > vm_status
        ssh $dfed << EOF
        
        echo
        echo
        echo
        echo
        nohup tcpdump -i any -s 0 -w /storage/dfed25.pcap >normal.log 2>/dev/null &
        echo
        echo
        echo
        sleep 5s
EOF

fi

if [[ "$fw_status" == "$True" ]]; then
        fw=$(lcp_status | grep -i 'FEPH.*ENABLEDUNLOCKED' | awk '{print $5}')
        if [ "$fw" == "ENABLEDUNLOCKED" ]
        then
	       fw=$(lcp_status | grep -i 'FEPH.*ENABLEDUNLOCKED' | awk '{print $6}')
        fi
        echo "$fw" > vm_status
        ssh $fw << EOF


        echo
        echo
        echo
        echo
        nohup tcpdump -i any -s 0 -w /storage/fw25.pcap >normal.log 2>/dev/null &
        echo
        echo
        echo
        sleep 5s
EOF
fi

if [[ "$bgc_status" == "$True" ]]; then
        bgc=$(lcp_status | grep -m1 -i 'H248.*ENABLEDUNLOCKED' | awk '{print $5}') 
        if [ "$bgc" == "ENABLEDUNLOCKED" ]
        then
	       bgc=$(lcp_status | grep -m1 -i 'H248.*ENABLEDUNLOCKED' | awk '{print $6}')
        fi
        echo "$bgc" > bgc_status
        chmod 755 *

        cat bgc_status

        sleep 5s
        cat bgc_status | while read line
do
        echo
        echo
        ssh $line << EOF
                echo
                echo
                echo
                echo
                nohup tcpdump -i any -s 0 -w /storage/bgw${line}.pcap >normal.log 2>/dev/null &
                echo
                echo
                echo
                sleep 5s
EOF


echo
echo
done
fi

if [[ "$sc_status" == "$True" ]]; then
        sc=$(lcp_status | grep -i 'IMS.*ENABLEDUNLOCKED' | awk '{print $5}' | xargs -n1 | sort -u | xargs | tr " " "\n") 
        if [ "sc" == "ENABLEDUNLOCKED" ]
        then
               sc=$(lcp_status | grep -i 'IMS.*ENABLEDUNLOCKED' | awk '{print $6}' | xargs -n1 | sort -u | xargs | tr " " "\n")
        fi
        echo "$sc" > sc_status
        chmod 755 *

        cat sc_status

        sleep 5s
        cat sc_status | while read line
do
        echo
        echo
        ssh $line << EOF
                echo
                echo
                echo
                echo
                nohup tcpdump -i any -s 0 -w /storage/sc${line}.pcap >normal.log 2>/dev/null &
                echo
                echo
                echo
                sleep 5s
EOF


echo
echo
done
fi


