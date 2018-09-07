var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');



var app = getApp();

Page({
  data: {
    footprintList: [],
    auth:false
  },
  getFootprintList() {
    let that = this;
    util.request(api.FootprintList).then(function (res) {
      if (res.errno === 0) {
        console.log(res.data);
        that.setData({
          footprintList: res.data.data
        });
      }
    });
  },
  deleteItem (event){
    let that = this;
    let footprint = event.currentTarget.dataset.footprint;
    var touchTime = that.data.touch_end - that.data.touch_start;
    console.log(touchTime);
    //如果按下时间大于350为长按  
    if (touchTime > 350) {
      wx.showModal({
        title: '',
        content: '要删除所选足迹？',
        success: function (res) {
          if (res.confirm) {
            util.request(api.FootprintDelete, { footprintId: footprint.id }, 'POST').then(function (res) {
              if (res.errno === 0) {
                wx.showToast({
                  title: '删除成功',
                  icon: 'success',
                  duration: 2000
                });
                that.getFootprintList();
              }
            });
            console.log('用户点击确定')
          }
        }
      });
    } else {
      wx.navigateTo({
        url: '/pages/goods/goods?id=' + footprint.goods_id,
      });
    }
    
  },
  onLoad: function (options) {
    var that = this
    wx.showLoading({
      title: '授权检测...',
      mask: true,
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
    if(app.globalData.token == ""){
      that.setData({
        auth: false
      })
      wx.hideLoading()
      wx.showToast({
        title: '未授权！请在“我的”页点击头像授权!',
        icon: 'none',
        duration: 2000,
        mask: true,
      })
    }else{
      //用户已经授权过
      that.setData({
        auth: true
      })
      wx.hideLoading()
      that.getFootprintList();
    }
  },
  onReady: function () {

  },
  onShow: function () {
    
  },
  onHide: function () {
    // 页面隐藏

  },
  onUnload: function () {
    // 页面关闭
  },
  //按下事件开始  
  touchStart: function (e) {
    let that = this;
    that.setData({
      touch_start: e.timeStamp
    })
    console.log(e.timeStamp + '- touch-start')
  },
  //按下事件结束  
  touchEnd: function (e) {
    let that = this;
    that.setData({
      touch_end: e.timeStamp
    })
    console.log(e.timeStamp + '- touch-end')
  }, 
})