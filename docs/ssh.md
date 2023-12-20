# Mac下mosh的安装及使用

### 服务器端
使用管理工具安装完mosh就可以了，比如debian系列的就可以通过下面命令安装
```
apt-get update && apt-get install mosh
```

需要注意的是，设置好防火墙规则，允许访问60001以上的udp端口，网上有很多教程使用的是ufw，一定要注意不要同时启动多个防火墙，比如当前运行了firewalld，但按教程安装了ufw，在ufw中打开了端口，但由于firewalld还在运行，导致无法连接，可以运行下面的命令解决

```
systemctl disable firewalld
systemctl enable ufw

ufw allow 60001:60100/udp
```

### 客户端
Mac上可以使用brew安装
```
brew install mosh
```

Mac上安装完后，如果LC_CTYPE和LC_ALL没有设置的话，可能会出现下面的错误
```
The locale requested by LC_CTYPE=UTF-8 isn't available here.
Running `locale-gen UTF-8' may be necessary.

The locale requested by LC_CTYPE=UTF-8 isn't available here.
Running `locale-gen UTF-8' may be necessary.

mosh-server needs a UTF-8 native locale to run.

Unfortunately, the local environment (LC_CTYPE=UTF-8) specifies
the character set "US-ASCII",

The client-supplied environment (LC_CTYPE=UTF-8) specifies
the character set "US-ASCII".

locale: Cannot set LC_CTYPE to default locale: No such file or directory
locale: Cannot set LC_ALL to default locale: No such file or directory
LANG=
LANGUAGE=
LC_CTYPE=UTF-8
LC_NUMERIC="POSIX"
LC_TIME="POSIX"
LC_COLLATE="POSIX"
LC_MONETARY="POSIX"
LC_MESSAGES="POSIX"
LC_PAPER="POSIX"
LC_NAME="POSIX"
LC_ADDRESS="POSIX"
LC_TELEPHONE="POSIX"
LC_MEASUREMENT="POSIX"
LC_IDENTIFICATION="POSIX"
LC_ALL=
Connection to ********** closed.
/usr/local/bin/mosh: Did not find mosh server startup message. (Have you installed mosh on your server?)
```

这个错误可以通过在客户端设置环境变量解决，可以放到当前shell的用户脚本中
```
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```

### 使用说明

mosh使用起来非常简便，只要服务器端和客户端都安装上mosh(ssh套件也是必要的），服务器端不需要启动mosh-server，可以直接使用，命令格式和ssh基本一致，但是不支持ssh的tunnel

1. 连接标准22端口的ssh服务器
```
mosh user@host
```

2. 连接非标准端口的ssh服务器
```
mosh --ssh='ssh -p 2222' user@host
```


# 终端共享/协作

VNC一类的工具可以共享桌面，用于协助、技术支持或者教学，终端下也有类似的工具 `screen`, 可以通过命名指定一个session名称，其他人通过指定的session名称连接上来，就可以一块使用同一个终端，每个人不仅看到对方输入的指令，而且可以输入指令被所有人看到。

具体步骤如下

1.用户A使用ssh以某一用户登录到服务器，运行
```shell
screen -S <session name>
```
2.用户B使用同一用户登录到服务器，运行
```shell
screen -x <session name>
```
