// pages/collageUserIn_pay/collageUserIn_pay.js
var util = require('../../utils/util.js');
var api = require('../../config/api.js');
const user = require('../../services/user.js');
var WxParse = require('../../lib/wxParse/wxParse.js');
const pay = require('../../services/pay.js');

Page({

  /**
   * 页面的初始数据
   */
  data: {
    orderid: 0,
    orderid_set: 0,
    addressId: 0,
    collageGoods: {},
    collageUser: {},
    orderInfo: {},
    is_pay:false,
    showModalStatusAress:false,
    checkedAddress:[],
    userInfo_in:{}

  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    console.log(options)
    this.setData({
      orderid: options.id
    })
    if (options.id){
      this.findinfo()
    }else {
      wx.showToast({
        title: '异常，请退出!',
        icon: 'none',
        duration: 2000,
        mask: true,
      })
    }
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
  
  },
  findinfo(){
    let that = this
    util.request(api.ColGoodsPayFind,{
      orderid: that.data.orderid
    },'POST').then(res => {
      console.log(res)
      that.setData({
        collageGoods: res.data.collageGoods,
        collageUser: res.data.collageUser,
        orderInfo: res.data.orderInfo,
      })
    })
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    let that = this
    user.loginByWeixin().then(res => {
      console.log(res)
      wx.hideLoading()
      that.setData({
        userInfo_in: res.data
      })
    })
    that.setData({
      showModalStatusAress: false
    })
  },
  getaddressList() {
    var that = this
    that.showModalAress()
    util.request(api.BarAddressList).then(res => {
      console.log(res)
      that.setData({
        addressList: res.data
      })
    })
  },
  findaddress() {
    var that = this
    if (that.data.addressId == 0) {
      wx.showToast({
        title: '请选择收货地址!',
        icon: 'none',
        duration: 1000,
        mask: true,
      })
    } else {
      util.request(api.AddressDetail, {
        id: that.data.addressId
      }).then(res => {
        console.log(res)
        if (res.errno === 0) {
          that.setData({
            checkedAddress: res.data
          });
        }
      });
    }
  },
  selectAddress(e) {
    var that = this
    console.log(e.currentTarget.dataset.addressid)
    var id = e.currentTarget.dataset.addressid
    if (id == 0) {
      that.hideModalAress()
    } else {
      that.setData({
        addressId: id
      })
      that.hideModalAress()
      that.findaddress()
    }

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {
  
  },
  surecollage(){
    let that = this
    console.log(that.data.userInfo_in)
    if (that.data.addressId == 0){
      wx.showToast({
        title: '请选择收货地址！',
        icon: 'none',
        duration: 2000,
        mask: true,
        success: function(res) {},
        fail: function(res) {},
        complete: function(res) {},
      })
    }else{
      that.writeCollageOrder()
    }
  },
  writeCollageOrder(){
    let that = this
    util.request(api.WriteCollageOrder,{
      orderid: that.data.orderid,
      user_in: that.data.userInfo_in,
      addressid: that.data.addressId
    },'POST').then(res => {
      console.log(res)
      if(res.errno == 0){
        that.setData({
          orderid_set:res.data
        })
        that.payOrder(res.data)
      } else if (res.errno == 17){
        if (res.data[0].order_status == 0){
          that.setData({
            orderid_set: res.data[0].id
          })
          that.payOrder()          
        } else if (res.data[0].order_status != 0){
          wx.showToast({
            title: '订单已存在且已付款！请勿重复操作!',
            icon: 'none',
            duration: 2000,
            mask: true,
          })
        }
        
      }
    })
  },
  payOrder(){
    let that = this
    // console.log(that.data.orderid_set)
    let orderId = that.data.orderid_set
    pay.payCollageOrder(orderId).then(res => {
      console.log(res)
      wx.hideLoading()
      if (res.errMsg == "requestPayment:ok") {
        var status = 201
        util.request(api.PaypayCollageOrderUser, {
          orderId: orderId,
          status: status
        }).then(function (res) {
          if (res.errno === 0) {
            wx.redirectTo({
              url: '/pages/collagegoods/collagegoods?id=' + that.data.orderid,
              success: function(res) {},
              fail: function(res) {},
              complete: function(res) {},
            })
          }
        });
        console.log("已付款")
      } else {
        wx.showToast({
          title: '未付款！',
          icon: 'none',
          duration: 2000,
          mask: true,
        })
        console.log("未付款")
      }
    }).catch(res => {
      // console.log("未付款")
      wx.showToast({
        title: '未付款！',
        icon: 'none',
        duration: 2000,
        mask: true,
      })
      // var status = 201
      // util.request(api.PaypayCollageOrderUser, {
      //     orderId: orderId,
      //     status: status
      //   }).then(function (res) {
      //     console.log(res)
      //     if (res.errno === 0) {
      //     }
      //   });
    })
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
  canelcollage(){
    wx.navigateBack({
      delta: 1,
    })
  },
  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
  
  },
  showModalAress: function () {
    // 显示遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    // this.getaddressList()
    this.animation = animation
    animation.translateY('90vh').step()
    this.setData({
      animationDataAress: animation.export(),
      showModalStatusAress: true
    })
    setTimeout(function () {
      animation.translateY(0).step()
      this.setData({
        animationDataAress: animation.export()
      })
    }.bind(this), 200)
  },
  hideModalAress: function () {
    // 隐藏遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY(250).step()
    this.setData({
      animationDataAress: animation.export(),
    })
    setTimeout(function () {
      animation.translateY(0).step()
      this.setData({
        animationDataAress: animation.export(),
        showModalStatusAress: false
      })
    }.bind(this), 200)
  },
  toAddress() {
    wx.navigateTo({
      url: '/pages/ucenter/addressAdd/addressAdd',
      success: function (res) {

      },
      fail: function (res) { },
      complete: function (res) { },
    })
  },
  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
  
  }
})