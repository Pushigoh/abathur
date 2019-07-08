#!/bin/bash

user=$(whoami)
userConfig="/home/$user/.abathur"
workDIR="/home/$user/docker"

#Initial Setup
if [ ! -f "$userConfig" ]; then
    touch $userConfig
fi
if [ ! -d "$workDIR" ]; then
    mkdir -P $workDIR
fi

