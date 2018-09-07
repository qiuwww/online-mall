var app = getApp();
var util = require('../../utils/util.js');
var api = require('../../config/api.js');


Page({
  data: {
    orderId: 0,
    actualPrice: 0.00,
    payId: 0,
  },
  onLoad: function (options) {
    // 页面初始化 options为页面跳转所带来的参数
    console.log(options)
    this.setData({
      orderId: options.orderId || 0,
      payId: options.payId || 0,
      actualPrice: (options.Price / 1).toFixed(2)
    })
  },
  onReady: function () {

  },
  onShow: function () {
    // 页面显示

  },
  onHide: function () {
    // 页面隐藏
    console.log('页面隐藏')
  },
  onUnload: function () {
    // 页面关闭
    console.log('页面关闭')
    // setTimeout(() => {
    //   wx.navigateBack({
    //     delta: 1,
    //   })
    // },1000)
    // wx.showModal({
    //   title: '提示',
    //   content: '订单已生成，你真的要取消支付吗 ？',
    //   success: function(res) {
    //     if(res.confirm){
    //       return true
    //       console.log('确认')
    //     }
    //     if(res.cancel){
    //       return false
    //       console.log('取消')
    //     }
    //   },
    //   fail: function(res) {},
    //   complete: function(res) {},
    // })
  },
  //向服务请求支付参数
  requestPayParam() {
    let that = this;
    const pay = require('../../services/pay.js');
    var orderId = that.data.orderId
    if (that.data.payId == 0){
      pay.payOrder(orderId).then(res => {
        console.log(res)
        wx.hideLoading()
        if (res.errMsg == "requestPayment:ok") {
          var status = 201
          util.request(api.SetOrder, {
            orderId: orderId,
            status: status
          }).then(function (res) {
            if (res.errno === 0) {
              console.log(res.data);
            }
          });
          wx.redirectTo({
            url: '/pages/payResult/payResult?status=true',
          })
        } else {
          console.log('订单未支付')
          wx.redirectTo({
            url: '/pages/payResult/payResult?status=false&orderId=' + orderId,
          })
        }
      })
    } else if (that.data.payId == 1) {
      pay.payOrder(orderId).then(res => {
        console.log(res)
        wx.hideLoading()
        if (res.errMsg == "requestPayment:ok") {
          var status = 201
          util.request(api.PayBargainOrder, {
            ordersn: orderId,
            status: status
          },'POST').then(function (res) {
            if (res.errno === 0) {
              console.log(res);
              wx.redirectTo({
                url: '/pages/payResult/payResult?status=true',
              })
            }else {
              wx.redirectTo({
                url: '/pages/payResult/payResult?status=false',
              })
            }
            
          });
        } else {
          wx.redirectTo({
            url: '/pages/payResult/payResult?status=false',
          })
        }
      })
    } else if (that.data.payId == 2){
      pay.payOrder(orderId).then(res => {
        console.log(res)
        wx.hideLoading()
        if (res.errMsg == "requestPayment:ok") {
          var status = 201
          util.request(api.PaypayCollageOrder, {
            orderId: orderId,
            // collageid: that.data.collageid,
            status: status
          }).then(function (res) {
            if (res.errno === 0) {
              console.log(res);
              wx.navigateTo({
                url: '/pages/collagegoods/collagegoods?id=' + res.data.id,
                success: function (res) { },
                fail: function (res) { },
                complete: function (res) { },
              })
            }
          });
        } else {
          wx.redirectTo({
            url: '/pages/payResult/payResult?status=false',
          })
        }
      })
    }
    
  },
  startPay() {
    var that = this
    wx.showLoading({
      title: '核实是否支付...',
    })
    if (Number(that.data.orderId) == 0) {
      wx.showToast({
        title: '异常 ! 请退出 ! ',
        icon: 'none',
        duration: 2000,
        mask: true,
      })
      return false
    }
    util.request(api.CheckOrderIsPay,{
      orderId: that.data.orderId
    },'POST').then(rees => {
      console.log(rees)
        if(rees.errno === 17){
            wx.showLoading({
          title: '价格核实...',
        })
        console.log(that.data.orderId)
        if (parseInt(that.data.actualPrice * 100) == 0){
          // console.log("9999999999999999999999")
          wx.showLoading({
            title: '核实异常...',
          })
          util.request(api.CheckErrPrice,{
            orderId: that.data.orderId
          },'POST').then(res =>{
            console.log(res)
            if(res.errno === 217){
              wx.hideLoading()
              wx.showToast({
                title: '价格已核实！',
                icon: 'none',
                duration: 2000,
                mask: true,
                success: function (res) {
                  var status = 201
                  util.request(api.SetOrder, {
                    orderId: that.data.orderId,
                    status: status
                  }).then(function (res) {
                    if (res.errno === 0) {
                      console.log(res.data);
                      wx.redirectTo({
                        url: '/pages/payResult/payResult?status=true',
                      })
                    }else{
                      wx.redirectTo({
                        url: '/pages/payResult/payResult?status=false',
                      })
                    }
                  });

                },
                fail: function (res) { },
                complete: function (res) { },
              })

            } else if (res.errno === 503){
              wx.hideLoading()
              wx.showToast({
                title: '价格异常！',
                icon: 'none',
                duration: 3000,
                mask: true,
                success: function(res) {},
                fail: function(res) {},
                complete: function(res) {},
              })
            }
          })

        }else {
          that.requestPayParam();
        }
      }else {
        wx.showToast({
          title: '此订单已支付 ！',
          icon: 'none',
          duration: 2000,
          mask: true,
          success: function(res) {},
          fail: function(res) {},
          complete: function(res) {},
        })
      }
    })
    
    
  }
})