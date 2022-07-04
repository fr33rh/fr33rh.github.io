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

