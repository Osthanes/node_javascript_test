#!/bin/bash

#********************************************************************************
# Copyright 2014 IBM
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#********************************************************************************

#############
# Colors    #
#############
export green='\e[0;32m'
export red='\e[0;31m'
export label_color='\e[0;33m'
export no_color='\e[0m' # No Color

##################################################
# Simple function to only run command if DEBUG=1 # 
### ###############################################
debugme() {
  [[ $DEBUG = 1 ]] && "$@" || :
}

set +e
set +x 

#install phantomjs, firefox, chrome, and xvfb
sudo apt-get update

echo "Installing phantomjs..."
npm install -g phantomjs

echo "Installing Chrome..."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository 'deb http://dl.google.com/linux/chrome/deb/ stable main'
sudo apt-get update
sudo apt-get -y install -q -y google-chrome-stable

echo "Installing XVFB and Firefox..."
sudo apt-get -y install xvfb firefox

ls
#if no test cmd provided, assume Node app
if [ -z "${TEST_CMD}" ]; then
    echo "Node.js application detected: "
    npm install
    xvfb-run npm test
#test cmd provided so install typical items and run cmd
else
    echo "Plain Javascript detected: "
    npm install selenium-webdriver 
    npm install selenium-standalone
    npm install wd-sync
    npm install wd 
    npm install mocha
    npm install mocha-phantomjs
    npm install chai
    npm install chai-as-promised
    npm install webdriverio 
    npm install chromedriver
    xvfb-run eval $TEST_CMD
fi
    
RESULT=$?

if [ $RESULT -ne 0 ]; then
    exit 1
fi