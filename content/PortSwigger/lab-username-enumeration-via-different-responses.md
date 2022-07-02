---
title: "爆破账号口令"
date: 2022-07-01T15:00:00+08:00
---

https://portswigger.net/web-security/authentication/password-based

# Lab: Username enumeration via different responses
This lab is vulnerable to username enumeration and password brute-force attacks. 
提供了用户名和密码字典
https://portswigger.net/web-security/authentication/auth-lab-usernames  
https://portswigger.net/web-security/authentication/auth-lab-passwords  
To solve the lab, enumerate a valid username, brute-force this user's password, then access their account page.


随便输入账号口令，提示Invalid username

拦截登陆请求，使用Intruder （Sniper attack type )
先测试username=§aaa§&password=bbb   
使用`Simple list` payload, 添加用户名字典,然后开始   
发现用户名是app1 (这个请求的返回长度不同)  
最终username=app1&password=moscow

# Lab: Username enumeration via subtly different responses

随便输入账号口令，提示Invalid username or password.

使用Intruder，观察response的长度，没有收获
On the Options tab, under Grep - Extract, click Add. In the dialog that appears, scroll down through the response until you find the error message Invalid username or password.. Use the mouse to highlight the text content of the message. The other settings will be automatically adjusted. Click OK and then start the attack.
结果发现有个请求的返回结果有细微差异，提示Invalid username or password少了一个句号
最终username=as&password=aaaaaa

# Lab: Username enumeration via response timing
This lab is vulnerable to username enumeration using its response times.
给了一个有效账号Your credentials: wiener:peter

添加header绕过IP防护
```
X-Forwarded-For: 127.0.0.1
```
Continue experimenting with usernames and passwords. Pay particular attention to the response times. Notice that when the username is invalid, the response time is roughly the same. However, when you enter a valid username (your own), the response time is increased depending on the length of the password you entered.   
使用 Intruder 的Pitchfork模式，因为需要同时使用IP和Username两个字典.  
On the Payloads tab, select payload set 1. Select the Numbers payload type. Enter the range 1 - 100 and set the step to 1. Set the max fraction digits to 0.   
Select payload set 2 and add the list of usernames.Start the attack.  
When the attack finishes, at the top of the dialog, click Columns and select the Response received and Response completed options. These two columns are now displayed in the results table.    
最终username=anaheim&password=tigger   

# Lab: Broken brute-force protection, IP block

In some implementations, the counter for the number of failed attempts resets if the IP owner logs in successfully. This means an attacker would simply have to log in to their own account every few attempts to prevent this limit from ever being reached.  
```
Your credentials: wiener:peter   
Victim's username: carlos   
```
Advanced users may want to solve this lab by using a macro or the Turbo Intruder extension. However, it is possible to solve the lab without using these advanced features.

设置一次只发送一个请求On the Resource pool tab, add the attack to a resource pool with Maximum concurrent requests set to 1.  
生成字典   
```
#!/bin/bash
for p in `cat password.txt`
do
	echo wiener >> list1.txt
	echo carlos >> list1.txt

	echo peter >> list2.txt
	echo $p >> list2.txt
done
```
使用pitchfork attack,添加list1和list2
When the attack finishes, filter the results to hide responses with a 200 status code.
最终username=carlos&password=1234567

# Lab: Username enumeration via account lock



Select the attack type Cluster bomb. Add a payload position to the username parameter. Add a blank payload position to the end of the request body by clicking Add § twice. The result should look something like this:  
```
username=§invalid-username§&password=example§§
```
On the Payloads tab, add the list of usernames to the first payload set. For the second set, select the Null payloads type and choose the option to generate 5 payloads. This will effectively cause each username to be repeated 5 times. Start the attack.   
问题1：这5次请求是有间隔的（先遍历set1中100个用户名，再遍历set2 ，要等一个循环），可能因为间隔时间较长而不会被封号，如何连续发送5次呢??
解决：交换Payload set 1和2的位置(burp按先后顺序编号,这里set 1 为5个空的payload)
```
password=bbbbbbbbb§§&username=§aaaa§
```
如果遇到参数的顺序不能调整怎们办呢？burp能够设置吗？？

问题2：等一分钟咋办,靠概率吗？You have made too many incorrect login attempts. Please try again in 1 minute(s).

最终password=159753&username=agenda

# Lab: Broken brute-force protection, multiple credentials per request

In Burp Repeater, replace the single string value of the password with an array of strings containing all of the candidate passwords. For example:
"username" : "carlos",
"password" : [
    "123456",
    "password",
    "qwerty"
    ...
]
成功登陆后获得302跳转和一个cookie
```
HTTP/1.1 302 Found
Location: /my-account
Set-Cookie: session=yvO5MJy7Wj1PUDnmp6AvIB8ZzWcskRtS; Secure; HttpOnly; SameSite=None
Connection: close
Content-Length: 0
```
Right-click on this request and select Show response in browser.

