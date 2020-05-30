#!/bin/bash


proc_id=$(ps -ef | grep -m1  $1 | awk '{print $2}')
echo
echo
kill -2 $proc_id
echo
echo
kill -9 $proc_id
echo
sleep 2s
echo "@!@" > mrf_trace_details
echo
echo "############################   !MRF! #######################################" >> mrf_trace_details
ps -ef | grep tcpdump >> mrf_trace_details
echo
echo "@!@" >> mrf_trace_details
echo
