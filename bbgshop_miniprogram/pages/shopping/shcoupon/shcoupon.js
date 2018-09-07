var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');



var app = getApp();

Page({
  data: {
    couponList: [],//用户优惠券
    // ablecupList: [],//可使用
    // unpricecupList: [], //价格不足
    // untimecupList: [], //过期
    // commonCup: [], //通用券
    // pointgoodsCup: [],//指定商品券
    totleprice: 0,
    goodsIdList:[],
  },
  onLoad: function (options) {
    wx.showLoading({
      title: '校验中...',

      mask: true,
    })
    let that = this;
    // console.log(options)
    var abc = options.Goods
    that.setData({
      totleprice: options.Price,
      goodsIdList: abc.split(","),
    })
    that.check()
    // let unprice = [] //价格不足
    // let able = [] //可使用优惠券
    // let untime = [] //过期


  },
  check(){
    var that = this
    // console.log(that.data.totleprice)
    // console.log(that.data.goodsIdList)
    util.request(api.CheckCupList, {
      // price: options.Price
      price: that.data.totleprice,
      idList: that.data.goodsIdList
    }, 'POST').then(function (res) {
      console.log(res.data);
      that.setData({
        couponListget:res.data.finall
      })
      that.regroup()
      wx.hideLoading()

    })
  },
  regroup(){
    var that = this
    // console.log(that.data.couponListget)
    var getList = that.data.couponListget
    that.data.couponList = []
    let list = []
    for (var i = 0; i < getList.length; i++) {
      let obj = {}
      obj.name = getList[i].coupon_name
      obj.id = getList[i].coupon_id
      obj.value = getList[i].coupon_value
      obj.coupon_type = getList[i].coupon_type
      obj.validity_end = getList[i].validity_end
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
      that.setData({
        couponList: list,
        // unablecouponList: uncuplist,
        // usedcouponList: usedcuplist
      })
    that.setTimeloop()
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
          var time = parseInt(list.validity_end) - new Date().getTime()
          // console.log(util.timestampToDate(time)) 
          list.localvalend = util.timestampToDateSec(time)
          list.abled = '1'
        }
      }
      that.setData({
        couponList: that.data.couponList
      })
    }, 1000)

  },
  selectthiscup(e){
    
    console.log(e)
    console.log(e.currentTarget.dataset.cupid)
    try {
      wx.setStorageSync('couponId', e.currentTarget.dataset.cupid);
    } catch (e) {

    }
    // wx.redirectTo({
    //   url: '/pages/shopping/checkout/checkout'
    // })
    wx.navigateBack({
      delta: 1,
    })
  },
  nocoupon: function () {
    try {
      wx.setStorageSync('couponId', "0");
    } catch (e) {

    }
    // wx.redirectTo({
    //   url: '/pages/shopping/checkout/checkout'
    // })
    wx.navigateBack({
      delta: 1,
    })
  },
  onReady: function () {

  },
  onShow: function () {
    // for (var i = 0; i < this.data.couponList.length ; i++){
    //   console.log('1')
    // }

    // console.log(this.data.couponList)
    // console.log(this.data.couponList)
    // console.log(this.data.totleprice)
  },
  onHide: function () {
    // 页面隐藏

  },
  onUnload: function () {
    // 页面关闭
  }
})