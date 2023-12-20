# 去除微信读书（非墨水屏版）中的漫画翻页动画

## 版本<=8.29.1
微信读书的墨水屏版貌似屏蔽了漫画功能，所有的漫画都没法搜索到，只能安装非墨水屏版本的微信读书，但是里面讨厌的滚动动画实在是闪瞎眼，研究了一下，去除漫画书籍里面点击翻页的动画效果可以修改如下代码，就是简单的把`smali_classes2/com/tencent/weread/comic/view/experimental/ComicRecyclerView$smoothScrollByConst$1.smali` 里面的 `smoothScrollBy` 替换为 `scrollBy`（没准可以全部搜索替换一下）

```
--- a/smali_classes2/com/tencent/weread/comic/view/experimental/ComicRecyclerView$smoothScrollByConst$1.smali
+++ b/smali_classes2/com/tencent/weread/comic/view/experimental/ComicRecyclerView$smoothScrollByConst$1.smali
@@ -67,7 +67,7 @@
     :goto_0
     const/4 v2, 0x0

-    invoke-virtual {v0, v2, v1}, Lcom/tencent/weread/comic/view/experimental/ComicRecyclerView;->smoothScrollBy(II)V
+    invoke-virtual {v0, v2, v1}, Lcom/tencent/weread/comic/view/experimental/ComicRecyclerView;->scrollBy(II)V

     return-void
 .end method
```

反编译也是个技术活儿，企鹅对apk保护的比较好，apktool解包总是报错，不过没关系，我们不需要修改res，只要把dex反编译了就可以了，按这个思路，只需要安装[smali和baksmali](https://github.com/JesusFreke/smali/wiki/SmaliBaksmali2.2)即可，编译完覆盖回去再打个包，齐活儿！

## 版本>= 8.29.2
Kindle升级到8.29.2后，去掉了大部分的`isEInkBuild`的代码，不知道是不是为了负优化，避免其他电子书争夺kindle的市场份额，上次针对krf/krx格式的去动画还可以用，但是针对mobi/pdf的去动画就没法用了。

只好又研究了一遍，自己弄了个 `Interpolator`， 反正去动画，就简单写一下好了

```
package com.amazon.android.docviewer.animation;

import android.util.Log;
import android.view.animation.Interpolator;

public class SimpleInterpolator implements Interpolator {
    boolean m_first = true;
    @Override
    public float getInterpolation(float input) {
        Log.i("Kindle.getInterpolation", "input="+input);
        if ( m_first ) {
            m_first = false;
            return 0;
        }
        return 1.0f;
    }
}

```

在 `AnimationTranslateX` 使用一下，就搞定了点击翻页去动画
```
    public AnimationTranslateX(View v, int offsetX, long duration, Interpolator interpolator) {
        Log.i("Kindle.AnimationTranslateX", "offsetX="+offsetX+",duration="+duration);
        this.animatedView = v;
        TranslateAnimation animation = new TranslateAnimation(0.0f, (float) offsetX, 0.0f, 0.0f);
        animation.setDuration(1);
        if (interpolator != null) {
            animation.setInterpolator(new SimpleInterpolator());
        }
        animation.setFillEnabled(true);
        animation.setFillAfter(true);
        v.setAnimation(animation);
    }
```

但是，滑动翻页去动画还在，抓了几个点，都没去掉，郁闷ing......

----

今天偷懒了一下，把828的`smali/com/amazon/android/docviewer`全部拷贝回来，反正亚马逊的同学只是把 `isEInkBuild` 相关的功能去掉了，并没有什么新功能，所以还是值得一试的，结果打开mobi就崩溃了，差了下好像还少了个 `smali_classes2/com/amazon/kindle/event/ReaderSensitivitySwitch.smali`，拷贝回来，搞定！

---
顺手调整了一下上面的空白，主要是修改`reader_top_margin`, `reader_title_offset_from_top`和`periodical_top_margin`这几个值，具体哪个起作用不知道，反正调整完就好多了，这几个值在下面的几个文件里面
```
res/values-large-port-v11/dimens.xml
res/values-large-v4/dimens.xml
res/values-xlarge-port-v11/dimens.xml
res/values-xlarge-v4/dimens.xml
```
