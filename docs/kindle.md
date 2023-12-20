## 越狱补丁

在[Snapshots of Coplate's packages](https://www.mobileread.com/forums/showthread.php?t=289215)里选择[package #2](https://www.mobileread.com/forums/attachment.php?attachmentid=158236&d=1501804569)

## 安卓系统（自助安装，但需要购买注册码）
http://kdroid.club/

# 使用越狱的 kindle 当终端显示器

Kindle具有保护视力的eink显示屏，但只有6寸，做电脑屏幕的屏显，显得太小，但作为终端使用确是不错的，越狱后的kindle可以安装kterm，横屏显示可以成为26x80大小的终端（隐藏键盘），使用screen的会话共享功能，就可以把kindle作为终端显示器用

* 首先，Kindle必须要[越狱](https://www.mobileread.com/forums/showthread.php?t=275881)
* 然后，安装扩展 - [KUAL](https://www.mobileread.com/forums/showthread.php?t=203326), [USBNET](https://www.mobileread.com/forums/showthread.php?t=225030), [KTerm](https://www.mobileread.com/forums/showthread.php?t=205064)
* 接下来，在电脑端，安装并启动ssh server和screen，在终端中启动命名为`kindle`的screen的会话(session)
```
screen -S kindle
```
* 然后，kindle上使用KUAL启动usbnet，电脑上另外启动一个终端使用ssh连接到kindle，在kindle的`/mnt/us`下建立文件`kterm.sh`
```
/mnt/us/extensions/kterm/bin/kterm -k 0 -o R -e ./mirror.sh
```
> 这个脚本的目的就是以横屏`-o R`启动，隐藏键盘`-k 0`，并在启动后运行同目录下的`mirror.sh`脚本

* 接着，在`/mnt/us`目录下建立文件`mirror.sh`(替换`user_on_pc`和ip，并拷贝ssh的私钥id_rsa到kindle的`/mnt/us`目录)
```
ssh -t -i /mnt/us/id_rsa user_on_pc@192.168.15.3 -- screen -x kindle
```
> 目的就是在kindle上使用ssh连回电脑，然后使用`screen -x`回到命名为`kindle`的会话中

* 用ssh从电脑连接到kindle上，在`/mnt/us`下运行`kterm.sh`，就可以连记到电脑上启动的screen的会话中了，这时在电脑的screen会话中操作，就可以在kindle上看到了

# 解决Kindle无法连接需要网页认证的Wifi

只需要将kindle连上电脑后，在Kindle的USB盘的根目录上，新建一个`WIFI_NO_NET_PROBE`的文件，kindle每次连接不可以直接上网的wifi就不会去检查网络的是否连通，然后打开kindle上的浏览器随便输入个网址就可以打开认证页面了。

[相关链接](https://www.mobileread.com/forums/showthread.php?t=199951)

# Kindle 特殊的调试代码

常用的代码(在kindle的搜索框输入):

* ;411或者;711 系统信息
* ;311 选择运营商（仅适用3G版）
* ;611 显示网络信息
* ;dm  获取系统日志

更多的代码参见[这个链接](https://wiki.mobileread.com/wiki/Kindle_Touch_Hacking)

# Kindle 3G运营商选择及调试界面

新买了个美版3G的kindle，折腾了两天，终于连上了3G，而网上的解决方案大都是针对kindle 3/kindle DX，而kindle paperwhite/voyage/oasis的解决方法很少，特记录一下：

1. 在主页搜索栏输入 ;311 可以选择运营商，注意那个分号一定要输入进去
2. 在主页搜索栏输入 ;611 可以显示3G调试信息
3. 首先，确定在[3G覆盖区](http://client0.cellmaps.com/viewer.html?cov=1)
4. 然后通过;311选择运营商，如果都无法连接3G，那就只能找美国亚马逊的客服了（注意：有可能需要把kindle先登录美亚账户）
5. 客服的套路一般是升级最新版+重置（其实这个完全没必要，目的就是让越狱失效），最终就是用;611让你提供DSN和ICCID，然后经过他们设置一下就可以了
6. 最后，美版3G是可以在国内使用并登录中亚账户的，而日版的3G好像无法在国内使用。

更新一下：
联系美亚客服恢复3G，一般没有在黑名单内的都可以恢复，点[联系客服](https://www.amazon.com/gp/help/customer/contact-us/)，选择你的设备，再选Chat，就可以在线联系客服，一般先上来的第一个客服是不会修复3G问题的，只会要求你升级到最新系统，然后重置，所以打算越狱的话就要先准备好，先不要和他继续聊了，告诉他升级完再联系，因为升级后就无法降级了，所以一定要先越狱，然后升级系统到最新版。再次联系客服，他一般会要求你连无线看版本，然后告诉你需要重置下就好了，千万别理他，重置了越狱就失效了，可以告诉他重置完再联系，下线后过一会儿，再去联系他，感觉客服是无法看到系统是否已经越狱的，所以再联系后就直接告诉他已经重置完了就行了，这是这个客服就会把你转手给另外一个客服去激活3G，提供上面第5步DSN和ICCID，然后马上就可以连上3G了。
