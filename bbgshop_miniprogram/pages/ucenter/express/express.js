var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');
var app = getApp();

Page({
  data: {
    orderId: 1,
    expressInfo: {},
    expressTraces: []
  },
  onLoad: function (options) {
    this.setData({
      orderId: options.orderId
    });
    console.log(options)
    
    this.getExpressInfo();
  },
  onReady: function () {
    // 页面渲染完成
  },
  onShow: function () {
    // 页面显示

  },
  getExpressInfo() {
    let that = this;
    wx.showLoading({
      title: '获取中...',
      mask: true,
      success: function (res) { },
      fail: function (res) { },
      complete: function (res) { },
    })
    util.request(api.OrderExpress, { orderId: that.data.orderId }).then(function (res) {
      wx.hideLoading()
      if (res.errno === 0) {
        that.setData({
          expressInfo: res.data,
          expressTraces: res.data.traces
        });
      }else {
        wx.showToast({
          title: '异常！',
          icon: 'none',
          duration: 3000,
          mask: true,
          success: function(res) {},
          fail: function(res) {},
          complete: function(res) {},
        })
      }
      console.log(that.data.expressInfo)
      console.log(that.data.expressTraces)
    });
  },
  updateExpress() {
    this.getExpressInfo();
  },
  onHide: function () {
    // 页面隐藏
  },
  onUnload: function () {
    // 页面关闭
  }
})