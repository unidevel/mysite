# React Native实战

## 准备
npm install -g react-native-cli 
npm install -g rnpm xcode

## React 常用组件
* redux
* react-redux
* redux-thunk
* string-format
* whatwg-fetch

## React Native常用组件
* [react-native-custom-checkbox](https://github.com/caroaguilar/react-native-custom-checkbox)
* react-native-sqlite-storage
* react-native-admob
* react-native-sqlite-storage
* react-native-vector-icons
* react-native-swipeout

## 常见问题
1. 使用Navigator组建时，上层的Container的样式不要使用`alignItems:'center'`，否则会无法显示

2. 使用`npm install --save` 安装新的依赖后，刷新app会报告`unable resolve modules`的错误，这时需要运行一次`npm install`才会恢复正常

3. 宽度100%使用样式`alignSelf: 'stretch'`，如果在ScrollView上使用，应该应用在`style`属性中，而不是`contentContainerStyle`中

4. 可用的字体，参见[react-native-fonts](https://github.com/dabit3/react-native-fonts)

5. 获取设备分辨率 `let { height, width } = Dimensions.get(“window”);`

6. 1个像素的边框`borderWidth: 1/PixelRatio.get()`或者`borderBottomWidth: StyleSheet.hairlineWidth`

7. 使用自定义字体，参见 [设置React Native自定义字体](http://bbs.reactnative.cn/topic/204/%E8%AE%BE%E7%BD%AEreact-native%E8%87%AA%E5%AE%9A%E4%B9%89%E5%AD%97%E4%BD%93)

8. Navigator转换组件在android中非常慢，折腾了半天，发现是console.log引起的

9. [已有Android工程集成ReactNative页面](http://www.jianshu.com/p/d63c9a22973d/comments/794117)

## 代码片段
```javascript
    static isAndroid = (Platform.OS === 'android')
```


# NavigationBar在android中title居中的问题
最近在android中使用React-native中Navigation.NavigationBar组件，发现title不像iOS中的那样居中，简单调整了下，使用`navigationStyles={Navigation.NavigationBar.StylesIOS}`后，Title是居中了，不过上面有一大块空白，看了下源代码，没有特别简便的方式处理，只好拷贝了一份`NavigatorNavigationBarStylesIOS.js`的源码，将其中的`STATUS_BAR_HEIGHT = 20`改为`STATUS_BAR_HEIGHT = 0`，引用这个样式，搞定

# 一些有用的adb命令

## Disable animation
```
adb shell settings put global window_animation_scale 0
adb shell settings put global transition_animation_scale 0
adb shell settings put global animator_duration_scale 0
```

## grant sdcard permissions
```
adb shell pm grant com.your.app.package android.permission.WRITE_EXTERNAL_STORAGE
adb shell pm grant com.your.app.package android.permission.READ_EXTERNAL_STORAGE
```

## get all apks
```
for i in $(adb shell pm list packages | awk -F':' '{print $2}'); do adb pull "$(adb shell pm path $i | awk -F':' '{print $2}')"; mv base.apk $i.apk 2&> /dev/null ;done
```

# 安卓手机原来可以通过USB OTG连接有线网络
无意中发现，安卓手机原来可以通过USB OTG配合给Mac使用的USB有线网卡来使用有线上网，可惜没研究出来怎么再建个AP出来共享.

不过这里有个另类的分享上网的方法
https://android.stackexchange.com/questions/26934/wifi-access-point-with-usb-otg-ethernet
就是将安卓手机作为代理服务器，配置为HTTP或者SCOKS代理，然后启动AP，电脑上设置手机ip为代理服务器就可以了。

# Mac下android SDK中的monitor无法点击

参考 https://stackoverflow.com/questions/47089757/android-device-monitor-freezes-on-mac-os-x/47090518

# Use installed gradle

```
> cd android
> ln -sf `which gradle` gradlew
```

# 免重置连接android wear到新手机

https://sspai.com/post/40486

