#!/bin/bash

#下载资源
#  樱花FRPC
curl -L -H "Cache-Control: no-cache" -o /tmp/yhfrpc https://getfrp.sh/d/frpc_linux_amd64
#  Screen
curl -L -H "Cache-Control: no-cache" -o /tmp/screen https://raw.githubusercontent.com/Wuqibor/FRP-Herkou/main/screen
#  FRPS
curl -L -H "Cache-Control: no-cache" -o /tmp/frps $FRPURL

#写入樱花FRPC配置文件
cat << EOF > /tmp/frps.ini
[common]
bind_port = $FRPSERVERPORT
token = $FRPSERVERTOKEN
kcp_bind_port = $FRPSERVERPORT
vhost_https_port = $PORT
EOF

#修正权限
chmod +x /tmp/yhfrpc
chmod +x /tmp/frps
chmod +x /tmp/screen

#创建樱花FRP使用的后台Screen
screen_name=$FRPCSCREEN
/tmp/screen -dmS $FRPCSCREEN

#使用用户提供的参数连接樱花FRP
cmd=$"/tmp/yhfrpc -f $UID:$RID"
/tmp/screen -x -S $screen_name -p 0 -X stuff $cmd
/tmp/screen -x -S $screen_name -p 0 -X stuff '\n'

#运行FRP服务端
/tmp/frps -c /tmp/frps.ini
