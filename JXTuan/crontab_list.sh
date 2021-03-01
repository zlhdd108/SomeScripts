# 每2天的23:50分清理一次日志
50 23 */2 * * rm -rf /logs/*.log
# 京喜工厂tuanID
10 * * * * node /scripts/jd_dreamFactory_tuanid.js >> /scripts/logs/jd_dreamFactory_tuanid.log 2>&1
# 上传 tuanID
11 * * * * node /scripts/qiniu.js >> /scripts/logs/qiniu.log 2>&1