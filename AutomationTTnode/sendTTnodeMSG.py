#!/usr/bin/python3
#coding=utf-8
import datetime as dt
import logging
import traceback
import random
import urllib3,json,time,sys,os,requests

TG_BOT_TOKEN = os.environ["TG_BOT_TOKEN"]     # telegram bot token 自行申请
TG_USER_ID = os.environ["TG_USER_ID"]         # telegram 用户ID
TT_WEEK = os.environ["TT_WEEK"]

def telegram_bot(title, content):
    print("\n")
    tg_bot_token = TG_BOT_TOKEN
    tg_user_id = TG_USER_ID
    if "TG_BOT_TOKEN" in os.environ and "TG_USER_ID" in os.environ:
        tg_bot_token = os.environ["TG_BOT_TOKEN"]
        tg_user_id = os.environ["TG_USER_ID"]
    if not tg_bot_token or not tg_user_id:
        print("Telegram推送的tg_bot_token或者tg_user_id未设置!!\n取消推送")
        return
    print("Telegram 推送开始")
    send_data = {"chat_id": tg_user_id, "text": title +'\n\n'+content, "disable_web_page_preview": "true"}
    response = requests.post(
        url ='https://api.telegram.org/bot%s/sendMessage' % (tg_bot_token), data=send_data)
    print(response.text)

def HandleException( excType, excValue, tb):
	ErrorMessage = traceback.format_exception(excType, excValue, tb)  # 异常信息
	logging.exception('ErrorMessage: %s' % ErrorMessage)  # 将异常信息记录到日志中
	str=""
	for item in ErrorMessage:
		str=str+item
	telegram_bot("[甜糖星愿]程序错误警报","\nErrorMessage:%s\n" %str)
	return

sys.excepthook = HandleException #全局错误异常处理！

logging.basicConfig(filename = '/AutomationTTnode/sendTTnodeMSG.log',format='%(asctime)s - %(filename)s[line:%(lineno)d] - %(levelname)s: %(message)s', level = logging.DEBUG)
logging.debug("日志开始")
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
####################以下内容请不要乱动，程序写得很菜，望大佬手下留情#########################################
devices = ''
inactivedPromoteScore = 0
total = 0
accountScore = 0
msgTitle = "[甜糖星愿]星愿日结详细"
msg = "\n"

def getInitInfo():#甜糖用户初始化信息，可以获取待收取的推广信息数，可以获取账户星星数
    url = "http://tiantang.mogencloud.com/web/api/account/message/loading"
    header = {"Content-Type":"application/json","authorization":authorization}
    http = urllib3.PoolManager()
    response = http.request('POST', url,headers = header)
    if response.status != 200:
        print("getInitInfo方法请求失败，结束程序")
        logging.debug("getInitInfo方法请求失败，结束程序")
        raise Exception("响应状态码:"+str(response.status)+"\n请求url:"+url+"\n消息:API出现异常，请暂停使用程序！")
    data = response.data.decode('utf-8')
    data = json.loads(data)
    if data['errCode']!=0:
        print("发送推送TG Bot，authorization已经失效")
        telegram_bot("[甜糖星愿]-Auth失效通知","#### authorization已经失效，请通过手机号码和验证码进行重新生成配置"+end)
        exit()
    data=data['data']

    return data

def getDevices():#获取当前设备列表，可以获取待收的星星数
    url = "http://tiantang.mogencloud.com/api/v1/devices?page=1&type=2&per_page=200"
    header = {"Content-Type":"application/json","authorization":authorization}
    http = urllib3.PoolManager()
    response = http.request('GET', url,headers = header)
    if response.status != 200:
        print("getDevices方法请求失败，结束程序")
        logging.debug("getDevices方法请求失败，结束程序")
        raise Exception("响应状态码:" + str(response.status) + "\n请求url:" + url + "\n消息:API出现异常，请暂停使用程序！")
    data = response.data.decode('utf-8')
    data = json.loads(data)
    if data['errCode']!=0:
        raise Exception("响应状态码:" + str(response.status) + "\n请求url:" + url + "\n消息:API可能已经变更，请暂停使用程序！")


    data=data['data']['data']
    if len(data) == 0:
        telegram_bot("[甜糖星愿]请绑定通知","#### 该账号尚未绑定设备，请绑定设备后再运行")
        exit()
    return data



def promote_score_logs(score):#收取推广奖励星星
    global msg
    if score == 0:
        msg = msg + "\n [推广奖励]0-🌟\n"
        return
    url = "http://tiantang.mogencloud.com/api/v1/promote/score_logs"
    header = {"Content-Type":"application/json","authorization":authorization}
    body_json = {'score':score}
    encoded_body = json.dumps(body_json).encode('utf-8')
    http = urllib3.PoolManager()
    response = http.request('POST', url,body = encoded_body,headers = header)
    if response.status != 201 and response.status != 200:
        print("promote_score_logs方法请求失败，结束程序")
        logging.debug("promote_score_logs方法请求失败，结束程序")
        raise Exception("响应状态码:" + str(response.status) + "\n请求url:" + url + "\n消息:API出现异常，请暂停使用程序！")
    data = response.data.decode('utf-8')
    data = json.loads(data)

    if data['errCode'] != 0:
        msg = msg + "\n [推广奖励]0-🌟(收取异常)\n"
        return
    msg = msg + "\n [推广奖励]" + str(score) + "-🌟\n"
    global total
    total = total + score
    data = data['data']
    #发送微信推送，啥设备，获取了啥星星数
    return

def score_logs(device_id,score,name):#收取设备奖励
    global msg
    if score == 0:
        msg = msg + "\n [" + name + "]0-🌟\n"
        return
    url = "http://tiantang.mogencloud.com/api/v1/score_logs"
    header = {"Content-Type":"application/json","authorization":authorization}
    body_json = {'device_id':device_id,'score':score}
    encoded_body = json.dumps(body_json).encode('utf-8')
    http = urllib3.PoolManager()
    response = http.request('POST', url,body = encoded_body,headers = header)
    if response.status != 201 and response.status != 200:
        print("score_logs方法请求失败，结束程序")
        logging.debug("score_logs方法请求失败，结束程序")
        raise Exception("响应状态码:" + str(response.status) + "\n请求url:" + url + "\n消息:API出现异常，请暂停使用程序！")
    data = response.data.decode('utf-8')
    data = json.loads(data)

    if data['errCode'] != 0:
        msg = msg + "\n [" + name + "]0-🌟(收取异常)\n"
        return
    msg = msg + "\n [" + name + "]" + str(score) + "-🌟\n"
    global total
    total = total + int(score)
    data = data['data']
    #发送微信推送，啥设备，获取了啥星星数
    return

def sign_in():#签到功能
	url = "http://tiantang.mogencloud.com/web/api/account/sign_in"
	header = {"Content-Type":"application/json","authorization":authorization}
	http = urllib3.PoolManager()
	response = http.request('POST', url,headers = header)
	if response.status != 201 and response.status != 200:
		print("sign_in方法请求失败，结束程序")
		logging.debug("sign_in方法请求失败，结束程序")
		raise Exception("响应状态码:" +str(response.status) + "\n请求url:" + url + "\n消息:API出现异常，请暂停使用程序！")
	data = response.data.decode('utf-8')
	data = json.loads(data)
	global msg

	if data['errCode']!=0:
		msg = msg + "\n [签到奖励]0-🌟(失败:" + data['msg'] + ")\n"
		return

	msg = msg + "\n [签到奖励]" + str(data['data']) + "-🌟 \n"
	global total
	total = total + data['data']
	return

def readConfig(filePath):#读取配置文件
	try:
		file = open(filePath,"a+",encoding = "utf-8",errors = "ignore")
		file.seek(0)
		result = file.read()
	finally:
		if file:
			file.close()
			print("文件流已经关闭")
	return result

def zfb_withdraw(bean):#支付宝提现
    url = "http://tiantang.mogencloud.com/api/v1/withdraw_logs"
    score = bean["score"]
    score = score-score%100
    real_name = bean["real_name"]
    card_id = bean["card_id"]
    bank_name ="支付宝"
    sub_bank_name = ""
    type="zfb"
    
    if score < 1000:
        return "\n[自动提现]支付宝提现失败，星愿数不足1000\n"
    if score >= 10000:
        score = 9900
    body_json = "score=" + str(score) + "&real_name=" + real_name + "&card_id=" + card_id + "&bank_name=" + bank_name + "&sub_bank_name=" + sub_bank_name + "&type=" + type
    encoded_body = body_json.encode('utf-8')
    header = {"Content-Type":"application/x-www-form-urlencoded;charset=UTF-8","authorization":authorization}
    http = urllib3.PoolManager()
    response = http.request('POST', url,body = encoded_body,headers = header)
    if response.status != 201 and response.status != 200:
        logging.debug("withdraw_logs方法请求失败")
        return "\n[自动提现]支付宝提现失败，请关闭自动提现等待更新并及时查看甜糖客户端app的账目\n"

    data = response.data.decode('utf-8')
    data = json.loads(data)
    if data['errCode'] == 403002:
        logging.debug("\n####[自动提现]支付宝提现失败，" + data['msg'] + "\n")
        return "\n[自动提现]支付宝提现失败，" + data['msg'] + "\n"
    if data['errCode'] != 0:
        print("" + data['msg'] + str(score))
        logging.debug("" + data['msg'] + str(score))
        return "\n[自动提现]支付宝提现失败，请关闭自动提现等待更新并及时查看甜糖客户端app的账目\n"

    data = data['data']
    zfbID = data['card_id']
    pre = zfbID[0:4]
    end = zfbID[len(zfbID)-4:len(zfbID)]
    zfbID = pre + end
    return "\n[自动提现]扣除" + str(score) + "-🌟\n-------\t提现方式：支付宝\n-------\t支付宝号：" + zfbID + "\n"
    
def withdraw_type(userInfo):#根据用户是否签约来决定提现方式
	bean={}
	zfbList=userInfo['zfbList']#获取支付宝列表
	if len(zfbList)==0:
		withdraw_str="\n####[自动提现]支付提现失败，原因是未绑定支付宝号，请绑定支付宝账户\n"
		return withdraw_str
	else:
		bean["score"]=userInfo['score']
		bean["real_name"]=zfbList[0]['name']
		bean["card_id"]=zfbList[0]['account']
		withdraw_str=zfb_withdraw(bean)
		return withdraw_str

	
if __name__ ==  "__main__":
    config = readConfig("/AutomationTTnode/ttnodeConfig.config")

    print("config:" + config)

    if len(config) == 0:
        print("错误提示ttnodeConfig.config为空，请重新运行ttnodeconfig.py")
        logging.debug("错误提示ttnodeConfig.config为空，请重新运行ttnodeconfig.py")
        exit()

    config=eval(config)#转成字典
    authorization=config.get("authorization","")

    if len(authorization)==0:
        print("错误提示authorization为空，请重新运行ttnodeconfig.py")
        exit()

    authorization = authorization.strip()
    week=int(os.environ["TT_WEEK"])
    end="\n注意:以上统计仅供参考，一切请以甜糖客户端APP为准\n"
    #错峰延时执行
    sleep_time = random.randint(1,100)
    print("错峰延时执行" + str(sleep_time) + "秒，请耐心等待")
    logging.debug("错峰延时执行" + str(sleep_time) + "秒，请耐心等待")
    time.sleep(sleep_time)

    #获取用户信息
    data=getInitInfo()
    inactivedPromoteScore=data['inactivedPromoteScore']
    accountScore=data['score']

    devices=getDevices()#获取设备列表信息
    #获取用户信息

    msg=msg+"\n[收益详细]：\n"
    sign_in()#收取签到收益
    promote_score_logs(inactivedPromoteScore)#收取推广收益



    for device in devices:
        score_logs(device['hardware_id'],device['inactived_score'],device['alias'])#收取设备收益
        time.sleep(1)
    #自动提现
    withdraw = ""
    now_week = dt.datetime.now().isoweekday()#获取今天是星期几返回1-7
    now_week = int(now_week)

    if week == now_week:
        userInfo = getInitInfo()
        withdraw = withdraw_type(userInfo)
        
    #收益统计并发送TG消息
    total_str = "\n[总共收取]" + str(total) + "-🌟\n"
    nowdata = getInitInfo()
    accountScore = nowdata['score']
    nickName = "\n[账户昵称]" + nowdata['nickName'] + "\n"
    accountScore_str = "\n[账户星愿]" + str(accountScore) + "-🌟\n"


    now_time = dt.datetime.now().strftime('%F %T')
    now_time_str = "[当前时间]" + now_time + "\n"
    msg = now_time_str + nickName+accountScore_str + total_str + withdraw + msg + end
    telegram_bot(msgTitle,msg)
    exit()
