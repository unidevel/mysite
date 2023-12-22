## Alias

我自己配置的一些缩写命令，保存到`~/.gitconfig`下

```
[alias]
	co = checkout
	sa = stash apply
	sp = stash pop
	sa = stash save
	sl = stash list
	sd = stash drop
	pr = pull --rebase
	ph = push
	pl = pull
	pf = push --force-with-lease
	s = status
	ss = status -sb
	st = status -sb
	sb = status -sb -u no
	l = log
	lc = diff --name-only --diff-filter=U
	ls = log --pretty=\"format:%Creset%ad %Cgreen%h %C(cyan)(%an): %Creset%s\" --date=short --no-merges
	lf = log --pretty=\"format:%Creset%ad %Cgreen%h %C(cyan)(%an): %Creset%s\" --date=short --no-merges --name-only
	ll = log --pretty=\"format:%Creset%ad %Cgreen%h %C(cyan)(%an): %Creset%s\" --date=short --graph --no-merges
	lll = log --pretty=\"format:%Creset%ad %Cgreen%h %C(cyan)(%an): %Creset%s\" --date=short --name-only --graph --no-merges
	lm = log --first-parent --pretty=\"format:%Creset%ad %Cgreen%h %C(cyan)(%an): %Creset%s\" --date=short --graph
	lg = log -g --pretty=\"format:%Creset%ad %Cgreen%h %C(cyan)(%an): %Creset%s\" --date=short --no-merges
	lt = tag -l
	lb = branch -vv
	lr = remote -v
	d = diff
	dd = diff --staged
	dc = diff --diff-filter=U
	bd = branch -D
	a = add -u
	aa = add
	cm = commit -m
	cc = commit
	co = checkout
	cb = checkout -b
	m = merge
	mm = merge
	mf = merge --ff-only
	mnf = merge --no-ff
	at = tag -a
	ta = tag -a
	tl = tag -l
	td = tag -d
	tv = tag -v
	rb = rebase
	ra = remote add
	rd = remote remove
	cfg = config
```

## 配置代理

github国内访问很慢，加速可以连接VPN，或者设置一个git的代理(针对ssh协议)

下面设置一个socks5的代理给git用

1. Create SOCKS proxy by using ssh to a linux machine, here is an example (assume SOCKS port 8087)
```shell
ssh -D 8087 <remote host>
```
2. After step 1, SOCKS proxy will listen `127.0.0.1:8087`, now let's create `~/.ssh/config` to setup ssh proxy for `git://` protocol.(Do not change the content)
```
Host github.com
  User git
  Hostname github.com
  Port 22
  ProxyCommand nc -X 5 -x localhost:8087 %h %p
```
3. Then create a script for git, for example, put it to `~/.myzsh/git-proxy-wrapper`
```shell
#!/bin/sh
_proxy=127.0.0.1
_proxyport=8087
nc -X 5 -x $_proxy:$_proxyport $@
```
4. Tell git use this script on our project. (run the git command under project folder, it's per project, or use `--global` flag to setup global proxy)
```shell
git config core.gitProxy '~/.myzsh/git-proxy-wrapper for github.com'
```
5. Then you can test your git pull/push command, and run the following command to verify proxy works while pulling/pushing.
```shell
ps -ef | grep -e 'nc '
```
6. Make sure ssh is connected in step1 when running git command to access remote repository.

**To remove the proxy**, edit `~/.gitconfig` (global) or `<project>/.git/config` (local) find the line in section `[core]` like `gitProxy = ~/.myzsh/git-proxy-wrapper for github.com` to remove. And remove the `Host` settings from ~/.ssh/config in step 2

## 显示git merge后冲突的文件列表

为git配置一条新的alias
```shell
git config --global alias.conflicts '!git diff --name-only --diff-filter=U'
```

然后就可以使用`git conflicts`来显示有冲突的文件列表了(也可用上面alias中的`lc`子命令)
