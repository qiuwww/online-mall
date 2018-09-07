var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');

var app = getApp();

Page({
  data: {
    typeId: 0,
    collectList: [],
    auth: false
  },
  getCollectList() {
    let that = this;
    util.request(api.CollectList, { typeId: that.data.typeId}).then(function (res) {
      if (res.errno === 0) {
        console.log(res.data);
        that.setData({
          collectList: res.data.data
        });
        wx.hideLoading()
      }
    });
  },
  onLoad: function (options) {
    let that = this
    wx.showLoading({
      title: '核实中...',
      mask: true,
    })
    if (app.globalData.token == "") {
      that.setData({
        auth: false
      })
      wx.hideLoading()
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
      wx.showLoading({
        title: '获取数据...',
        mask: true,
      })
      that.getCollectList();
    }
    // wx.getSetting({
    //   success: function (res) {
    //     wx.hideLoading()
    //     if (res.authSetting['scope.userInfo']) {
    //       wx.getUserInfo({
    //         success: function (res) {
    //           console.log(res.userInfo)
    //           //用户已经授权过
    //           that.setData({
    //             auth: true
    //           })
    //           that.getCollectList();
              
    //         }
    //       })
    //     } else {
    //       that.setData({
    //         auth: false
    //       })
    //       wx.showToast({
    //         title: '未授权！请在“我的”页点击头像授权!',
    //         icon: 'none',
    //         duration: 2000,
    //         mask: true,
    //       })
    //     }
    //   }
    // })
  },
  onReady: function () {

  },
  onShow: function () {
    // wx.getSetting({
    //   success: (res) => {
    //     console.log(res)
    //     if (res.authSetting["scope.userInfo"] == true) {
    //       console.log("已授权")
    //     } else {
    //       console.log("未授权")
    //       wx.showToast({
    //         title: '获取失败，用户未授权！',
    //         icon: 'none',
    //         duration: 3000,
    //       })
    //     }

    //   }
    // })
  },
  onHide: function () {
    // 页面隐藏

  },
  onUnload: function () {
    // 页面关闭
  },
  openGoods(event) {
    
    let that = this;
    let goodsId = this.data.collectList[event.currentTarget.dataset.index].value_id;

    //触摸时间距离页面打开的毫秒数  
    var touchTime = that.data.touch_end - that.data.touch_start;
    console.log(touchTime);
    //如果按下时间大于350为长按  
    if (touchTime > 350) {
      wx.showModal({
        title: '',
        content: '确定删除吗？',
        success: function (res) {
          if (res.confirm) {
            
            util.request(api.CollectAddOrDelete, { typeId: that.data.typeId, valueId: goodsId}, 'POST').then(function (res) {
              if (res.errno === 0) {
                console.log(res.data);
                wx.showToast({
                  title: '删除成功',
                  icon: 'success',
                  duration: 2000
                });
                that.getCollectList();
              }
            });
          }
        }
      })
    } else {
      wx.navigateTo({
        url: '/pages/goods/goods?id=' + goodsId,
      });
    }  
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