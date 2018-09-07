// pages/ucenter/distribution_catch/distribution_catch.js
var util = require('../../../utils/util.js');
var user = require('../../../services/user.js');
var api = require('../../../config/api.js');
const app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    auth: false,
    applybtndisable: true,
    userInfo: {},
    disdata: [],
    disvalue: '',
    cancatch_all: 0.00,
    animationData: '',
    showModalStatus: false,
    cardlist: [],
    getcashtypevalue: '',
    getcashtype: 0,
    selectbankcard: {}

  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    let that = this
    wx.showLoading({
      title: '检测授权...',
      mask: true,
    })
    // 查看是否授权
    wx.getSetting({
      success: function (res) {
        if (res.authSetting['scope.userInfo']) {
          // 已经授权，可以直接调用 getUserInfo 获取头像昵称
          wx.showLoading({
            title: '检测合法性...',
            mask: true,
          })
          wx.getUserInfo({
            success: function (res) {
              // console.log(res.userInfo)
              user.loginByWeixin().then(ress => {
                console.log(ress)
                that.setData({
                  auth: true,
                  userInfo: ress.data.userInfo
                })
                that.distributioninfo()
                // that.finddistribinfo()
              })
            }
          })
        } else {
          that.setData({
            auth: false,
          })
          wx.hideLoading()
        }
      }
    })
  },
  catch_apply() {
    // console.log("123465798")
    let that = this
    if (that.data.getcashtype === 0){
      wx.showToast({
        title: '暂不支持提现到微信零钱，请选择银行卡提现 ！',
        icon: 'none',
        duration: 2000,
        mask: true,
        success: function(res) {},
        fail: function(res) {},
        complete: function(res) {},
      })
      return false 
    }
    wx.showModal({
      title: '提示',
      content: '点击确认即可提交提现申请，点击取消即取消 !',
      success: function (res) {
        if (res.confirm) {
          wx.showModal({
            title: '提示Again',
            content: '是否提现￥' + that.data.disvalue + ' 到 ' + that.data.getcashtypevalue + ' 吗?',
            showCancel: true,
            success: function (res) {
              if (res.confirm) {
                wx.showLoading({
                  title: '提交中...',
                  mask: true,
                })
                // console.log('用户点击确定')
                util.request(api.ApplyDistributionCatch, {
                  userInfo: that.data.userInfo,
                  value: that.data.disvalue,
                  cashtype: that.data.getcashtype,
                  selectbankcard: that.data.selectbankcard
                }, 'POST').then(res => {
                  console.log(res)
                  if (res.errno === 0) {
                    wx.hideLoading()
                    wx.showToast({
                      title: '提现申请已提交 !',
                      icon: 'success',
                      duration: 2000,
                      mask: true,
                      success: function (res) {
                        // that.onLoad()
                      },
                      fail: function (res) { },
                      complete: function (res) { },
                    })
                    wx.navigateBack({
                      delta: 1,
                    })
                  }
                })
              } else if (res.cancel) {
                // console.log('用户点击取消')
              }
            }
          })    
        }
      }
    })    
  },
distributioninfo() {
  let that = this
  wx.showLoading({
    title: '获取数据...',
    mask: true,
  })
  util.request(api.FindDistributionInfoCatch, {
    userinfo: that.data.userInfo
  }, 'POST').then(res => {
    console.log(res)
    that.setData({
      disdata: res.data,
      cancatch_all: res.data[0].can_withdraw_cash
    })
    util.request(api.FindBankCard, {}, 'POST').then(ress => {
      console.log(ress)
      that.setData({
        cardlist: ress.data
      })
      that.lastforth()
    })
    wx.hideLoading()
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
},
allmoney() {
  let that = this
  if (Number(that.data.cancatch_all) == 0){
    that.setData({
      disvalue: that.data.cancatch_all,
      applybtndisable: true
    })
  }else {
    that.setData({
      disvalue: that.data.cancatch_all,
      applybtndisable: false
    })
  }
  
  // that.input_money
},
input_money(e) {
  let that = this
  let reg = /^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/
  // console.log(parseInt(e.detail.value))
  if (Number(e.detail.value) == 0) {
    that.setData({
      applybtndisable: true
    })
  } else if (Number(e.detail.value) > Number(that.data.cancatch_all)) {
    that.setData({
      applybtndisable: true
    })
  } else if (reg.test(e.detail.value)) {
    that.setData({
      applybtndisable: false
    })
  } else if (!reg.test(e.detail.value)) {
    that.setData({
      applybtndisable: true
    })
  }
  that.setData({
    disvalue: e.detail.value
  })
},
selectbankcard(e) {
  let item = e.currentTarget.dataset.item
  console.log(e.currentTarget.dataset)
  this.setData({
    getcashtype: item.id,
    getcashtypevalue: item.card_bank_name + ' ' + item.card_bank_code + ' ' + ' 尾号 ' + item.lastforth,
    selectbankcard: item
  })
  this.hideModal()
},
getcashwechat() {
  this.setData({
    getcashtype: 0,
    getcashtypevalue: '微信零钱',
    selectbankcard: ''
  })
  this.hideModal()
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
  this.setData({
    getcashtype: 0,
    getcashtypevalue: '微信零钱'
  })
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
showModal: function () {
  // 显示遮罩层
  var animation = wx.createAnimation({
    duration: 200,
    timingFunction: "linear",
    delay: 0
  })
  this.animation = animation
  animation.translateY('50vh').step()
  this.setData({
    animationData: animation.export(),
    showModalStatus: true
  })
  setTimeout(function () {
    animation.translateY(0).step()
    this.setData({
      animationData: animation.export()
    })
  }.bind(this), 200)
},
hideModal: function () {
  // 隐藏遮罩层
  var animation = wx.createAnimation({
    duration: 200,
    timingFunction: "linear",
    delay: 0
  })
  this.animation = animation
  animation.translateY('50vh').step()
  this.setData({
    animationData: animation.export(),
  })
  setTimeout(function () {
    animation.translateY(0).step()
    this.setData({
      animationData: animation.export(),
      showModalStatus: false
    })
  }.bind(this), 200)
},
/**
 * 用户点击右上角分享
 */
onShareAppMessage: function () {

}
})