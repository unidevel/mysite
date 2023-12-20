## 为chromium设置google账户同步

参考[这篇文章](https://stackoverflow.com/questions/67459316/enabling-chromium-to-sync-with-google-account)

最简单的方法，编辑或者创建 `~/.config/chromium-flags.conf`，内容如下：

```
--oauth2-client-id=77185425430.apps.googleusercontent.com
--oauth2-client-secret=OTJgUOQcT7lO7GsGZq2G4IlT
```

这种方法使用的是他人创建的apikey，如果觉得不安全可以参考文章里面的方法自己创建
