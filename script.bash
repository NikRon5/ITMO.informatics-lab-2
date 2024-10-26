#!/bin/bash
ip=$1

# Splitting ip by dots
declare -a ip_array=()
declare -a numbers_array=()
for (( i=0; i<${#ip}; i++ ))
do
  digit=${ip:$i:1}
  if [[ $digit = . ]]
  then
    ip_array+=($numbers_array)
    numbers_array=()
  else
    numbers_array+=$digit
    if [[ $((i+1)) = ${#ip} ]]
    then
      ip_array+=($numbers_array)
    fi
  fi
done

# Convert to binary
numberToBin() {
  num=$1
  bin="00000000"
  for (( i=7; i>=0; i-- ))
  do 
    bin="${bin:0:i}$((num%2))${bin:i+1}"
    num=$((num/2))
  done
}

ip_result=""
for ip_num in "${ip_array[@]}"
do
  numberToBin $ip_num
  ip_result+=$bin.
done
echo ${ip_result%?}
