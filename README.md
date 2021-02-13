# FRP Heroku (On Sakura FRP)

## 概述

用于在 Heroku 上部署一个仅仅可以使用80和443端口的FRP服务。

## 警告

**Heroku 为我们提供了免费的容器服务，我们不应该滥用它，所以本项目不宜做为长期穿透使用。**

**Heroku 的网络并不稳定，国内链接速度也并不理想，仅供测试用途，部署前请三思。**

## 镜像

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://dashboard.heroku.com/new?template=https://github.com/Wuqibor/FRP-Herkou)

## ENV 设定

`FRPURL` > `用户用于部署的FRP服务端，请直接提供服务端下载直链！`。

`CONFIGURL` > `用户用于部署的FRP服务端对应的配置文件，请直接提供配置文件下载直链！`。

`UID` > `在SakuraFRP的链接UID`。

`RID` > `在SakuraFRP创建的用于数据传输的隧道id`。

## 其他

这个项目有什么用？SakuraFRP不是提供了443/80端口的HTTP(S)隧道吗？
——国内服务器域名未备案(18岁年龄限制忧伤/免费域名不支持备案)，国外服务器禁止使用tk/ml/cf/ga/gq等免费域名(莫得钱qwq...)

可是Herkou如果要自定义域名要绑定信用卡那那不是白干了？
——反向代理/CDN

如果SakuraFRP/Herkou对此项目有任何异议，请联系删除

Email:admin@wuqibor.gq
