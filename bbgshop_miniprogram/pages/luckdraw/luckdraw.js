// pages/luckdraw/luckdraw.js
const util = require('../../utils/util.js');
const api = require('../../config/api.js');
const user = require('../../services/user.js');
var WxParse = require('../../lib/wxParse/wxParse.js');

const app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    id: 0,
    luckmain: {},
    userinfo: {},
    // auth: false,
    button_state: 1,
    join_list: [],
    isout: 0,
    luckly_list: [],
    showModalStatusAress: false,
    animationDataAress: '',
    addressList: [],
    // isopen: 0
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    wx.showLoading({
      title: '跳转中...',
      mask: true,
    })
    console.log(options)
    if (options) {
      this.setData({
        id: options.id
      })
    }
    this.getluckInfo()
    this.checkauth()
  },
  checkauth() {
    wx.showLoading({
      title: '检测授权...',
      mask: true,
    })
    let that = this
    try {
      var value = wx.getStorageSync('auth')
      console.log(value)
      if (value) {
        that.setData({
          auth: true
        })
        user.loginByWeixin().then(res => {
          console.log(res)
          that.setData({
            userinfo: res.data
          })
          that.checkisjoin()
          wx.hideLoading()
          app.globalData.userInfo = res.data.userInfo;
          app.globalData.token = res.data.token;
        })
        // Do something with return value
      } else {
        that.setData({
          auth: false
        })
        that.selectjoinpeople()
        wx.hideLoading()
      }
    } catch (e) {
      // Do something when catch error
    }
  },
  getluckInfo() {
    wx.showLoading({
      title: '获取中...',
      mask: true,
    })
    let that = this
    util.request(api.FindLuckDrawInfo, {
      id: that.data.id
    }, 'POST').then(res => {
      console.log(res)
      if (res.errno === 17) {
        wx.hideLoading()
        wx.showToast({
          title: '抽奖不存在 !',
          icon: 'none',
          duration: 2000,
          mask: true,
        })
      } else {
        that.setData({
          luckmain: res.data.luckmain
        })
        that.setTime()
        WxParse.wxParse('goodsDetail', 'html', res.data.luckmain.luck_goods_detail, that);
      }
    })
  },
  setTime() {
    let that = this
    console.log(that.data.luckmain)
    // for (let i = 0; i < that.data.luckmain.length; i++) {
    let item = that.data.luckmain
    item.open_local_time = util.timestampToTime(item.luck_open_time)
    // }
    that.setData({
      luckmain: that.data.luckmain
    })
    if (item.is_out_time === 1) {
      that.setData({
        isout: 1
      })
    }
    if (item.is_open === 1) {
      that.findluck_people()
    }
    // that.findluck_people()
  },
  findluck_people() {
    let that = this
    if (that.data.luckmain.luck_draw_user_id == '') {
      wx.showToast({
        title: '抽奖异常 ！',
        icon: 'none',
        duration: 2000,
        mask: true,
      })
    }
    util.request(api.FindLucklyPeople, {
      luckid: that.data.luckmain.luck_draw_user_id,
      id: that.data.id
    }, 'POST').then(res => {
      console.log(res)
      if (res.errno === 0) {
        that.setData({
          luckly_list: res.data
        })
      }
    })
  },
  bindGetUserInfo: function(e) {
    let that = this
    wx.showLoading({
      title: '加载中...',
      mask: true,
    })
    if (e.detail.userInfo) {
      console.log("允许授权")
      // console.log(e.detail.userInfo)
      try {
        wx.setStorageSync('auth', true)
      } catch (e) {}
      //缓存到本地已授权
      that.setData({
        auth: true
      })
      // that.getGoodsInfo()
      user.loginByWeixin().then(res => {
        console.log(res)
        that.setData({
          userinfo: res.data
        })
        that.checkisjoin()
        wx.hideLoading()
        app.globalData.userInfo = res.data.userInfo;
        app.globalData.token = res.data.token;
      })
      //用户按了允许授权按钮
    } else {
      //用户按了拒绝按钮
      console.log("拒绝授权")
      that.setData({
        auth: false
      })
      try {
        wx.setStorageSync('auth', false)
      } catch (e) {} //缓存到本地未授权
      wx.hideLoading()
    }
  },
  checkisjoin() {
    wx.showLoading({
      title: '用户是否参与...',
      mask: true,
    })
    let that = this
    that.selectjoinpeople()
    
    util.request(api.CheckUserIsJoin, {
      userinfo: that.data.userinfo,
      drawid: that.data.id
    }, 'POST').then(res => {
      console.log(res)
      wx.hideLoading()
      if (res.errno === 0) {
        that.setData({
          button_state: 0
        })
      } else if (res.errno === 17) {
        that.setData({
          button_state: 1
        })
      }
    })
  },
  selectjoinpeople() {
    let that = this
    wx.showLoading({
      title: '查找参与者...',
      mask: true,
    })
    util.request(api.FindJoinPeople, {
      id: that.data.id
    }, 'POST').then(res => {
      console.log(res)
      if (res.errno === 0) {
        that.setData({
          join_list: res.data
        })
      }
    })
  },
  join_luck() {
    wx.showLoading({
      title: '核实中...',
      mask: true,
    })
    let that = this
    // if (that.data.auth) {
      // if (that.data.luckmain.have_join_people_num >= that.data.luckmain.luck_people_num) {
      //   wx.hideLoading()
      //   wx.showToast({
      //     title: '参与人数已达最大值 ！',
      //     icon: 'none',
      //     duration: 2000,
      //     mask: true,
      //   })
      // }else {
      wx.showLoading({
        title: '参与中...',
        mask: true,
      })
      util.request(api.JoinLuckDraw, {
        userinfo: that.data.userinfo,
        drawid: that.data.id
      }, 'POST').then(res => {
        console.log(res)
        if (res.errno === 0) {
          wx.hideLoading()
          wx.showToast({
            title: '参与成功 !',
            icon: 'none',
            duration: 1500,
            mask: true,
            success: function(res) {
              that.setData({
                button_state: 1
              })
              wx.showLoading({
                title: '刷新中...',
                mask: true,
              })
              that.selectjoinpeople()
              util.request(api.FindLuckDrawInfo, {
                id: that.data.id
              }, 'POST').then(res => {
                if (res.errno === 17) {
                  wx.hideLoading()
                  wx.showToast({
                    title: '抽奖不存在 !',
                    icon: 'none',
                    duration: 2000,
                    mask: true,
                  })
                } else {
                  wx.hideLoading()
                  that.setData({
                    luckmain: res.data.luckmain
                  })
                  that.setTime()
                }
              })
            },
            fail: function(res) {},
            complete: function(res) {},
          })
        }
      })
      // }
    // } else {
    //   wx.navigateTo({
    //     url: '/pages/AwxChageUserInfoGet/wxChageUserInfoGet?route=' + 'pages/luckdraw/luckdraw' + "&data=" + that.data.id,
    //     success: function(res) {
    //       wx.showToast({
    //         title: '您未授权 ！',
    //         icon: 'none',
    //         duration: 1000,
    //         mask: true,
    //       })
    //     },
    //     fail: function(res) {},
    //     complete: function(res) {},
    //   })
    // }
  },
  seeall_joiner() {
    let that = this
    wx.navigateTo({
      url: '/pages/luckdraw_all/luckdraw_all?id=' + that.data.id,
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
    // console.log('查看所有参与者')
  },
  selectaddress() {
    // console.log("123456")
    wx.showLoading({
      title: '核实中...',
      mask: true,
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
    let that = this
    util.request(api.CheckIsGet, {
      luckid: that.data.id,
      luckgoods: that.data.luckmain.goods,
      userInfo: that.data.userinfo.userInfo
    }, 'POST').then(res => {
      console.log(res)
      if (res.errno === 503) {
        that.getaddressList()
      } else if (res.errno === 17) {
        wx.hideLoading()
        wx.showToast({
          title: '您已经领取过此奖品啦 ~ ',
          icon: 'none',
          duration: 2000,
          mask: true,
          success: function(res) {},
          fail: function(res) {},
          complete: function(res) {},
        })
      }
    })

  },
  getaddressList() {
    var that = this
    wx.showLoading({
      title: '获取地址...',
      mask: true,
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
    util.request(api.AfterBargainSuccessAdressList,{
      userId: that.data.userinfo.userInfo.id
    },'POST').then(res => {
      console.log(res)
      that.setData({
        addressList: res.data
      })
      that.showModalAress()

    })
  },
  selectAddress(e) {
    var that = this
    console.log(e.currentTarget.dataset.addressid)
    var addressid = e.currentTarget.dataset.addressid
    util.request(api.AfterBargainSuccessAdressDetail, {
      id: addressid
    }, 'POST').then(res => {
      console.log(res)
      var address = res
      wx.showModal({
        title: '提示',
        content: '确认收货地址为' + address.data.full_region + address.data.address + " , " + address.data.name + " , " + address.data.mobile + " 吗 ？",
        success: function(res) {
          if (res.confirm) {
            wx.showModal({
              title: '警告',
              content: '收货地址确认后不可修改，是否继续 ？',
              success: function(res) {
                if (res.confirm) {
                  wx.showLoading({
                    title: '订单生成中...',
                    mask: true
                  })
                  that.setOrderPay(address.data)
                }
              },
              fail: function(res) {},
              complete: function(res) {},
            })
          }
          // if(res.cancel){

          // }
        },
        fail: function(res) {},
        complete: function(res) {},
      })
    })
  },
  setOrderPay(address) {
    var that = this
    console.log(address)
    // console.log(that.data.luckmain)
    util.request(api.LucksetOrder, {
      luckid: that.data.id,
      addressInfo: address,
      luckgoods: that.data.luckmain.goods,
      userInfo: that.data.userinfo.userInfo

    }, "POST").then(res => {
      console.log(res)

      if (res.errno === 0) {
        that.hideModalAress()
        wx.navigateTo({
          url: '/pages/pay/pay?Price=' + res.data.orderPrice + '&orderId=' + res.data.ordersn,
        })
      } else {
        wx.showToast({
          title: '未知错误，请重试！',
          icon: 'none',
          duration: 2500,
          mask: true,
        })
      }
      wx.hideLoading()
    })
  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function() {

  },
  toAddress() {
    wx.navigateTo({
      url: '/pages/ucenter/addressAdd/addressAdd',
      success: function(res) {

      },
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  showModalAress: function() {
    // 显示遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY('60vh').step()
    this.setData({
      animationDataAress: animation.export(),
      showModalStatusAress: true
    })
    setTimeout(function() {
      animation.translateY(0).step()
      this.setData({
        animationDataAress: animation.export()
      })
    }.bind(this), 200)
    wx.hideLoading()
  },
  hideModalAress: function() {
    // 隐藏遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY('60vh').step()
    this.setData({
      animationDataAress: animation.export(),
    })
    setTimeout(function() {
      animation.translateY(0).step()
      this.setData({
        animationDataAress: animation.export(),
        showModalStatusAress: false
      })
    }.bind(this), 200)
  },
  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function() {

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function() {
    this.hideModalAress()
  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function() {
    this.hideModalAress()
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function() {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function() {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function() {

  }
})