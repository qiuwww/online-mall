// pages/ucenter/level_page/level_page.js
var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');
var user = require('../../../services/user.js');
var app = getApp();

Page({

  /**
   * 页面的初始数据
   */
  data: {
    userInfo: {},
    userLevelData: {
      user_all_price: 0.00,
      user_recharge_monery: 0.00,
      user_discount: 1.00,
      user_level: 0,
    },
    user_rechange_list: [],
    level_list: [],
    btn_sure_disabled: true,
    show_input_box: false,
    disvalue: '',
    // Will_discount: 0.0,
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    // console.log(options)
    let that = this
    try {
      var value = wx.getStorageSync('userInfo')
      if (value) {
        // Do something with return value
        console.log(value)
        that.setData({
          userInfo: value
        })
        that.getuserLevelInfo()
      }
    } catch (e) {
      // Do something when catch error
    }

  },
  // onPullDownRefresh() {
  //   let that = this
  //   console.log("123465")
  //   // if(op == '0'){
  //   // this.checkauth('1')
  //   // wx.showLoading({
  //   //   title: '更新中...',
  //   //   mask: true,
  //   // })
  //   // that.getuserLevelInfo();
  // },
  getuserLevelInfo() {
    let that = this
    util.request(api.getUserLevelInfo,{
      userId: that.data.userInfo.id
    },'POST').then(res => {
      console.log(res)
      if(res.errno === 0){
        that.setData({
          userLevelData: res.data.data,
          level_list: res.data.level_list,
          user_rechange_list: res.data.rechange_list
        })
        that.reloadlisttime()
      }
    })
     
  },
  reloadlisttime(){
    let that = this
    if (that.data.userLevelData.user_level < that.data.level_list.length){
      let rest_price = (that.data.level_list[that.data.userLevelData.user_level].recharge_monery - that.data.userLevelData.user_recharge_monery).toFixed(2)
      console.log(rest_price)
      that.data.userLevelData.rest_price = rest_price
    }
    
    for (let i = 0; i < that.data.user_rechange_list.length; i++){
      var list = that.data.user_rechange_list[i]
      list.add_localtime = util.timestampToTime(list.add_time)
    }
    that.setData({
      user_rechange_list: that.data.user_rechange_list,
      userLevelData: that.data.userLevelData,
      // Will_discount: that.data.level_list.length > 0 && (that.data.userLevelData.user_level == that.data.level_list.length) ? '' : (that.data.level_list[that.data.userLevelData.user_level].discount_scale * 1).toFixed(1) 
    })
  },
  startRecharge(){
    let that = this
    wx.showModal({
      title: '提示',
      content: '点击确认填写充值金额即可生成充值订单，付款后您将获得更大的优惠 ！ （充值订单不可退款 ！）',
      success: function(res) {
        if(res.confirm){
          setTimeout(() => {
            that.setData({
              show_input_box: true
            })
          },200)
        }
      },
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  close_mask() {
    this.setData({
      show_input_box: false
    })
  },
  input_money(e) {
    let that = this
    let reg = /^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/
    if (Number(e.detail.value) == 0) {
      that.setData({
        btn_sure_disabled: true
      })
    } else if (Number(e.detail.value) > 999999) {
      that.setData({
        btn_sure_disabled: true
      })
    } else if (reg.test(e.detail.value)) {
      that.setData({
        btn_sure_disabled: false
      })
    } else if (!reg.test(e.detail.value)) {
      that.setData({
        btn_sure_disabled: true
      })
    }
    that.setData({
      disvalue: e.detail.value
    })
  },
  rechargeSure(){
    let that = this
    wx.showModal({
      title: '提示',
      content: '点击确认即表示立即充值。 （充值订单不可退款 ！）',
      success: function (res) {
        if (res.confirm) {
          wx.showLoading({
            title: '生成订单...',
            mask: true,
          })
          util.request(api.SetRechangeOrder,{
            userId: that.data.userInfo.id,
            rechangePrice: that.data.disvalue
          },'POST').then(res => {
            console.log(res)
            if(res.errno === 0){
              let id = res.data
              const pay = require('../../../services/pay.js');
              pay.payRechangeOrder(id).then(res => {
                console.log(res)
                wx.hideLoading()
                if (res.errMsg == "requestPayment:ok") {
                  var status = 1
                  util.request(api.SetRechangeOrderStatus, {
                    orderId: id,
                    status: status
                  },"POST").then(function (ress) {
                    if (ress.errno === 0) {
                      console.log(ress.data);
                      wx.showToast({
                        title: '支付成功 !',
                        icon: 'none',
                        duration: 2000,
                        mask: true,
                      })
                      that.close_mask()
                      that.getuserLevelInfo()
                      // wx.redirectTo({
                      //   url: '/pages/payResult/payResult?status=true',
                      // })
                    }
                  });
                } else {
                  wx.showToast({
                    title: '支付失败 !',
                    icon: 'none',
                    duration: 2000,
                    mask: true,
                  })
                  that.close_mask()
                  that.getuserLevelInfo()
                  // console.log('订单未支付')
                  // wx.redirectTo({
                  //   url: '/pages/payResult/payResult?status=false&orderId=' + orderId,
                  // })
                }
              })
            }
          })
          // that.
        }
      },
      fail: function (res) { },
      complete: function (res) { },
    })
  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
  
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

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
  
  }
})