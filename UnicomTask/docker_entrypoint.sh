#!/bin/sh
set -e

#获取配置的自定义参数
if [ $1 ]; then
    run_cmd=$1
fi

echo "获取最新UnicomTask相关代码"
git -C /scripts git reset --hard
git -C /scripts pull origin master --rebase
git -C /UnicomTask git reset --hard
git -C /UnicomTask pull origin main --rebase
cd /UnicomTask
pip3 install --upgrade pip
pip3 install -r requirements.txt
echo "获取最新UnicomTask相关代码完成"

echo "首次初始化定时任务..."
sh -x /scripts/UnicomTask/default_task.sh
echo "初始化完成..."

if [ $run_cmd ]; then
    echo "启动crondtab定时任务主进程..."
    crond -f
else
    echo "默认定时任务执行结束。"
fi
echo -e "\n\n"
