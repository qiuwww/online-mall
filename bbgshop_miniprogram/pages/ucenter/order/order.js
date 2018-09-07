const app = getApp();
var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');
var user = require('../../../services/user.js');
const qiniuUploader = require("../../../utils/qiniuUploader");

Page({
  data: {
    orderList: [],
    refund_orderid: '',
    refund_orderprice: '',
    refund_resond: '',
    nav_item: ['待付款', '待发货', '待收货', '已完成', '退款/售后'],
    refund_nologarray: ['全额退款'],
    refund_logarray: ['全额退款', '部分退款'],
    refund_index: 0,
    refund_logindex: 0,
    refund_resonarray: ['拍错商品', '商品缺货', '与卖家协商一致退款', '未按约定时间发货', '其他'],
    refund_logresonarray: ['拍错商品', '商品缺货', '与卖家协商一致退款', '未按约定时间发货', '漏发/错发', '收到商品不符合描述', '认为不是正品', '商品质量问题', '其他'],
    refundreson_index: 0,
    refundreson_logindex: 0,
    activeTab: 0,
    refund_type: 0,
    refundloc_orderid: '',
    refundloc_orderprice: '',
    qiniuUpload: '',
    refund_price: '',
    refund_uploadimg: [],
    // comment_uploadimg:[],
    showModalStatusComment: false,
    animationDataComment: '',
    showModalStatus: false,
    animationData: '',
    comment_detail: {},
    showRefundBox: false,
    showRefundTimeBox: false,
    timestate: 'null',
    // auth: false,
    distributionData: [],
    userinfo: '',


  },
  onLoad: function (options) {
    // 页面初始化 options为页面跳转所带来的参数
    let that = this
    // that.setDistriPrice('20180605152025161097')
    // that.checkisstoragedis('20180605152025161097')

    try {
      var tab = wx.getStorageSync('tab');
      // console.log(addressId)
      // if (addressId != '') {
      this.setData({
        activeTab: tab
      });
      // }
    } catch (e) {
      // Do something when catch error
    }
    // console.log(app.globalData.token)



  },
  onShow() {
    let that = this
    // if (app.globalData.token == "") {
    //   that.setData({
    //     auth: false
    //   })
    //   wx.showToast({
    //     title: '未授权！请在“我的”页点击头像授权!',
    //     icon: 'none',
    //     duration: 2000,
    //     mask: true,
    //   })
    // } else {
    //   //用户已经授权过
    //   that.setData({
    //     auth: true
    //   })
      wx.showLoading({
        title: '获取中...',
        mask: true,
        success: function (res) {
          that.getOrderList();
         },
        fail: function (res) { },
        complete: function (res) { },
      })
    // }
  },
  getOrderList() {
    let that = this;
    util.request(api.OrderList, {
      index: that.data.activeTab
    }, 'POST').then(function (res) {
      wx.hideLoading()
      if (res.errno === 0) {
        that.setData({
          orderList: res.data.reverse()
        });
      }
    });
  },
  bindPickerChange: function (e) {
    // console.log('picker发送选择改变，携带值为', e.detail.value)
    if (this.data.refund_type == 0) {
      this.setData({
        refund_index: e.detail.value
      })
      if (e.detail.value == 1) {
        this.setData({
          showRefundBox: true
        })
      }
    } else if (this.data.refund_type == 1) {
      this.setData({
        refund_logindex: e.detail.value
      })
      if (e.detail.value == 1) {
        this.setData({
          showRefundBox: true
        })
      }
    }

  },
  bindPickerChangeReson(e) {
    if (this.data.refund_type == 0) {
      this.setData({
        refundreson_index: e.detail.value
      })
    } else if (this.data.refund_type == 1) {
      this.setData({
        refundreson_logindex: e.detail.value
      })
    }
  },
  payOrder(e) {
    var that = this
    console.log(e.target.dataset)
    var orderPrice = e.target.dataset
    // let collageType = e.target.dataset.collage_type
    if (orderPrice.payid == 0) {
      wx.navigateTo({
        url: '/pages/pay/pay?Price=' + orderPrice.orderPrice + '&orderId=' + orderPrice.orderId + '&payId= ' + orderPrice.payid,
      })
    } else if (orderPrice.payid == 1) {
      wx.navigateTo({
        url: '/pages/pay/pay?Price=' + orderPrice.orderPrice + '&orderId=' + orderPrice.orderId + '&payId= ' + orderPrice.payid,
      })
    } else if (orderPrice.payid == 2) {
      if (orderPrice.collageType == 1) {
        util.request(api.SnFindOrder, {
          ordersn: orderPrice.orderId
        }, 'POST').then(res => {
          console.log(res)
          if (res.errno === 0) {
            let orderId = res.data.orderinfo.id
            util.request(api.ColFriendFindMain, {
              orderid: orderId
            }, 'POST').then(res => {
              console.log(res)
              let ordermainid = res.data.ordermainid
              // let ordertruesn = res.data.orderinfo.order_sn
              // let ordertrueprice = res.data.orderinfo.actual_price
              // wx.hideLoading()
              //  wx.navigateTo({
              //    url: '/pages/pay/pay?Price=' + ordertrueprice + '&orderId=' + ordertruesn,
              // })
              wx.navigateTo({
                url: '/pages/collageUserIn_pay/collageUserIn_pay?id=' + ordermainid,
              })
            });
          }
        })

      } else if (orderPrice.collageType == 0) {
        wx.navigateTo({
          url: '/pages/pay/pay?Price=' + orderPrice.orderPrice + '&orderId=' + orderPrice.orderId + '&payId= ' + orderPrice.payid,
        })
      }
    }


  },
  refund(e) {
    let that = this
    let goods = e.currentTarget.dataset.goods
    let reg = /^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/
    // console.log(goods)
    let orderid = that.data.refund_orderid
    console.log(orderid)
    if (that.data.refund_type == 0) {   //未发货之前退款
      console.log(that.data.refund_resond) //退款原因
      console.log(that.data.refund_index) //退款方式 下标
      console.log(that.data.refundreson_index) //退款原因 下标
      console.log(that.data.refund_orderprice) //退款订单总价
      let refund_price = that.data.refund_orderprice
      console.log(refund_price)  //退款金额

      wx.showModal({
        title: '警告！',
        content: '是否确认订单编号为：' + orderid + ",的退款申请？（退款金额为 ￥" + refund_price + " ）",
        success: function (res) {
          if (res.confirm) {
            util.request(api.RefundOrder, {
              orderid: orderid,
              refund_type: that.data.refund_type, //退款类型
              refund_reson: that.data.refund_resond, //退款原因
              refund_index: that.data.refund_index, //退款方式 下标
              refund_local_index: that.data.refund_nologarray[that.data.refund_index], //退款方式 文字
              refundreson_index: that.data.refundreson_index, //退款原因 下标
              refundreson_local_index: that.data.refund_resonarray[that.data.refundreson_index], //退款原因 文字
              refund_order_price: that.data.refund_orderprice,
              refund_price: refund_price
            }, 'POST').then(res => {
              console.log(res)
              // if()
              wx.showLoading({
                title: '提交中...',
              })
              if (res.errno == 0) {
                util.request(api.OrderList, {
                  index: 1
                }, 'POST').then(function (res) {
                  wx.hideLoading()
                  if (res.errno === 0) {
                    console.log(res.data);
                    that.setData({
                      orderList: res.data,

                    });
                    that.hideModal()
                    wx.showToast({
                      title: '提交成功！',
                      icon: 'success',
                      duration: 2000,
                      mask: true,
                      success: function (res) { },
                      fail: function (res) { },
                      complete: function (res) { },
                    })
                  }
                });
              }
            })
          }
        },
        fail: function (res) { },
        complete: function (res) { },
      })

    } else if (that.data.refund_type == 1) {   //发货后退款
      console.log(that.data.refund_uploadimg) //退款凭证图片
      console.log(that.data.refund_resond)    //退款原因
      console.log(that.data.refund_logindex) //退款方式 下标
      console.log(that.data.refundreson_logindex) //退款原因 下标
      console.log(that.data.refund_orderprice) //退款订单总价
      if (that.data.refund_logindex != 1) {
        that.setData({
          refund_price: that.data.refund_orderprice
        })
      } else { }
      if (that.data.refund_price == '' || that.data.refund_price == 0 || that.data.refund_price > that.data.refund_orderprice) {
        // console.log(that.data.refund_price * 100)
        wx.showToast({
          title: '价格异常！',
          icon: 'none',
          duration: 2000,
          mask: true,
          success: function (res) { },
          fail: function (res) { },
          complete: function (res) { },
        })
        return false
      }
      if (that.data.refund_resond == '') {
        wx.showToast({
          title: '请填写退款理由！！',
          icon: 'none',
          duration: 2000,
          mask: true,
          success: function (res) { },
          fail: function (res) { },
          complete: function (res) { },
        })
        return false
      }
      if (!reg.test(that.data.refund_price)){
        wx.showToast({
          title: '退款金额最小值为分 ！！',
          icon: 'none',
          duration: 2000,
          mask: true,
          success: function (res) { },
          fail: function (res) { },
          complete: function (res) { },
        })
        return false
      }
      console.log((Number(that.data.refund_price) * 100))     //退款金额

      wx.showModal({
        title: '警告！',
        content: '是否确认订单编号为：' + orderid + ",的退款申请？（退款金额为 ￥" + that.data.refund_price + " ）",
        success: function (res) {
          if (res.confirm) {
            util.request(api.RefundOrder, {
              orderid: orderid,
              refund_uploadimg: that.data.refund_uploadimg, //退款图片
              refund_type: that.data.refund_type, //退款类型
              refund_reson: that.data.refund_resond, //退款原因
              refund_index: that.data.refund_index, //退款方式 下标
              refund_local_index: that.data.refund_nologarray[that.data.refund_index], //退款方式 文字
              refundreson_index: that.data.refundreson_index, //退款原因 下标
              refundreson_local_index: that.data.refund_resonarray[that.data.refundreson_index], //退款原因 文字
              refund_order_price: that.data.refund_orderprice,
              refund_price: that.data.refund_price
            }, 'POST').then(res => {
              console.log(res)
              // if()
              wx.showLoading({
                title: '提交中...',
              })
              if (res.errno == 0) {
                util.request(api.OrderList, {
                  index: 2
                }, 'POST').then(function (res) {
                  wx.hideLoading()
                  if (res.errno === 0) {
                    console.log(res.data);
                    that.setData({
                      orderList: res.data,

                    });
                    that.hideModal()
                    wx.showToast({
                      title: '退款申请已提交！',
                      icon: 'success',
                      duration: 2000,
                      mask: true,
                      success: function (res) { },
                      fail: function (res) { },
                      complete: function (res) { },
                    })
                  }
                });
              }
            })
          }
        },
        fail: function (res) { },
        complete: function (res) { },
      })

    } else if (that.data.refund_type == 2) {   //发起评论
      // console.log(that.data.refund_resond)
    }

  },
  protimeOrder(e) {
    var that = this
    console.log("查看进度")
    console.log(e)
    wx.showLoading({
      title: '更新中...',
      mask: true,
      success: function (res) { },
      fail: function (res) { },
      complete: function (res) { },
    })
    util.request(api.OrderList, {
      index: 4
    }, 'POST').then(function (res) {
      wx.hideLoading()
      if (res.errno === 0) {
        console.log(res.data);
        that.setData({
          orderList: res.data
        });
      }
    })
    var a = e.currentTarget.dataset.refundId
    this.setData({
      showRefundTimeBox: true,
      timestate: a
    })

  },
  hideRefundTimeBox() {
    this.setData({
      showRefundTimeBox: false
    })
  },
  returnOrder(e) {
    let that = this
    console.log("撤销操作")
    wx.showLoading({
      title: '核实中...',
      mask: true,
      success: function (res) { },
      fail: function (res) { },
      complete: function (res) { },
    })
    var a = e.currentTarget.dataset
    // if (a.refundId !== 1001){
    //   wx.hideLoading()
    //   wx.showToast({
    //     title: '操作失败！',
    //     icon: 'none',
    //     duration: 2000,
    //     mask: true,
    //     success: function(res) {},
    //     fail: function(res) {},
    //     complete: function(res) {},
    //   })
    // }else {
    wx.hideLoading()
    wx.showModal({
      title: '警告！',
      content: '是否撤销对' + a.refundSn + '，的退款申请？',
      success: function (res) {
        wx.showLoading({
          title: '执行中...',
          mask: true,
          success: function (res) { },
          fail: function (res) { },
          complete: function (res) { },
        })
        if (res.confirm) {
          util.request(api.CanelRefundOrder, {
            ordersn: a.orderId,
            backstate: a.backState
          }, 'POST').then(res => {
            console.log(res)
            if (res.errno == 0) {
              wx.showToast({
                title: '撤回成功！',
                icon: 'none',
                duration: 2500,
                mask: true,
                success: function (res) { },
                fail: function (res) { },
                complete: function (res) { },
              })
              util.request(api.OrderList, {
                index: 4
              }, 'POST').then(function (res) {
                wx.hideLoading()
                if (res.errno === 0) {
                  console.log(res.data);
                  that.setData({
                    orderList: res.data
                  });
                }
              });
            }
          })
        }
        if (res.cancel) {
          wx.hideLoading()
          wx.showToast({
            title: '已取消！',
            icon: 'none',
            duration: 1500,
            mask: true,
            success: function (res) { },
            fail: function (res) { },
            complete: function (res) { },
          })
        }
      },
      fail: function (res) { },
      complete: function (res) { },
    })
    // }
  },
  textinput(e) {
    this.setData({
      refund_resond: e.detail.value
    })
  },
  refund_price_bind() {
    var that = this
    if (that.data.refund_logindex != 1) {

    } else {
      console.log("开启修改金额")
      that.setData({
        showRefundBox: true
      })
    }

  },
  refund_price_input(e) {
    this.setData({
      refund_price: e.detail.value
    })

  },
  sure_refund_price() {
    if (Number(this.data.refund_orderprice) <= Number(this.data.refund_price)) {
      wx.showToast({
        title: '部分退款金额不能大于等于总金额！',
        icon: 'none',
        duration: 1500,
        mask: true,
        success: function (res) { },
        fail: function (res) { },
        complete: function (res) { },
      })
      this.setData({
        refund_price: ''
      })
    } else if (Number(this.data.refund_price) == 0) {
      wx.showToast({
        title: '退款金额不能为零！',
        icon: 'none',
        duration: 1500,
        mask: true,
        success: function (res) { },
        fail: function (res) { },
        complete: function (res) { },
      })
    } else {
      this.setData({
        showRefundBox: false
      })
    }
  },
  hideRefunBox() {
    this.setData({
      showRefundBox: false,
      refund_price: ''
    })
  },
  deliveryOrder: function (e) {
    let that = this;
    console.log(e)
    var orderid = e.currentTarget.dataset.orderId
    wx.showModal({
      title: '提示',
      content: '是否确认收货？确认收货后暂时无法申请售后，请谨慎操作！！！',
      success: function (res) {
        if (res.confirm) {
          wx.showModal({
            title: '提示！',
            content: '请再次确认，确认收货后暂时无法申请售后！是否继续？',
            success: function (res) {
              if (res.confirm) {
                var status = 301
                var orderId = orderid
                util.request(api.SetOrder, {
                  orderId: orderid,
                  status: status
                }).then(function (res) {
                  if (res.errno === 0) {
                    console.log(res.data);
                    that.checkisstoragedis(orderid)
                    wx.showToast({
                      title: '确认成功！',
                      icon: 'success',
                      duration: 2000
                    })
                    util.request(api.OrderList, {
                      index: 2
                    }, 'POST').then(function (res) {
                      wx.hideLoading()
                      if (res.errno === 0) {
                        console.log(res.data);
                        that.setData({
                          orderList: res.data
                        });
                      }
                    });
                  }
                });
              }
            },
            fail: function (res) { },
            complete: function (res) { },
          })

        } else if (res.cancel) {
          // console.log('取消删除订单')
        }
      }
    })
  },
  checkisstoragedis(sn) {
    let that = this
    // let sn = sn
    wx.showLoading({
      title: '加载中...',
      mask: true,
    })
    user.loginByWeixin().then(res => {
      console.log(res)
      that.setData({
        userinfo: res.data.userInfo
      })
      that.setdistributionOwnDis(sn)
      util.request(api.CheckIsDistributionHaveFather, {
        userId: res.data.userInfo.id
      }, 'POST').then(ress => {
        console.log(ress)
        if (ress.errno === 555 || ress.errno === 444) {
          try {
            var value = wx.getStorageSync('invitation')
            console.log(value)
            if (value) {
              console.log("用户没有邀请者,读取本地邀请者缓存")
              that.setData({
                distributionData: JSON.parse(value) || ''
              })
              that.setDistriInviter(sn, that.data.distributionData)
            }else {
              console.log("用户没有邀请者，本地没有邀请者缓存，正常下单流程用户")
            }

          } catch (e) {

          }
        } else if(ress.errno === 666 ){
          console.log('父级的一次分销 ')
          that.setDistriPrice(sn,666)
        } else if (ress.errno === 777) {
          console.log('父级的二次分销 ')
          that.setDistriPrice(sn,777)
        }
      })
    })

  },
  setDistriInviter(sn,pasteruser) {
    let that = this
    console.log("进入绑定分销关系函数")
    util.request(api.SetInviterMaster, {
      nowuser: that.data.userinfo,
      pasteruser: pasteruser
    }, 'POST').then(res => {
      console.log(res)
      if (res.errno === 11) {
        that.setDistriPrice(sn,0)
        wx.hideLoading()
        try {
          wx.removeStorageSync('invitation')
        } catch (e) {
          // Do something when catch error
        }
      }else {
        wx.hideLoading()
        wx.showToast({
          title: '异常 ！',
          icon: 'none',
          duration: 1000,
          mask: true,
        })
      }
    })
  },
  setDistriPrice(sn,typec){
    let that = this
    util.request(api.AddDistributionPrice,{
      sn:sn,
      typec: typec,
      nowuser: that.data.userinfo,
    },'POST').then(res => {
      console.log(res)
      if(res){
        wx.hideLoading()
      }
    })
  },
  setdistributionOwnDis(sn){
    let that = this
    console.log(that.data.userinfo.id)
    util.request(api.SetDistributionOwnDis,{
      userId: that.data.userinfo.id,
      sn:sn
    },'POST').then(res => {
      console.log(res)
      if(res.errno === 999) {
        console.log('设置分销员自身提成成功 ！')
      }else{
        wx.showToast({
          title: '异常 ！',
          icon: 'none',
          duration: 1000,
          mask: true,
        })
      }
    })
  },
  commentOrder(e) {
    var that = this
    // wx.showLoading({
    //   title: '加载中...',
    //   mask: true,
    // })
    var order = e.target.dataset
    that.setData({
      refund_type: 2
    })

    util.request(api.GetTooken, 'POST').then(res => {
      console.log(res)
      that.setData({
        qiniuUpload: res.data.uploadToken
      })
    })
    that.setData({
      refund_uploadimg: []
    });
    that.getdetail(order)
  },
  getdetail(order) {
    // console.log(order)
    var that = this
    util.request(api.OrderDetail, {
      orderId: order.orderId
    }).then(function (res) {
      console.log(res)
      wx.hideLoading()
      that.checklistiscom(res.data)
    })
  },
  checklistiscom(list) {
    // console.log(list)
    var that = this
    wx.showLoading({
      title: '核实是否评论...',
    })
    util.request(api.ListIsComment, {
      goodslist: list
    }, 'POST').then(res => {
      console.log(res)
      wx.hideLoading()
      that.setData({
        comment_detail: res.data
      })

      if (res.data.nocomlist.length >= 1) {
        var lengthh = res.data.nocomlist
        var list = JSON.stringify(lengthh);
        wx.navigateTo({
          url: '../ordercomment/ordercomment?nocomlist=' + list,
          success: function (res) {
            wx.showToast({
              title: '您还有 ' + lengthh.length + ' 个商品未评论！',
              icon: 'none',
              duration: 2000,
              mask: true,
              success: function (res) { },
              fail: function (res) { },
              complete: function (res) { },
            })
          },
          fail: function (res) { },
          complete: function (res) { },
        })
      } else if (res.data.nocomlist.length == 0) {
        util.request(api.UpdateComment, {
          orderid: res.data.orderInfo.id
        }, 'POST').then(res => {
          console.log(res)
          if (res.errno == 0) {
            wx.showToast({
              title: '评论已完成，订单状态已更新！',
              icon: 'none',
              duration: 2000,
              mask: true,
              success: function (res) { },
              fail: function (res) { },
              complete: function (res) { },
            })
            util.request(api.OrderList, {
              index: 3
            }, 'POST').then(function (res) {
              wx.hideLoading()
              if (res.errno === 0) {
                console.log(res.data);
                that.setData({
                  orderList: res.data
                });
              }
            });
            // that.hideModalComment()

          }
        })
      }
    })
  },
  onReady: function () {
    // 页面渲染完成
  },
  changetab(e) {
    var that = this

    wx.showLoading({
      title: '获取中...',
    })
    // console.log(e.currentTarget.dataset.tab)
    var tab = e.currentTarget.dataset.tab
    try {
      wx.setStorageSync('tab', tab);
    } catch (e) {

    }
    // if (that.data.auth) {
      util.request(api.OrderList, {
        index: tab
      }, 'POST').then(function (res) {
        wx.hideLoading()
        console.log(res);
        if (res.errno === 0) {
          that.setData({
            orderList: res.data.reverse()
          });
        }
      });
    // } else {
    //   wx.hideLoading()
    //   wx.showToast({
    //     title: '未授权！请在“我的”页点击头像授权!',
    //     icon: 'none',
    //     duration: 2000,
    //     mask: true,
    //     success: function (res) { },
    //     fail: function (res) { },
    //     complete: function (res) { },
    //   })
    // }
    this.setData({
      activeTab: tab
    })
  },
  logisOrder(e) {
    var that = this
    console.log(e.target.dataset)
    var orderPrice = e.target.dataset
    // console.log(orderPrice)
    wx.navigateTo({
      url: '/pages/ucenter/express/express?Price=' + orderPrice.orderPrice + '&orderId=' + orderPrice.orderId,
    })
  },
  collectOrder() {

  },
  refundOrder(e) {
    var that = this
    that.setData({
      refund_uploadimg: []
    });
    if (e.target.dataset.type == 0) {
      wx.showModal({
        title: '提示',
        content: '是否发起' + e.target.dataset.orderId + '，的退款申请，（未发货仅退款）？',
        success: function (res) {
          if (res.confirm) {
            that.setData({
              refund_orderid: e.target.dataset.orderId,
              refund_orderprice: e.target.dataset.orderPrice,
              refund_type: 0,
            })
            that.showModal()
          }
        },
        fail: function (res) { },
        complete: function (res) { },
      })
    } else if (e.target.dataset.type == 1) {
      wx.showModal({
        title: '警告！',
        content: '当前商品已发货，是否确认发起' + e.target.dataset.orderId + '，的退款申请？',
        success: function (res) {
          if (res.confirm) {
            that.setData({
              refund_orderid: e.target.dataset.orderId,
              refund_orderprice: e.target.dataset.orderPrice,
              refund_type: 1,
            })
            util.request(api.GetTooken, 'POST').then(res => {
              console.log(res)
              that.setData({
                qiniuUpload: res.data.uploadToken
              })
            })
            that.showModal()
          }
        },
        fail: function (res) { },
        complete: function (res) { },
      })
    }

  },
  didPressChooesImage() {
    var that = this;
    // didPressChooesImage(that);
    initQiniu(that);
    // 微信 API 选文件
    wx.chooseImage({
      count: 1,
      success: function (res) {
        var filePath = res.tempFilePaths[0];
        // 交给七牛上传
        qiniuUploader.upload(filePath, (res) => {
          console.log(res)
          let obj = {}
          obj = res
          obj.img = api.uploadaddress + res.imageURL
          that.data.refund_uploadimg.push(obj)
          that.setData({
            refund_uploadimg: that.data.refund_uploadimg
          })
        }, (error) => {
          console.log(error)
          console.error('error: ' + JSON.stringify(error));
        }, null,// 使用 null 作为参数占位符
          (progress) => {
            // console.log('上传进度', progress.progress)
            // console.log('已经上传的数据长度', progress.totalBytesSent)
            // console.log('预期需要上传的数据总长度', progress.totalBytesExpectedToSend)
          }, cancelTask => that.setData({ cancelTask })
        );
      }
    })
  },
  delimg(e) {
    let that = this
    wx.showModal({
      title: '提示',
      content: '是否删除此图片？',
      success: function (res) {
        if (res.confirm) {
          var imgs = that.data.refund_uploadimg;
          var index = e.currentTarget.dataset.index;
          imgs.splice(index, 1);
          that.setData({
            refund_uploadimg: imgs
          });
        }
      },
      fail: function (res) { },
      complete: function (res) { },
    })

    // console.log("99999999999999")
  },
  // })
  onHide: function () {
    // 页面隐藏
  },
  onUnload: function () {
    // 页面关闭
  },
  showModal: function () {
    // 显示遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY('80vh').step()
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
    animation.translateY('80vh').step()
    this.setData({
      animationData: animation.export(),
      refund_price: 1
    })
    setTimeout(function () {
      animation.translateY(0).step()
      this.setData({
        animationData: animation.export(),
        showModalStatus: false,
        refund_price: 1
      })
    }.bind(this), 200)
  },
  seeOrder(e) {
    console.log(e.currentTarget.dataset.orderId)
    wx.navigateTo({
      url: '../orderDetail/orderDetail?id=' + e.currentTarget.dataset.orderId,
      success: function (res) { },
      fail: function (res) { },
      complete: function (res) { },
    })
  },
  tocollagegoods(e) {
    wx.showLoading({
      title: '核实中...',
      mask: true,
    })
    console.log(e.currentTarget.dataset.orderId)
    console.log(e.currentTarget.dataset.collageType)
    let orderId = e.currentTarget.dataset.orderId
    let collageType = e.currentTarget.dataset.collageType
    // 1为拼团者
    if (collageType == 1) {
      util.request(api.ColFriendFindMain, {
        orderid: orderId
      }, 'POST').then(res => {
        console.log(res)
        let ordermainid = res.data.ordermainid
        wx.hideLoading()
        wx.navigateTo({
          url: '/pages/collagegoods/collagegoods?id=' + ordermainid,
          success: function (res) { },
          fail: function (res) { },
          complete: function (res) { },
        })
      });
    } else if (collageType == 0) {
      wx.hideLoading()
      wx.navigateTo({
        url: '/pages/collagegoods/collagegoods?id=' + orderId,
        success: function (res) { },
        fail: function (res) { },
        complete: function (res) { },
      })
    }
  },
  collagesuccess() {
    wx.showToast({
      title: '拼团已成功，已进入发货队列！',
      icon: 'none',
      duration: 2000,
      mask: true,
    })
  }
})
// 初始化七牛相关参数
function initQiniu(that) {
  var options = {
    region: 'ECN', // 华北区
    // uptokenURL: 'https://[yourserver.com]/api/uptoken',
    uptoken: that.data.qiniuUpload,
    // domain: 'http://[yourBucketId].bkt.clouddn.com',
    shouldUseQiniuFileName: false
  };
  qiniuUploader.init(options);
}
