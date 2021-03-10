# 每2天的23:50分清理一次日志
50 23 */2 * * rm -rf /logs/*.log

0 23 * * * update.sh >> /logs/update.log 2>&1

30 23 * * * cd /unicomtask && python3 main.py