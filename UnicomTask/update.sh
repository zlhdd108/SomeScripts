#!/bin/sh
set -e

echo "获取最新定时任务相关代码"
cd /unicomtask
git pull
cp -f /unicomtask/*.py /scripts \
cp -f /unicomtask/requirements.txt /scripts
cd /scripts && pip3 install -r requirements.txt
echo "获取最新定时任务相关代码完成"
