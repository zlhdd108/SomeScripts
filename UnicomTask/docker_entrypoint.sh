#!/bin/sh
set -e

#获取配置的自定义参数
if [ $1 ]; then
    run_cmd=$1
fi

function initUnicomTask() {
    mkdir /UnicomTask
    cd /UnicomTask
    git init
    git remote add -f origin https://github.com/srcrs/UnicomTask
    git config core.sparsecheckout true
    echo *.py >>/UnicomTask/.git/info/sparse-checkout
    echo requirements.txt >>/UnicomTask/.git/info/sparse-checkout
    git pull origin main --rebase
    pip3 install --upgrade pip
    pip3 install -r requirements.txt
}
if [ ! -d "/UnicomTask/" ]; then
    echo "未检查到UnicomTask脚本相关文件，初始化下载相关脚本"
    initUnicomTask
else
    echo "更新UnicomTask脚本相关文件"
    git -C /UnicomTask reset --hard
    git -C /UnicomTask pull origin main --rebase
    cd /UnicomTask
    pip3 install -r requirements.txt
fi

echo "获取最新UnicomTask相关代码"
cd /scripts
git reset --hard
git pull origin main --rebase
echo "获取最新UnicomTask相关代码完成"

echo "首次初始化定时任务..."
sh -x /scripts/UnicomTask/default_task.sh
echo "初始化完成..."

if [ $run_cmd ]; then
    echo "Start crontab task main process..."
    echo "启动crondtab定时任务主进程..."
    crond -f
else
    echo "默认定时任务执行结束。"
fi