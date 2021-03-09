#!/bin/sh
set -e

#获取配置的自定义参数
if [ $1 ]; then
    run_cmd=$1
fi

echo "获取最新UnicomTask相关代码"
cd /scripts
git reset --hard
git pull origin master --rebase
cd /UnicomTaskScripts
git reset --hard
git pull origin main --rebase
cp -f /UnicomTaskScripts/*.py /UnicomTask
cp -f /UnicomTaskScripts/requirements.txt /UnicomTask
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
