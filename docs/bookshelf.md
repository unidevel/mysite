# 简介

[Bookshelf.js](http://bookshelfjs.org)是nodejs中比较成熟的关系型数据库的ORM框架，如同java中的spring/hibernate框架。

## 为什么选用Bookshelf.js
* 最重要的就是它支持Promise，现在nodejs正朝ES7发展，async/await的代码结构是异步代码未来的趋势
* 基于Backbone的Model框架，backbone的筒子们很容易上手，API也比较简单
* 支持一对一，一对多，多对多的关系映射，在此基础上，更有through方法来支持动态关系的建立
* 由于其基于knex.js，knex.js的好处就一块算上来了，可以方便的部署发布在Postgres/MSSQL/MySQL/MariaDB/SQLite3/Oracle上，knex还提供了发布和迁移的工具，十分简便

## Bookshelf.js的安装
首先，推荐使用nodejs 7.x，它支持ES7的async/await特性，但是还没有进入到稳定版中，所以在使用的时候，需要加入--harmony-async-await参数，可以在环境中加入alias，简化命令行参数
```shell
# 将下面的代码根据你使用的shell加入~/.zshrc或~/.bashrc中
alias node="node --harmony-async-await"
```
安装bookshelf之前要先装knex
```shell
# 安装knex工具
$ npm install knex -g
# 加入knex和bookshelf依赖
$ npm install knex --save
$ npm install bookshelf --save
# 然后根据你的数据库安装对应的驱动
$ npm install pg
$ npm install mysql
$ npm install mariasql
$ npm install sqlite3
```

接下来，我们以一个简单的blog系统来实验一下knex的功能，首先创建blog数据库
```shell
$ mysql -u root
> create database blog CHARACTER SET utf8 COLLATE utf8_general_ci;
```

创建bookshelf实例，以mysql为例
```javascript
var knex = require('knex')({
  client: 'mysql',
  connection: {
    host     : '127.0.0.1',
    user     : 'root',
    password : '',
    database : 'blog',
    charset  : 'utf8'
  }
});

var bookshelf = require('bookshelf')(knex);
```

## 使用knex工具初始化数据库
首先，在项目目录下，执行下列命令，创建knexfile.js模版文件
```shell
$ knex init
Created ./knexfile.js
```

打开knexfile.js，我们这个简单的例程，没必要使用staging配置，所以就保留了development和production的配置，根据情况修改配置
```javascript
// Update with your config settings.

module.exports = {
  development: {
    client: 'mysql',
    connection: {
      database: 'blog',
      user:     'root',
      password: ''
    },
    pool: {
      min: 2,
      max: 10
    },
    migrations: {
      tableName: 'knex_migrations'
    }
  },

  production: {
    client: 'mysql',
    connection: {
      database: 'blogprod',
      user:     'root',
      password: ''
    },
    pool: {
      min: 2,
      max: 10
    },
    migrations: {
      tableName: 'knex_migrations'
    }
  }
};
```

使用knex工具生成migration脚本，将会在migartions的文件夹中创建带时间戳的js脚本，用于更新数据库，这是个非常方便的功能，大大简化的数据库版本的维护，每次可以通过命令knex migrate:latest部署数据库变化，上面去掉的staging配置即在生产环境上线前的部署测试配置。
```shell
$ knex migrate:make blog
Using environment: development
Created Migration: /workspace/blog/migrations/20161124103857_blog.js
```

打开migrations下的20161124103857_blog.js文件
```javascript
exports.up = function(knex, Promise) {
  
};

exports.down = function(knex, Promise) {
  
};
```
可以看到里面有2个方法`up`和`down`，用来发布和回滚，修改下脚本，使用knex来创建blog相关的几个表，由于node暂时未直接支持async/await，所以直接knex命令无法运行含有async/await的代码，所以采用标准的Promise方式
```javascript
exports.up = function(knex, Promise) {
  const createUser = knex.schema.createTable('user', function(table){
      table.increments('id').primary();
      table.string('name', 64).notNullable();
      table.string('avatar', 255);
      table.string('password', 64);
      table.timestamps();
      table.unique('name');
  });
  const createBlog = knex.schema.createTable('blog', function(table){
      table.increments('id').primary();
      table.string('title').notNullable();
      table.text('content');
      table.integer('author_id').unsigned().references('user.id');
      table.timestamps();
  });
  const createTag = knex.schema.createTable('tag', function(table){
      table.integer('author_id').unsigned().references('user.id');
      table.string('name', 64);
      table.primary(['author_id', 'name']);
  });
  const createBlogTag = knex.schema.createTable('blog_tag', function(table){
    table.integer('blog_id').unsigned().references('blog.id');
    table.string('tag', 64);
  });
  return Promise.all([createUser, createBlog, createTag, createBlogTag])
};

exports.down = function(knex, Promise) {
  const dropUser = knex.schema.dropTable('user');
  const dropBlog = knex.schema.dropTable('blog');
  const dropTag = knex.schema.dropTable('tag');
  const dropBlogTag = knex.schema.dropTable('blog_tag');
  return Promise.all([dropBlogTag, dropTag, dropBlog, dropUser]);
};

```
运行命令knex migrate:latest来发布数据库的修改
```shell
$ knex migrate:latest   
Using environment: development
Batch 1 run: 1 migrations 
/workspace/blog/migrations/20161124103857_blog.js
```

使用mysqldump可以看到创建出了下面几张表
```sql
CREATE TABLE `blog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text,
  `author_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_author_id_foreign` (`author_id`),
  CONSTRAINT `blog_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `blog_tag` (
  `blog_id` int(10) unsigned DEFAULT NULL,
  `tag` varchar(64) DEFAULT NULL,
  KEY `blog_tag_blog_id_foreign` (`blog_id`),
  CONSTRAINT `blog_tag_blog_id_foreign` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tag` (
  `author_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`author_id`,`name`),
  CONSTRAINT `tag_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

---
接下来，将以一个简化的blog应用进行Bookshelf.js实战

# blog数据实战

## 回顾
上一节中我们使用了knex创建了数据库表，有

* user 表
* blog 表
* tag  表
* blog_tag 表

user和blog为一对多的关系
user和tag为一对多的关系
blog和tag为一对多的关系

### 首先，使用bookshelf.js添加一个用户Tom，通过此操作，演示基本的增、删、查找功能
第一步，初始化bookshelf
```javascript
const knexfile = require('./knexfile')
const knexConfig = process.env.NODE_ENV=='production'?knexfile.production:knexfile.development
const knex = require('knex')(knexConfig)
const bookshelf = require('bookshelf')(knex)
```
第二步，创建User模型
```javascript
const User = bookshelf.Model.extend({
  tableName: 'user',
  hasTimestamps: true
})
```
接下来，加入数据操作的方法
```javascript
async function addTom(){
  console.log('adding user Tom')
  var tom = await findTom()
  if ( tom != null ) {
    // delete Tom if exists
    await tom.destroy()
  }
  var user = new User({name:'Tom', password:'CatchJerry', avatar: 'http://www.avatarsdb.com/avatars/cat.jpg'})
  var model = await user.save()
  console.log(model.toJSON())
  return model.id
}

async function findTom(){
  console.log('finding user Tom');
  var tom = await User.forge({name: 'Tom'}).fetch()
  return tom
}
```
最后，运行上述函数(*注意：async返回值实际为一个promise*)
```javascript
Promise.all([addTom()]).then(function(){
  console.log('done')
})
```
*注意：运行代码要使用nodejs 7.x，并且要在后面加上参数**--harmony-async-await***

从例子中可以看出

* 新增和修改的操作都是由`save`方法完成的
* 删除通过`destroy`方法完成
* 查找使用`fetch`方法，注意这个只取一行数据，想要取得全部的数据可以使用`fetchAll`，此外还提供了分页获取数据的方法`fetchPage`
* 获得数据后可以使用`toJSON`方法转换为json格式的数据

### 接下来，加入一个blog，演示一对多的关系
第一步，修改User模型，加入blogs，用于查找用户的发帖（*注意：这里指定外键 author_id，bookshelf中默认是 <表名>_id 的列，例如如果我们使用名称user_id作为blog的外键，则无需显示指出*)
```javascript
const User = bookshelf.Model.extend({
  tableName: 'user',
  hasTimestamps: true,
  blogs: function(){
    return this.hasMany(Blog, 'author_id')
  }
})
```
第二步，加入Blog模型，
```javascript
const Blog = bookshelf.Model.extend({
  tableName: 'blog',
  hasTimestamps: true,
  author: function(){
    return this.belongTo(User, 'author_id')
  }
})
```
接下来，加入增加和查询blog的方法，这里通过不同的方法插入两条记录
```javascript
async function addUserBlogs(name){
  var user = await findUser(name);
  // 第一种方式，直接加入外键插入数据
  await Blog.forge({title: "My first blog", content: 'Blah blah blah', author_id: user.id}).save();
  // 第一种方式，通过create方法插入数据
  await user.blogs().create(Blog.forge({title:'My second blog', content:'Aha aha aha'}));
}
```
下面，演示查找用户的blog，通过`withRelated`设置，在查询user数据的同时，获取用户的blog数据，注意这里的'blogs'字串对应在模型中设置的blogs方法
```javascript
async function getUserBlogs(name){
  var user = await User.forge({name: name}).fetch({withRelated: 'blogs'})
  var blogs = user.related('blogs')
  console.log(blogs.toJSON())
  return blogs;
}
```
最后，加入入口代码，运行上面的代码
```javascript
Promise.all([addUserBlogs('Tom'), getUserBlogs('Tom')]).then(function(){
  console.log('done')
})
```
---
至此，基本的Bookshelf.js操作就基本上覆盖了，可以看出Bookshelf从模型出发，屏蔽了直接的SQL操作，简化了数据操作，增强了可移植性

