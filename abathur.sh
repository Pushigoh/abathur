#!/bin/bash

user=$(whoami)
userConfig="/home/$user/.abathur"

#Initial Setup
if [ ! -f "$userConfig" ]; then
    touch $userConfig
    echo "workDIR=\"/home/$user/docker\"" >> $userConfig
fi
source $userConfig
if [ ! -d "$workDIR" ]; then
    mkdir -P $workDIR
fi
#check if both values were passed in
if [ -z $1 ] || [ -z $2 ]; then
    echo 'Usage: abathur $command $containerName'
    exit
fi
commandment=""
case $1 in
    create)
        commandment="$workDIR/docker_template/docker_template.sh $2"
        ;;
    build)
        commandment="$workDIR/$2/build.sh"
        ;;
    run)
        commandment="$workDIR/$2/run.sh"
        ;;
    kill)
        commandment="docker kill $2; docker container rm $2"
        ;;
    exec)
        commandment="docker exec $2 $3"
        ;;
    spawn)
        commandment="$workDIR/$2/run.sh -d"
        ;;
    edit)
        case $3 in #todo: Add option to edit files
            Dockerfile);;
            run);;
            build);;
        esac
        ;;
    ip)
    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $2
        ;;
    *)
        echo 'Usage: abathur $command $containerName'
        ;;
esac
eval $commandment

