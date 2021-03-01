#!/usr/bin/python3
#coding=utf-8
import urllib3,json,time,sys,os,requests
import datetime as dt

TT_PHONE = os.environ["TT_PHONE"]             # 注册手机号

def getCode(phone):#获取验证码！
    phone = TT_PHONE
    if "TT_PHONE" in os.environ and "TT_PHONE" in os.environ:
        phone = os.environ["TT_PHONE"]

    url="http://tiantang.mogencloud.com/web/api/login/code"
    body_json = "phone="+phone
    encoded_body = body_json.encode('utf-8')
    http = urllib3.PoolManager()
    header = {"Content-Type":"application/x-www-form-urlencoded"}
    response = http.request('POST', url,body = encoded_body,headers = header)
    if response.status != 201 and response.status != 200:
        print("getCode方法请求失败，结束程序")
        exit()
    data = response.data.decode('utf-8')
    data = json.loads(data)

    if data['errCode'] != 0:
        print("请输入正确的手机号码！")
        exit()
    data = data['data']
    return

def getAuthorization(phone,authCode):#获取Authorization
    phone = TT_PHONE
    if "TT_PHONE" in os.environ and "TT_PHONE" in os.environ:
        phone = os.environ["TT_PHONE"]
    
    url="http://tiantang.mogencloud.com/web/api/login"
    body_json = "phone=" + phone + "&authCode=" + authCode
    encoded_body = body_json.encode('utf-8')
    header = {"Content-Type":"application/x-www-form-urlencoded"}
    http = urllib3.PoolManager()
    response = http.request('POST', url,body = encoded_body,headers = header)
    if response.status != 201 and response.status != 200:
        print("getAuthorization方法请求失败，结束程序")
        exit()
    data = response.data.decode('utf-8')
    data = json.loads(data)

    if data['errCode'] != 0:
        print("验证码错误!等待1分钟后重新运行再次获取验证码！\n")
        exit()
    data = data['data']

    return data['token']

if __name__ ==  "__main__":

    phonenum = os.environ["TT_PHONE"]
    getCode(phonenum)
    print("验证码发送成功请耐心等待！\n")
    authCode = input("请确保你输入验证码短信是甜糖发的验证码短信，以免造成经济损失，概不负责。\n请输入验证码：\n")
    authCode = str(authCode)
    if len(authCode) != 6:
        print("请输入正确的验证码!!请重新运行")
        exit()
    authorization=getAuthorization(phonenum,authCode)
    print("你的authorization：\n\n" + authorization + "\n\n")

    config={}
    config["authorization"]=authorization
    try:
        file=open("/AutomationTTnode/ttnodeConfig.config","w+",encoding="utf-8",errors="ignore")
        file.write(str(config))
        file.flush()
    finally:
        if file:
            file.close()
    exit()