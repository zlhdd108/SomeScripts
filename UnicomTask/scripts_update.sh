#!/bin/sh
set -e

##定义合并定时任务相关文件路径变量
defaultListFile="/pss/pack_some_script/$DEFAULT_LIST_FILE"
customListFile="/pss/pack_some_script/$CUSTOM_LIST_FILE"
mergedListFile="/pss/pack_some_script/merged_list_file.sh"

function initUnicomTask() {
    mkdir /UnicomTask
    cd /UnicomTask
    git init
    git remote add -f origin https://github.com/srcrs/UnicomTask
    git config core.sparsecheckout true
    echo login.py >>/UnicomTask/.git/info/sparse-checkout
    echo main.py >>/UnicomTask/.git/info/sparse-checkout
    echo notify.py >>/UnicomTask/.git/info/sparse-checkout
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
    echo "# UnicomTask">>$mergedListFile
    echo "30 23 * * * cd UnicomTask && python3 main.py >> /logs/main.log 2>&1" >>$mergedListFile
fi
