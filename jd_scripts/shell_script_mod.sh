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
cp -f /i-chenzhe/*.js /scripts

# 百变大咖秀
echo "# 百变大咖秀" >> /scripts/docker/merged_list_file.sh
echo "0 10,11 * * 1-4 node /scripts/jd_entertainment.js >> /scripts/logs/jd_entertainment.log 2>&1" >> /scripts/docker/merged_list_file.sh
# 粉丝互动
echo "# 粉丝互动" >> /scripts/docker/merged_list_file.sh
echo "15 10 * * * node /scripts/jd_fanslove.js >> /scripts/logs/jd_fanslove.log 2>&1" >> /scripts/docker/merged_list_file.sh
# 超级摇一摇
echo "# 超级摇一摇" >> /scripts/docker/merged_list_file.sh
echo "5 20 * * * node /scripts/jd_shake.js >> /scripts/logs/jd_shake.log 2>&1" >> /scripts/docker/merged_list_file.sh
# 京东超市-大转盘
echo "# 京东超市-大转盘" >> /scripts/docker/merged_list_file.sh
echo "10 10 * * * node /scripts/z_marketLottery.js >> /scripts/logs/jd_marketLottery.log 2>&1" >> /scripts/docker/merged_list_file.sh
# 众筹许愿池
echo "# 众筹许愿池" >> /scripts/docker/merged_list_file.sh
echo "5 10 13-20 3 * node /scripts/z_wish.js >> /scripts/logs/jd_wish.log 2>&1" >> /scripts/docker/merged_list_file.sh
# 美的家电节
echo "# 美的家电节" >> /scripts/docker/merged_list_file.sh
echo "15 10 10-31 3 * node /scripts/z_unionPoster.js >> /scripts/logs/z_unionPoster.log 2>&1" >> /scripts/docker/merged_list_file.sh

# diy sh
wget -O /scripts/docker/diy.sh https://raw.githubusercontent.com/FKPYW/SomeScripts/master/Scripts/diy.sh
echo "# diy sh" >> /scripts/docker/merged_list_file.sh
echo "57 * * * * sh -x /scripts/docker/diy.sh >> /scripts/logs/diy.log 2>&1" >> /scripts/docker/merged_list_file.sh

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

# 京喜工厂参团
sed -i "s/https:\/\/gitee.com\/shylocks\/updateTeam\/raw\/main\/jd_updateFactoryTuanId.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateFactoryTuanId.json/g" /scripts/jd_dreamFactory.js
sed -i "s/https:\/\/raw.githubusercontent.com\/LXK9301\/updateTeam\/master\/jd_updateFactoryTuanId.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateFactoryTuanId.json/g" /scripts/jd_dreamFactory.js
sed -i "s/https:\/\/gitee.com\/lxk0301\/updateTeam\/raw\/master\/shareCodes\/jd_updateFactoryTuanId.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateFactoryTuanId.json/g" /scripts/jd_dreamFactory.js
sed -i "s/\(.*\/\/.*joinLeaderTuan.*\)/  await joinLeaderTuan();/g" /scripts/jd_dreamFactory.js
# 京东赚赚
sed -i "s/https:\/\/gitee.com\/shylocks\/updateTeam\/raw\/main\/jd_zz.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_zz.json/g" /scripts/jd_jdzz.js
sed -i "s/https:\/\/gitee.com\/lxk0301\/updateTeam\/raw\/master\/shareCodes\/jd_zz.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_zz.json/g" /scripts/jd_jdzz.js
# 签到领现金
sed -i "s/https:\/\/gitee.com\/shylocks\/updateTeam\/raw\/main\/jd_cash.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateCash.json/g" /scripts/jd_cash.js
sed -i "s/https:\/\/gitee.com\/lxk0301\/updateTeam\/raw\/master\/shareCodes\/jd_updateCash.json/https:\/\/raw.githubusercontent.com\/FKPYW\/updateTeam\/master\/shareCodes\/jd_updateCash.json/g" /scripts/jd_cash.js
sed -ie "32,33s/^[^\]*/  \`eU9YaOvnM_4k9WrcnnAT1Q@eU9Yar-3M_8v9WndniAQhA@eU9YaO-2YPUn-TzQwycVgw@eU9YaOiwMKklo2eGyCFG1A@ZnQya-i1Y_UmpGzUnnEX@fkFwauq3ZA@aUNmM6_nOP4j-W4@eU9Yau3kZ_4g-DiByHEQ0A@f0JyJuW7bvQ@IhM0bu-0b_kv8W6E@eU9YKpnxOLhYtQSygTJQ@-oaWtXEHOrT_bNMMVso@eU9YG7XaD4lXsR2krgpG\`,/g" /scripts/jd_cash.js
# 宠汪汪赛跑邀请助力
wget -O /scripts/jd_joy_run.js https://raw.githubusercontent.com/FKPYW/SomeScripts/master/jd_scripts/jd_joy_run.js
# 修改助力开关
sed -i "s/helpAu = true;/helpAu = false;/g" /scripts/jd_*.js
sed -i "s/helpAuthor = true;/helpAuthor = false;/g" /scripts/jd_*.js
