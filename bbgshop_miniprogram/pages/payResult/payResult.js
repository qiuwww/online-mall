var util = require('../../utils/util.js');
var api = require('../../config/api.js');
const pay = require('../../services/pay.js');

var app = getApp();
Page({
  data: {
    // status: true,
    paystatues:true,
    orderId: 0
  },
  onLoad: function (options) {
    var that = this
    // 页面初始化 options为页面跳转所带来的参数
    console.log(options)
    that.setData({
      orderId: options.orderId || 0,
      paystatues: options.status
    })
    console.log(that.data.paystatues)
    
  },
  onReady: function () {

  },
  onShow: function () {
    // 页面显示

  },
  onHide: function () {
    // 页面隐藏

  },
  onUnload: function () {
    // 页面关闭

  },
  seeorder() {
    wx.redirectTo({
      url: '/pages/ucenter/order/order',
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  content() {
    wx.switchTab({
      url: '/pages/index/index',
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  payOrder() {
    pay.payOrder(this.data.orderId).then(res => {
      wx.redirectTo({
         url: '/pages/payResult/payResult?status=true',
      })
      this.setData({
        paystatues: true
      });
    }).catch(res => {
      util.showErrorToast('支付失败');
    });
  }
})