#!/bin/bash


su - rtp99 << EOF
echo
echo
echo


vm=\$(IcmAdminTool.pl PrintRoutingTable | grep 'ActiveNode' | awk '{print \$1}' | cut -d "=" -f 2 | cut -d, --output-delimiter ' ' -f 1,2)


echo "\$vm"
IcmAdminTool.pl PrintRoutingTable | grep \$vm | grep "::" | awk '{print $3}' | cut -d ":" -f 4 > cif
echo
echo
echo
echo
IcmAdminTool.pl PrintRoutingTable | grep 'tdc' | awk '{print \$3}' | cut -d ":" -f 4 > tdcore
echo
echo
echo
echo
ltd=\$(IcmAdminTool.pl PrintRoutingTable | grep 'ActiveVmList\[L2TD\]' | awk '{print \$12}' | cut -d "=" -f 2 | cut -d ")" -f 1 | cut -f2 -d"(")


echo "\$ltd"
IcmAdminTool.pl PrintRoutingTable | grep \$ltd | grep "::" | awk '{print $3}' | cut -d ":" -f 4 > ltd

EOF
