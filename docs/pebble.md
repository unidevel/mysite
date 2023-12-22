# 安装pebble sdk 的踩坑之旅

Pebble公司虽然倒了，但是手表真的非常好用，想弄个开发环境，发现官网已经消失了，还好Google到它的备份[网站](https://developer.rebble.io/developer.pebble.com/sdk/index.html)和[这个](https://developer.get-rpws.com/)，照着教程动手开始在OSX下撸开发环境，踩坑无数。首先要注意的是它的sdk工具只能用python2.x，如果装了python3的，先把python链接到OSX自带的python2.7上。

好不容易把sdk工具弄上，接着撸hello world，这才发现下载不了SDK，查了下源码才发现要从官网下载，官网没了，当然......还好找到了个[文档](https://www.reddit.com/r/pebble/comments/9ufaay/sdk_install_guide/)
```shell
pebble sdk install https://github.com/aveao/PebbleArchive/raw/master/SDKCores/sdk-core-4.3.tar.bz2
```

撸完 hello world, 运行又出问题了，报了一大堆python错误，当时没记下来，核心是找不到 `__ZN5boost6system15system_categoryEv`，继续查发现首先，缺少动态库`libboost_python-mt.dylib`，不过看到`/usr/local/lib/libboost_python27-mt.dylib`我顺手就链接了一个，但发现还是没这个，感觉boost或者boost-python有问题，想到这个SDK是好几年前的产物，没准是版本对不上，就开始找旧版本，折腾了几个终于发现`brew install boost@1.60`里面有这个符号，装上把lib下的所有文件链接到`/usr/local/lib`下，终于撸起来了hello world.

# Pebble重生为Rebble

在装有**最新Pebble官方app**的手机上用 **手机浏览器** 打开这个地址 https://auth.rebble.io/ ，按步骤操作就可以切换到Rebble的市场，下载表盘和app，感觉这个新的市场做的比以前那个好，速度快还支持中文。
