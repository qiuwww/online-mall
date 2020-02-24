# miniprogram.NOTE

"libVersion": "2.6.4",

微信小程序开发，[官方文档](https://developers.weixin.qq.com/miniprogram/dev/framework/)

## 小程序启动

1. 微信开发者工具，登陆 -> 小程序 -> 添加本地项目;
2. 无 appid，需要重新注册；
3. 使用已 appid 也；
4. 接口数据请求，需要官网配置（对于本地请求，需要配置不校验地址，设置-> 项目设置 -> 不校验合法域名....）。

## 程序执行流程

1. 使用微信开发者工具打开源代码（|通过工具初始化项目）；
2. app 文件，参考[目录结构说明](https://developers.weixin.qq.com/miniprogram/dev/framework/structure.html)；
3. app.json/pages(路由文件) -> pages，具体的页面

### 微信首页如何确定的

默认采用的是 app.json/pages[0]，当然也可以进行判断然后[跳转](https://developers.weixin.qq.com/miniprogram/dev/api/route/wx.navigateTo.html)。

## 常用接口

[App 的生命周期](https://developers.weixin.qq.com/miniprogram/dev/reference/api/App.html)

[Page 的生命周期](https://developers.weixin.qq.com/miniprogram/dev/reference/api/Page.html)，与组件不大一样。

- onLoad: function (options) {// 页面初始化 options 为页面跳转所带来的参数

## 组件

[基础组件](https://developers.weixin.qq.com/miniprogram/dev/component/)

[自定义组件](https://developers.weixin.qq.com/miniprogram/dev/reference/api/Component.html)

[公共组件](https://developers.weixin.qq.com/miniprogram/dev/framework/custom-component/)

[更多参考](https://www.cnblogs.com/kdcg/p/9115778.html)

需要添加配置说明：

```js
// 然后在生成的pop.json文件中将component定义为true

{
  "component": true
}
```

[组件的生命周期](https://developers.weixin.qq.com/miniprogram/dev/framework/custom-component/lifetimes.html)

### 常用基础组件

scroll-view：

## WXML 语法

[WXML 语法](https://developers.weixin.qq.com/miniprogram/dev/reference/wxml/)

## WXS 语法参考

WXS（WeiXin Script）是小程序的一套脚本语言，结合 WXML，可以构建出页面的结构。

WXS 与 JavaScript 是不同的语言，有自己的语法，并不和 JavaScript 一致。

## 插件

[插件的文档](https://developers.weixin.qq.com/miniprogram/dev/framework/plugin/)

插件是对**一组 js 接口、自定义组件或页面的封装**，用于嵌入到小程序中使用。插件不能独立运行，必须嵌入在其他小程序中才能被用户使用；而第三方小程序在使用插件时，也无法看到插件的代码。因此，插件适合用来封装自己的功能或服务，提供给第三方小程序进行展示和使用。

**相对于普通 js 文件或自定义组件**，插件拥有更强的独立性，拥有独立的 API 接口、域名列表等，但同时会受到一些限制，如一些 API 无法调用或功能受限。还有个别特殊的接口，虽然插件不能直接调用，但可以使用 插件功能页 来间接实现。

## 常用操作

### 设置当前页面分享

需要在页面对象 Page 初始化的时候添加 onShareAppMessage，如 index 页面：

```js
onShareAppMessage: function() {
    let that = this
      return {
        title: '贝堡商城',
        desc: '贝堡商城微信小程序',
        path: '/pages/index/index',
        imageUrl: '../../image/CorporateData/bbg_share_logo.png',
    }
  },
```

### banner 滚动图

使用基础组件[swiper](https://developers.weixin.qq.com/miniprogram/dev/component/swiper.html)。

### 加载图片

[image 组件](https://developers.weixin.qq.com/miniprogram/dev/component/image.html)

```wxml
<image lazy-load class='icon_bar_img' src="{{item.icon_url}}"></image>
```

lazy-load： 图片懒加载，在即将进入一定范围（上下三屏）时才开始加载

### 事件

[事件](https://developers.weixin.qq.com/miniprogram/dev/framework/view/wxml/event.html)定义在 Page 对象参数中，在 wxml 中可以直接使用，定义类似 react，使用类似 vue。

参考 index 的 JumpUrl 方法。

```js
// 定义
},
  JumpUrl(e){
    let id = e.currentTarget.dataset.url
    util.request(api.getchildrenCategoryIdByFather,{
      id:id
    },'POST').then(res => {
      console.log(res)
      id = res.data.return_id
      let title = res.data.fathercategoryTitle
      wx.navigateTo({
        url: '/pages/category/category?id=' + id + '&title=' + title,
        success: function (res) { },
        fail: function (res) { },
        complete: function (res) { },
      })
    })
  },
// 使用

<view class="icon_bar_item" bindtap='JumpUrl' data-url='{{item.category_id}}' wx:for="{{channel}}" wx:key="{{item.id}}">
```

bindtap 相当于点击 click。

注意**区分 catch(catch 会阻止事件向上冒泡)与 bind**。

### 页面跳转方式

#### 1. 代码跳转 wx.navigateTo

[页面跳转](https://developers.weixin.qq.com/miniprogram/dev/api/route/wx.navigateTo.html)。保留当前页面，跳转到应用内的某个页面。

```js
wx.navigateTo({
  url: 'test?id=1',
  events: {
```

#### 2. 标签跳转

[navigator](https://developers.weixin.qq.com/miniprogram/dev/component/navigator.html)

```wxml
<navigator url="/pages/search/search" class="input">
      <image class="icon"></image>
      <text class="txt">商品搜索, 共{{goodsCount}}款好物</text>
    </navigator>
```

### tabBar

声明了做为 tabBar 的页面会带有导航 tabBar。

### 循环显示一个列表

[列表渲染](https://developers.weixin.qq.com/miniprogram/dev/reference/wxml/list.html)

使用指令，与 vue 类似

```js
 wx:for="{{channel}}" wx:key="{{item.id}}"
```

- view:wx:for

- block wx:for， 也可以将 wx:for 用在<block/>标签上，以渲染一个包含多节点的结构块。

### wxml 中的判断

类似 vue 中的指令形式

wx:if="{{luckdraw.length > 0}}"

### 样式问题 WXSS

[WXSS](https://developers.weixin.qq.com/miniprogram/dev/framework/view/wxss.html)

### 弹框

[wx.showModal](https://developers.weixin.qq.com/miniprogram/dev/api/ui/interaction/wx.showModal.html)

参考砍价页面 "pages/Resagin_bargain/Resagin_bargain",

```js
wx.showModal({
  title: "提示 ！",
  content:
    "系统检测您为新用户，新用户需要授权才能参与砍价，点击确认按钮后点击屏幕任意位置获取授权，否则将会产生不可估计的错误。",
  success: function(res) {
    if (res.confirm) {
      console.log("用户点击确定");
    } else if (res.cancel) {
      console.log("用户点击取消");
    }
  },
  fail: function(res) {},
  complete: function(res) {}
});
```

#### 确认与取消按钮事件

在 success 中处理。

### 顶部 tab 切换

横向滚动条

<scroll-view scroll-x="true" class="cate-nav-body" style="width: 750rpx;" scroll-left="{{scrollLeft}}">
      <view wx:for="{{allnavcategory}}" class="item {{ id == item.id ? 'active' : ''}}" data-id="{{item.id}}" wx:key="{{item.id}}" bindtap="switchCate">
        <view class="name">{{item.name}}</view>
      </view>
    </scroll-view>

没有内置的 tab 组件，需要自己添加。

https://blog.csdn.net/findhappy117/article/details/82823783
https://www.jianshu.com/p/d75f1a99ef18

### 重置 title

wx.setNavigationBarTitle({

### 下拉刷新

[onPullDownRefresh](https://developers.weixin.qq.com/miniprogram/dev/reference/api/Page.html#onpulldownrefresh)

参考 online-mall-FullStatck/bbgshop_miniprogram/pages/category/category.js

### 底部固定位置的工具

<view class='bottom_btn_area'>

自定义： position: fixed;

```css
/* 以下为底部按钮重构样式 */
.bottom_btn_area {
  border-top: 1px solid #eee;
  height: 100rpx;
  position: fixed;
  /* display: flex;
  justify-content: center;
  align-items: center; */
  bottom: 0;
  left: 0;
  right: 0;
  background: #fff;
  box-shadow: 1rpx 1rpx 20rpx 1rpx #ddd;
}
```

### 个人中心，还有非常多的东西

ucenter

### 用户登录

[登录逻辑](https://www.cnblogs.com/dashucoding/p/9917371.html)

wx.login({

[官方文档](https://developers.weixin.qq.com/miniprogram/dev/api/open-api/login/wx.login.html)

#### 分析开发环境的登陆问题

utils/util/request 函数

流程：

1. 直接进入页面，只有检查 store 的信息；
2. online-mall-FullStatck/bbgshop_miniprogram/pages/AwxChageUserInfoGet/wxChageUserInfoGet.js 这里进行登录。
3. 后台拿到用户的微信信息，然后处理：/Users/qww/Documents/learn/online-mall-FullStatck/bbgshop_nodemaster/src/api/controller/auth.js
4. 通过后台请求https://api.weixin.qq.com/sns/jscode2session接口；
5. 这里需要配置商户的小程序的一些信息：online-mall-FullStatck/bbgshop_nodemaster/src/common/config/config.js
6. 这里的小程序密钥，切忌公开。

### 真机调试

使用 ip 链接后端。
