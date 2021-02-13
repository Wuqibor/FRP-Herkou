#!/bin/sh

#下载樱花FRP客户端
mkdir /usr/local/yhfrp
curl -L -H "Cache-Control: no-cache" -o /usr/local/yhfrp/yhfrpc https://getfrp.sh/d/frpc_linux_amd64

#通过用户提供URL下载的frp客户端和配置文件
mkdir /usr/local/frp
curl -L -H "Cache-Control: no-cache" -o /usr/local/frp/frps $FRPURL

cat << EOF > /usr/local/frp/frps.ini
[common]
bind_port = $FRPSERVERPORT
token = $FRPSERVERTOKEN
kcp_bind_port = $FRPSERVERPORT
vhost_https_port = $PORT
EOF

#下载Screen
mkdir /usr/local/screen
curl -L -H "Cache-Control: no-cache" -o /usr/local/screen/screen https://raw.githubusercontent.com/Wuqibor/FRP-Herkou/main/screen

#修正权限
chmod +x /usr/local/yhfrp/yhfrpc
chmod +x /usr/local/frp/frps
chmod +x /usr/local/screen/screen

#创建樱花FRP使用的后台Screen
screen_name=$FRPCSCREEN
/usr/local/screen/screen -dmS $FRPCSCREEN

#使用用户提供的参数连接樱花FRP
cmd=$"/usr/local/yhfrp/yhfrpc -f $UID:$RID"
/usr/local/screen/screen -x -S $screen_name -p 0 -X stuff $"cmd"
/usr/local/screen/screen -x -S $screen_name -p 0 -X stuff $'\n'

#运行FRP服务端
/usr/local/frp/frps -c /usr/local/frp/frps.ini
