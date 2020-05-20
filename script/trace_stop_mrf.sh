#!/bin/bash


proc_id=$(ps -ef | grep -m1  $1 | awk '{print $2}')
echo
echo
kill -2 $proc_id
echo
echo
kill -9 $proc_id
