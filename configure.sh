#!/bin/sh

#下载樱花FRP客户端
mkdir /usr/local/yhfrp
curl -L -H "Cache-Control: no-cache" -o /usr/local/yhfrp/yhfrpc https://getfrp.sh/d/frpc_linux_amd64

#通过用户提供URL下载的frp客户端和配置文件
mkdir /usr/local/frp
curl -L -H "Cache-Control: no-cache" -o /usr/local/frp/frps $FRPURL
curl -L -H "Cache-Control: no-cache" -o /usr/local/frp/frps.ini $CONFIGURL

#下载Screen
mkdir /usr/local/screen
curl -L -H "Cache-Control: no-cache" -o /usr/local/screen/screen https://github.com/Wuqibor/FRP-Herkou/blob/main/screen?raw=true

#修正权限
chmod +x /usr/local/yhfrp/yhfrpc
chmod +x /usr/local/frp/frps

#创建樱花FRP使用的后台Screen
screen_name=$FRPCSCREEN
screen -dmS $FRPCSCREEN

#使用用户提供的参数连接樱花FRP
cmd=$"/usr/local/yhfrp/yhfrpc -f $UID:$RID"
screen -x -S $screen_name -p 0 -X stuff $"cmd"
screen -x -S $screen_name -p 0 -X stuff $'\n'

#运行FRP服务端
/usr/local/frp/frps -c /usr/local/frp/frps.ini
