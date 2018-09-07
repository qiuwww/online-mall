// pages/Resagin_bargain/Resagin_bargain.js
var util = require('../../utils/util.js');
var api = require('../../config/api.js');
const user = require('../../services/user.js');

var app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    is_userInfo: false,//本地是否有用户数据缓存
    auth: false,
    bargainList: [], //所有砍价商品的列表
    userBargainList: [], //用户参与的砍价列表
    userInfo: {}, //用户信息
    activeTab: 0, //底部tabbar选中的索引，默认为0
    showSkeleton: true, //显示布局骨架
    showSkuModalStatus: false, //商品的sku弹层显示
    animationSkuData: {}, //商品sku弹层的动画
    checkedSpecText: ' 请选择规格 ',
    specificationList: [], //商品的规格键值对
    productList: [], //商品的所有规格种类
    checkgoods: {}, //选择的商品的信息 显示在sku头部
    thisbargoods: {}, //用户选择的砍价商品的信息
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function(options) {
    //判断授权
    wx.showLoading({
      title: '跳转中...',
      mask: true,
    })
    let that = this
    try {
      var value = wx.getStorageSync('userInfo')
      if (value) {
        that.setData({
          userInfo: value,
          is_userInfo: true
        })
        that.getBargainList()
        // Do something with return value
      } else {
        // wx.showToast({
        //   title: '数据异常 !',
        //   icon: 'none',
        //   duration: 2000,
        //   mask: true,
        // })
        wx.hideLoading()
        wx.showModal({
          title: '提示 ！',
          content: '系统检测您为新用户，新用户需要授权才能参与砍价，点击确认按钮后点击屏幕任意位置获取授权，否则将会产生不可估计的错误。',
          success: function(res) {
          },
          fail: function(res) {},
          complete: function(res) {},
        })
      }
    } catch (e) {
      wx.showToast({
        title: '数据异常 ！ 请退出 ！',
        icon: 'none',
        duration: 2000,
        mask: true,
      })
      // Do something when catch error
    }
  },
  //授权
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
        auth: true,
        is_userInfo: true
      })
      // that.getGoodsInfo()
      user.loginByWeixin().then(res => {
        console.log(res)
        that.setData({
          userInfo: res.data.userInfo
        })
        that.getBargainList()
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
  //获取砍价的商品列表
  getBargainList() {
    wx.showLoading({
      title: '获取中...',
      mask: true,
    })
    let that = this
    util.request(api.BargainList).then(function(res) {
      console.log(res)
      if (res.errno === 0) {
        that.setData({
          bargainList: res.data.data,
          showSkeleton: false
        })
        that.getUserBarList()
      } else {
        setTimeout(function() {
          wx.hideLoading()
          that.setData({
            showSkeleton: false
          })
        }, 500)
      }
      console.log(that.data.bargainList)
    });
  },
  //获取用户砍价的列表
  getUserBarList() {
    let that = this
    wx.showLoading({
      title: '获取中...',
      mask: true,
    })
    util.request(api.UserBargainList, {
      userId: that.data.userInfo.id
    }, 'POST').then(res => {
      console.log(res.data.data)
      that.setData({
        userBargainList: res.data.data,
        showSkeleton: false
      })
      wx.hideLoading()
      that.setTimeloop()
    })

  },
  //倒计时循环
  setTimeloop() {
    var that = this
    var loop = setInterval(function () {
      for (var i = 0; i < that.data.userBargainList.length; i++) {
        var list = that.data.userBargainList[i]
        if (parseInt(list.end_time) - new Date().getTime() < 0) {
          list.listtime = "0"
        } else {
          var time = parseInt(list.end_time) - new Date().getTime()
          list.listtime = util.timestampToDate(time)
        }
      }
      that.setData({
        userBargainList: that.data.userBargainList
      })
    }, 1000)
  },
  //底部tabbar的改变事件
  changeActiveTab(e) {
    // console.log()
    let that = this
    let index = e.currentTarget.dataset.index
    if (index == 0) {
      that.setData({
        activeTab: index,
      })
      that.getBargainList()
    } else if (index == 1) {
      that.setData({
        // showSkeleton: true,
        activeTab: index,
      })
      that.getUserBarList()
    }
  },
  // 以下为‘我的砍价’页面函数

  //点击付款按钮
  payCut_Btn(e) {
    let barid = e.currentTarget.dataset.barid
    util.request(api.FindBargainOrderInfo,{
      barid: barid
    },'POST').then(res => {
      console.log(res)
      if (res.errno === 0) {
        wx.navigateTo({
          url: '/pages/pay/pay?Price=' + res.data.price + '&orderId=' + res.data.order_sn + '&payId=1',
          success: function(res) {},
          fail: function(res) {},
          complete: function(res) {},
        })
      }
    })
  },
  //点击继续砍价
  continueCut_Btn(e) {
    let barid = e.currentTarget.dataset.barid
    wx.navigateTo({
      url: '/pages/Resagin_bargain_goods/Resagin_bargain_goods?id=' + barid,
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  //砍价商品页面点击砍价按钮
  launchBargain(e) {
    let that = this
    wx.showLoading({
      title: '核实中...',
      mask: true,
    })
    console.log(e.currentTarget.dataset.bargainid)
    let barId = e.currentTarget.dataset.bargainid
    let goodsId = e.currentTarget.dataset.goodsid
    // 查找用户是否参与过此条砍价 FindUserIsCut
    util.request(api.FindUserIsCut, {
      userId: that.data.userInfo.id,
      barId: barId
    }, 'POST').then(res => {
      console.log(res)
      if(res.errno === 17) {
        wx.hideLoading()
        wx.showToast({
          title: res.errmsg,
          icon: 'none',
          duration: 1500,
          mask: true,
        })
      } else if(res.errno === 0){
      wx.hideLoading()
      that.showSkuMask(goodsId, barId)
      }
    })
  },
  //打开弹层时查找商品的规格
  FindGoodsSkuInfo(id) {
    var that = this
    console.log(id)
    var goodsid = id
    util.request(api.FindGoodSku, {
      id: goodsid
    }).then(res => {
      console.log(res)
      that.setData({
        checkgoods: res.data.goodsinfo,
        specificationList: res.data.specificationList,
        productList: res.data.productList,
      })
    })
  },
  //选择规格时查询价格
  SkuPriceInfo(barId) {
    var that = this
    // wx.showLoading({
    //   title: '获取中...',
    //   mask: true,
    // })
    util.request(api.FindBargainById, {
      id: barId
    }, 'POST').then(function(res) {
      console.log(res.data.data)
      that.setData({
        thisbargoods: res.data.data
      })
      // wx.hideLoading()
    });
  },
  //确定发起砍价
  skuSure() {
    //提示选择完整规格
    var that = this
    console.log(that.isCheckedAllSpec())
    if (!that.isCheckedAllSpec()) {
      wx.showToast({
        title: '选择完整规格！',
        icon: 'none',
        duration: 1500,
      })
      return false;
    }
    //根据选中的规格，判断是否有对应的sku信息
    let checkedProduct = that.getCheckedProductItem(that.getCheckedSpecKey());
    // console.log(checkedProduct)
    if (!that.data.checkgoods || that.data.checkgoods.length <= 0) {
      //找不到对应的product信息，提示没有库存
      wx.showToast({
        title: '没有库存！',
        icon: 'none',
        duration: 1500,
      })
      return false;
    }

    //验证库存
    if (that.data.checkgoods.goods_number < 1) {
      //找不到对应的product信息，提示没有库存
      wx.showToast({
        title: '库存不足！',
        icon: 'none',
        duration: 1500,
      })
      return false;
    }
    if (that.data.checkgoods == {}) {
      wx.showToast({
        title: '异常！请重试！',
        icon: 'none',
        duration: 1500,
      })
    }
    wx.showModal({
      title: '提示！',
      content: '是否确认发起 ' + that.data.thisbargoods.goods_name + "*****" + that.data.checkedSpecText + "*****款的砍价，发起后砍价商品和规格不可更改！",
      success: function(res) {
        if (res.confirm) {
          console.log(that.data.checkgoods)
          util.request(api.SetUserLaunchBargain, {
            userInfo: that.data.userInfo,
            bargoods: that.data.thisbargoods,
            skuInfo: that.data.checkgoods,
            skuValue: that.data.checkedSpecText
          }, 'POST').then(res => {
            console.log(res)
            if(res.errno === 0) {
              wx.showToast({
                title: '发起成功 ！ 跳转中！',
                icon: 'none',
                duration: 1500,
                mask: true,
              })
              wx.navigateTo({
                url: '/pages/Resagin_bargain_goods/Resagin_bargain_goods?id=' + res.data,
                success: function(res) {},
                fail: function(res) {},
                complete: function(res) {},
              })
              // that.SetUserLaunchCut()
            }else {
              wx.showToast({
                title: '发起失败 ！',
                icon: 'none',
                duration: 1500,
                mask: true,
              })
            }
          })
        }
      },
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  // //用户发起时的第一次砍价 
  // SetUserLaunchCut() {
  //   let that = this
  //   wx.showLoading({
  //     title: '砍价中...',
  //     mask: true,
  //   })


  // },
  //显示选择商品的sku弹层
  showSkuMask(goodsId, barId) {
    // var id = e.target.dataset.goodsid
    // var barid = e.target.dataset.barid
    this.FindGoodsSkuInfo(goodsId)
    this.SkuPriceInfo(barId)
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY(500).step()
    this.setData({
      checkedSpecText: ' 请选择规格 ',
      animationSkuData: animation.export(),
      showSkuModalStatus: true
    })
    setTimeout(function() {
      animation.translateY(0).step()
      this.setData({
        animationSkuData: animation.export()
      })
    }.bind(this), 200)
  },
  hideSkuModal: function() {
    // 隐藏遮罩层
    var animation = wx.createAnimation({
      duration: 200,
      timingFunction: "linear",
      delay: 0
    })
    this.animation = animation
    animation.translateY(500).step()
    this.setData({
      animationSkuData: animation.export(),
    })
    setTimeout(function() {
      animation.translateY(0).step()
      this.setData({
        animationSkuData: animation.export(),
        showSkuModalStatus: false
      })
    }.bind(this), 200)
    // this.setData({
    //   specificationList: [],
    //   productList: []
    // })
  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function() {

  },
  // 以下为sku点击判断事件
  clickSkuValue: function(event) {
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
  getCheckedSpecValue: function() {
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
  setSpecValueStatus: function() {

  },
  //判断规格是否选择完整
  isCheckedAllSpec: function() {
    return !this.getCheckedSpecValue().some(function(v) {
      console.log(v)
      if (v.valueId == 0) {
        return true;
      }
    });
  },
  getCheckedSpecKey: function() {
    let checkedValue = this.getCheckedSpecValue().map(function(v) {
      console.log(v.valueId)
      return v.valueId;
    });

    return checkedValue.reverse().join('_');
  },
  changeSpecInfo: function() {
    var that = this
    let checkedNameValue = this.getCheckedSpecValue();

    //设置选择的信息
    let checkedValue = checkedNameValue.filter(function(v) {
      if (v.valueId != 0) {
        return true;
      } else {
        return false;
      }
    }).map(function(v) {
      return v.valueText;
    });
    if (checkedValue.length > 0) {
      this.setData({
        'checkedSpecText': checkedValue.join('/')
      });
    } else {
      this.setData({
        'checkedSpecText': '请选择规格'
      });
    }
    // console.log(checkedValue)
    // console.log(checkedNameValue)

    if (checkedValue.length == checkedNameValue.length) {
      // console.log("999999")
      var value2 = []
      for (var i = 0; i < checkedNameValue.length; i++) {
        var obj = checkedNameValue[i].valueId
        value2.push(obj)
      }
      value2 = value2.sort()
      console.log(value2)
      util.request(api.FindBarValues, {
        data: value2
      }, "POST").then(function(res) {
        console.log(res)
        that.setData({
          checkgoods: res.data
        })
      });

      // for (var j = 0; j < value2.length;j++){
      //   // console.log(value2)
      //   final = value2[i] + '_'
      // }
      // console.log(final)
    }

  },
  getCheckedProductItem: function(key) {
    // console.log(this.data.productList)
    //  return this.data.productList
    console.log(key)
    return this.data.productList.filter(function(v) {
      if (v.goods_specification_ids == key) {
        return true;
      } else {
        return false;
      }
    });
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function() {
    this.hideSkuModal()
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