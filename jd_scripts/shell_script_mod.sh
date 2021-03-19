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
if [ ! -d "/SomeScripts/" ]; then
    echo "未检查到SomeScripts仓库脚本，初始化下载相关脚本..."
    git clone https://github.com/FKPYW/SomeScripts.git /SomeScripts
else
    echo "更新jd_scripts脚本相关文件..."
    git -C /SomeScripts reset --hard
    git -C /SomeScripts pull --rebase
fi

cp -f /i-chenzhe/*.js /scripts
cp -f /SomeScripts/jd_scripts/*.js /scripts/docker
cp -f /SomeScripts/jd_scripts/diy.sh /scripts/docker
cp -f /SomeScripts/jd_scripts/custom_script.sh /scripts/docker
cp -f /SomeScripts/jd_scripts/remote_crontab_list.sh /scripts/docker
sed -i "/^$/d" /SomeScripts/jd_scripts/remote_crontab_list.sh
cat /SomeScripts/jd_scripts/remote_crontab_list.sh >> /scripts/docker/merged_list_file.sh

# 修改京东赚赚定时
sed -i "s/10 11 \* \* \* node \/scripts\/jd_jdzz.js/10 \* \* \* \* node \/scripts\/jd_jdzz.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/10 11 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_jdzz.js/10 \* \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_jdzz.js/g" /scripts/docker/merged_list_file.sh
# 修改闪购盲盒定时
sed -i "s/27 8 \* \* \* node \/scripts\/jd_sgmh.js/27 8,23 \* \* \* node \/scripts\/jd_sgmh.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/27 8 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_sgmh.js/27 8,23 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_sgmh.js/g" /scripts/docker/merged_list_file.sh
# 修改京喜财富岛定时
sed -i "s/15 \*\/2 \* \* \* node \/scripts\/jd_cfd.js/30 \*\/1 \* \* \* node \/scripts\/jd_cfd.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/15 \*\/2 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_cfd.js/30 \*\/1 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_cfd.js/g" /scripts/docker/merged_list_file.sh
# 修改京东家庭号定时
sed -i "s/20 6,7 \* \* \* node \/scripts\/jd_family.js/30 6,15 \* \* \* node \/scripts\/jd_family.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/20 6,7 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_family.js/30 6,15 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_family.js/g" /scripts/docker/merged_list_file.sh
# 修改美丽颜究院定时
sed -i "s/1 7,12,19 \* \* \* node \/scripts\/jd_beauty.js/30 8,13,20 \* \* \* node \/scripts\/jd_beauty.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/1 7,12,19 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_beauty.js/30 8,13,20 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_beauty.js/g" /scripts/docker/merged_list_file.sh
# 修改环球挑战赛定时
sed -i "s/35 6,22 \* \* \* node \/scripts\/jd_global.js/55 6,22 \* \* \* node \/scripts\/jd_global.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/35 6,22 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_global.js/55 6,22 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_global.js/g" /scripts/docker/merged_list_file.sh
# 修改京东国际盲盒定时
sed -i "s/5 7,12,23 \* \* \* node \/scripts\/jd_global_mh.js/15 7,12,23 \* \* \* node \/scripts\/jd_global_mh.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/5 7,12,23 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_global_mh.js/15 7,12,23 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_global_mh.js/g" /scripts/docker/merged_list_file.sh
# 修改京东极速版红包定时
sed -i "s/15 0,23 \* \* \* node \/scripts\/jd_speed_redpocke.js/30 0,23 \* \* \* node \/scripts\/jd_speed_redpocke.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/15 0,23 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_speed_redpocke.js/30 0,23 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_speed_redpocke.js/g" /scripts/docker/merged_list_file.sh