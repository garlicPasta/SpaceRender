#!/usr/bin/env bash

coffee -c test/


TEST='test'
while getopts “d” OPTION
do
     case $OPTION in
         d)
             TEST='test-debug'
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

npm run-script $TEST
rm test/*.js

