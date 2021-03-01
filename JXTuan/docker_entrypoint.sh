#!/bin/sh
set -e

echo "获取最新定时任务相关代码"
cd /pss
git pull origin master --rebase
cd JXTuan
cp crontab_list.sh default_task.sh scripts_update.sh /pss
cp -f /pss/JXTuan/scripts/* /scripts

echo "获取最新定时任务相关代码完成"

echo "首次初始化定时任务..."
sh -x /pss/scripts_update.sh
echo "初始化完成..."

echo "启动crondtab定时任务主进程..."
crond -f
