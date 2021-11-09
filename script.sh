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

if [ $response = inv ]
then 
  echo What contract address?
  read caddr 
  echo What is the abi path?
  read abipath
  echo What is the function?
  read function 
  echo What is your inputs?
  read inputs
  starknet invoke --address $caddr --abi $abipath_abi.json --function $function --inputs $inputs
  ./script.sh
fi

if [ $response = call ]
then 
  echo What contract address?
  read caddr
  echo What is the abi path?
  read abipath
  echo What is the function?
  read function 
  starknet call --address $caddress --abi $abipath_abi.json --function $function 
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

if [ $response = ts ]
then
  echo enter transaction hash:
  read txhash
  echo With error? y or n?
  read op 
  
  if [[ $op = n ]]
  then
  starknet tx_status --hash $txhash
  ./script.sh

  elif [[ $op = y ]]
  then
    echo What is the _compiled.json?
    read name
    starknet tx_status --hash $txhash --contract $name_compiled.json --error_message
    ./script.sh
  else 
    ./script.sh
  fi
fi

if [ $response = help ]
then
  echo -e " 
  //===============[]========================================================================\\
  ||    Command    ||                              Description                              ||
  |]===============[]=======================================================================[|
  || dep           || Deploy the contract MAKE SURE TO NOT ADD .CAIRO OR _COMPILED.JSON     ||
  || inv           || Invokes a contract                                                    ||
  || call          || Calls a function                                                      ||
  || comp          || Is used to compile a file                                             ||
  || comp options: ||                                                                       ||
  || contract      || Compiles a starknet contract                                          ||
  || If not        || Compiles a cairo file                                                 ||
  ||---------------||-----------------------------------------------------------------------||
  || run           || Is used to run the file MAKE SURE TO NOT ADD .CAIRO OR _COMPILED.JSON ||
  || run options:  ||                                                                       ||
  || poi           || --print-output --print_info                                           ||
  || poir          || --print-output --print_info --relocate_prints                         ||
  || polppi        || --print_output --layout=plain --program_input=file_name_input.json    ||
  || polspi        || --print_output --layout=small --program_input=file_name_input.json    ||
  || poldpi        || --print_output --layout=dex --program_input=file_name_input.json      ||
  || polapi        || --print_output --layout=all --program_input=file_name_input.json      ||
  || trace         || --tracer                                                              ||
  ||---------------||-----------------------------------------------------------------------||
  || cli options:  ||                                                                       ||
  || th            || Gets a transactions information                                       ||
  || co            || Gets a deployed contracts code in abi format                          ||
  || bl            || Gets entire block information                                         ||
  || ts            || Gets transactions current status                                      ||
  \\================[]=======================================================================//
  "
  ./script.sh
fi
