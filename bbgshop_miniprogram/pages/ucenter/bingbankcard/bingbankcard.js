// pages/ucenter/bingbankcard/bingbankcard.js
var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');
var app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    auth: false,
    cardlist: [],
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    wx.showLoading({
      title: '获取中...',
      mask: true,
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
    let that = this
    if (app.globalData.token == "") {
      that.setData({
        auth: false
      })
      wx.showToast({
        title: '未授权！请在“我的”页点击头像授权!',
        icon: 'none',
        duration: 2000,
        mask: true,
        success: function (res) { },
        fail: function (res) { },
        complete: function (res) { },
      })
    } else {
      that.setData({
        auth: true
      })
      that.getbandcardList();
    }
  },
  getbandcardList() {
    let that = this
    util.request(api.FindBankCard,{

    },'POST').then(res => {
      console.log(res)
      that.setData({
        cardlist: res.data
      })
      that.lastforth()
    })
  },
  lastforth() {
    let that = this
    for (let i = 0; i < that.data.cardlist.length; i++) {
      let list = that.data.cardlist[i]
      list.lastforth = list.card_code.substr(list.card_code.length - 4)
    }
    that.setData({
      cardlist: that.data.cardlist
    })
    wx.hideLoading()
  },
  delbankcard(e) {
    let that = this
    console.log(e.currentTarget.dataset.id)
    let id = e.currentTarget.dataset.id
    wx.showModal({
      title: '提示',
      content: '是否删除此绑定的银行卡？',
      success: function (res) {
        if (res.confirm) {
          console.log('用户点击确定')
          wx.showLoading({
            title: '操作中...',
            mask: true,
          })
          util.request(api.DelBankCard,{
            id: id
          },'POST').then(res => {
            console.log(res)
            if(res.errno === 0) {
              wx.hideLoading()
              wx.showToast({
                title: '删除成功 !',
                icon: 'none',
                duration: 1000,
                mask: true,
              })
              that.onLoad()
            }
          })
        } else if (res.cancel) {
          // console.log('用户点击取消')
        }
      }
    })
  },
  toaddcardpage() {
    wx.navigateTo({
      url: '/pages/ucenter/bankcard/bankcard',
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

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    this.onLoad()
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