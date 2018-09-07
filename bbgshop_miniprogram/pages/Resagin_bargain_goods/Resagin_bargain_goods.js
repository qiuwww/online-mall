// pages/Resagin_bargain_goods/Resagin_bargain_goods.js
var util = require('../../utils/util.js');
var api = require('../../config/api.js');
const user = require('../../services/user.js');
var WxParse = require('../../lib/wxParse/wxParse.js');

var app = getApp();
Page({
  /**
   * 页面的初始数据
   */
  data: {
    bargain_user_table_id: 0, //bargain_user表的id
    launched_userInfo: {}, //发起用户的数据
    bargainUserInfo: {}, //bargain_info表的数据
    bargainMainInfo: {}, //bargain 主表的数据
    goodsInfo: {}, //砍价的商品的数据
    otherGoods: [], //猜你喜欢的商品
    cuted_user_list: [], //参与砍价的人
    bar_is_End: false, //拼团超时
    auth: false, //用户是否授权
    user_IN_Info: {},//进入页面的用户信息
    is_launch_user: false,//进入用户是否为发起者
    share_btn_disabled: true,//按钮失效状态
    showShareModalStatus: false,//分享弹窗的状态
    animationShareData: {},//分享按钮的动画
    showFCPrice: false,//好友砍价完之后显示砍价金额的弹层
    userIsCut: 1,//进入用户是否参与过此次砍价 （默认为参与过）
    FCcutprice: 0.00,//用户砍了的价格 (回显)
    IS_CUT_SUCCESS: false,//砍价是否完成
    IS_CUT_SUCCESS_AND_GET: false,//砍价是否生成了订单
    showAdressModalStatus: false,//收货地址的弹层状态
    animationAdressData: {},//收货地址的弹层动画
    addressList: [],//用户的收货地址
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    let that = this
    wx.showLoading({
      title: '获取中...',
      mask: true,
    })
    if (options.id) {
      that.setData({
        bargain_user_table_id: options.id
      })
      that.findBargainInfo()
    } else {
      wx.hideLoading()
      wx.showToast({
        title: '异常 ！ 请退出 ！',
        icon: 'none',
        duration: 1500,
        mask: true,
      })
    }
  },
  findBargainInfo() {
    let that = this
    util.request(api.FindUserBargain, {
      bargainid: that.data.bargain_user_table_id
    }, 'POST').then(function(res) {
      console.log(res)
      wx.hideLoading()
      that.setData({
        bargainUserInfo: res.data.bargainuser_table_info,
        // IS_CUT_SUCCESS: res.data.bargainmain_table_info.is_success == 0 ? false : true,
        // share_btn_disabled: res.data.bargainmain_table_info.is_success == 0 ? false : true,
        bargainMainInfo: res.data.bargainmain_table_info,
        launched_userInfo: res.data.launched_userInfo,
        cuted_user_list: res.data.cuted_user_list,
        goodsInfo: res.data.goods,
        otherGoods: res.data.othergoods,
      })
      that.checkAuth()
      WxParse.wxParse('goodsDetail', 'html', res.data.bargainmain_table_info.activity_detail, that);
      // that.checkopenid()
      // console.log(that.data.userInfo)
    });
  },
  //常规的授权验证
  checkAuth() {
    wx.showLoading({
      title: '授权验证...',
      mask: true,
    })
    let that = this
    console.log('进入授权验证函数')
    wx.getSetting({
      success: function (res) {
        if (res.authSetting['scope.userInfo']) {
          // 已经授权，可以直接调用 getUserInfo 获取头像昵称
          wx.showLoading({
            title: '记录用户...',
            mask: true,
          })
          user.loginByWeixin().then(res => {
            console.log(res)
            that.setData({
              user_IN_Info: res.data.userInfo
            })
            app.globalData.userInfo = res.data.userInfo;
            app.globalData.token = res.data.token;
            that.checkIsLaunch()
            wx.hideLoading()
          })
          that.setData({
            auth: true
          })
        } else {
          try {
            wx.setStorageSync('auth', false)
          } catch (e) { }
          that.setData({
            auth: false
          })
          wx.hideLoading()
          console.log("没有授权")
        }
      }
    })
  },
  //好友砍价
  friendCutBtn() {
    let that = this
    wx.showLoading({
      title: '砍价中...',
      mask: true,
    })
    util.request(api.FriendCut, {
      user_INInfo: that.data.user_IN_Info,
      launcheduser: that.data.launched_userInfo,
      bargainUserInfo: that.data.bargainUserInfo
    }, 'POST').then(res => {
      console.log(res)
      wx.hideLoading()
      if(res.errno === 217) {
        wx.showToast({
          title: '您已经砍过啦 ~',
          icon: 'none',
          duration: 1500,
          mask: true,
        })
      } else if (res.errno === 0){
        that.setData({
          showFCPrice: true,
          FCcutprice: res.data,
          share_btn_disabled: true,
          userIsCut: 1
        })
        //用户砍价完成之后 再次查询砍价主要内容 （回调）
        that.findBargainInfo_Again()
      } else if (res.errno === 999) {
        //砍价信息已砍价到底价
        that.setData({
          showFCPrice: true,
          FCcutprice: res.data,
          share_btn_disabled: true,
          userIsCut: 1,
          IS_CUT_SUCCESS: true
        })
        that.findBargainInfo_Again()
      }
    })
  },
  //用户砍价完成之后 再次查询砍价的主要内容
  findBargainInfo_Again() {
    let that = this
    util.request(api.AfterBargainFindInfoAgain,{
      barId: that.data.bargain_user_table_id
    },'POST').then(res => {
      console.log(res)
      if(res.errno === 0){
        that.setData({
          bargainUserInfo: res.data.bargainUserInfo,
          cuted_user_list: res.data.joinInBargainUserList,
        })
      }else {
        wx.showToast({
          title: '异常 ！ 请退出 !',
          icon: 'none',
          duration: 1500,
          mask: true,
        })
      }
    })
  },
  //授权弹窗
  bindGetUserInfo: function (e) {
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
      } catch (e) {
      }
      //缓存到本地已授权
      that.setData({
        auth: true
      })
      // that.getGoodsInfo()
      user.loginByWeixin().then(res => {
        console.log(res)
        that.setData({
          user_IN_Info: res.data.userInfo
        })
        that.checkIsLaunch()
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
      } catch (e) {
      }//缓存到本地未授权
      wx.hideLoading()
    }
  },
  //判断是否为发起者
  checkIsLaunch() {
    let that = this
    if (that.data.bargainUserInfo.is_success == 0) {
      that.setData({
        IS_CUT_SUCCESS: false
      })
    } else {
      that.setData({
        IS_CUT_SUCCESS: true
      })
    }
    if (that.data.bargainUserInfo.iscut !== 0 && that.data.bargainUserInfo.iscut !== 1) {
      that.setData({
        IS_CUT_SUCCESS_AND_GET: true,
        share_btn_disabled: true
      })
    } else {
      that.setData({
        IS_CUT_SUCCESS_AND_GET: false
      })
    }
    if (that.data.launched_userInfo.id === that.data.user_IN_Info.id){
      console.log('发起者')
      that.setData({
        share_btn_disabled: false,
        is_launch_user: true,
      })
      if (that.data.bargainUserInfo.iscut !== 0 && that.data.bargainUserInfo.iscut !== 1) {
        that.setData({
          IS_CUT_SUCCESS_AND_GET: true,
          share_btn_disabled: true
        })
      } else {
        that.setData({
          IS_CUT_SUCCESS_AND_GET: false
        })
        that.showShareModal()
      }
      
    }else {
      console.log('不是发起者')
      that.setData({
        share_btn_disabled: false,
        is_launch_user: false,
      })
      //不是发起者就核对该用户是否砍过价
      that.checkFriendIsCut()      
    }
    that.setTimeloop()
    
  },
  //不是发起者就核对该用户是否砍过价
  checkFriendIsCut() {
    let that = this
    console.log('进入核对用户是否砍过价函数')
    util.request(api.CheckFriendIsCut,{
      user_IN_id: that.data.user_IN_Info.id,
      barId: that.data.bargain_user_table_id
    },'POST').then(res => {
      console.log(res)
      if(res.errno === 17){
        that.setData({
          share_btn_disabled: true,
          userIsCut: 1,//参与过砍价 (不能砍价，按钮失效状态)
        })
      } else if (res.errno === 0){
        that.setData({
          share_btn_disabled: false,
          userIsCut: 0,//没有参与过砍价 (可以砍价，按钮激活状态)
        })
      }
      if (that.data.bargainUserInfo.iscut !== 0 && that.data.bargainUserInfo.iscut !== 1) {
        that.setData({
          IS_CUT_SUCCESS_AND_GET: true,
          share_btn_disabled: true
        })
      } else {
        that.setData({
          IS_CUT_SUCCESS_AND_GET: false
        })
      }
    })
  },
  //倒计时循环
  setTimeloop() {
    var that = this
    var loop = setInterval(function() {
      if ((parseInt(that.data.bargainUserInfo.end_time) - new Date().getTime()) < 0) {
        that.setData({
          bar_is_End: true
        })
        console.log('过期')
        that.hideShareModal()
        that.hideAdressModal()
        clearInterval(loop)
      }
      var list = that.data.bargainUserInfo
      var time = parseInt(list.end_time) - new Date().getTime()
      list.listtime = util.timestampToTw(time)
      that.setData({
        bargainUserInfo: that.data.bargainUserInfo
      })
    }, 100)
  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function() {

  },
  share_wechat_friend() {
    console.log('分享给微信好友')
  },
  share_wechat_qzone() {
    console.log('分享给微信朋友圈')
  },
  toIndexPage() {
    wx.switchTab({
      url: '/pages/index/index',
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  // 用户点击领取按钮 
  beforShowAdressModal() {
    let that = this
    util.request(api.AfterBargainSuccessAdressList,{
      userId: that.data.user_IN_Info.id
    },'POST').then(res => {
      console.log(res)
      if(res.errno === 0){
        that.setData({
          addressList: res.data
        })
        that.showAdressModal()
      }else {
        wx.showToast({
          title: '异常 ！ 请退出 !',
          icon: 'none',
          duration: 1500,
          mask: true,
        })
      }
    })
  },
  //用户选择收货地址并生成订单
  selectAddress(e) {
    let that = this
    console.log(e.currentTarget.dataset.addressid)
    let id = e.currentTarget.dataset.addressid
    util.request(api.AfterBargainSuccessAdressDetail,{
      id: id
    },'POST').then(res => {
      console.log(res)
      if(res.errno === 0){
        let address = res.data
        wx.showModal({
          title: '请确认 ！',
          content: '确认收货地址为' + address.full_region + address.address + " , " + address.name + " , " + address.mobile + " 吗 ？",
          success: function (res) {
            if (res.confirm) {
              wx.showModal({
                title: '请再次确认 ！',
                content: '请确认商品为' + that.data.bargainUserInfo.goods_name + " , " + that.data.bargainUserInfo.goods_sku_value + " , " + " 吗 ？ 点击确认支付 " + that.data.bargainUserInfo.goods_lowest_price + " 元购买 ！ ",
                success: function(res) {
                  if (res.confirm) {
                    wx.showLoading({
                      title: '订单生成...',
                      mask: true,
                    })
                    util.request(api.AfterBargainSuccessSetOrder,{
                      selectAdressId: id,
                      orderUserId: that.data.launched_userInfo.id,
                      orderBargainId: that.data.bargain_user_table_id,
                    },'POST').then(ress => {
                      console.log(ress)
                      if (ress.errno === 0){
                        wx.hideLoading()
                        that.setData({
                            IS_CUT_SUCCESS_AND_GET: true,
                            share_btn_disabled: true
                        })
                        that.hideAdressModal()
                        wx.navigateTo({
                          url: '/pages/pay/pay?Price=' + ress.data.orderPrice + '&orderId=' + ress.data.orderSn + '&payId=1',
                          success: function (ress) {},
                          fail: function (ress) {},
                          complete: function (ress) {},
                        })

                      } else if (ress.errno === 17){
                        wx.showToast({
                          title: '此砍价信息已被生成订单，请在‘我的订单’中查看 ！',
                          icon: 'none',
                          duration: 2500,
                          mask: true,
                        })
                      }
                    })
                  } 
                },
                fail: function (ress) {},
                complete: function (ress) {},
              })
            }
          },
          fail: function (res) { },
          complete: function (res) { },
        })
      }
    })
    
  },
  //显示收货地址的弹层
  showAdressModal() {
    // 显示遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY(250).step()
    this.setData({
      animationAdressData: animation.export(),
      showAdressModalStatus: true
    })
    setTimeout(function () {
      animation.translateY(0).step()
      this.setData({
        animationAdressData: animation.export()
      })
    }.bind(this), 200)
  },
  //隐藏收货地址的弹层
  hideAdressModal(){
    // 隐藏遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY(250).step()
    this.setData({
      animationAdressData: animation.export(),
    })
    setTimeout(function () {
      animation.translateY(0).step()
      this.setData({
        animationAdressData: animation.export(),
        showAdressModalStatus: false
      })
    }.bind(this), 200)
  },
  // 显示分享的弹层
  showShareModal: function () {
    // 显示遮罩层
    let that = this
    // that.friendcutthen()
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY(250).step()
    this.setData({
      animationShareData: animation.export(),
      showShareModalStatus: true
    })
    setTimeout(function () {
      animation.translateY(0).step()
      this.setData({
        animationShareData: animation.export()
      })
    }.bind(this), 200)
  },
  // 隐藏分享的弹层
  hideShareModal: function () {
    // 隐藏遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY(250).step()
    this.setData({
      animationShareData: animation.export(),
    })
    setTimeout(function () {
      animation.translateY(0).step()
      this.setData({
        animationShareData: animation.export(),
        showShareModalStatus: false
      })
    }.bind(this), 200)
  },
  //隐藏好友砍价回调弹层
  offFCcutmask() {
    this.setData({
      showFCPrice: false
    })
  },
  // exit() {

  // },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function() {

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function() {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function() {

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