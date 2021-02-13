#!/bin/bash

#下载资源
#  樱花FRPC
curl -L -H "Cache-Control: no-cache" -o /usr/local/yhfrpc https://getfrp.sh/d/frpc_linux_amd64
#  Screen
curl -L -H "Cache-Control: no-cache" -o /usr/local/screen https://raw.githubusercontent.com/Wuqibor/FRP-Herkou/main/screen
#  FRPS
curl -L -H "Cache-Control: no-cache" -o /usr/local/frps $FRPURL

#写入樱花FRPC配置文件
cat << EOF > /usr/local/frps.ini
[common]
bind_port = $FRPSERVERPORT
token = $FRPSERVERTOKEN
kcp_bind_port = $FRPSERVERPORT
vhost_https_port = $PORT
EOF

#修正权限
chmod +x /usr/local/yhfrpc
chmod +x /usr/local/frps
chmod +x /usr/local/screen

#创建樱花FRP使用的后台Screen
screen_name=$FRPCSCREEN
/usr/local/screen -dmS $FRPCSCREEN

#使用用户提供的参数连接樱花FRP
cmd=$"/usr/local/yhfrpc -f $UID:$RID"
/usr/local/screen -x -S $screen_name -p 0 -X stuff $cmd
/usr/local/screen -x -S $screen_name -p 0 -X stuff '\n'

#运行FRP服务端
/usr/local/frps -c /usr/local/frps.ini
