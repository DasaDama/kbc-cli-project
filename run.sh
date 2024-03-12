#!/bin/bash

time=$(date -d "-1 day" +\%Y-\%m-\%d)    
ofile="../tmp/ec.txt"

exit_code=1

while [ $exit_code -eq 1 ]; do
  kbc remote job run keboola.snowflake-transformation/1098016094
  kbc remote table download out.c-date_check.exit_code_table -o $ofile
  if [ -f $ofile ] && [[ $(eval echo `grep $time $ofile | awk -F ',' '{print $2}'`) -eq 0 ]]; then 
     exit_code=0
     echo -e "\n\nAll ok $time."
  else 
     kbc remote job run keboola.ex-currency/1098014983
     sleep 1h
  fi
done

