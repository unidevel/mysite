# 小米电子书上一些隐藏的设置

打开运行的服务
```shell
adb shell am start -n com.android.settings/.RunningServices
```

打开应用信息
```shell
adb shell am start -n com.android.settings/.applications.ManageApplications
adb shell am start -n com.android.settings/.ManageApplications
```

打开安全设置
```shell
adb shell am start -n com.android.settings/.SecuritySettings
```

设备管理器
```shell
adb shell am start -n com.android.settings/.DeviceAdminSettings
```

开发者选项
```shell
adb shell am start -n com.android.settings/.DevelopmentSettings
```

电池
```shell
adb shell am start -n com.android.settings/.fuelgauge.PowerUsageSummary
```

声音设置
```shell
adb shell am start -n com.android.settings/.SoundSettings
```

Webview
```shell
adb shell am start -n com.android.settings/.WebViewImplementation
```

Wifi
```shell
adb shell am start -n com.android.settings/.wifi.WifiSettings
```

Bluetooth
```shell
adb shell am start -n com.android.settings/.bluetooth.BluetoothSettings
```

热点
```shell
adb shell am start -n com.android.settings/.TetherSettings
```

语言输入法
```shell
adb shell am start -n com.android.settings/.LanguageSettings
```

显示
```shell
adb shell am start -n com.android.settings/.DisplaySettings
```

应用存储
```shell
adb shell am start -n com.android.settings/.applications.StorageUse
```

第三方账户
```shell
adb shell am start -n com.mgs.settings/.ThirdAccountActivity
```

应用启动器
```shell
adb shell am start -n com.mgs.settings/.app.AppMain
```

DPI 设置
```shell
adb shell am start -n com.mgs.settings/.app.EinkSettingsDialog
```

设置
```shell
adb shell am start -n com.mgs.settings/.MgsSettingsActivity
```

多看设置
```shell
adb shell am start -n com.duokan.mireader/com.duokan.home.SystemSettingActivity
```

切换服务器
```shell
adb shell am start -n com.duokan.einkreader/com.duokan.reader.ui.general.ServerSettingActivity
```


甜点秀
```shell
com.android.systemui/com.android.systemui.DessertCase
```

界面调节工具
```shell
adb shell am start -n com.android.systemui/com.android.systemui.DemoMode
```

调节对比度
```shell
adb shell am start -n com.android.systemui/com.android.systemui.einksettings.EinkSettingsActivity
```

快捷面板
```shell
adb shell am start -n com.android.systemui/com.android.systemui.shortcutmenu.ShortcutMenuActivity
```

游戏彩蛋
```shell
adb shell am start -n com.android.systemui/com.android.systemui.egg.MLandActivity
```

自启动
```shell
adb shell am start -n com.softwinner.awmanager/.AwManager
```

亮度调节
```shell
adb shell am start -n com.android.systemui/.settings.BrightnessDialog
```
