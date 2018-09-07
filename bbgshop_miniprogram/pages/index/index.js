const util = require('../../utils/util.js');
const api = require('../../config/api.js');
const user = require('../../services/user.js');
const app = getApp();
//获取应用实例
Page({
  data: {
    newGoods: [],
    // newGoodslist: [],
    hotGoods: [],
    // hotGoodslist: [],
    luckdraw: [],
    collage: [],
    // topics: [],
    // brands: [],
    floorGoods: [],
    banner: [],
    channel: [],
    auth: false,
    userinfo: {},
    Inviter_userid: [],
    Inviter_laster: '',
    isdistribution: false,
    Inviter_locallaster: [],
    scrollTop: 0, //滚动监听
  },
  onShareAppMessage: function() {
    let that = this
      return {
        title: '贝堡商城',
        desc: '贝堡商城微信小程序',
        path: '/pages/index/index',
        imageUrl: '../../image/CorporateData/bbg_share_logo.png',
    }

  },
  // 下拉刷新
  onPullDownRefresh: function() {
    let that = this
    // if(op == '0'){
    // this.checkauth('1')
    wx.showLoading({
      title: '更新中...',
      mask: true,
    })
    that.getIndexData();
  },
  getIndexData: function() {
    let that = this;
    util.request(api.IndexUrl).then(function(res) {
      console.log(res)
      wx.hideLoading()
      if (res.errno === 0) {
        that.setData({
          luckdraw: res.data.luckdraw,
          collage: res.data.collage,
          newGoods: res.data.newGoodsList,
          hotGoods: res.data.hotGoodsList,
          // topics: res.data.topicList,
          // brand: res.data.brandList,
          floorGoods: res.data.categoryList,
          banner: res.data.banner,
          channel: res.data.channel
        });
        util.request(api.GoodsCount).then(function(res) {
          that.setData({
            goodsCount: res.data.goodsCount
          });
        });
        wx.stopPullDownRefresh()
        that.setTime()
      }
    });
  },
  setTime() {
    let that = this
    console.log(that.data.luckdraw)
    for (let i = 0; i < that.data.luckdraw.length; i++) {
      let item = that.data.luckdraw[i]
      item.open_local_time = util.timestampToTime(item.luck_open_time)
      item.limit_local_time = util.timestampToTime(item.luck_limit_time)
    }
    that.setData({
      luckdraw: that.data.luckdraw
    })
  },
  toluckdrawpage(e) {
    // console.log(e.currentTarget.dataset.id)
    wx.navigateTo({
      url: '/pages/luckdraw/luckdraw?id=' + e.currentTarget.dataset.id,
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  tocollagepage(e) {
    wx.navigateTo({
      url: '/pages/goods/goods?id=' + e.currentTarget.dataset.id,
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  onLoad: function(options) {
    let that = this
    // console.log(options)
    wx.showLoading({
      title: '连接服务器...',
      mask: true,
    })
    that.getIndexData();
    that.checkIsAuth();
  },
  checkIsAuth() {
    wx.getStorage({
      key: 'auth',
      success: function(res) {
        console.log('存在')
        console.log(res.data)
      },
      fail: function(res) {
        console.log('不存在')
        wx.setStorage({
          key: "auth",
          data: false
        })
      },
    })
  },
  tocategorypage(e) {
    wx.navigateTo({
      url: '/pages/category/category?id=' + e.currentTarget.dataset.id + '&title=商品分类',
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  // back_to_top() {
  //   wx.pageScrollTo({
  //     scrollTop: 0,
  //     duration: 2000
  //   })
  // },
  // //滚动监听
  // scroll(e) {
  //   console.log(e)
  //   // this.setData({
  //   //   scrollTop: e.detail.scrollTop
  //   // })
  //   // console.log(this.data.scrollTop)
  // },
  onReady: function() {
    // console.log("1111111")
    // 页面渲染完成

  },
  onShow: function(op) {
    // 页面显示
    let that = this
    // if(op == '0'){
    // this.checkauth('1')
    // wx.showLoading({
    //   title: '更新中...',
    //   mask: true,
    //   success: function(res) {},
    //   fail: function(res) {},
    //   complete: function(res) {},
    // })
    that.getIndexData();

    // this.onshowaction()

    // }
    // this.onLoad();
    // this.goLogin()


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
  // onshowaction() {
  // this.checkauth('1')
  // },
  onHide: function() {
    // 页面隐藏
  },
  onUnload: function() {
    // 页面关闭
  },
})
