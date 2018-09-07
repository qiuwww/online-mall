var util = require('../../utils/util.js');
var api = require('../../config/api.js');
const user = require('../../services/user.js');


var app = getApp();

Page({
  data: {
    cartGoods: [],
    cartTotal: {
      "goodsCount": 0,
      "goodsAmount": 0.00,
      "checkedGoodsCount": 0,
      "checkedGoodsAmount": 0.00
    },
    isEditCart: false,
    checkedAllStatus: true,
    editCartList: [],
    auth:false,
  },
  onLoad: function (options) {
    // 页面初始化 options为页面跳转所带来的参数
    // console.log(options)
    wx.showLoading({
      title: '获取中...',
      mask: true,
    })

  },
  onReady: function () {
    // 页面渲染完成

  },
  onShow: function () {
    // 页面显示
    // if (this.data.isEditCart == true) {
    //   wx.showToast({
    //     title: '处于编辑状态！',
    //     icon: 'none',
    //     duration: 2000,
    //   })
    // }
    this.goLogin()
    this.getCartList();
  },
  onHide: function () {
    // 页面隐藏
    this.setData({
      isEditCart: false
    })
  },
  goLogin() {
    let that = this
    try {
      var value = wx.getStorageSync('auth')
      console.log(value)
      if (value) {
        that.setData({
          auth: true
        })
        that.data.cartGoods = []
        that.data.cartTotal = []
        util.request(api.CartList).then(function (res) {
          if (res.errno === 0) {
            console.log(res.data);
            that.setData({
              cartGoods: res.data.cartList,
              cartTotal: res.data.cartTotal
            });
          }
          that.setData({
            checkedAllStatus: that.isCheckedAll()
          });
        })
        // user.loginByWeixin().then(res => {
        //   console.log(res)
        //   that.setData({
        //     userinfo: res.data
        //   })
        //   wx.hideLoading()
        //   app.globalData.userInfo = res.data.userInfo;
        //   app.globalData.token = res.data.token;
        // })
        // Do something with return value
      } else {
        that.setData({
          auth: false
        })
        // that.selectjoinpeople()
        wx.hideLoading()
      }
    } catch (e) {
      // Do something when catch error
    }
  },
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
        that.goLogin()
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
  onUnload: function () {
    // 页面关闭
    this.setData({
      isEditCart: false
    })
    // util.request(api.CartCheckeder).then(res => {
    //   console.log(res)
    // });
  },
  getCartList: function () {

    let that = this;
    util.request(api.CartList).then(function (res) {
      if (res.errno === 0) {
        console.log(res.data);
        that.setData({
          cartGoods: res.data.cartList,
          cartTotal: res.data.cartTotal
        });
      }

      that.setData({
        checkedAllStatus: that.isCheckedAll()
      });
      wx.hideLoading()
    });
  },
  isCheckedAll: function () {
    //判断购物车商品已全选
    return this.data.cartGoods.every(function (element, index, array) {
      if (element.checked == true) {
        return true;
      } else {
        return false;
      }
    });
  },
  // stopEvt(event){
  //   console.log(event)
  //   event.stopPropagation()
  // },
  checkedItem: function (event) {
    // console.log(event)
    wx.showLoading({
      title: '获取中...',
      mask: true,
    })
    let itemIndex = event.target.dataset.itemIndex ? event.target.dataset.itemIndex : event.currentTarget.dataset.itemIndex;
    // console.log(itemIndex)
    let that = this;

    if (!this.data.isEditCart) {
      util.request(api.CartChecked, { productIds: that.data.cartGoods[itemIndex].product_id, isChecked: that.data.cartGoods[itemIndex].checked ? 0 : 1 }, 'POST').then(function (res) {
        if (res.errno === 0) {
          console.log(res.data);
          that.setData({
            cartGoods: res.data.cartList,
            cartTotal: res.data.cartTotal
          });
        }

        that.setData({
          checkedAllStatus: that.isCheckedAll()
        });
      });
    } else {
      //编辑状态
      let tmpCartData = this.data.cartGoods.map(function (element, index, array) {
        if (index == itemIndex) {
          element.checked = !element.checked;
        }

        return element;
      });

      that.setData({
        cartGoods: tmpCartData,
        checkedAllStatus: that.isCheckedAll(),
        'cartTotal.checkedGoodsCount': that.getCheckedGoodsCount()
      });
    }
    wx.hideLoading()
  },
  getCheckedGoodsCount: function () {
    let checkedGoodsCount = 0;
    this.data.cartGoods.forEach(function (v) {
      if (v.checked === true) {
        checkedGoodsCount += v.number;
      }
    });
    console.log(checkedGoodsCount);
    return checkedGoodsCount;
  },
  checkedAll: function () {
    let that = this;
    wx.showLoading({
      title: '获取中...',
      mask: true,
    })
    if (!this.data.isEditCart) {
      var productIds = this.data.cartGoods.map(function (v) {
        return v.product_id;
      });
      util.request(api.CartChecked, { productIds: productIds.join(','), isChecked: that.isCheckedAll() ? 0 : 1 }, 'POST').then(function (res) {
        if (res.errno === 0) {
          console.log(res.data);
          that.setData({
            cartGoods: res.data.cartList,
            cartTotal: res.data.cartTotal
          });
        }

        that.setData({
          checkedAllStatus: that.isCheckedAll()
        });
        wx.hideLoading()
      });
    } else {
      //编辑状态
      let checkedAllStatus = that.isCheckedAll();
      let tmpCartData = this.data.cartGoods.map(function (v) {
        v.checked = !checkedAllStatus;
        wx.hideLoading()
        return v;
      });

      that.setData({
        cartGoods: tmpCartData,
        checkedAllStatus: that.isCheckedAll(),
        'cartTotal.checkedGoodsCount': that.getCheckedGoodsCount()
      });
    }

  },
  editCart: function () {
    var that = this;
    if (this.data.isEditCart) {
      this.getCartList();
      this.setData({
        isEditCart: !this.data.isEditCart
      });
    } else {
      //编辑状态
      let tmpCartList = this.data.cartGoods.map(function (v) {
        v.checked = false;
        return v;
      });
      this.setData({
        editCartList: this.data.cartGoods,
        cartGoods: tmpCartList,
        isEditCart: !this.data.isEditCart,
        checkedAllStatus: that.isCheckedAll(),
        'cartTotal.checkedGoodsCount': that.getCheckedGoodsCount()
      });
    }

  },
  updateCart: function (productId, goodsId, number, id) {
    let that = this;

    util.request(api.CartUpdate, {
      productId: productId,
      goodsId: goodsId,
      number: number,
      id: id
    }, 'POST').then(function (res) {
      if (res.errno === 0) {
        console.log(res.data);
        that.setData({
          //cartGoods: res.data.cartList,
          //cartTotal: res.data.cartTotal
        });
      }

      that.setData({
        checkedAllStatus: that.isCheckedAll()
      });
    });

  },
  cutNumber: function (event) {

    let itemIndex = event.target.dataset.itemIndex;
    let cartItem = this.data.cartGoods[itemIndex];
    let number = (cartItem.number - 1 > 1) ? cartItem.number - 1 : 1;
    cartItem.number = number;
    this.setData({
      cartGoods: this.data.cartGoods
    });
    this.updateCart(cartItem.product_id, cartItem.goods_id, number, cartItem.id);
  },
  addNumber: function (event) {
    let itemIndex = event.target.dataset.itemIndex;
    let cartItem = this.data.cartGoods[itemIndex];
    let number = cartItem.number + 1;
    cartItem.number = number;
    this.setData({
      cartGoods: this.data.cartGoods
    });
    this.updateCart(cartItem.product_id, cartItem.goods_id, number, cartItem.id);

  },
  checkoutOrder: function () {
    //获取已选择的商品
    let that = this;

    var checkedGoods = this.data.cartGoods.filter(function (element, index, array) {
      if (element.checked == true) {
        return true;
      } else {
        return false;
      }
    });

    if (checkedGoods.length <= 0) {
      return false;
    }
    util.request(api.BingPhoneFind, {
      userId: app.globalData.userInfo.id
    }, 'POST').then(function (res) {
      console.log(res)
      if (res.data.Result.mobile == "") {
        wx.navigateTo({
          url: '/pages/ucenter/bingphone/bingphone',
          success: function (res) { },
          fail: function (res) { },
          complete: function (res) { },
        })
      } else {
        wx.showLoading({
          title: '核实规格...',
          mask: true,
        })
        that.checkcartsku(checkedGoods)
        // wx.navigateTo({
        //   url: '../shopping/checkout/checkout',
        // })
      }
    })
  },
  checkcartsku(checkedGoods) {
    console.log(checkedGoods)
    var that = this
    util.request(api.CartCheckSku, {
      checkedGoods: checkedGoods
    }, 'POST').then(res => {
      console.log(res)
      wx.hideLoading()
      let chagesku = res.data
      if (chagesku.length == 0) {
        wx.navigateTo({
          url: '../shopping/checkout/checkout',
        })
      } else {
        // console.log("9999999")
        let data = ''
        let ids = ''
        for (var i = 0; i < chagesku.length; i++) {
          console.log(i)
          data = chagesku[i].goods_name + ',' + data,
            ids = chagesku[i].product_id + ','
        }
        wx.showModal({
          title: '提示',
          content: '当前选择商品中' + data + "的库存已发生改变，下单失败！，点击确定将会删除库存改变的商品！",
          success: function (res) {
            if (res.confirm) {
              util.request(api.CartDelete, {
                productIds: ids
              }, 'POST').then(res => {
                console.log(res)
                if (res.errno === 0) {
                  console.log(res.data);
                  let cartList = res.data.cartList.map(v => {
                    console.log(v);
                    v.checked = false;
                    return v;
                  });

                  that.setData({
                    cartGoods: cartList,
                    cartTotal: res.data.cartTotal
                  });
                }
              })
            }
          },
          fail: function (res) { },
          complete: function (res) { },
        })
      }
    })
  },
  deleteCart: function () {
    //获取已选择的商品
    let that = this;
    wx.showModal({
      title: '警告！',
      content: '是否删除选中商品？',
      success: function (res) {
        if (res.confirm) {
          let productIds = that.data.cartGoods.filter(function (element, index, array) {
            if (element.checked == true) {
              return true;
            } else {
              return false;
            }
          });

          if (productIds.length <= 0) {
            return false;
          }

          productIds = productIds.map(function (element, index, array) {
            if (element.checked == true) {
              return element.product_id;
            }
          });


          util.request(api.CartDelete, {
            productIds: productIds.join(',')
          }, 'POST').then(function (res) {
            if (res.errno === 0) {
              console.log(res.data);
              let cartList = res.data.cartList.map(v => {
                console.log(v);
                v.checked = false;
                return v;
              });

              that.setData({
                cartGoods: cartList,
                cartTotal: res.data.cartTotal
              });
            }

            that.setData({
              checkedAllStatus: that.isCheckedAll()
            });
          });
          // console.log('用户点击确定')
        } else if (res.cancel) {
          console.log('用户点击取消')
        }
      }
    })

  }
})