#!/bin/bash

input1=$1

echo "hello world!"
echo "howdy!"
echo "bye bye"
cat $input1 | grep -i -E "Manager"
echo "to be continued..." 
#awk '{print $1, $4}' $input1
