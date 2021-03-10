# 每2天的23:50分清理一次日志
50 23 */2 * * rm -rf /logs/*.log

30 23 * * * cd /DoUnicomTask && python3 main.py |ts >> /logs/main.log 2>&1