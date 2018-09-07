// pages/ucenter/bankcard/bankcard.js
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
    bankNumber: '',
    cardName: '',
    cardType: '',
    cardNamecode: '',
    cardTypecode: '',
    bingbtnable: true,
    name: '',
    phoneNumber: '',
    idcard: '',
    banklist_value: '请选择开户行',
    banklist: [
      '工商银行','农业银行','中国银行','建设银行','招商银行','邮储银行','交通银行','浦发银行','民生银行','兴业银行','平安银行','中信银行','华夏银行','广发银行','光大银行','北京银行','宁波银行'
    ]
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
                wx.hideLoading()
                // that.distributioninfo()
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
  //姓名
  getUserIdCardName: function (e) {
    this.setData({
      name: e.detail.value
    })
  },
  //银行卡号
  getUserIdCardNumber: function (e) {
    let that = this
    // console.log(that.data.cardTypeMap)
    
    this.setData({
      bankNumber: e.detail.value
    })
    if (e.detail.value.length >= 16 && e.detail.value.length <= 19){
      that.setData({
         bingbtnable: false
      })
    }else {
      that.setData({
        bingbtnable: true
      })
    }
  },
  bindPickerChange(e) {
    this.setData({
      banklist_value: this.data.banklist[e.detail.value]
    })
  },
  //绑定银行卡
  submitInfos: function () {
    var that = this;
    var regname = /^[\u4e00-\u9fa5]{2,16}$/g;
      if (!regname.test(that.data.name)) {
        wx.showToast({
          title: '姓名验证失败 ！',
          icon: 'none',
          image: '',
          duration: 1000
        })
        return false;
      } else if (that.data.banklist_value === '请选择开户行'){
        wx.showToast({
          title: '请选择开户行 ！',
          icon: 'none',
          image: '',
          duration: 1000
        })
        return false;
      }
    let bankinfo = {}
    bankinfo.bank_user_name = that.data.name
    wx.showModal({
      title: '警告 ！',
      content: '请确认银行卡号，开户行和姓名，否则会导致提现失败 ！',
      success: function(res) {
        if(res.confirm){
          util.request(api.AddBingBankCard, {
            userInfo: that.data.userInfo,
            bankcode: that.data.bankNumber,
            name: that.data.name,
            bankname: that.data.banklist_value
          }, 'POST').then(res => {
            console.log(res)
            if (res.errno === 17) {
              wx.showToast({
                title: '此银行卡已被绑定 ！',
                icon: 'none',
                duration: 2000,
                mask: true,
              })
            } else if (res.errno === 0) {
              wx.showToast({
                title: '绑定成功 ！',
                icon: 'none',
                duration: 1500,
                mask: true,
              })
              setTimeout(function () {
                wx.navigateBack({
                  delta: 1,
                })
              }, 1500)
            }
          })
        }
      },
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