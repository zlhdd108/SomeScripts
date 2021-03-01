## 甜糖心愿自动提现 Docker

【自用仅限支付宝】

代码修改来自

https://github.com/744287383/AutomationTTnode

##### docker镜像

docker pull fatelight/automationttnode:latest

#### 参数

TT_PHONE			 #注册手机号

TG_BOT_TOKEN	#TG推送

TG_USER_ID

TT_WEEK				#提现日期1-7自选

AutomationTTnode 配置文件保存目录，如果需要保存请挂着到本地

部署好后 docker exec -it xxx /bin/sh 进入容器 [xxx 为容器名称]

执行 python3 /pss/AutomationTTnode/ttnodeConfig.py 然后填入验证码，输出你的authorization：代表成功

crontab -l 查看定时任务，sendTTnodeMSG.py为自动领取和提现

