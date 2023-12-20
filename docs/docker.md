# 删除container的日志

创建rmlog脚本, 使用`rmlog <container name>`删除log
```shell
#!/bin/sh
if [ -z "$1" ]; then
  echo "rmlog <container name>"
  exit 1
fi
docker run --rm -it --privileged --pid=host walkerlee/nsenter -t 1 -m -u -i -n \
    cp /dev/null $(docker inspect -f '{{.LogPath}}' $1)
```

# 从container获取docker run的命令

```shell
alias runlike="docker run --rm -v /var/run/docker.sock:/var/run/docker.sock:ro assaflavie/runlike"
```

# 一次删除多个docker image的多个版本

最近build每次commit 都自动生成一个docker image，结果磁盘没多久就占满了，下面的命令可以一次删除一批image，只保留第一个
```shell
docker images | grep <<<image pattern>>> | awk '{print $3}' | sed '1d' | xargs docker rmi -f
```
