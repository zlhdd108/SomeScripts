# 自定义更新时间
58 * * * * sh -x /scripts/docker/diy.sh >> /scripts/logs/diy.log 2>&1
# custom_script
59 * * * * sh -x /scripts/docker/custom_script.sh >> /scripts/logs/custom_script.log 2>&1

# 百变大咖秀
0 10,11 * * 1-4 node /scripts/jd_entertainment.js >> /scripts/logs/jd_entertainment.log 2>&1

# 粉丝互动
15 10 * * * node /scripts/jd_fanslove.js >> /scripts/logs/jd_fanslove.log 2>&1

# 超级摇一摇
5 20 * * * node /scripts/jd_shake.js >> /scripts/logs/jd_shake.log 2>&1

# 联想集卡活动
10 15 15-29 3 * node /scripts/z_lenovo.js >> /scripts/logs/jd_lenovo.log 2>&1

# 京东超市-大转盘
10 10 * * * node /scripts/z_marketLottery.js >> /scripts/logs/jd_marketLottery.log 2>&1

# 金口碑奖投票
3 10 * 3 * node /scripts/z_mgold.js >> /scripts/logs/jd_mgold.log 2>&1

# 母婴-跳一跳
10 8,14,20 17-25 3 * node /scripts/z_mother_jump.js >> /scripts/logs/jd_mother_jump.log 2>&1

# 众筹许愿池
5 10 13-20 3 * node /scripts/z_wish.js >> /scripts/logs/jd_wish.log 2>&1
