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
sed -i "/^$/d" /SomeScripts/jd_scripts/remote_crontab_list.sh
cat /SomeScripts/jd_scripts/remote_crontab_list.sh >> /scripts/docker/merged_list_file.sh

# custom_docker_entrypoint
echo "# 自定义更新时间" >> /scripts/docker/merged_list_file.sh
echo "58 * * * * sh -x /scripts/docker/diy.sh >> /scripts/logs/diy.log 2>&1" >> /scripts/docker/merged_list_file.sh
echo "# custom_script" >> /scripts/docker/merged_list_file.sh
echo "59 * * * * sh -x /scripts/docker/custom_script.sh >> /scripts/logs/custom_script.log 2>&1" >> /scripts/docker/merged_list_file.sh

## 百变大咖秀
echo "# 百变大咖秀" >> /scripts/docker/merged_list_file.sh
echo "0 10,11 * * 2-5 node /scripts/jd_entertainment.js >> /scripts/logs/jd_entertainment.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 粉丝互动
echo "# 粉丝互动" >> /scripts/docker/merged_list_file.sh
echo "16 10 * * * node /scripts/jd_fanslove.js >> /scripts/logs/jd_fanslove.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 超级摇一摇
echo "# 超级摇一摇" >> /scripts/docker/merged_list_file.sh
echo "5 20 * * * node /scripts/jd_shake.js >> /scripts/logs/jd_shake.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 京东小魔方
echo "# 京东小魔方" >> /scripts/docker/merged_list_file.sh
echo "8 10 16-18 * * node /scripts/jd_xmf.js >> /scripts/logs/jd_xmf.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 联想集卡活动
echo "# 联想集卡活动" >> /scripts/docker/merged_list_file.sh
echo "8 15 15-29 3 * node /scripts/z_lenovo.js >> /scripts/logs/jd_lenovo.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 京东超市-大转盘
echo "# 京东超市-大转盘" >> /scripts/docker/merged_list_file.sh
echo "10 10 * * * node /scripts/z_marketLottery.js >> /scripts/logs/jd_marketLottery.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 母婴-跳一跳
echo "# 母婴-跳一跳" >> /scripts/docker/merged_list_file.sh
echo "15 8,14,20 17-25 3 * node /scripts/z_mother_jump.js >> /scripts/logs/jd_mother_jump.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 一加盲盒
echo "# 一加盲盒" >> /scripts/docker/merged_list_file.sh
echo "16 12 17-30 3 *  node /scripts/z_oneplus.js >> /scripts/logs/jd_oneplus.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 美的家电节
echo "# 美的家电节" >> /scripts/docker/merged_list_file.sh
echo "12 10 10-31 3 * node /scripts/z_unionPoster.js >> /scripts/logs/jd_unionPoster.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 众筹许愿池
echo "# 众筹许愿池" >> /scripts/docker/merged_list_file.sh
echo "5 10 13-20 3 * node /scripts/z_wish.js >> /scripts/logs/jd_wish.log 2>&1" >> /scripts/docker/merged_list_file.sh

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