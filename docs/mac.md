# Mac升级到10.15 Catalina根目录下自己创建的文件丢失？

花了俩小时升级到了`10.15 Catalina`，结果还没来得及体验NB的新功能，就发现整个开发目录都不见了，心想apple不至于搞出这么低级的升级问题。稳住搜了下，果然发现[有人已经踩坑](https://apple.stackexchange.com/questions/371852/where-does-the-upgrade-to-macos-catalina-move-root-directory-files)。
原来升级后文件被移动到了`/Users/Shared/Relocated Items/Security`，难道升级完不应该提示一下吗？说好的贴心人性化哪儿去了？？？

刚整完这个，又发现[自签名的证书不能用了](https://support.apple.com/en-us/HT210176)，据说[用openssl 1.1.1](https://forums.developer.apple.com/thread/119877)可以解决这个问题

接下来，发现[brew安装的macvim又出问题了](https://github.com/macvim-dev/macvim/issues/947)，据说补丁已经进了，可以用下面的方式安装
```
brew install macvim --HEAD
```

第二天，发现VirtualBox不断崩溃，装了最新版本也没用，后来找到[这个](https://forums.virtualbox.org/viewtopic.php?p=454145#p454145)，把privacy settings里面关于VirtualBox的全部去掉后，好像终于不崩溃了。


# Mac下使用XQuartz运行docker中的X11程序

网上有不少教程，可是基本上都不能正常启动x11应用。调查了一下发现
，[从XQuartz 2.7.9开始，不再监听tcp 6000端口了](https://bugs.freedesktop.org/show_bug.cgi?id=96771)，只能把[unix socket转换为tcp socket](https://github.com/moby/moby/issues/8710#issuecomment-72669844)才能正常运行x11应用，重新整理了一下流程如下：

1. `brew install socat`
2. `brew cask install xquartz`
3. `open -a XQuartz`, 选中 **allow connections from network clients**，然后重启 XQuartz
4. `socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"`
5. `export IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}') `
6. `xhost + $IP`
7. `docker run --rm --name firefox -e DISPLAY=$IP:0 jess/firefox`

如果想使用wm，可以参考[这篇](https://fanf.livejournal.com/142372.html)，设置xquartz，主要步骤如下:

1. `mkdir ~/.xinitrc.d`
2. add `exec <yourwm>` to `~/.xinitrc.d/99-wm.sh`
3. `chmod +x ~/.xinitrc.d/99-wm.sh`
4. Restart XQuartz.

# 离奇的Macbook无法开机案
某日，我的一台macbook air 无法开机，插入电源也不管用，长按电源键不管用，键盘灯也不亮，心想这下得重置了，无意中翻过来看到背面有个耳机拆下来的小磁铁在背后吸着，灵光一闪，心想不会是这个磁铁搞出来的吧，去掉了果然马上开机，看来是磁铁正好吸附在屏幕开关上了，幸好没重置......
