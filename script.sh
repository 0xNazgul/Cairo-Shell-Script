#!/bin/bash

echo What would you like to do?

read response

if [ $response = comp ]
then
  echo What file?
  read file 
  modified=${file::-6}
  cairo-compile $file --output ${modified}_compiled.json
  ./test.sh
fi

if [ $response = run ]
then  
  echo What file?
  read file
  echo Output choice?
  read option
  
  if [[ $option = print ]]
  then 
    cairo-run --program=${file}_compiled.json --print_output --print_info --relocate_prints
    ./test.sh
  elif [[ $option = trace ]]
  then
    cairo-run --program=${file}_compiled.json --tracer
  else
    ./test.sh
  fi
fi

if [ $response = help ]
then
  echo comp - Is used to compile the file given
  echo run - Is used to run the file with few options MAKE SURE TO NOT ADD .CAIRO OR _COMPILED.JSON
  echo run options - print=--print-output --print_info --relocate_prints trace=--tracer
  ./test.sh
fi



