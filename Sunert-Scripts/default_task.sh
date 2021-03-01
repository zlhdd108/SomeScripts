#!/bin/sh
set -e

echo "获取最新定时任务相关代码"
cd /pss
git pull origin master --rebase
cd Sunert-Scripts
cp crontab_list.sh default_task.sh scripts_update.sh /pss
echo "获取最新定时任务相关代码完成!"

echo "执行脚本更新相关任务"
sh -x /pss/scripts_update.sh
echo "执行脚本更新相关任务完成!"