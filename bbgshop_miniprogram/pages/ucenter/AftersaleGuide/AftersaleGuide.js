// pages/ucenter/AftersaleGuide/AftersaleGuide.js
var WxParse = require('../../../lib/wxParse/wxParse.js');
var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');
var user = require('../../../services/user.js');

var app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    have_guide: [],
    is_Skeleton: true,
    
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.getGuide()
  },
  getGuide() {
    let that = this
    util.request(api.GetAfterGuide).then(res => {
      console.log(res)
      that.setData({
        have_guide: res.data,
        is_Skeleton: false
      })
      if (res.data.length > 0) {
        WxParse.wxParse('guide', 'html', res.data[0].rules_text, that);
      }
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