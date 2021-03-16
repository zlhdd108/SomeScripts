#!/bin/sh

# 克隆i-chenzhe仓库
if [ ! -d "/i-chenzhe/" ]; then
    echo "未检查到i-chenzhe仓库脚本，初始化下载相关脚本..."
    git clone https://github.com/i-chenzhe/qx /i-chenzhe
else
    echo "更新i-chenzhe脚本相关文件..."
    git -C /i-chenzhe reset --hard
    git -C /i-chenzhe pull --rebase
fi
# 克隆jd_scripts仓库
if [ ! -d "/jd_scripts/" ]; then
    echo "未检查到jd_scripts仓库脚本，初始化下载相关脚本..."
    mkdir /jd_scripts
    cd /jd_scripts
    git init
    git remote add -f origin https://github.com/FKPYW/SomeScripts.git
    git config core.sparsecheckout true
    echo jd_scripts/* >> /jd_scripts/.git/info/sparse-checkout
    git pull origin master
else
    echo "更新jd_scripts脚本相关文件..."
    git -C /jd_scripts reset --hard
    git -C /jd_scripts pull --rebase
fi

cp -f /i-chenzhe/*.js /scripts
cp -f /jd_scripts/jd_scripts/*.js /scripts/docker
cp -f /jd_scripts/jd_scripts/diy.sh /scripts/docker
cp -f /jd_scripts/jd_scripts/custom_script.sh /scripts/docker

# custom_docker_entrypoint
echo "# 自定义更新时间" >> /scripts/docker/merged_list_file.sh
echo "57 * * * * sh -x /scripts/docker/diy.sh >> /scripts/logs/diy.log 2>&1" >> /scripts/docker/merged_list_file.sh
