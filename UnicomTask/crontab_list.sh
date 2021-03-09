# 每2天的23:50分清理一次日志
50 23 */2 * * rm -rf /logs/*.log
# UnicomTask
30 23 * * * cd /scripts/UnicomTask/UnicomTask && python3 main.py
