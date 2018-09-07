// pages/shopping/collagecheckout/collagecheckout.js
var util = require('../../utils/util.js');
var api = require('../../config/api.js');
const pay = require('../../services/pay.js');

Page({

  /**
   * 页面的初始数据
   */
  data: {
    addressId: 0,
    addressList: [],
    showModalStatusAress: false,
    goodsid: 0,
    skuid: 0,
    collageid: 0,
    skuvalue: '',
    goodsInfo: {},
    skuInfo: {},
    userInfo: {},
    collageInfo: {},
    orderId: 0,
    is_pay: 0,
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    console.log(options)
    var that = this
    that.setData({
      goodsid: options.goodsid,
      skuid: options.skuid,
      collageid: options.collageid,
      skuvalue: options.skuvalue,
    })
    that.findgoods()
    that.findcollageuser()
  },
  findgoods(){
    var that = this
    util.request(api.CollageFindGoods,{
      goodsid: that.data.goodsid,
      skuid: that.data.skuid,
      collageid: that.data.collageid
    },'POST').then(res => {
      console.log(res)
      that.setData({
        goodsInfo: res.data.goodslist,
        skuInfo: res.data.skulist,
        collageInfo: res.data.collagelist,
      })

    })
  },
  findaddress(){
    var that = this
    if (that.data.addressId == 0){
      wx.showToast({
        title: '请选择收货地址!',
        icon: 'none',
        duration: 1000,
        mask: true,
      })
    }else {
      util.request(api.AfterBargainSuccessAdressDetail, { 
        id: that.data.addressId 
        },'POST').then(res => {
          console.log(res)
        if (res.errno === 0) {
          that.setData({
            checkedAddress: res.data
          });
        }
      });
    }
  },
  findcollageuser(){
    let that = this
    util.request(api.FindCollageUser,{
      goodsid: that.data.goodsid,
    },'POST').then(res => {
      console.log(res)
      if(res.data.length == 0){
        that.setData({
          is_pay: 0
        })
      }else {
        if (res.data[0].is_pay == 1){
          that.setData({
            is_pay: 1,
            orderId: res.data[0].order_id
          })
        }
      }
    })
  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
  
  },
  surecollage() {
    let that = this;
    if (that.data.addressId == 0){
      wx.showToast({
        title: '请选择收货地址!',
        icon: 'none',
        duration: 2000,
        mask: true,
      })
      return false
    }
    if (that.data.skuid == 0 || that.data.collageid == 0 || that.data.goodsid == 0) {
      wx.showToast({
        title: '商品异常或拼团信息异常，请重试!',
        icon: 'none',
        duration: 2000,
        mask: true,
      })
      return false
    }
    that.setCollageOrder()
  },
  setCollageOrder(){
    let that = this
    wx.showLoading({
      title: '生成订单...',
      mask: true,
    })
    util.request(api.setCollageOrder, {
      goodsid: that.data.goodsid,
      skuid: that.data.skuid,
      collageid: that.data.collageid,
      addressid: that.data.addressId,
      skuvalue: that.data.skuvalue
    }, 'POST').then((res) => {
      console.log(res)
      // console.log(order.order_id)
      // that.setData({
      //   orderId: res.data[0].orderId
      // })
      if(res.errno == 0){
         wx.showLoading({
          title: '生成付款信息...',
          mask: true,
          success: function(res) {},
          fail: function(res) {},
          complete: function(res) {},
        })
         that.payOrder(res.data.orderId)
       

      } else if(res.errno == 17) {
        let order = res.data[0]
        if (res.data[0].is_pay == 0){
          wx.showLoading({
            title: '生成付款信息...',
            mask: true,
            success: function (res) { },
            fail: function (res) { },
            complete: function (res) { },
          })
          that.payOrder(order.order_id)
        } else if(res.data[0].is_pay == 1){
          console.log(order.order_id)
          wx.showToast({
            title: '您已发起过此次拼团！',
            icon: 'none',
            duration: 2000,
            mask: true,
            success: function(res) {},
            fail: function(res) {},
            complete: function(res) {},
          })
          wx.navigateTo({
            url: '/pages/collagegoods/collagegoods?id=' + order.order_id,
            success: function (res) { },
            fail: function (res) { },
            complete: function (res) { },
          })
        }
      }
    })
  },
  canelcollage(){
    wx.navigateBack({
      delta: 1,
    })
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    this.setData({
      showModalStatusAress: false
    })
    
  },
  getaddressList() {
    var that = this
    try {
      var value = wx.getStorageSync('userInfo')
      if (value) {
        // Do something with return value
        that.showModalAress()
        util.request(api.AfterBargainSuccessAdressList,{
          userId: value.id
        },'POST').then(res => {
          console.log(res)
          that.setData({
            addressList: res.data
          })
        })
      }
    } catch (e) {
      // Do something when catch error
    } 
    
  },
  selectAddress(e) {
    var that = this
    console.log(e.currentTarget.dataset.addressid)
    var id = e.currentTarget.dataset.addressid
    if( id == 0){
      that.hideModalAress()
    }else {
      that.setData({
        addressId: id
      })
      that.hideModalAress()
      that.findaddress()
    }

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
  tocollagegoods() {
    wx.navigateTo({
      url: '/pages/collagegoods/collagegoods?id=' + this.data.orderId,
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {
    this.setData({
      showModalStatusAress: false
    })
  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {
    this.setData({
      showModalStatusAress: false
    })
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

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
  
  },
  payOrder(orderid) {
    let that = this;
    var orderId = orderid
    pay.payCollageOrder(orderId).then(res => {
      console.log(res)
      wx.hideLoading()
      if (res.errMsg == "requestPayment:ok") {
        var status = 201
        util.request(api.PaypayCollageOrder, {
          orderId: orderId,
          collageid: that.data.collageid,
          status: status
        }).then(function (res) {
          if (res.errno === 0) {
            // console.log(res.data);
            wx.navigateTo({
              url: '/pages/collagegoods/collagegoods?id=' + orderId,
              success: function(res) {},
              fail: function(res) {},
              complete: function(res) {},
            })
          }
        });
        console.log("已付款")
        
        // wx.redirectTo({
        //   url: '/pages/payResult/payResult?status=true',
        // })
      } else {
        console.log("未付款")
        // wx.redirectTo({
        //   url: '/pages/payResult/payResult?status=false',
        // })
      }
    }).catch(res => {
      console.log("未付款")
    })
  }
})