var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');



var app = getApp();

Page({
  data: {
    array: ['请选择反馈类型', '商品相关', '功能异常', '投诉建议', '其他'],
    index: 0,
    mobileinput: "",
    textareainput: "",
    textarealength: 0,
  },
  bindPickerChange: function (e) {
    // console.log('picker发送选择改变，携带值为', e.detail.value)
    this.setData({
      index: e.detail.value
    })
  },
  onLoad: function (options) {
  },
  mobileinput: function (event) {
    var that = this
    that.setData({
      mobileinput: event.detail.value
    })
    console.log(that.data.mobileinput)
  },
  textareainput: function (event) {
    var that = this
    that.setData({
      textareainput: event.detail.value,
      textarealength: event.detail.value.length
    })
    console.log(that.data.textareainput)
  },
  okfeedback: function () {
    var that = this
    if (that.data.index == 0) {
      util.showErrorToast('反馈类型为空！');
    } else if (that.data.textareainput == "") {
      util.showErrorToast('信息为空！');
    } else if (that.data.mobileinput == "") {
      util.showErrorToast('手机号为空！');
    } else {
      if (that.data.index == 1){
        that.setData({
          index: "商品相关"
        })
      }
      if (that.data.index == 2) {
        that.setData({
          index: "功能异常"
        })
      }
      if (that.data.index == 3) {
        that.setData({
          index: "投诉建议"
        })
      }
      if (that.data.index == 4) {
        that.setData({
          index: "其他"
        })
      }
      console.log(that.data.index)
      // util.request(api.BingPhoneText, {
      //   Phone: that.data.mobileinput
      // }, 'POST').then(function (res) {
      //   // console.log(res)
      //   if (res.errno === 1001) {
      //     util.showErrorToast('手机号格式错误');
      //   }else {
          wx.request({
            url: api.FeedBackExchange,
            data: {
              feedtype: that.data.index,
              content: that.data.textareainput,
              phone: that.data.mobileinput
            },
            header: {
              'Content-Type': 'application/json',
              'X-Nideshop-Token': wx.getStorageSync('token')
            },
            method: 'POST',
            responseType: 'text',
            success: function (res) {
              console.log(res)
              if (res.statusCode === 200) {
                wx.showToast({
                  title: '提交成功！',
                  icon: 'success',
                  image: '',
                  duration: 1500,
                  mask: true,
                  success: function (res) {

                  },
                  fail: function (res) { },
                  complete: function (res) { },
                })
                setTimeout(function () {
                  wx.switchTab({
                    url: '/pages/ucenter/index/index',
                  })
                }, 1500)

              }
             },
            fail: function (res) { },
            complete: function (res) { },
          })
          // util.request(api.FeedBackExchange,{
          //   feedtype: that.data.index,
          //   content: that.data.textareainput,
          //   phone: that.data.mobileinput
          // },'POST').then(function (res) {
          //   console.log(res)
          //   if (res.errno === 0){
          //     wx.showToast({
          //       title: '提交成功！',
          //       icon: 'success',
          //       image: '',
          //       duration: 1500,
          //       mask: true,
          //       success: function(res) {
                  
          //       },
          //       fail: function(res) {},
          //       complete: function(res) {},
          //     })
          //     setTimeout(function(){
          //       wx.switchTab({
          //         url: '/pages/ucenter/index/index',
          //       })
          //     },1500)

          //   }
          // })
        }
      // })
    // }
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
  }
})