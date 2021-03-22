#!/bin/sh


## 克隆i-chenzhe仓库
if [ ! -d "/i-chenzhe/" ]; then
    echo "未检查到i-chenzhe仓库脚本，初始化下载相关脚本..."
    git clone https://github.com/i-chenzhe/qx /i-chenzhe
else
    echo "更新i-chenzhe脚本相关文件..."
    git -C /i-chenzhe reset --hard
    git -C /i-chenzhe pull origin main --rebase
fi
cp -f /i-chenzhe/*_*.js /scripts

cat /i-chenzhe/remote_crontab_list.sh >> /scripts/docker/merged_list_file.sh

if [ -d "/scripts/jd_live_lottery_social.js" ]; then
    echo "未检查到live脚本..."
    echo "# if" >>$mergedListFile
    echo "5 8,12,16,20,23 * * * node /scripts/jd_live_lottery_social.js >> /scripts/logs/jd_live_lottery_social.log 2>&1" >>$mergedListFile