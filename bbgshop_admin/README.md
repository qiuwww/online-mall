## bbgshop 后台端 Vue.js + element 1.x + Vant + Echarts

> **首先感谢大家的支持，谢谢你们**

**后台已实现的功能**

1. **登录**
> （请注意，**登录只有一个账号**，登录界面还有一艘可爱的小船 ~~）

2. **echarts 数据可视化**
> （呃，姑且就先这么说吧，以后还要加数据）

3. **基本的订单操作**
> （修改地址，修改留言，~~修改价格~~ （本来是有修改价格的，但是老板说不需要，然后就删掉了），修改用户收货地址，发货，退款，物流查询）

4. **商品管理**
> （商品的增删查改，商品规格增删查改，图片上传，富文本控件改写  嗯...似乎也就一点点东西，歪，你是不是觉得商品和商品规格的怎删查改很简单啊 ！ 赶紧停止那方面的想像啊喂，原本一千五百行代码，我还重构过一次，很复杂的，你信我啊...喂...心情复杂.png）

5. **商品分类**
> （商品分类的增删查改，分类图标显示在主页啊什么的）

6. **分销模块**
> （注：只是一级分销，兄弟别激动...，就是用户申请成为分销员，后台同意后该用户分享商品后，其他用户通过其分享的链接进入小程序，绑定关系以其他用户确认收货为准，绑定关系永久存在，他/她买商品之后，分销员就会获取一部分佣金，嘘，佣金可以提现的喔~ ，（哼，光是企业打款到用户银行卡就搞了一个礼拜））

7. **店铺管理**
> （就是一些主页轮播图啊，常见问题啊什么的）

8. **店铺运营**
> （包括优惠券，拼团，砍价，抽奖模块，大部分时间都花在这些上面，哼，自己去看，不想说它）

9. **用户管理**
> （包括用户列表和用户反馈）


**此项目需要 [服务端](https://github.com/yuanbon/bbgshop_nodemaster) (https://github.com/yuanbon/bbgshop_nodemaster)，[小程序端](https://github.com/yuanbon/bbgshop_miniprogram)   (https://github.com/yuanbon/bbgshop_miniprogram) 配合，请务必注意这三个是一个整体的项目，请勿分开 **

## 以下为一些截图 （加载有点慢，请耐心等待）




> 首页
![enter image description here](http://resource.bbgshop.com/github/66V%7DGY0LXFLTS%5BJE%5BZOMYZH.png)

> 后台主页
![enter image description here](http://resource.bbgshop.com/github/J1@~UJJI~J0AV%603VSR7UWJG.png)

> 嗯.... 所谓的可视化 （以后还会加数据）
![enter image description here](http://resource.bbgshop.com/github/%28AP2OKCXPW%29JH%5B_I9%5DPOXPX.png)

> 商品列表
![enter image description here](http://resource.bbgshop.com/github/%5DT3C_85%29LR8DK%7B28%25B%25F%5BCW.png)

> 添加修改商品数据

![enter image description here](http://resource.bbgshop.com/github/50%25QMIEU3~HAG%25M2%7BUXQBCD.png)
![enter image description here](http://resource.bbgshop.com/github/DIQA2XKYE%601M7@%29Y6W14UVJ.png)
![enter image description here](http://resource.bbgshop.com/github/A_$FOOG%60S$0@OE%29YV%7B%25$8%25C.png)

> 优惠券，拼团，砍价，抽奖 的页面都差不多，就贴一张图了啊  
![enter image description here](http://resource.bbgshop.com/github/@%253GVF%7DN9%5BW@B$%5DH8L%29OXAP.png)

**差不多界面就是这样子的，很low**

## 运行

> 此项目需要服务端配合 [这是超级超级超级链接](https://github.com/yuanbon/bbgshop_nodemaster)(https://github.com/yuanbon/bbgshop_nodemaster)，要先启动服务端再启动此项目才行
> 后台运行clone到本地或下载压缩文件到本地之后  解压之后  先安装依赖 `cnpm install`  然后  `npm run dev` 没有报错的话就是启动成功了 打开 localhost:9080 即可看到那艘可爱的小船啦 嘿嘿嘿.png ，打包命令是 `npm run build` 线上访问直接请将编译出的文件放到服务器上即可  


## 注：后台上传图片的地址在config/api.js 里的 UploadAddress 字段

## 打赏

> 哈哈哈 如果帮到了你 那真的是太好了

![enter image description here](http://resource.bbgshop.com/github/mm_facetoface_collect_qrcode_1531550221909.png)

![enter image description here](http://resource.bbgshop.com/github/1531550384970.jpg)

**谢谢你们的支持，有问题请添加微信 m13101221 或 添加qq群 823666423，刚创的群，欢迎捧场**

> 谢谢你们啦
