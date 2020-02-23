# miniprogram.NOTE

微信小程序开发，[官方文档](https://developers.weixin.qq.com/miniprogram/dev/framework/)

## 程序执行流程

1. 使用微信开发者工具打开源代码（|通过工具初始化项目）；
2. app 文件，参考[目录结构说明](https://developers.weixin.qq.com/miniprogram/dev/framework/structure.html)；
3. app.json/pages(路由文件) -> pages，具体的页面

### 微信首页如何确定的

默认采用的是 app.json/pages[0]，当然也可以进行判断然后[跳转](https://developers.weixin.qq.com/miniprogram/dev/api/route/wx.navigateTo.html)。

## 常用接口

[App 的生命周期](https://developers.weixin.qq.com/miniprogram/dev/reference/api/App.html)

[Page 的生命周期](https://developers.weixin.qq.com/miniprogram/dev/reference/api/Page.html)，与组件不大一样。

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
