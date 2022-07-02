---
title: "Lab Multi Factor"
date: 2022-07-02T15:18:04+08:00
---


# Lab: 2FA simple bypass



-    Your credentials: wiener:peter
-    Victim's credentials carlos:montoya

利用wiener:peter登陆后，页面正上方有个"Email client",里面有验证码，输入后登陆成功,跳转到  
https://0ac500ba04fc6a72c02403f600fb0025.web-security-academy.net/my-account  
使用carlos:montoya登陆后，直接修改url即可绕过认证  

#  Lab: 2FA broken logic

-   Your credentials: wiener:peter
-   Victim's username: carlos


梳理下登陆逻辑，有三步
- POST /login 提交账号口令,服务器返回session
- GET /login2 通知服务器发送mfa-code(只有4位数字)
```
GET /login2 HTTP/1.1
Host: 0a81002203a78683c00d231f001800d0.web-security-academy.net
Cookie: verify=wiener; session=cjiAPG6MGGP0YWYDe3A3qeeyolMc5pmY
```
- POST /login2 验证mfa-code

第二步把verify=wiener替换为carlos，发现wiener没有收到mfa-code了，推测carlos收到了
第三步也把wiener替换为carlos，爆破mfa-code
(社区版burp爆破速度特别慢？？？试试Turbo Intruder呢？？)

# Lab: 2FA bypass using a brute-force attack

 This lab's two-factor authentication is vulnerable to brute-forcing. You have already obtained a valid username and password, but do not have access to the user's 2FA verification code. To solve the lab, brute-force the 2FA code and access Carlos's account page.

Victim's credentials: carlos:montoya

You will need to use Burp macros in conjunction with Burp Intruder to solve this lab. For more information about macros, please refer to the Burp Suite documentation. Users proficient in Python might prefer to use the Turbo Intruder extension, which is available from the BApp store.

需要使用Macro自动宏或者Turbo Intruder插件(短时间发送大量请求)
