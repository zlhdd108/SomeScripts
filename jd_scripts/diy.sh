#!/bin/sh
set -e

#获取配置的自定义参数
if [ $1 ]; then
    run_cmd=$1
fi

echo "------------------执行 DIY shell脚本-----------------"
sh -x /usr/local/bin/docker_entrypoint.sh
echo "---------------------务执行完成----------------------"

echo "---------------执行 custom_script 脚本---------------"
sh -x /scripts/docker/custom_script.sh
echo "---------------------务执行完成----------------------"

echo "----------------加载最新的定时任务文件-----------------"
crontab /scripts/docker/merged_list_file.sh
echo "---------------------务执行完成----------------------"

echo -e "\n\n"
