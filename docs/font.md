# 获取字体postscript 名称（OSX/Linux）

在配置字体时通常要使用字体的postscript名字，而不是文件名，为了得到这个名称，可以使用下面的命令
```shell
fc-scan --format "%{postscriptname}\n" file
```

如果在html使用，需要使用字体的family名称(在kindle的font hack的配置里也要用这个)，可以使用下面的命令得到
```shell
fc-scan --format "%{family}\n" file
```

此外，[fc-scan](https://www.systutorials.com/docs/linux/man/1-fc-scan/)还可以显示很多有用的信息

Mac系统下可以使用`mdls`显示字体的信息
