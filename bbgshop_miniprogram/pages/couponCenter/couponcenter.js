// pages/couponCenter/couponcenter.js
var util = require('../../utils/util.js');
var api = require('../../config/api.js');
Page({

  /**
   * 页面的初始数据
   */
  data: {
      couponListGet: [],
      couponList:[],
      pointgoods: [],
      inputcoupon: '',
      cupon_perscent:0.04,
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    var that = this
    wx.showLoading({
      title: '获取中...',
      mask: true,
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
    util.request(api.CouponList).then(res =>{
      console.log(res)
      that.setData({
        couponListGet:res.data
      })
      that.regroup()
    })
  },
  regroup(){
    var that = this
    // console.log(that.data.couponListGet)
    var couponListGet = that.data.couponListGet
    // that.setData({
    //   couponList:[]
    // })
    that.data.couponList = []
    let list = []
    for (var i = 0; i < couponListGet.length;i++){
      // console.log(i)
      let obj = {}
      if (couponListGet[i].point_goods !== ''){
        // obj.src = 'null'
        if (couponListGet[i].goods.length > 1){
          // obj.src = 'null'
          obj.ispoint = '2'
          obj.goods = couponListGet[i].goods
        }else {
          obj.ispoint = '1'
          obj.src = couponListGet[i].goods[0].list_pic_url
        }
      }else {
        obj.ispoint = '0'
        obj.src = '../../image/allgoods.png'
      }
      if (couponListGet[i].obtained_num >= couponListGet[i].coupon_number){
        obj.end = 1
      }else {
        obj.end = 0
      }
      obj.name = couponListGet[i].coupon_name
      obj.num = couponListGet[i].coupon_number
      obj.obtained = couponListGet[i].obtained_num
      obj.coupon_type = couponListGet[i].coupon_type
      obj.percept = ((parseInt(couponListGet[i].obtained_num) / parseInt(couponListGet[i].coupon_number)).toFixed(4) * 100).toFixed(2)
      // if (couponListGet[i].coupon_type == 1){
      //   obj.value = couponListGet[i].coupon_value + '折'
      // }else{
        obj.value = couponListGet[i].coupon_value
      // }

      if (couponListGet[i].coupon_limit == 1) {
        obj.limit = '满'+couponListGet[i].coupon_limit_value + '可用'
      } else {
        obj.limit = "无门槛"
      } 
      // if (couponListGet[i].validity_type == 2) {
      //   // console.log(couponListGet[i].validity_limit_day)
      //   var timestamp = parseInt(couponListGet[i].validity_limit_day)
      //   // var ling = util.timestampToDate(time)
      //   // var ling = timestamp % 86400000
      //   var H = parseInt((timestamp % 86400000) / 3600000);
      //   var M = parseInt((timestamp % 3600000) / 60000);
      //   var S = ((timestamp % 60000) / 1000).toFixed(0);
      //   var localH = H < 10 ? '0' + H : H;
      //   var localM = M < 10 ? '0' + M : M;
      //   var localS = S < 10 ? '0' + S : S;
      //   var ling = localH + ":" + localM + ":" + localS
      //   obj.limit_day = couponListGet[i].validity_limit_day
      //   obj.limit_localday = ling
      // } else {
      //   obj.limit_day = couponListGet[i].validity_limit_day
      //   obj.limit_localday = ''
      // } 
      obj.id = couponListGet[i].coupon_id
      list.push(obj)
      // console.log(list)

    }
    that.setData({
      couponList:list
    })
    wx.hideLoading()
  },
  get_coupon(e){
    var that = this
    console.log(e.currentTarget.dataset.id)
    var id = e.currentTarget.dataset.id
    var name = e.currentTarget.dataset.name
    wx.showModal({
      title: '提示',
      content: '是否领取优惠券'+ name +'吗？',
      success: function(res) {
        if (res.confirm) {
          wx.showLoading({
            title: '领取中...',
            mask: true,
          })
          util.request(api.UserGetCup,{
            id:id
          },'POST').then(res => {
            console.log(res)
            var data = res.data
            wx.hideLoading()
            if(res.errno == 217){
              wx.showToast({
                title: '您已经领过此张券啦！',
                icon: 'none',
                duration: 2000,
                mask: true,
                success: function(res) {},
                fail: function(res) {},
                complete: function(res) {},
              })
            }else {
              that.onLoad()
              var endtime = (data.validity_end / 1).toFixed(0)
              console.log(endtime)
              var endlocaltime = util.timestampToTime(endtime)
              wx.showModal({
                title: '提示',
                content: '领取成功，请在' + endlocaltime + '前使用！',
                success: function(res) {},
                fail: function(res) {},
                complete: function(res) {},
              })
            }
          })
          // console.log('用户点击确定')
        } else if (res.cancel) {
          // console.log('用户点击取消')
          wx.showToast({
            title: '取消领取！',
            icon: 'none',
            duration: 2000,
            mask: true,
          })
        }
      },
      fail: function(res) {},
      complete: function(res) {},
    })

  },
  togoodspage(e){
    wx.navigateTo({
      url: '/pages/goods/goods?id=' + e.currentTarget.dataset.id,
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  bindinputcoupon(e){
    var that = this
    console.log(e)
    that.setData({
      inputcoupon:e.detail.value
    })
    console.log(that.data.inputcoupon)
  },
  exchangecoupon(){
    var that = this
    util.request(api.FindInputCup,{
      id: that.data.inputcoupon
    },'POST').then(res => {
      console.log(res)
      if (res.errno == 11){
        wx.showToast({
          title: '没有此优惠券！',
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
    console.log(e)
    var that = this
    let pointgoodss = e.currentTarget.dataset.goods
    that.setData({
      pointgoods: pointgoodss
    })

  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
  
  },
  helptip(){
    wx.showToast({
      title: '领取后请尽快使用 ！',
      icon: 'none',
      duration: 2000,
      mask: true,
    })
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