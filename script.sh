#!/bin/bash

echo What would you like to do?

read response

if [ $response = comp ]
then
  echo What file?
  read file 
  modified=${file::-6}
  cairo-compile $file --output ${modified}_compiled.json
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

if [ $response = help ]
then
  echo comp - Is used to compile the file given
  echo run - Is used to run the file with few options MAKE SURE TO NOT ADD .CAIRO OR _COMPILED.JSON
  echo run options: 
  echo poi = [--print-output --print_info]
  echo poir = [--print-output --print_info --relocate_prints]
  echo polppi = [--print_output --layout=plain --program_input=file_name_input.json]
  echo polspi = [--print_output --layout=small --program_input=file_name_input.json]
  echo poldpi = [--print_output --layout=dex --program_input=file_name_input.json]
  echo polapi = [--print_output --layout=all --program_input=file_name_input.json]
  
  echo trace = [--tracer]
  ./script.sh
fi
