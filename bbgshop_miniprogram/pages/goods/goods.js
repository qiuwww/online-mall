var app = getApp();
var WxParse = require('../../lib/wxParse/wxParse.js');
var util = require('../../utils/util.js');
var api = require('../../config/api.js');
const user = require('../../services/user.js');

Page({
  data: {
    route: '',
    id: 0,
    power: 0,
    goods: {},
    gallery: [],
    // attribute: [],
    issueList: [],
    comment: [],
    brand: {},
    collage: [],
    checkedGoods: [],
    specificationList: [],
    productList: [],
    checkgoodsprice: "",
    checkgoodsku: "",
    relatedGoods: [],
    cartGoodsCount: 0,
    userHasCollect: 0,
    showModalStatus: false,
    typec: 0,
    number: 1,
    checkedSpecText: '请选择规格数量',
    openAttr: false,
    noCollectImage: "/image/like.png",
    hasCollectImage: "/image/liked.png",
    collectBackImage: "/image/like.png",
    is_Inviter: 0,
    auth: false,
    isdistribution: false,
    Inviter_locallaster: '',
    Inviter_laster: '',
    Inviter_userid: [],
    CorporateName: '',
  },
  onLoad: function (options) {
    // 页面初始化 options为页面跳转所带来的参数
    var that = this;
    console.log(options)
    wx.showLoading({
      title: '获取中...',
      mask: true,
    })
    if (options.ids) {
      console.log('被分享者进入')
      that.setData({
        is_Inviter: 1,
        id: parseInt(options.id),
        Inviter_userid: JSON.parse(options.ids),
        CorporateName: app.CorporateData.name
      });
      // that.checkdisauth()

    } else {
      console.log('正常用户进入')
      that.setData({
        is_Inviter: 0,
        id: parseInt(options.id),
        CorporateName: app.CorporateData.name
      });
      // that.noraldisauth()
    }
    that.getGoodsInfo();
    util.request(api.CartGoodsCount).then(function (res) {
      if (res.errno === 0) {
        that.setData({
          cartGoodsCount: res.data.cartTotal.goodsCount
        });
      }
    });

  },
  onShareAppMessage: function () {
    let that = this
    console.log(that.data.goods.id)
    console.log(that.data.Inviter_locallaster)
      return {
        title: '贝堡商城',
        desc: that.data.goods.name,
        path: '/pages/goods/goods?id=' + that.data.goods.id + '&ids=' + that.data.Inviter_locallaster,
        imageUrl: '../../image/CorporateData/bbg_share_logo.png',
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
      that.getGoodsInfo()
      user.loginByWeixin().then(res => {
        console.log(res)
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
  getGoodsInfo: function () {
    let that = this;
    util.request(api.GoodsDetail, { id: that.data.id }).then(function (res) {
      console.log(res)
      if (res.errno === 0) {
        that.setData({
          goods: res.data.info,
          collage: res.data.collage,
          checkgoodsprice: res.data.info,
          gallery: res.data.gallery,
          issueList: res.data.issue,
          comment: res.data.comment,
          brand: res.data.brand,
          specificationList: res.data.specificationList,
          productList: res.data.productList,
          userHasCollect: res.data.userHasCollect
        });

        if (res.data.userHasCollect == 1) {
          that.setData({
            'collectBackImage': that.data.hasCollectImage
          });
        } else {
          that.setData({
            'collectBackImage': that.data.noCollectImage
          });
        }

        // if (that.data.is_Inviter == 0){
        //   that.noraldisauth()
        //   // that.checkdisauth()
        // } else if (that.data.is_Inviter == 1){
        //   that.checkdisauth()
        // }
        that.getGoodsRelated();
        that.checkdisauth()
        WxParse.wxParse('goodsDetail', 'html', res.data.info.goods_desc, that);
        // wx.hideLoading()
        console.log(that.goodsDetail)
      }
    });

  },
  getGoodsRelated: function () {
    let that = this;
    util.request(api.GoodsRelated, { id: that.data.id }).then(function (res) {
      if (res.errno === 0) {
        that.setData({
          relatedGoods: res.data.goodsList,
        });
      }
    });
    setTimeout(() => {
      wx.hideLoading()
    },217)
  },
  checkdisauth() {
    let that = this
    // wx.showLoading({
    //   title: '授权检测...',
    //   mask: true,
    // })
    try {
      var value = wx.getStorageSync('auth')
      if (value) {
        if (value) {
          user.loginByWeixin().then(resp => {
            console.log(resp)
            that.setData({
              auth: true,
              userinfo: resp.data.userInfo
            })
            console.log(that.data.Inviter_userid)
            if (that.data.is_Inviter == '0') {
              that.share_distribution()
              console.log('进入用户已授权正常用户')
            } else if (that.data.is_Inviter == '1') {
              try {
                wx.setStorageSync('invitation', JSON.stringify(that.data.Inviter_userid))
                console.log('进入用户为被分享者,已授权，分销信息已存入本地')
              } catch (e) {
                // console.log(e)
              }
              that.share_distribution()
            }
            // if (that.data.Inviter_userid.length == 0){
            //   try {
            //     var value = wx.getStorageSync('invitation')
            //     console.log(value)
            //     if (value) {
            //       console.log("用户授权,读取本地分销缓存")
            //       that.setData({
            //         Inviter_userid: JSON.parse(value)
            //       })
            //     }
            //   } catch (e) {
            //   }
            // }else {
            //   console.log(that.data.Inviter_userid)
            // }
          })
        } else {
          that.setData({
            auth: false
          })
          console.log(that.data.Inviter_userid)
          if (that.data.is_Inviter == '0') {
            that.share_distribution()
            console.log('进入用户未授权正常用户')
          } else if (that.data.is_Inviter == '1') {
            try {
              wx.setStorageSync('invitation', JSON.stringify(that.data.Inviter_userid))
              console.log('进入用户为被分享者,未授权，分销信息已存入本地')
            } catch (e) {
              // console.log(e)
            }
            that.share_distribution()
          }
          // wx.navigateTo({
          //   url: '/pages/AwxChageUserInfoGet/wxChageUserInfoGet',
          //   success: function (res) { },
          //   fail: function (res) { },
          //   complete: function (res) { },
          // })
        }
        // Do something with return value
      }
    } catch (e) {
      // Do something when catch error
    }

  },
  share_distribution() {
    let that = this
    // console.log(e)
    if (that.data.auth) {
      util.request(api.CheckUserIsDistribution, {
        userid: that.data.userinfo.id
      }, 'POST').then(res => {
        console.log(res)
        if (res.errno == 17) {
          that.setData({
            isdistribution: false
          })
        } else if (res.errno == 503) {
          let list = []
          list[0] = res.data[0].user_id
          list[1] = res.data[0].farther_distribution_user_id
          // list[2] = res.data[0].grandpa_distribution_user_id
          // list[3] = res.data[0].grandfather_distribution_user_id
          that.setData({
            isdistribution: true,
            Inviter_laster: res.data[0],
            Inviter_locallaster: JSON.stringify(list)
          })

        }
      })
    } else {
      that.setData({
        isdistribution: false
      })
    }
    wx.hideLoading()
    // that.set_Inviter_Action()
  },
  // set_Inviter_Action() {
  //   let that = this
  //   console.log(that.data.userinfo)
  //   console.log(that.data.Inviter_userid)
  //   try {
  //     wx.setStorageSync('invitation', JSON.stringify(that.data.Inviter_userid))
  //     console.log('分销信息已存入本地')
  //   } catch (e) {
  //     // console.log(e)
  //   }
  //   // util.request(api.SetInviterMaster, {
  //   //   nowuser: that.data.userinfo,
  //   //   pasteruser: that.data.Inviter_userid
  //   // }, 'POST').then(res => {
  //   //   console.log(res)
  //   //   try {
  //   //     wx.removeStorageSync('invitation')
  //   //   } catch (e) {
  //   //     // Do something when catch error
  //   //   }
  //   // })

  // },
  clickSkuValue: function (event) {
    let that = this;
    let specNameId = event.currentTarget.dataset.nameId;
    let specValueId = event.currentTarget.dataset.valueId;

    //判断是否可以点击

    //TODO 性能优化，可在wx:for中添加index，可以直接获取点击的属性名和属性值，不用循环
    let _specificationList = this.data.specificationList;
    for (let i = 0; i < _specificationList.length; i++) {
      if (_specificationList[i].specification_id == specNameId) {
        for (let j = 0; j < _specificationList[i].valueList.length; j++) {
          if (_specificationList[i].valueList[j].id == specValueId) {
            //如果已经选中，则反选
            if (_specificationList[i].valueList[j].checked) {
              _specificationList[i].valueList[j].checked = false;
            } else {
              _specificationList[i].valueList[j].checked = true;
            }
          } else {
            _specificationList[i].valueList[j].checked = false;
          }
        }
      }
    }
    this.setData({
      'specificationList': _specificationList
    });
    //重新计算spec改变后的信息
    this.changeSpecInfo();
    //重新计算哪些值不可以点击
  },

  //获取选中的规格信息
  getCheckedSpecValue: function () {
    let checkedValues = [];
    let _specificationList = this.data.specificationList;
    for (let i = 0; i < _specificationList.length; i++) {
      let _checkedObj = {
        nameId: _specificationList[i].specification_id,
        valueId: 0,
        valueText: ''
      };
      for (let j = 0; j < _specificationList[i].valueList.length; j++) {
        if (_specificationList[i].valueList[j].checked) {
          _checkedObj.valueId = _specificationList[i].valueList[j].id;
          _checkedObj.valueText = _specificationList[i].valueList[j].value;
        }
      }
      checkedValues.push(_checkedObj);
    }

    return checkedValues;

  },
  //根据已选的值，计算其它值的状态
  setSpecValueStatus: function () {

  },
  //判断规格是否选择完整
  isCheckedAllSpec: function () {
    return !this.getCheckedSpecValue().some(function (v) {
      if (v.valueId == 0) {
        return true;
      }
    });
  },
  getCheckedSpecKey: function () {
    let checkedValue = this.getCheckedSpecValue().map(function (v) {
      console.log(v.valueId)
      return v.valueId;
    });

    return checkedValue.reverse().join('_');
  },
  changeSpecInfo: function () {
    var that = this
    let checkedNameValue = this.getCheckedSpecValue();

    //设置选择的信息
    let checkedValue = checkedNameValue.filter(function (v) {
      if (v.valueId != 0) {
        return true;
      } else {
        return false;
      }
    }).map(function (v) {
      return v.valueText;
    });
    if (checkedValue.length > 0) {
      this.setData({
        'checkedSpecText': checkedValue.join('　')
      });
    } else {
      this.setData({
        'checkedSpecText': '请选择规格数量'
      });
    }
    // console.log(checkedValue)
    // console.log(checkedNameValue)

    if (checkedValue.length == checkedNameValue.length) {
      console.log("999999")
      wx.showLoading({
        title: '获取中...',
        mask: true,
      })
      // console.log(this.data.productList)
      var value2 = []
      // var final = ''
      for (var i = 0; i < checkedNameValue.length; i++) {
        // let obj =
        var obj = checkedNameValue[i].valueId
        value2.push(obj)
      }
      console.log(value2)
      let value3 = value2.sort()
      console.log(value3)
      // let ids = value2.join('_')
      util.request(api.FindValues, { data: value3 }, "POST").then(function (res) {
        console.log(res)
        that.setData({
          checkgoodsprice: res.data
          //  checkgoodsku:res.data
          //  checkedProduct
        })
        wx.hideLoading()
        //  console.log(that.data.checkgoodsku)

      });
      // for (var j = 0; j < value2.length;j++){
      //   // console.log(value2)
      //   final = value2[i] + '_'
      // }
    }

  },
  getCheckedProductItem: function (key) {
    // console.log(this.data.productList)
    //  return this.data.productList
    console.log(key)
    return this.data.productList.filter(function (v) {
      //  console.log(v)
      if (v.goods_specification_ids == key) {
        return true;
      } else {
        return false;
      }
    });
  },
  power() {
    let that = this
    console.log(app.globalData.userInfo)
    if (!that.data.auth) {
      that.setData({
        power: 0
      })
    } else {
      that.setData({
        power: 1
      })
    }
    that.checkauth()
  },
  showModal: function () {
    // 显示遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY(600).step()
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
    animation.translateY(600).step()
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
  checkoutOrder: function () {
    var that = this;
    // if (this.data.openAttr == false) {
    //   //打开规格选择窗口
    //   this.setData({
    //     openAttr: !this.data.openAttr,
    //     collectBackImage: "/static/images/detail_back.png"
    //   });
    // } else {

    //提示选择完整规格
    if (!this.isCheckedAllSpec()) {
      wx.showToast({
        title: '选择完整规格！',
        icon: 'none',
        duration: 1500,
      })
      return false;
    }
    //根据选中的规格，判断是否有对应的sku信息
    let checkedProduct = this.getCheckedProductItem(this.getCheckedSpecKey());
    console.log(checkedProduct)
    if (!this.data.checkgoodsprice || this.data.checkgoodsprice.length <= 0) {
      //找不到对应的product信息，提示没有库存
      wx.showToast({
        title: '没有库存！',
        icon: 'none',
        duration: 1500,
      })
      return false;
    }

    //验证库存
    if (this.data.checkgoodsprice.goods_number < this.data.number) {
      //找不到对应的product信息，提示没有库存
      wx.showToast({
        title: '库存不足！',
        icon: 'none',
        duration: 1500,
      })
      return false;
    }
    // console.log("123")
    // console.log(that.data.goods)
    // console.log(that.data)
    // var goodser = that.data.goods
    var checkedGoods = that.data.goods
    //取消购物车商品的选中状态
    util.request(api.CartCheckeder)
      .then(function (res) { });
    //添加到购物车
    console.log(checkedProduct)
    util.request(api.CartAddcopy, { goodsId: this.data.goods.id, number: this.data.number, productId: this.data.checkgoodsprice.id }, "POST")
      .then(function (res) {
        console.log(res)
        if (res.errmsg == 200) {
          wx.switchTab({
            url: '/pages/cart/cart',
            success: function (res) {
              wx.showToast({
                icon: 'none',
                duration: 2500,
                title: '商品已存在购物车中！' + '点击下单即可！'
              });
            },
            fail: function (res) { },
            complete: function (res) { },
          })
          // return false
        } else {
          let _res = res;
          if (_res.errno == 0) {
            wx.showToast({
              title: '添加到购物车！'
            });
            that.setData({
              // openAttr: !that.data.openAttr,
              cartGoodsCount: _res.data.cartTotal.goodsCount
            });
            if (that.data.userHasCollect == 1) {
              that.setData({
                'collectBackImage': that.data.hasCollectImage
              });
            } else {
              that.setData({
                'collectBackImage': that.data.noCollectImage
              });
            }
          } else {
            wx.showToast({
              image: '/static/images/icon_error.png',
              title: _res.errmsg,
              mask: true
            });
          }
          util.request(api.BingPhoneFind,{
            userId: that.data.userinfo.id
          },'POST').then(function (res) {
            console.log(res)
            if (res.data.Result.mobile == "") {
              wx.navigateTo({
                url: '/pages/ucenter/bingphone/bingphone',
                success: function (res) { },
                fail: function (res) { },
                complete: function (res) { },
              })
            } else {
              wx.navigateTo({
                url: '../shopping/checkout/checkout',
              })
            }
          });
        }
      });
  },
  checkauth() {
    let that = this
    // if (that.data.power == 0) {
    //   wx.hideLoading()
    //   wx.navigateTo({
    //     url: '/pages/AwxChageUserInfoGet/wxChageUserInfoGet?route=' + 'pages/goods/goods' + "&data=" + that.data.goods.id,
    //     success: function (res) { },
    //     fail: function (res) { },
    //     complete: function (res) { },
    //   })
    // } else if (that.data.power == 1) {
      wx.showLoading({
        title: '获取信息...',
        mask: true,
      })
      // user.loginByWeixin().then(res => {
        // console.log(res)
        wx.hideLoading()
        that.showModal()
      // }).catch(res => {
        // console.log(res)
      // })
    // }
  },
  checkpower(e) {
    var that = this
    console.log(e)
    let typea = e.currentTarget.dataset.type
    console.log(typea)
    that.setData({
      typec: typea
    })
    wx.showLoading({
      title: '检测授权...',
      mask: true,
    })
    this.power()
  },
  collect() {
    var that = this;
    //提示选择完整规格
    if (!this.isCheckedAllSpec()) {
      wx.showToast({
        title: '选择完整规格！',
        icon: 'none',
        duration: 1500,
      })
      return false;
    }
    //根据选中的规格，判断是否有对应的sku信息
    let checkedProduct = this.getCheckedProductItem(this.getCheckedSpecKey());
    console.log(checkedProduct)
    if (!this.data.checkgoodsprice || this.data.checkgoodsprice.length <= 0) {
      //找不到对应的product信息，提示没有库存
      wx.showToast({
        title: '没有库存！',
        icon: 'none',
        duration: 1500,
      })
      return false;
    }

    //验证库存
    if (this.data.checkgoodsprice.goods_number < this.data.number) {
      //找不到对应的product信息，提示没有库存
      wx.showToast({
        title: '库存不足！',
        icon: 'none',
        duration: 1500,
      })
      return false;
    }
    util.request(api.BingPhoneFind, {
      userId: that.data.userinfo.id
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
        // console.log(this.data.checkgoodsprice)
        wx.showModal({
          title: '提示',
          content: '规格选择后无法更改（谨慎操作！）',
          success: function (res) {
            if (res.confirm) {
              wx.navigateTo({
                url: '/pages/collagecheckout/collagecheckout?collageid=' + that.data.collage[0].id + "&goodsid=" + that.data.goods.id + "&skuid=" + that.data.checkgoodsprice.id + "&skuvalue=" + that.data.checkedSpecText,
                success: function (res) { },
                fail: function (res) { },
                complete: function (res) { },
              })
            }
          },
          fail: function (res) { },
          complete: function (res) { },
        })
      }
    });

  },
  onReady: function () {
    // 页面渲染完成

  },
  onShow: function () {
    // 页面显示
    this.hideModal()
  },
  onHide: function () {
    // 页面隐藏

  },
  onUnload: function () {
    // 页面关闭

  },
  switchAttrPop: function () {
    if (this.data.openAttr == false) {
      this.setData({
        openAttr: !this.data.openAttr,
        collectBackImage: "/static/images/detail_back.png"
      });
    }
  },
  closeAttrOrCollect: function () {
    let that = this;
    // wx.showLoading({
    //   title: '授权检测...',
    //   mask: true
    // })
    // if (!that.data.auth) {
    //   wx.navigateTo({
    //     url: '/pages/AwxChageUserInfoGet/wxChageUserInfoGet?route=' + that.data.route + "&data=" + that.data.goods.id,
    //     success: function (res) { },
    //     fail: function (res) { },
    //     complete: function (res) { },
    //   })
    // } else {
      util.request(api.CollectAddOrDelete, { typeId: 0, valueId: that.data.id }, "POST").then(function (res) {
        let _res = res;
        wx.hideLoading()
        if (_res.errno == 0) {
          if (_res.data.type == 'add') {
            that.setData({
              'collectBackImage': that.data.hasCollectImage
            });
            wx.showToast({
              title: '收藏成功！',
              icon: 'success',
              image: '',
              duration: 1000,
              mask: true,
            })
          } else {
            wx.showToast({
              title: '取消收藏！',
              icon: 'success',
              image: '',
              duration: 500,
              mask: true,
            })
            that.setData({
              'collectBackImage': that.data.noCollectImage
            });
          }

        } else {
          wx.showToast({
            image: '/static/images/icon_error.png',
            title: _res.errmsg,
            mask: true
          });
        }
      })
    // }
  },
  openCartPage: function () {
    wx.switchTab({
      url: '/pages/cart/cart',
    });
  },
  addToCart: function () {
    var that = this;
    wx.showLoading({
      title: '加载中...',
    })
    // if (this.data.openAttr == false) {
    //   //打开规格选择窗口
    //   this.setData({
    //     openAttr: !this.data.openAttr,
    //     collectBackImage: "/static/images/detail_back.png"
    //   });
    // } else {

    //提示选择完整规格
    if (!this.isCheckedAllSpec()) {
      wx.showToast({
        title: '选择完整规格！',
        icon: 'none',
        duration: 1500,
      })
      return false;
    }

    //根据选中的规格，判断是否有对应的sku信息
    let checkedProduct = this.getCheckedProductItem(this.getCheckedSpecKey());
    console.log()
    if (!this.data.checkgoodsprice || this.data.checkgoodsprice.length <= 0) {
      //找不到对应的product信息，提示没有库存
      wx.showToast({
        title: '没有库存！',
        icon: 'none',
        duration: 1500,
      })
      return false;
    }

    //验证库存
    if (this.data.checkgoodsprice.goods_number < this.data.number) {
      //找不到对应的product信息，提示没有库存
      wx.showToast({
        title: '库存不足！',
        icon: 'none',
        duration: 1500,
      })
      return false;
    }
    // user.loginByWeixin().then(res => {
    //   app.globalData.userInfo = res.data.userInfo;
    //   app.globalData.token = res.data.token;
    util.request(api.CartAdd, { goodsId: this.data.goods.id, number: this.data.number, productId: this.data.checkgoodsprice.id }, "POST")
      .then(function (res) {
        let _res = res;
        if (_res.errno == 0) {
          wx.showToast({
            title: '添加成功'
          });
          that.hideModal()
          that.setData({
            // openAttr: !that.data.openAttr,
            cartGoodsCount: _res.data.cartTotal.goodsCount
          });
          if (that.data.userHasCollect == 1) {
            that.setData({
              'collectBackImage': that.data.hasCollectImage
            });
          } else {
            that.setData({
              'collectBackImage': that.data.noCollectImage
            });
          }
        } else {
          wx.showToast({
            image: '/static/images/icon_error.png',
            title: _res.errmsg,
            mask: true
          });
        }

      });
  },
  cutNumber: function () {
    this.setData({
      number: (this.data.number - 1 > 1) ? this.data.number - 1 : 1
    });
  },
  addNumber: function () {
    this.setData({
      number: this.data.number + 1
    });
  },
  toindex() {
    wx.switchTab({
      url: '/pages/index/index',
      success: function (res) { },
      fail: function (res) { },
      complete: function (res) { },
    })
  },
  openCustomerPage() {
    wx.navigateTo({
      url: '/pages/ucenter/customer/customer',
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  canelCart() {
    this.hideModal()
  }
})
