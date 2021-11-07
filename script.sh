#!/bin/bash

echo What would you like to do?

read response

if [ $response = comp ]
then
  echo What file?
  read file 
  echo contract? y or n?
  read op
  if [[ $op = n ]]
  then
    modified=${file::-6}
    cairo-compile $file --output ${modified}_compiled.json
    ./script.sh
  elif [[ $op = y ]]
  then
    modified=${file::-6}
    starknet-compile $file --output=${modified}_compiled.json --abi=${modified}_abi.json
    ./script.sh  
  else
    ./script.sh  
  fi
fi

if [ $response = dep ]
then 
  echo What file?
  read file
  starknet deploy --contract $file_compiled.json
  ./script.sh
fi

if [ $response = run ]
then  
  echo What file?
  read file
  echo Output choice?
  read option
  
  if [[ $option = poi ]]
  then 
    cairo-run --program=${file}_compiled.json --print_output --print_info 
    ./script.sh
  elif [[ $option = poir ]]
  then 
    cairo-run --program=${file}_compiled.json --print_output --print_info --relocate_prints
    ./script.sh
  elif [[ $option = polppi ]]
  then 
    cairo-run --program=${file}_compiled.json --print_output --layout=plain --program_input=${file}_input.json
    ./script.sh
  elif [[ $option = polspi ]]
  then 
    cairo-run --program=${file}_compiled.json --print_output --layout=small --program_input=${file}_input.json
    ./script.sh
  elif [[ $option = poldpi ]]
  then 
    cairo-run --program=${file}_compiled.json --print_output --layout=dex --program_input=${file}_input.json
    ./script.sh
  elif [[ $option = polapi ]]
  then 
    cairo-run --program=${file}_compiled.json --print_output --layout=all --program_input=${file}_input.json
    ./script.sh
  elif [[ $option = trace ]]
  then
    cairo-run --program=${file}_compiled.json --tracer
  else
    ./script.sh
  fi
fi

if [ $response = th ]
then
  echo enter transaction hash:
  read thash
  starknet get_transaction --hash $thash
  ./script.sh
fi
if [ $response = co ]
then
  echo enter contract address:
  read addr
  starknet get_code --contract_address $addr
  ./script.sh
fi
if [ $response = bo ]
then
  echo enter block ID:
  read blid
  starknet get_block --id $blid
  ./script.sh
fi
if [ $response = help ]
then
  echo comp - Is used to compile the file given
  echo comp options:
  echo contract = [ starknet-compile file --output file_compiled.json --abi file_abi.json ]
  echo if not = [cairo-compile file --output file_compiled.json]
  echo dep  - deploy the contract MAKE SURE TO NOT ADD .CAIRO OR _COMPILED.JSON
  echo run - Is used to run the file with few options MAKE SURE TO NOT ADD .CAIRO OR _COMPILED.JSON
  echo run options: 
  echo poi = [--print-output --print_info]
  echo poir = [--print-output --print_info --relocate_prints]
  echo polppi = [--print_output --layout=plain --program_input=file_name_input.json]
  echo polspi = [--print_output --layout=small --program_input=file_name_input.json]
  echo poldpi = [--print_output --layout=dex --program_input=file_name_input.json]
  echo polapi = [--print_output --layout=all --program_input=file_name_input.json]
  echo trace = [--tracer]
  echo cli options:
  echo th = starknet get_transaction --hash TRANSACTION_HASH
  echo co = starknet get_code --contract_address CONTRACT_ADDRESS
  echo bl = starknet get_block --id BLOCK_ID
  ./script.sh
fi
