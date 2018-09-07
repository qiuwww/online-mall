// pages/collagegoods/collagegoods.js
var util = require('../../utils/util.js');
var api = require('../../config/api.js');
const user = require('../../services/user.js');
var WxParse = require('../../lib/wxParse/wxParse.js');
Page({

  /**
   * 页面的初始数据
   */
  data: {
    orderid: '',
    userInfo_in:{}, //进入用户的信息
    userInfo:{}, //发起者信息
    orderInfo: {}, //订单详情
    collageGoods: {}, //发起拼团的商品信息
    collageMain:{}, //拼团的主表详情
    collageUser:{}, //拼团的用户表信息
    collageUserFriend:[], //拼团的帮助用户列表
    otherGoods:[],//其他商品
    shortPeople: 0,//还差的人数
    // lest_time: 0,
    isEnd: false, //超时
    isLunch: false, //发起者
    showModalStatus:false,
    isSuccess:false,//拼团是否成功
  },

  /**
   * 生命周期函数--监听页面加载
    */
  onLoad: function (options) {
    console.log(options)
    let routee = getCurrentPages()
    console.log(routee[0].route)
    this.setData({
      route: routee[0].route,
      orderid: options.id
    })
    wx.showLoading({
      title: '登录检测...',
      mask: true
    })
    this.getopenid()

  },
  getopenid() {
    wx.showLoading({
      title: '授权检测...',
      mask: true
    })
    var that = this
    wx.getSetting({
      success: function (res) {
        if (res.authSetting['scope.userInfo']) {
          wx.getUserInfo({
            success: function (res) {
              console.log(res.userInfo)
              //用户已经授权过
              user.loginByWeixin().then(res => {
                console.log(res)
                wx.hideLoading()
                that.setData({
                  userInfo_in: res.data
                })
                that.getInfo()
              })
                .catch(res => {
                  console.log(res)
                })
            }
          })
        } else {
          wx.hideLoading()
          wx.redirectTo({
            url: '/pages/AwxChageUserInfoGet/wxChageUserInfoGet?route=' + that.data.route + "&data=" + that.data.orderid,
            success: function (res) { },
            fail: function (res) { },
            complete: function (res) { },
          })
        }
      }
    })
  },
  getInfo() {
    var that = this
    // console.log(that.data.)
    wx.showLoading({
      title: '获取数据...',
      mask: true
    })
    console.log(that.data.orderid)
    util.request(api.ColGoodsFindInfo, {
      orderid: that.data.orderid
    },'POST').then(function (res) {
      wx.hideLoading()
      console.log(res.data)
      console.log(that.data.userInfo_in)
      that.setData({
        userInfo: res.data.userInfo,
        orderInfo: res.data.orderInfo,
        collageGoods: res.data.collageGoods,
        collageMain: res.data.collageMain,
        collageUser: res.data.collageUser,
        collageUserFriend: res.data.collageUserFriend,
        otherGoods: res.data.otherGoods,
      })
      WxParse.wxParse('goodsDetail', 'html', res.data.collageMain.activity_detail, that);
      that.checkShort()

    })
  },
  checkShort(){
    let that = this
    // console.log(that.data.collageMain.least_coll_num)    
    // console.log(that.data.collageUserFriend.length)
    that.setData({
      shortPeople: that.data.collageMain.least_coll_num - that.data.collageUserFriend.length - 1
    })
    that.checkLunch()    
    console.log(that.data.shortPeople)
    if (that.data.shortPeople === 0){
        console.log("拼团成功")
        that.setData({
          isSuccess:true
        })
        that.successAction()
    }else {
      that.setData({
        isSuccess: false
      })
      that.setTimeloop()      
    }
  },
  successAction(){
    let that = this
    util.request(api.ColSuccess, {
      orderid: that.data.orderid
    }, 'POST').then(function (res) {
      console.log(res)
      if(res.errno === 0){
        wx.showToast({
          title: '拼团已完成，订单状态已更新！请在订单中查看详情！',
          icon: 'none',
          duration: 2500,
          mask: true,
        })
      }
      
    })
   
  },
  toorderpage(){
    wx.redirectTo({
      url: '/pages/ucenter/order/order',
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
  
  },
  checkLunch(){
    let that = this
    // console.log(that.data.userInfo)
    // console.log(that.data.userInfo_in)
    if (that.data.userInfo.weixin_openid === that.data.userInfo_in.sessionData.openid){
      // console.log("8978977")
      //进入用户为发起者
      that.setData({
        isLunch: true
      })
    }else {
      that.setData({
        isLunch: false
      })
    }
  },
  friendpaybtn(){
    let that = this
    wx.showModal({
      title: '提示',
      content: '您需要支付' + that.data.collageMain.collage_price+'元加入拼团，点击确定即可进入付款界面！',
      success: function(res) {
        if(res.confirm){
          wx.navigateTo({
            url: '/pages/collageUserIn_pay/collageUserIn_pay?id=' + that.data.orderid,
            success: function(res) {},
            fail: function(res) {},
            complete: function(res) {},
          })
        }
      },
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
  
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {
  
  },
  sharebtn(){
    let that = this
    that.showModal()
  },
  showModal: function () {
    // 显示遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY(250).step()
    this.setData({
      animationData: animation.export(),
      showModalStatus: true
    })
    setTimeout(function () {
      animation.translateY(0).step()
      this.setData({
        animationData: animation.export()
      })
    }.bind(this), 200)
  },
  hideModal: function () {
    // 隐藏遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY(250).step()
    this.setData({
      animationData: animation.export(),
    })
    setTimeout(function () {
      animation.translateY(0).step()
      this.setData({
        animationData: animation.export(),
        showModalStatus: false
      })
    }.bind(this), 200)
  },
  share_wechat_friend() {
    console.log("分享到微信好友")
  },
  share_wechat_qzone() {
    console.log("分享到微信朋友圈")
  },
  share_qq_friend() {
    console.log("分享到qq好友")
  },
  share_qq_qzone() {
    console.log("分享到qq空间")
  },
  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {
  
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
  
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
  
  },
  setTimeloop() {
    var that = this
    var loop = setInterval(function () {
      if ((parseInt(that.data.collageUser.end_time) - new Date().getTime()) < 0) {
        that.setData({
          isEnd: true
        })
        that.setouttimecollage()
        that.hideModal()
        clearInterval(loop)
      }
      var list = that.data.collageUser
      var time = parseInt(list.end_time) - new Date().getTime()
      list.listtime = util.timestampToTw(time)
      that.setData({
        collageUser: that.data.collageUser
      })
    }, 100)
  },
  setouttimecollage(){
    let that = this
    console.log(that.data.orderInfo)
    util.request(api.CollageIsOutTime,{
      orderid: that.data.orderInfo.id
    },'POST').then(res => {
      console.log(res)
    })
  },
  exit(){
    wx.navigateBack({
      delta: 1,
    })
  },
  toindex(){
    wx.switchTab({
      url: '/pages/index/index',
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  tocollage(){
    wx.navigateTo({
      url: '/pages/goods/goods?id='+ this.data.collageGoods.goods_id,
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
  
  }
})