### BbgShop商城（服务端）

本项目需要配合微信小程序端使用，GitHub: [https://github.com/yuanbon/bbgshop_miniprogram](https://github.com/yuanbon/bbgshop_miniprogram)，和后台
GitHub: [https://github.com/yuanbon/bbgshop_admin](https://github.com/yuanbon/bbgshop_admin)，


### 本地开发环境配置
+ 克隆项目到本地
```
git clone https://github.com/yuanbon/bbgshop_nodemaster
```
> 注意数据库字符编码为utf8mb4
+ 更改数据库配置
  src/common/config/database.js

```
const mysql = require('think-model-mysql');

module.exports = {
    handle: mysql,
    database: 'bbgshop',
    prefix: 'bbgshop_',
    encoding: 'utf8mb4',
    host: '127.0.0.1',
    port: '3306',
    user: 'root',
    password: '你的密码',
    dateStrings: true
};
```

+ 填写微信登录和微信支付配置
src/common/config/config.js
```
// default config
module.exports = {
  default_module: 'api',
  weixin: {
    appid: '', // 小程序 appid
    secret: '', // 小程序密钥
    mch_id: '', // 商户帐号ID
    partner_key: '', // 微信支付密钥
    notify_url: '' // 微信异步通知
  }
};
```
+ 填写人机行为验证
src/common/config/config.js
```
vaptcha:{  
  vid:'',
  key:''
},
```
+ 填写七牛上传配置
src/common/config/config.js
```
qiniu: {
  accessKey: '', // 七牛提供的公钥
  secretKey: '', // 七牛提供的私钥
  bucketName: ''// 存储空间名
},
```
+ 填写阿里云通信基础能力业务短信发送 （需要填写，运行的时候此处为空会报错，看效果的话请不要留空随便填点数据）
src/common/config/config.js
```
SMSClient:{  
  accessKeyId: '',
  secretAccessKey: '',
  SignatureName: '',
  TemplateDomesticCode: '',//国内短信code
  TemplateAbroadCode: '',//国际短信code
},
```

+ 安装依赖并启动
```
cnpm install
npm start
```
访问http://127.0.0.1:8360/

### 微信退款需要商户证书，下载后把.p12文件放在服务端根目录即可

### 线上部署

+ 没有域名部署参考文档：[不用买域名、不用备案、不用配置https快速部署Node.js微信小程序商城（基于Node.js+MySQL+ThinkJS）](http://www.jianshu.com/p/78a0f5f424e1)

+ 如有域名且已备案，可参考：
  + [阿里云 Ubuntu 16.04 下部署 Node.js + MySQL 微信小程序商城](http://www.jianshu.com/p/38d13a7c1b78)
  + [阿里云 CentOS 7.3 下部署基于 Node.js + MySQL 的微信小程序商城](http://www.jianshu.com/p/5d5497697b0a)


### 以上不是我写的，请谨慎操作，我只会在windows系统的服务器上部署


### 功能列表
+ 首页
+ 分类首页、分类商品、新品首发、人气推荐商品页面
+ 商品详情页面，包含加入购物车、收藏商品、商品评论功能
+ 搜索功能
+ 砍价功能
+ 拼团功能
+ 优惠券功能
+ 抽奖功能
+ 分销功能
+ 完整的购物流程，商品的加入、编辑、删除、批量选择，收货地址的选择，下单支付，退款
+ 会员中心（订单、收藏、足迹、收货地址、意见反馈）
....


## 打赏

> 哈哈哈 如果帮到了你 那真的是太好了

![enter image description here](http://resource.bbgshop.com/github/mm_facetoface_collect_qrcode_1531550221909.png)

![enter image description here](http://resource.bbgshop.com/github/1531550384970.jpg)

**谢谢你们的支持，有问题请添加微信 m13101221 或 添加qq群 823666423，刚创的群，欢迎捧场**

> 谢谢你们啦


### 最后
谢谢大家支持



###后台登录账号为admin 密码为bbgshop
