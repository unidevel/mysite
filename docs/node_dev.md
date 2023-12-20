# 灵活的使用Promise

在js脚本中Promise能让我们灵活的处理异步的事件，尤其是结合async/await使用时。

通常我们使用的都是简单的等待，比如等待网络请求
```javascript
var data = await fetchData(...)
processData(data);
```

有时，需要等待的情况会比较复杂，比如等待一个对象创建后去执行一些对象上的方法
```javascript
var someObject = await getSomeObject()
someObject.execSomeMethod(...)
```

这时，可以采用下面的方式实现
```javascript
class DummyObject {
    doSomething(...args){
        console.log('DummyObject.doSomething', ...args);
    }
}

class DummyWrapper{
  constructor(){
    this.instance = null;
    this.promise = new Promise(resolve=>{
      this.resolve = (inst)=>{
        this.instance = inst;
        resolve(inst);
        delete this.promise;
        delete this.resolve;
      }
    });
  }

  setInstance(inst){
    if ( this.instance != null ) this.instance = inst;
    else this.resolve(inst);
  }

  doSomething(...args){
    console.log('DummyWrapper.doSomething', ...args);
    if ( this.instance ) {
      this.instance.doSomething(...args)
    }
    else if ( this.promise ) {
      this.promise.then(()=>this.instance.doSomething(...args));
    }
  }
}
var wrapper = new DummyWrapper();
wrapper.doSomething("hello", "world1");
wrapper.doSomething("hello", "world2");
setTimeout(()=>{
    wrapper.doSomething("creating dummyObject");
    var instance = new DummyObject();
    wrapper.setInstance(instance);
}, 1000);
```
输入如下
```shell
DummyWrapper.doSomething hello world1
DummyWrapper.doSomething hello world2
creating dummyObject
DummyObject.doSomething hello world1
DummyObject.doSomething hello world2
```

# 处理npm symlink错误

在FAT32文件系统上，`npm install`无法执行symlink，无法进行依赖安装
```shell
Error: EPERM: operation not permitted, symlink '../mime/cli.js' -> '/mnt/us/node/apps/test/node_modules/.bin/mime'
```

这时可以使用选项`--no-bin-links`安装
```shell
npm install --no-bin-links
```

# 检视Tooltip元素

在Web开发中，我们经常会需要调试DOM节点的样式，但有些节点，像DOM定制的Tooltip这种元素，需要鼠标移上去，才会出现，鼠标移出就消失，非常难以捕捉。

仔细分析一下，这种节点一般都是mouseout触发了隐藏的逻辑，如果我们不知道代码在哪里，可以采用下面的方法来阻止Tooltip的消失

首先，打开调试控制台，在console输入执行下面的脚本
```javascript
setTimeout(function(){debugger;},5000);
```

然后，将鼠标移动到目标元素上，使Tooltip得以显示，等待几秒钟，断点中断，就可以自由的检视Tooltip元素的样式了。

# [Bookshelf.JS开发实战](bookshelf.md)
