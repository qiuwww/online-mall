// pages/ucenter/luckdraw/luckdraw.js
var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');
var user = require('../../../services/user.js');
var app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    luckDrawList: [],
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    let that = this
    util.request(api.SelectAllLuckList,{}).then(res => {
      console.log(res.data)
      that.setData({
        luckDrawList:res.data
      })
      that.settimeLocal()
    })
    // console.log(res.data)
  },
  settimeLocal() {
    let that = this
    // console.log('123456')
    // console.log(that.data.luckDrawList)
    for (let i = 0; i < that.data.luckDrawList.length;i++) {
      console.log(that.data.luckDrawList[i].luck_limit_time)
      that.data.luckDrawList[i].locallimit_time = util.timestampToTime(that.data.luckDrawList[i].luck_limit_time)
      that.data.luckDrawList[i].localopen_time = util.timestampToTime(that.data.luckDrawList[i].luck_open_time)
      that.data.luckDrawList[i].differpeople = that.data.luckDrawList[i].luck_people_num - that.data.luckDrawList[i].have_join_people_num
    }
    that.setData({
      luckDrawList: that.data.luckDrawList
    })
  },
  toLuckDrawDetailPage(e) {
    console.log(e.currentTarget.dataset.id)
    wx.navigateTo({
      url: '/pages/luckdraw/luckdraw?id=' + e.currentTarget.dataset.id,
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