var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');
const app = getApp();

Page({
  data: {
    couponListget:[],
    couponList:[],
    pointgoods: [],
    unablecouponListget: [],
    unablecouponList:[],
    usedcouponListget: [],
    usedcouponList:[],
    activeTab:0,
    auth:false
  },
  onLoad: function (options) {
    let that = this;
    wx.showLoading({
      title: '加载中...',
      mask: true,
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
    if (app.globalData.token == ""){
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
    }else {
      that.setData({
        auth: true
      })
      that.getList() 
    }
  },
  getList(){
    let that = this
    util.request(api.UserCouponList).then(function (res) {
        console.log(res.data);
        that.setData({
          couponListget: res.data.ablelist,
          unablecouponListget: res.data.unablelist,
          usedcouponListget: res.data.usedlist
        })
        that.regroup()
    });
  },
  regroup(){
    var that = this
    // console.log(that.data.couponListget)
    var getList = that.data.couponListget
    var unableList = that.data.unablecouponListget
    var usedList = that.data.usedcouponListget
    that.data.couponList = []
    let list = []
    for (var i = 0; i < getList.length; i++){
      let obj = {}
      obj.name = getList[i].coupon_name
      obj.value = getList[i].coupon_value
      obj.coupon_type = getList[i].coupon_type
      obj.validity_end = getList[i].validity_end
      obj.validity_start = getList[i].validity_start
      if (getList[i].coupon_limit == 1) {
        obj.limit = '满 ' + getList[i].coupon_limit_value + ' 可用'
      } else {
        obj.limit = "无门槛"
      } 
      if (getList[i].point_goods !== '') {
        // obj.src = 'null'
        if (getList[i].goods.length > 1) {
          // obj.src = 'null'
          obj.ispoint = '2'
          obj.goods = getList[i].goods
        } else {
          obj.ispoint = '1'
          obj.goods = getList[i].goods
        }
      } else {
        obj.ispoint = '0'
      }
      list.push(obj)
    }

    that.data.usedcouponList = []
    // console.log(usedList)
    let usedcuplist = []
    for (var k = 0; k < usedList.length;k++){
      let obj2 = {}
      obj2.name = usedList[k].coupon_name
      obj2.value = usedList[k].coupon_value
      obj2.coupon_type = usedList[k].coupon_type
      obj2.validity_end = usedList[k].validity_end
      if (usedList[k].coupon_limit == 1) {
        obj2.limit = '满 ' + usedList[k].coupon_limit_value + ' 可用'
      } else {
        obj2.limit = "无门槛"
      } 
      if (usedList[k].point_goods !== '') {
        // obj.usedList = 'null'
        if (usedList[k].goods.length > 1) {
          // obj.src = 'null'
          obj2.ispoint = '2'
          obj2.goods = usedList[k].goods
        } else {
          obj2.ispoint = '1'
          obj2.goods = usedList[k].goods
        }
      } else {
        obj2.ispoint = '0'
      }
      // console.log(obj2)
      usedcuplist.push(obj2)
      // console.log(usedcuplist.push(obj2))
      
    }
    // console.log(usedcuplist)
    that.data.unablecouponList = []
    let uncuplist = []
    for (var j = 0; j < unableList.length; j++) {
      let obj1 = {}
      obj1.name = unableList[j].coupon_name
      obj1.value = unableList[j].coupon_value
      obj1.coupon_type = unableList[j].coupon_type
      obj1.validity_end = unableList[j].validity_end
      if (unableList[j].coupon_limit == 1) {
        obj1.limit = '满 ' + unableList[j].coupon_limit_value + ' 可用'
      } else {
        obj1.limit = "无门槛"
      }
      if (unableList[j].point_goods !== '') {
        // obj.src = 'null'
        if (unableList[j].goods.length > 1) {
          // obj.src = 'null'
          obj1.ispoint = '2'
          obj1.goods = unableList[j].goods
        } else {
          obj1.ispoint = '1'
          obj1.goods = unableList[j].goods
        }
      } else {
        obj1.ispoint = '0'
      }
      uncuplist.push(obj1)
    }
    that.setData({
      couponList: list,
      unablecouponList: uncuplist,
      usedcouponList: usedcuplist
    })
    that.setTimeloop()
    wx.hideLoading()
    
    // that.setTime()
    // console.log(that.data.couponList)
    // console.log(that.data.unablecouponList)
    // console.log(that.data.usedcouponList)
  },
  setTime(){
    let that = this
    for (var i = 0; i < that.data.couponList.length; i++) {
      // console.log("123")
      var list = that.data.couponList[i]
      if (parseInt(list.validity_end) - new Date().getTime() < 0) {
        list.localvalend = "0"
        list.abled = '0'
        that.hideModal()
      } else {
        console.log(list)
        var starttime = parseInt(list.validity_start)
        var endtime = parseInt(list.validity_end)
        // console.log(util.timestampToDate(time)) 
        list.localvalend = util.timestampToTime(starttime) + ' 至 ' + util.timestampToTime(endtime)
        list.abled = '1'
      }
    }
    that.setData({
      couponList: that.data.couponList
    })
  },
  setTimeloop() {
    var that = this
    // console.log(that.data.userbargainList)
    var loop = setInterval(function () {
      for (var i = 0; i < that.data.couponList.length; i++) {
        // console.log("123")
        var list = that.data.couponList[i]
        if (parseInt(list.validity_end) - new Date().getTime() < 0) {
          list.localvalend = "0"
          list.abled = '0'
          that.hideModal()
        } else {
          var endtime = parseInt(list.validity_end)
          var time = parseInt(list.validity_end) - new Date().getTime()
          // console.log(util.timestampToDate(time)) 
          // list.localvalend = util.timestampToDateSec(time)
          list.localvalend = util.timestampToTime(endtime) + ' 截止，剩余 ' + util.timestampToDateSec(time)
          list.abled = '1'
        }
      }
      that.setData({
        couponList: that.data.couponList
      })
      // console.log(that.data.userbargainList)
      // if (that.data.activeTab !== 0) {
      //   clearInterval(loop)
      // }
    }, 1000)


    // that.setData({
    //   userbargainList:
    // })
    // that.data.userbargainList.set(obj)
    // that.data.userbargainList.push(obj)
    // console.log(that.data.userbargainList)

  },
  userCupGoods(e){
    wx.showToast({
      title: '跳转中...',
      mask: true,
    })
    // console.log(e.currentTarget.dataset.goodsid)
    var id = e.currentTarget.dataset.goodsid
    wx.navigateTo({
      url: '/pages/goods/goods?id='+id,
      success: function(res) {
        wx.hideLoading()
      },
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  changetab(e){
    var that = this
    console.log(e.currentTarget.dataset.tab)
    var tab = e.currentTarget.dataset.tab
    // if (tab == '0') {
      if(that.data.auth){
        that.getList()
      }else {
        wx.showToast({
          title: '未授权！请在“我的”页点击头像授权!',
          icon: 'none',
          duration: 2000,
          mask: true,
        })
      }

    // } else if (tab == '0'){

    // }
    this.setData({
      activeTab:tab
    }) 
  },
  toCouponcenter(){
    let that = this
    if(that.data.auth){
      wx.navigateTo({
        url: '/pages/couponCenter/couponcenter',
      })
    }else {
      wx.showToast({
        title: '未授权！请在“我的”页点击头像授权!',
        icon: 'none',
        duration: 2000,
        mask: true,
      })
    }

  },
  tousecupzero(){
    // console.log("1234789")
    wx.switchTab({
      url: '/pages/index/index',
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
    // wx.navigateTo({
    //   url: '/pages/index/index',
    //   success: function(res) {},
    //   fail: function(res) {},
    //   complete: function(res) {},
    // })
  },
  showModal: function (e) {
    // 显示遮罩层
    this.goodslist(e)
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY(500).step()
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
    animation.translateY(500).step()
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
  goodslist(e) {
    // console.log(e)
    var that = this
    let pointgoodss = e.currentTarget.dataset.goods
    that.setData({
      pointgoods: pointgoodss
    })

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