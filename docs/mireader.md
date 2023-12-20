# 小米电子书上一些隐藏的设置

打开运行的服务
```
adb shell am start -n com.android.settings/.RunningServices
```

打开应用信息
```
adb shell am start -n com.android.settings/.applications.ManageApplications

adb shell am start -n com.android.settings/.ManageApplications
```

打开安全设置
```
adb shell am start -n com.android.settings/.SecuritySettings
```

设备管理器
```
adb shell am start -n com.android.settings/.DeviceAdminSettings
```

开发者选项
```
adb shell am start -n com.android.settings/.DevelopmentSettings
```

电池
```
adb shell am start -n com.android.settings/.fuelgauge.PowerUsageSummary
```

声音设置
```
adb shell am start -n com.android.settings/.SoundSettings
```

Webview
```
adb shell am start -n com.android.settings/.WebViewImplementation
```

Wifi
```
adb shell am start -n com.android.settings/.wifi.WifiSettings
```

Bluetooth
```
adb shell am start -n com.android.settings/.bluetooth.BluetoothSettings
```

热点
```
adb shell am start -n com.android.settings/.TetherSettings
```

语言输入法
```
adb shell am start -n com.android.settings/.LanguageSettings
```

显示
```
adb shell am start -n com.android.settings/.DisplaySettings
```

应用存储
```
adb shell am start -n com.android.settings/.applications.StorageUse
```

第三方账户
```
adb shell am start -n com.mgs.settings/.ThirdAccountActivity
```

应用启动器
```
adb shell am start -n com.mgs.settings/.app.AppMain
```

DPI 设置
```
adb shell am start -n com.mgs.settings/.app.EinkSettingsDialog
```

设置
```
adb shell am start -n com.mgs.settings/.MgsSettingsActivity
```

多看设置
```
adb shell am start -n com.duokan.mireader/com.duokan.home.SystemSettingActivity
```

切换服务器
```
adb shell am start -n com.duokan.einkreader/com.duokan.reader.ui.general.ServerSettingActivity
```


甜点秀
```
com.android.systemui/com.android.systemui.DessertCase
```

界面调节工具
```
adb shell am start -n com.android.systemui/com.android.systemui.DemoMode
```

调节对比度
```
adb shell am start -n com.android.systemui/com.android.systemui.einksettings.EinkSettingsActivity
```

快捷面板
```
adb shell am start -n com.android.systemui/com.android.systemui.shortcutmenu.ShortcutMenuActivity
```

游戏彩蛋
```
adb shell am start -n com.android.systemui/com.android.systemui.egg.MLandActivity
```

自启动
```
adb shell am start -n com.softwinner.awmanager/.AwManager
```

亮度调节
```
adb shell am start -n com.android.systemui/.settings.BrightnessDialog
```
