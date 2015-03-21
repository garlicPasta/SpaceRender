#!/usr/bin/env bash

coffee -c test/
npm test
rm test/*.js

