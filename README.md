cpolar 一个公网映射到本地HTTP的工具，官网1Mbps永久免费


```
networks:
  bridge:
    driver: "bridge"
services:
  jellyfin:
    container_name: "jellyfin"
    hostname: "jellyfin"
    image: "sleechengn/cpolar:latest"
    restart: always
    environment:
      TOKEN: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  #你在cpolar.com获取的token
      URL: http://192.168.13.54:8096                 #你内网的HTTP服务
      SMTP_HOST: "smtp.qq.com"                       #SMTP主机，这里我用QQ，你改成你的
      SMTP_PORT: "587"                               #SMTP端口
      SMTP_USER: "xxxxxxxxxxx@qq.com"                #SMTP登录账号
      SMTP_PASSWD: "xxxxxxxxxxxxxxx"                 #STMP登录密码
      SMTP_FROM: "xxxxxx@qq.com"                     #你的邮箱 
      SMTP_TO: "xxxxxxx@live.cn"                     #要把公网地址发送到的目标邮箱
      MSUBJECT: "Jellyfin Cpolar 网络映射"           #邮件主题
    networks:
      - "bridge"
```
