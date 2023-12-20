# A5Pro 及其他墨水屏设备

### 设置启动器

```
adb shell cmd package set-home-activity "ch.deletescape.lawnchair.plah"
adb reboot
```

### 禁用内置app

https://www.booksebook.it/?p=223&lang=en

```
adb shell pm disable-user --user 0 com.hmct.account
adb shell pm disable-user --user 0 org.hapjs.mockup
adb shell pm disable-user --user 0 com.hmct.semantic.analysis
adb shell pm disable-user --user 0 com.hmct.hmctmanual
adb shell pm disable-user --user 0 com.hmct.userexperienceprogram
adb shell pm disable-user --user 0 com.hisense.fans.club
adb shell pm disable-user --user 0 com.hisense.hiphone.appstore
adb shell pm disable-user --user 0 com.hmct.instruction
adb shell pm disable-user --user 0 com.hmct.dreams
adb shell pm disable-user --user 0 com.hmct.phoneclone.ink
adb shell pm disable-user --user 0 com.hmct.userfeedback
adb shell pm disable-user --user 0 com.hmct.ftmode
adb shell pm disable-user --user 0 com.android.printspooler
adb shell pm disable-user --user 0 com.hmct.questionnaire
adb shell pm disable-user --user 0 com.hmct.voiceassist
adb shell pm disable-user --user 0 com.hmct.voicetranslate
adb shell pm disable-user --user 0 com.hmct.voicetranslate

```


```
adb shell pm disable-user --user 0 com.android.hplayer
adb shell pm disable-user --user 0 com.android.browser
adb shell pm disable-user --user 0 com.android.calendar
adb shell pm disable-user --user 0 com.android.contacts
adb shell pm disable-user --user 0 com.android.firewall
adb shell pm disable-user --user 0 com.android.hplayer
adb shell pm disable-user --user 0 com.android.providers.downloads.ui
adb shell pm disable-user --user 0 com.android.sos
adb shell pm disable-user --user 0 com.hmct.account
adb shell pm disable-user --user 0 com.hmct.antivirus
adb shell pm disable-user --user 0 com.hmct.assist
adb shell pm disable-user --user 0 com.hmct.einklauncher.plugin.wechat
adb shell pm disable-user --user 0 com.hmct.FileManager.Activity
adb shell pm disable-user --user 0 com.hmct.imageedit
adb shell pm disable-user --user 0 com.hmct.mobileclear
adb shell pm disable-user --user 0 com.hmct.questionnaire
adb shell pm disable-user --user 0 com.hmct.theme
adb shell pm disable-user --user 0 com.hmct.voiceassist
adb shell pm disable-user --user 0 com.hmct.voicetranslate
adb shell pm disable-user --user 0 com.hmct.music
adb shell pm disable-user --user 0 com.hmct.hmctmanual
adb shell pm disable-user --user 0 com.hmct.userexperienceprogram
adb shell pm disable-user --user 0 com.tencent.soter.soterserver
adb shell pm disable-user --user 0 org.hapjs.mockup
adb shell pm disable-user --user 0 com.hmct.jdreader
adb shell pm disable-user --user 0 com.tencent.android.location
adb shell pm disable-user --user 0 com.hmct.hiphone.juplugin
adb shell pm disable-user --user 0 com.hmct.einklauncher.plugin.wechat
adb shell pm disable-user --user 0 com.hmct.voiceassist
adb shell pm disable-user --user 0 com.hmct.ftmode
adb shell pm disable-user --user 0 com.hmct.semantic.analysis
```

### Froid
https://f-droid.org/

### 阅读

* App - https://github.com/gedoor/legado/releases
* 书源 - https://www.fxxz.com/gonglue/95397.html

### 文件传输
* wifi file explorer
* Snapdrop
* Syncthing

### remove ads
https://f-droid.org/en/packages/org.jak_linux.dns66/

### Ice box(需购买注册码)

https://coolapk.com/apk/com.catchingnow.icebox


```
adb shell dumpsys account
adb shell pm list users
adb shell pm remove-user <user-id>
adb shell dpm set-device-owner com.catchingnow.icebox/.receiver.DPMReceiver
```

