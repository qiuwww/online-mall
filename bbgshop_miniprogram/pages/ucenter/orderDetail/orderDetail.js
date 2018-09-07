var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');

Page({
  data: {
    orderId: 0,
    orderInfo: {},
    orderGoods: [],
    handleOption: {},
    add_time:"",
    refund_time:'',
    pay_time: '',
    logic_time: '',
    confirLogic_time: '',
    refundsuccess_time: '',
    pendout_time: '',
    del_time: "",
    refundInfo: [],
  },
  onLoad: function (options) {
    // 页面初始化 options为页面跳转所带来的参数
    console.log(options)
    this.setData({
      orderId: options.id
    });
    this.getOrderDetail();
  },
  getOrderDetail() {
    let that = this;
    util.request(api.OrderDetail, {
      orderId: that.data.orderId
    }).then(function (res) {
      console.log(res)
      if (res.errno === 0) {
        // console.log(res.data);
        that.setData({
          orderInfo: res.data.orderInfo,
          orderGoods: res.data.orderGoods,
          handleOption: res.data.handleOption,
          add_time: util.timestampToTime(res.data.orderInfo.add_time),
          pay_time: util.timestampToTime(res.data.orderInfo.pay_time),
          // pendout_time: 
          logic_time: util.timestampToTime(res.data.orderInfo.logistics_time),
          confirLogic_time: util.timestampToTime(res.data.orderInfo.confirLogic_time),
        });
        // console.log(res.data.orderInfo.confirLogic_time)
        // console.log(that.data.confirLogic_time)
        if (res.data.refundInfo.length >= 1){
          that.setData({
            refundInfo: res.data.refundInfo,
            del_time: util.timestampToTime(res.data.refundInfo[0].del_time),
            refund_time: util.timestampToTime(res.data.refundInfo[0].creat_time),
            refundsuccess_time: util.timestampToTime(res.data.refundInfo[0].refund_time),
            // confirLogic_time: util.timestampToTime(res.data.orderInfo.refund_time),
            // refundsuccess_time: util.timestampToTime(res.data.refundInfo[0].refund_time),
          });
        }
        if (res.data.refundInfo.length == 0 && res.data.orderInfo.refund_is_success == 1){
          console.log("32154654987985279")
          that.setData({
            refundsuccess_time: util.timestampToTime(res.data.orderInfo.refund_time)
          })
        }
        // console.log(that.data.confirLogic_time)
        
        // console.log(that.data.refundInfo)
        // that.payTimer();
      }
    });
  },
  // payTimer() {
  //   let that = this;
  //   let orderInfo = that.data.orderInfo;

  //   setInterval(() => {
  //     console.log(orderInfo);
  //     orderInfo.add_time -= 1;
  //     that.setData({
  //       orderInfo: orderInfo,
  //     });
  //   }, 1000);
  // },
  // payOrder() {
  //   let that = this;
  //   var orderPrice = e.target.dataset
  //   console.log(orderPrice)
  //   wx.navigateTo({
  //     url: '/pages/pay/pay?Price=' + orderPrice.orderPrice + '&orderId=' + orderPrice.orderId,
  //   })
  // },
  deliveryOrder:function () {
    let that = this;
    wx.showModal({
      title: '提示',
      content: '是否确认收货？',
      success: function (res) {
        if (res.confirm) {
          var status = 301
          var orderId = that.data.orderInfo.order_sn
          util.request(api.SetOrder, {
            orderId: orderId,
            status: status
          }).then(function (res) {
            if (res.errno === 0) {
              console.log(res.data);
              wx.showToast({
                title: '确认成功！',
                icon: 'success',
                duration: 2000
              })
              wx.switchTab({
                url: '/pages/ucenter/index/index',
              })
            }
          });
        } else if (res.cancel) {
          // console.log('取消删除订单')
        }
      }
    })
  },
  cancelOrder:function () {
    let that = this;
    wx.showModal({
      title: '提示',
      content: '是否取消订单？',
      success: function (res) {
        if (res.confirm) {
          util.request(api.OrderCancel, {
            orderId: that.data.orderId
          }).then(function (res) {
            console.log(res.data);
            if (res.data.cancelorderList === 1) {
              wx.showToast({
                title: '删除成功！',
                icon: 'success',
                duration: 2000
              })
              wx.navigateBack({
                delta: 1,
              })
              // wx.switchTab({
              //   url: '/pages/ucenter/index/index',
              // })
            }
          });
        } else if (res.cancel) {
          wx.showToast({
            title: '已取消！',
            icon: 'none',
            duration: 2000
          })
        }
      }
    })

  },
  onReady: function () {
    // 页面渲染完成
  },
  onShow: function () {
    // 页面显示
  },
  onHide: function () {
    // 页面隐藏
  },
  onUnload: function () {
    // 页面关闭
  }
})