---
title: "Lab Username Enumeration via Different Responses"
date: 2022-07-01T15:00:00+08:00
---

提供了用户名和密码字典

https://portswigger.net/web-security/authentication/auth-lab-usernames  
https://portswigger.net/web-security/authentication/auth-lab-passwords  


拦截登陆请求，使用Intruder （Sniper attack type )

先测试username=§aaa§&password=bbb   
使用`Simple list` payload, 添加用户名字典,然后开始   
发现用户名是app1 (这个请求的返回长度不同)  
最终username=app1&password=moscow
