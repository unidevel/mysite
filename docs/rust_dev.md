# 通过jemallocator获取heap的使用信息

在 main 函数前加入

```rust
use jemalloc_ctl::{stats, epoch};

#[global_allocator]
static ALLOC: jemallocator::Jemalloc = jemallocator::Jemalloc;
```

统计代码
```rust
     epoch::advance().unwrap();
     let allocated = stats::allocated::read().unwrap();
     let resident = stats::resident::read().unwrap();
     println!("{} bytes allocated/{} bytes resident", allocated, resident);
```


References:
1. https://docs.rs/jemalloc-ctl/latest/jemalloc_ctl/
2. https://github.com/jemalloc/jemalloc/wiki/Use-Case%3A-Basic-Allocator-Statistics

# 在rust工程中使用本地的crate

例如在myproj里面使用mylib的crate
```
root
├── myproj
│  ├── Cargo.lock
│  ├── Cargo.toml
│  └── src
│     └── main.rs
└── mylib
   ├── Cargo.toml
   └── src
      └── lib.rs
```

可以在`mylib/Cargo.toml`依赖里面设置`mylib = { path = "../mylib" }`，完整的代码如下
```toml
[package]
name = "myproj"
version = "0.1.0"
authors = [".............."]
edition = "2018"

# See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html

[dependencies]
mylib = { path = "../mylib" }
```

# Rust 在OSX下交叉编译 linux 目标文件

这个折腾了好久，一开始在虚拟机直接编译出linux的目标程序，发现放到ubuntu上面报告 libssl.so.1.1 找不到，于是就想静态编译进去，然后就发现了musl这个好东东。折腾了一番，发现两种方案可以方便做交叉编译。

### 方案一，使用交叉编译工具

* 添加交叉编译工具 https://github.com/FiloSottile/homebrew-musl-cross

```shell
brew install FiloSottile/musl-cross/musl-cross
```

* 添加rust的目标系统编译库工具
```shell
rustup target add x86_64-unknown-linux-musl
```

* 设置 `$HOME/.cargo/config`
```toml
[target.x86_64-unknown-linux-musl]
linker = "x86_64-linux-musl-gcc"
```

* 设置环境变量 `CROSS_COMPILE`
```shell
export CROSS_COMPILE=x86_64-linux-musl-
```

* 如果用到了reqwest，会出现编译 openssl 编译错误，可以参考这个修改一下依赖设置 https://github.com/richfelker/musl-cross-make/issues/65
```toml
[dependencies.reqwest]
version = "0.9"
default-features = false
features = ["rustls-tls"]
```

* 参考链接
https://blog.filippo.io/easy-windows-and-linux-cross-compilers-for-macos/

---

### 方法二，使用docker镜像

https://github.com/clux/muslrust


