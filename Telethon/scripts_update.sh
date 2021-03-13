#!/bin/sh
set -e

PIDS=`ps -ef |grep jd_zbj |grep -v grep | awk '{print $2}'`

if [ ! -f "/telethon/jd_zbj.py" ]; then
    echo "京东直播间抽奖脚本不存在，跳过执行..."
else
    echo "京东直播间抽奖脚本存在，判断脚本进程是否存在..."
    if [ "$PIDS" != "" ]; then
        echo "脚本进程存在，跳过执行..."
    else
        echo "脚本进程不存在，执行脚本..."
        cd /telethon && python3 -u jd_zbj.py |ts >> /logs/jd_zbj.log 2>&1 &
        echo "脚本执行完成..."
    fi
fi
