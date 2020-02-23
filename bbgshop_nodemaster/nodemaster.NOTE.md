## controller 中操作数据库

https://www.thinkjs.org/zh-cn/doc/3.0/relation_model.html#toc-7f9

#### 取得数据

```
拿到cart_rules表中的所有数据，查找条件是{rules_suit: 0}；
const list = await this.model('cart_rules').where({rules_suit: 0}).select();
```

#### 更新数据

```
update
const data = await this.model('cart_rules').where({id: id}).update({is_abled: 0});
```

#### 分页查找数据，并返回

```
order: 排序规则
countSelect: 分页查询数据
const data = await this.model('cart_rules').where({rules_name: ['like', `%${name}%`]}).order(['id DESC']).page(page, size).countSelect();
    return this.success(data);
```

#### 删除数据

```
const data = await this.model('cart_rules').where({id: id}).delete();
```

#### 新增数据

```
对象的形式表示一个表
await this.model('cart_rules').add({});
```

### find 与 select

find 查询单条数据
select 查询多条数据

## 接口的返回

Controller / 控制器
https://www.thinkjs.org/zh-cn/doc/3.0/controller.html#api

#### 正确返回

controller.success(data, message);

格式化输出一个正常的数据，一般是操作成功后输出，等同于 ctx.success。

```
return this.success(data);
```

#### 异常的数据返回

controller.fail(errno, errmsg, data)

格式化输出一个异常的数据，一般是操作失败后输出，等同于 ctx.fail。

```
return this.fail(2, '金额结算规则更新成功 ！');
```

## 接口中的参数获取

```
query: ctx.query,
parmas: ctx.params,
body: ctx.request.body
```

三类参数：body/params/query

#### controller.post(name)， post 请求中的 body 参数

请求类型为 POST, PUT, DELETE, PATCH, LINK, UNLINK 时才可以通过 post 方法获取提交的数据。

获取 POST 提交的参数，等同于 [ctx.post](/doc/3.0/context.html#toc-29b)。

#### ctx.param(name, value) query

获取、设置 URL 上的参数值。由于 `get`、`query` 等名称已经被 Koa 使用，所以这里只能使用 param。

ctx.param('name'); //获取参数值，如果不存在则返回 undefined

ctx.param(); //获取所有的参数值，包含动态添加的参数

获取 query 参数，等同于 [ctx.param](/doc/3.0/context.html#toc-f5e)。由于 ctx.get 已经被 Koa 使用，所以无法添加 ctx.get 方法。

#### 获取查询参数，在 get 接口中的 query，通过如下的方式

```
'comment?postId=:1&id=:2',
const postId = this.get('postId');
const commentId = this.get('id');
```

## 数据库操作

#### 直接使用可视化软件进行操作 navicat， 添加一个表，并添加字段

新建表 -》 设计表-》 添加字段（设置字段参数） -》 保存字段 -》 刷新表 -》 新增的时候添加这个字段

## 组件库的相关使用 vant 和 element-ui

#### van-popup

vant 的弹框操作

#### 侧边栏导航

```
<el-menu-item index="/dashboard">
    <i class="fa fa-map-signs"></i>
    <span>主页</span>
</el-menu-item>
```

#### 操作之前的确认弹框 element-ui

直接调用\$confirm 来打开一个确认对话框， 就是 el-dialog 的简略写法

```
this.$confirm('是否确认导出为Excel表格 ?', '提示', {
  confirmButtonText: '确定',
  cancelButtonText: '取消',
  type: 'warning'
}).then(() => {
  确认的后续操作
}).catch(() => {
  取消的确认操作
  this.$message({
    type: 'info',
    message: '取消导出 ！'
  });
});
```

## thinkjs 相关

https://thinkjs.org/zh-cn/doc/1.2/start.html

### 项目结构说明

创建项目后，会生成如下的目录结构：

├── App
│ ├── Common
│ │ └── common.js ---- 通用函数文件，一般将项目里的一些全局函数放在这里
│ ├── Conf
│ │ └── config.js ---- 项目配置文件
│ ├── Lib
│ │ ├── Behavior ---- 行为类存放位置
│ │ ├── Controller
│ │ │ └── Home
│ │ │ └── IndexController.js ---- 逻辑控制类
│ │ └── Model ---- 模型类
│ ├── Runtime ---- 运行时的一些文件
│ │ ├── Cache ---- 缓存目录
│ │ ├── Data ---- 数据目录
│ │ ├── Log
│ │ └── Temp
│ └── View
│ └── Home
│ └── index_index.html ---- 模版文件，默认使用 ejs 模版引擎
├── ctrl.sh ---- 项目启动、停止脚本
└── www
├── index.js ---- 入口文件
└── resource ---- 静态资源目录
├── css ---- css 文件
├── img ---- 图片文件
├── js ---- js 文件
├── module ---- 第三方的一些组件
└── swf ---- flash 文件

## thinkjs 的后台处理逻辑

### 接口请求

没有明确的接口路由文件，请求依次查找文件目录。如

`http://127.0.0.1:8360/admin/guide/setnoviceguide` => admin 目录 => controller/guide 控制器 => setnoviceguide 方法 => 数据库表(guide + model) => 查询数据 data，然后返回。
