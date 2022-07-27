#!/bin/bash
###
 # @Descripttion: 
 # @Version: 
 # @Author: sage
 # @Date: 2022-01-26 13:33:47
 # @LastEditors: sage
 # @LastEditTime: 2022-01-26 13:46:23
 # @FilePath: \lora_detector_stm32c:\Users\yl-0256\Downloads\video_service_monitor.sh
### 

PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/webuser1/.local/bin:/home/webuser1/bin

# gateway
APP_GATEWAY_SERVER="./product_deploy_server"

function process_exists()
{
    exists=$(pgrep -fc $1)
    return $exists
}

function restart_process_if_die()
{
    program=$1
    cmd=$2
    process_exists $program
    if [ $? -eq 0 ]; then
        printf "Process ${program} die. restarting\n"
        eval $cmd
        status=$?
        if [ $status -eq 0 ]; then
            pid=$(pgrep -f $1)
            printf "Process ${program} restarted. pid=%d\n" $pid
        else
            printf "Process ${program} restart failed. status=%d\n" $status
        fi
    else
        printf "Process ${program} alive. \n"
    fi
}

cd /home/webuser1/product_deploy/gateway
restart_process_if_die ./product_deploy_server ./product_deploy_server

