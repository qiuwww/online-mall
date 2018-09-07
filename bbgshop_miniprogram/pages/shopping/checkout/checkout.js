var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');
const pay = require('../../../services/pay.js');

var app = getApp();

Page({
  data: {
    checkedGoodsList: [],
    showcounp:false,
    freetext: '',
    show:0,
    ordersn:0,
    goodsidList: [],//商品id
    addressInfo:[],
    checkedAddress: {},
    // checkedCoupon: [],
    couponList: [],
    goodsTotalPrice: 0.00, //商品总价
    freightPrice: 0.00,    //快递费
    couponPrice: 0.00,     //优惠券的价格
    orderTotalPrice: 0.00,  //订单总价
    actualPrice: 0.00,     //实际需要支付的总价
    rules_value: '未参与优惠活动',//优惠活动减免
    userDiscount_Value: '未参与等级优惠',//用户等级减免
    // supplier_ids: '',//供货商的id 字符串
    is_Identity: 0,//是否需要身份信息
    IdentityInput: '',//身份信息
    userDiscount_Price: 0.00,
    addressId: 0,
    couponId: 0,
    // couponIdid: 0,
    selectconponlist:[],
    userinfo: {},
  },
  onLoad: function (options) {
    wx.showLoading({
      title: '加载中...',
    })
    this.reloadRouter()
    // 页面初始化 options为页面跳转所带来的参数
    // console.log(options.goodsid)
    // this.setData({
    //   selectid: options.goodsid
    // })
    try {
      var addressId = wx.getStorageSync('addressId');
      // console.log(addressId)
      if (addressId != '') {
        this.setData({
          addressId: addressId
        });
      }
      var userInfo = wx.getStorageSync('userInfo'); 
      // console.log(userinfo)
      if (userInfo) {
        this.setData({
          userinfo: userInfo
        });
      }
      var couponId = wx.getStorageSync('couponId');
      if (couponId) {
        this.setData({
          couponId: couponId
        });
      }
    } catch (e) {
      // Do something when catch error
    }
    this.FindCup()
  },
  reloadRouter() {
    let that = this
    setTimeout(() => {
      if (that.data.checkedGoodsList.length == 0){
        wx.navigateBack({
          delta: 1,
        })
      }

    },2000)
  },
  freetext(event){
    // console.log(event)
    this.setData({
      freetext:event.detail.value
    })
    // console.log(this.data.freetext)

  },
  IdentityInput(e){
    this.setData({
      IdentityInput: e.detail.value
    })
    // console.log(this.data.IdentityInput)
  },
  backindex(){
    wx.switchTab({
      url: '/pages/index/index',
      // success: function(res) {},
      // fail: function(res) {},
      // complete: function(res) {},
    })
  },
  getCheckoutInfo: function () {
    let that = this;
    console.log(that.data.addressId)
    console.log(that.data.couponId)
    // console.log(that.data.userinfo)
    util.request(api.CartCheckout, { addressId: that.data.addressId, couponId: that.data.couponId, userId: that.data.userinfo.id },'POST').then(function (res) {
        if (res.errno === 0) {
          console.log(res.data);
          that.setData({
            addressId: res.data.addressId,
            checkedGoodsList: res.data.checkedGoodsList,
            checkedAddress: res.data.checkedAddress,
            actualPrice: res.data.actualPrice,
            rules_value: res.data.rules_value,
            userDiscount_Value: res.data.userDiscount_Value,
            userDiscount_Price: res.data.userDiscount_Price,
            // supplier_ids: res.data.supplier_ids,
            // checkedCoupon: res.data.checkedCoupon,
            couponList: res.data.couponList,
            couponPrice: res.data.couponPrice,
            freightPrice: res.data.freightPrice,
            goodsTotalPrice: (res.data.goodsTotalPrice).toFixed(2),
            orderTotalPrice: res.data.orderTotalPrice,
            is_Identity: res.data.is_Identity
          });
          console.log(that.data.checkedGoodsList)
        }

        setTimeout(() => {
          wx.hideLoading()
        }, 217)
      });

    // }

  },
  selectAddress() {
    wx.navigateTo({
      url: '/pages/shopping/address/address',
    })
  },
  addAddress() {
    wx.navigateTo({
      url: '/pages/shopping/address/address',
    })
  },
  selectcoupon() {
    var that = this
    console.log(that.data.goodsTotalPrice)
    console.log(that.data.checkedGoodsList)
    // console.log(this.data.goodsidList)
    let idlist = []
    for (var i = 0; i < that.data.checkedGoodsList.length;i++){
      let goodsLiss = that.data.checkedGoodsList[i]
      let obj = {}
      obj = goodsLiss.goods_id
      idlist.push(obj)
    }
    console.log(idlist)
    let id = idlist.join(',')
    wx.navigateTo({
      url: '/pages/shopping/shcoupon/shcoupon?Price=' + that.data.goodsTotalPrice + '&Goods=' + id,
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  backindextip(){
    wx.showModal({
      title: '警告',
      content: '此按钮是为了应对一些场景无法返回主页的情况，是否放弃订单返回主页？',
      success: function(res) {
        if(res.confirm){
          wx.switchTab({
            url: '/pages/index/index',
            success: function (res) { },
            fail: function (res) { },
            complete: function (res) { },
          })
        }
        
      },
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  FindCup(){
    var that = this
    console.log(this.data.couponId)
    util.request(api.CouponFind, { couponId: this.data.couponId },"POST").then(function (res) {
      console.log(res);
      that.setData({
        selectconponlist: res.data.couponList,
      })

    })
    that.getCheckoutInfo();
    
  },
  onReady: function () {
    // 页面渲染完成
    // console.log(this.data.checkedAddress)
    // console.log(this.data.couponIdid)
    // let that = this
    // setTimeout(() => {
    //   if (that.data.checkedGoodsList.length == 0) {
    //     wx.navigateBack({
    //       delta: 1,
    //     })
    //   }
    // },5000)
  },
  onShow: function () {
    // 页面显示
    // try {
    //   wx.setStorageSync('couponId', 0);
    // } catch (e) {

    // }
    console.log()
    this.onLoad()

  },
  onHide: function () {
    // 页面隐藏
    // 页面关闭
    try {
      wx.setStorageSync('couponId', 0);
    } catch (e) {

    }
  },
  onUnload: function () {
    // 页面关闭
    try {
      wx.setStorageSync('couponId', 0);
    } catch (e) {

    }
    // util.request(api.CartCheckeder).then(res => {
    //   console.log(res)
    // });
  },
  submitOrder: function () {
    var that = this
    if (that.data.is_Identity == 1){
      let reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/
      if (!reg.test(that.data.IdentityInput)){
        wx.showToast({
          title: '身份证信息有误 ！',
          icon: 'none',
          duration: 1000,
          mask: true,
        })
        return false
        
      }else {
        console.log('身份证正确')
      }
    }
    if (this.data.addressId <= 0) {
      util.showErrorToast('请选择收货地址');
      return false;
    }
    if (this.data.checkedAddress.name == '') {
      util.showErrorToast('收货地址错误');
      return false;
    }
    if (this.data.checkedAddress.mobile == '') {
      util.showErrorToast('收货地址错误');
      return false;
    }
    if (this.data.checkedAddress.mobile == '') {
      util.showErrorToast('收货地址错误');
      return false;
    }
    if (this.data.checkedAddress.full_region == null) {
      util.showErrorToast('收货地址错误');
      return false; 
    }
    if (this.data.actualPrice * 100 <= 0 ){
      // console.log(this.actualPrice)
      // util.showErrorToast('下单失败');
      wx.showToast({
        title: '哼，订单金额小于0了，别想骗我！',
        icon: 'none',
        duration: 2500,
        mask: true,
        success: function(res) {},
        fail: function(res) {},
        complete: function(res) {},
      })
      return false;
    }
    wx.showLoading({
      title: '订单提交中...',
      mask: true,
      success: function (res) { },
      fail: function (res) { },
      complete: function (res) { },
    })
    console.log(this.data.checkedGoodsList)
    console.log(this.data.actualPrice)
    util.request(api.OrderSubmit, { 
      addressId: this.data.addressId, 
      couponId: this.data.couponId, 
      postscript: this.data.freetext, 
      freightPrice: this.data.freightPrice,
      couponPrice: this.data.couponPrice,
      goodsTotalPrice: this.data.goodsTotalPrice,
      actualPrice: this.data.actualPrice,
      GoodsList: this.data.checkedGoodsList,
      userId: this.data.userinfo.id,
      userDiscount_Price: this.data.userDiscount_Price,
      IdentityInput: this.data.IdentityInput
      // supplier_ids: this.data.supplier_ids
      }, 'POST').then(res => {
      console.log(res)
      if (res.errno === 0) {
        console.log(res.data.orderInfo);
        var orderid = res.data.orderInfo.id
        util.request(api.OrderDetail,{
          orderId: orderid
        }).then(function (res) {
          wx.hideLoading()
          if (res.errno === 0) {
            console.log(res.data);
            var actualprice = res.data.orderInfo.actual_price
            var ordertrueId = res.data.orderInfo.order_sn
            wx.navigateTo({
              url: '/pages/pay/pay?Price=' + actualprice + '&orderId=' + ordertrueId,
            })

          }
          that.getCheckoutInfo();
        });
        // const orderId = res.data.orderInfo.id;
        // pay.payOrder(parseInt(orderId)).then(res => {
        //   wx.redirectTo({
        //     url: '/pages/payResult/payResult?status=1&orderId=' + orderId
        //   });
        // }).catch(res => {
        //   wx.redirectTo({
        //     url: '/pages/payResult/payResult?status=0&orderId=' + orderId
        //   });
        // });
      } else {
        wx.hideLoading()
        util.showErrorToast('下单失败');
      }
    });
  }
})