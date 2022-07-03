#!/bin/bash
i=$1
if [[ $i == 1 ]]
then
  echo "i is 1"
elif [[ $i == 2 ]]
then
  echo "i is 2"
else
  echo "i is neither 1 or 2 but it is $i"
fi