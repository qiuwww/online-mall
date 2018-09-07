// pages/ucenter/distribution/distribution.js
var WxParse = require('../../../lib/wxParse/wxParse.js');
var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');
var user = require('../../../services/user.js');

const app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    AreacodeArray_index: 215,//区号下标
    AreacodeArray: [],//区号列表
    AllAreacodeArray: [],
    userInfo: {},
    add_local_time: '0000/00/00',
    auth:false,
    is_apply: 0,
    distributionInfo: [],
    disgoods: [],
    discatch: [],
    show_mask: false,
    inputMobile: '',
    inputcode: '',
    truesode: '',
    second: 45,
    truesode: 0,
    cancatch: false,
    codeloading: false,
    codedisabled: false,
    checkdisabled: true,
    sendcodetext: " 获取验证码 ",
    changeisabled: false,
    selectedcountry: {},
    show_simple_box: false,
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.onloadaction()
  },
  onloadaction() {
    let that = this
    wx.showLoading({
      title: '检测中...',
      mask: true,
    })
    that.getDisRules()
    // 查看是否授权
    wx.getSetting({
      success: function (res) {
        if (res.authSetting['scope.userInfo']) {
          // 已经授权，可以直接调用 getUserInfo 获取头像昵称
          wx.getUserInfo({
            success: function (res) {
              console.log(res.userInfo)
              user.loginByWeixin().then(res => {
                console.log(res)
                that.setData({
                  auth: true,
                  userInfo: res.data.userInfo
                })
                that.finddistribinfo()
                wx.hideLoading()
              })

            }
          })
        } else {
          that.setData({
            auth: false,
          })
          wx.hideLoading()
        }
      }
    })
  },
  bindPickerChange(e) {
    console.log(e)
    let that = this
      this.setData({
        AreacodeArray_index: e.detail.value,
        selectedcountry: that.data.AllAreacodeArray[e.detail.value]
      })
  },
  getcountrycode(){
    let that = this
    util.request(api.GetCountryCode).then(res => {
      console.log(res)
      if (res.errno == 0) {
        for (let i = 0; i < res.data.length;i++){
          // console.log(i)
          that.data.AreacodeArray.push(" [ " + res.data[i].country_code + ' ] ' + res.data[i].country_name_chinese + '-' + res.data[i].country_name_english)
        } 
        that.setData({
          AreacodeArray: that.data.AreacodeArray,
          AllAreacodeArray: res.data,
          selectedcountry: res.data[that.data.AreacodeArray_index]
        })
      } else {
        wx.showToast({
          title: '获取失败 ！',
          icon: 'none',
          duration: 2000,
        })
      }

    })
    
  },
  getDisRules() {
    let that = this
    util.request(api.GetDisRules, {

    }, 'POST').then(res => {
      console.log(res)
      // that.setData({
      //   rules_text: res.data.rules_text
      // })
      WxParse.wxParse('rulestext', 'html', res.data.rules_text, that);
    })
  },
  tocatch() {
    // console.log('9987897987')
    wx.navigateTo({
      url: '/pages/ucenter/distribution_catch/distribution_catch',
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
  },
  see_simple() {
    console.log('123456798')
    let that = this
    that.setData({
      show_simple_box: true
    })
  },
  close_mask() {
    let that = this
    that.setData({
      show_simple_box: false
    })
  },
  seerule() {
    console.log('123456798')
  },
  finddistribinfo() {
    let that = this
    util.request(api.FindDistributionInfo,{
      orderId: that.data.userInfo.id
    },'POST').then(res => {
      console.log(res)
      if(res.errno === 17){
        that.setData({
          is_apply: 1
        })
      } else if (res.errno === 503){
        that.setData({
          is_apply: 0,
          distributionInfo: res.errmsg.disdata,
          disgoods: res.errmsg.disgoods.reverse(),
          discatch: res.errmsg.discatch.reverse(),
        })
        that.setaddTime()
      } else if (res.errno === 99) {
        that.setData({
          is_apply: 2,
          // distributionInfo: res.errmsg[0]
        })
      }
    })
  },
  setaddTime() {
    let that = this
    let time = util.timestampToTime(that.data.distributionInfo[0].add_time)
    for (let i = 0; i < that.data.disgoods.length; i++){
      var list = that.data.disgoods[i]
      list.add_localtime = util.timestampToTime(list.add_time)
      // console.log(that.data.disgoods[i].add_localtime)
    }
    that.data.distributionInfo[0].localrate = Number(that.data.distributionInfo[0].rate * 1).toFixed(2)
    that.data.distributionInfo[0].localprice = Number(that.data.distributionInfo[0].price * 1).toFixed(2)
    if (Number(that.data.distributionInfo[0].localprice) > Number(that.data.distributionInfo[0].can_withdraw_cash)){
      that.setData({
        cancatch: false
      })
    }else {
      that.setData({
        cancatch: true
      })
    }
    for( let j = 0;j < that.data.discatch.length; j++){
      var listt = that.data.discatch[j]
      listt.add_localtime = util.timestampToTime(list.add_time)
    } 
    that.setData({
      add_local_time: time,
      distributionInfo: that.data.distributionInfo,
      disgoods: that.data.disgoods,
      discatch: that.data.discatch
    })


  },
  phoneinput(e) {
    // console.log(e.detail.value)
    this.setData({
      inputMobile: e.detail.value
    })
  },
  codeinput(e) {
    // console.log(e.detail.value)
    this.setData({
      inputcode: e.detail.value
    })
  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
  
  },
  hide_model() {
    this.setData({
      show_mask:false
    })
  },
  becomedistribution() {
    let that = this
    util.request(api.BingPhoneFind, {
      userId: that.data.userInfo.id
    }, 'POST').then(function (res) {
      console.log(res)
      let resule = res.data
      if (resule.Result.mobile == "") {
        wx.navigateTo({
          url: '/pages/ucenter/bingphone/bingphone',
          success: function (res) { },
          fail: function (res) { },
          complete: function (res) { },
        })
      } else {
        wx.showModal({
          title: '提示',
          content: '当您点击确认即视为同意成为志愿者的条件，并向我们发出成为志愿者的申请，我们将在一个工作日之内处理您的请求 ！',
          success: function(res) {
            if(res.confirm){
              wx.showLoading({
                title: '提交申请...',
                mask: true,
              })
              setTimeout(() => {
                util.request(api.ApplyDistribution, {
                  phone: resule.Result.mobile,
                  selectedcountry: resule.selectedcountry,
                  userid: that.data.userInfo.id
                }, 'POST').then(ress => {
                  console.log(ress)
                  that.finddistribinfo()
                  that.hide_model()
                })
                util.request(api.BingPhoneFind,{
                  userId: that.data.userInfo.id
                },'POST').then(function (resd) {
                  console.log(resd)
                  that.setData({
                    userInfo: resd.data.Result
                  })
                  wx.hideLoading()
                  wx.showToast({
                    title: '志愿者申请已提交 ！',
                    icon: 'none',
                    duration: 2000
                  })
                });
              }, 1000)
            }
          },
          fail: function(res) {},
          complete: function(res) {},
        })
        
        // console.log(this.data.checkgoodsprice)
        // wx.showModal({
        //   title: '提示',
        //   content: '规格选择后无法更改（谨慎操作！）',
        //   success: function (res) {
        //     if (res.confirm) {
        //       wx.navigateTo({
        //         url: '/pages/collagecheckout/collagecheckout?collageid=' + that.data.collage[0].id + "&goodsid=" + that.data.goods.id + "&skuid=" + that.data.checkgoodsprice.id + "&skuvalue=" + that.data.checkedSpecText,
        //         success: function (res) { },
        //         fail: function (res) { },
        //         complete: function (res) { },
        //       })
        //     }
        //   },
        //   fail: function (res) { },
        //   complete: function (res) { },
        // })
      }
    });
    // that.getcountrycode()
    // that.setData({
    //   show_mask: true
    // })
    // util.request(api.SetDistriUser, {}, 'POST').then(res => {
    //   console.log(res)
    //   that.finddistribinfo()
    // })
  },
  // getcode() {
  //   var that = this
  //   if (this.data.inputMobile == "") {
  //     wx.showToast({
  //       title: '请先输入手机号 ！',
  //       icon: 'none',
  //       duration: 1000,
  //       mask: true,
  //     })
  //     // return false;
  //   } else {
  //     util.request(api.BingPhoneText, {
  //       Phone: that.data.inputMobile,
  //       selectedcountry: that.data.selectedcountry
  //     }, 'POST').then(function (res) {
  //       console.log(res)
  //       if (res.errno === 1001) {
  //         wx.showToast({
  //           title: '手机号格式错误 ！',
  //           icon: 'none',
  //           duration: 1000,
  //           mask: true,
  //         })
  //       }else if (res.data.type === 1) {
  //         //发送国际短信
  //         console.log('发送国际短信')
  //         util.request(api.SedAbroadSode, {
  //           phone: that.data.inputMobile,
  //           selectedcountry: that.data.selectedcountry
  //         }, 'POST').then(function (res) {
  //           console.log(res)
  //           if (res.errno === 0) {
  //             wx.showToast({
  //               title: res.data.message,
  //               icon: 'none',
  //               duration: 2000
  //             })
  //             if (res.data.message == '短信发送成功 ！') {
  //               setTimeout(() => {
  //                 wx.showToast({
  //                   title: '您即将收到一条来自' + app.CorporateData.title + '的短信，请注意查收 ！',
  //                   icon: 'none',
  //                   duration: 2000
  //                 })
  //               }, 2000)
  //             } else {
  //               setTimeout(() => {
  //                 wx.showToast({
  //                   title: '异常状态 ！ 短信发送失败 ！',
  //                   icon: 'none',
  //                   duration: 2000,
  //                 })
  //               }, 2000)
  //             }

  //             console.log(res.data.num)
  //             that.setData({
  //               truesode: res.data.num
  //             })
  //           } else {
  //             wx.showToast({
  //               title: '短信发送失败 ！',
  //               icon: 'none',
  //               duration: 2000,
  //               mask: true,
  //             })
  //           }
  //         })
  //         //按钮倒计时
  //         var second = that.data.second;
  //         that.setData({
  //           sendcodetext: second + '秒',
  //           codedisabled: true,
  //           codeloading: true,
  //           checkdisabled: false,
  //         })
  //         const timer = setInterval(() => {
  //           second--;
  //           if (second) {
  //             that.setData({
  //               sendcodetext: second + '秒',
  //               codedisabled: true,
  //               codeloading: true,
  //             })
  //           } else {
  //             clearInterval(timer);
  //             that.setData({
  //               sendcodetext: ' 获取验证码 ',
  //               codedisabled: false,
  //               codeloading: false,
  //             })
  //           }
  //         }, 1000);
          
  //       } else if (res.data.type === 0){
  //         //发送国内短信
  //         console.log('发送国内短信')
  //         //验证手机号
  //         //发送验证码
  //         util.request(api.SedDomesticSode, {
  //           phone: that.data.inputMobile
  //         }, 'POST').then(function (res) {
  //           console.log(res)
  //           if (res.errno === 0) {
  //             wx.showToast({
  //               title: res.data.message,
  //               icon: 'none',
  //               duration: 2000
  //             })
  //             if (res.data.message == '短信发送成功 ！') {
  //               setTimeout(() => {
  //                 wx.showToast({
  //                   title: '您即将收到一条来自' + app.CorporateData.title + '的短信，请注意查收 ！',
  //                   icon: 'none',
  //                   duration: 2000
  //                 })
  //               }, 2000)
  //             } else {
  //               setTimeout(() => {
  //                 wx.showToast({
  //                   title: '异常状态 ！ 短信发送失败 ！',
  //                   icon: 'none',
  //                   duration: 2000,
  //                 })
  //               }, 2000)
  //             }

  //             console.log(res.data.num)
  //             that.setData({
  //               truesode: res.data.num
  //             })
  //           } else {
  //             wx.showToast({
  //               title: '短信发送失败 ！',
  //               icon: 'none',
  //               duration: 2000,
  //               mask: true,
  //             })
  //           }
  //         })
  //         //按钮倒计时
  //         var second = that.data.second;
  //         that.setData({
  //           sendcodetext: second + '秒',
  //           codedisabled: true,
  //           codeloading: true,
  //           checkdisabled: false,
  //         })
  //         const timer = setInterval(() => {
  //           second--;
  //           if (second) {
  //             that.setData({
  //               sendcodetext: second + '秒',
  //               codedisabled: true,
  //               codeloading: true,
  //             })
  //           } else {
  //             clearInterval(timer);
  //             that.setData({
  //               sendcodetext: ' 获取验证码 ',
  //               codedisabled: false,
  //               codeloading: false,
  //             })
  //           }
  //         }, 1000);
  //       }
  //     })
  //   }
  // },
  // checked: function () {
  //   var that = this
  //   console.log(that.data.truesode)
  //   if (that.data.inputcode == '') {
  //     wx.showToast({
  //       title: '您没有输入验证码 ！',
  //       icon: 'none',
  //       duration: 2000
  //     })
  //   } else {
  //     //验证手机号
  //     // util.request(api.CheckSode,{
  //     //   phone: that.data.inputMobile,
  //     //   code: that.data.inputcode,
  //     // }, 'POST').then(function (res){
  //     //   console.log(res)
  //     try {
  //       var value = wx.getStorageSync('userInfo')
  //       if (value) {
  //         // Do something with return value
  //         if (that.data.truesode !== that.data.inputcode) {
  //           util.showErrorToast('验证码错误 ！');
  //         } else {
  //           console.log(that.data.inputMobile)
  //           util.request(api.BingPhoneBing, {
  //             bingphone: that.data.inputMobile,
  //             selectedcountry: that.data.selectedcountry,
  //             userid: value.id
  //           }, 'POST').then(function (res) {
  //             console.log(res)
  //             if (res.errno == 0) {
  //               setTimeout(() => {
  //                 util.request(api.ApplyDistribution, {
  //                   phone: that.data.inputMobile,
  //                   selectedcountry: that.data.selectedcountry,
  //                   userid: value.id
  //                 }, 'POST').then(ress => {
  //                   console.log(ress)
  //                   that.finddistribinfo()
  //                   that.hide_model()
  //                 })
  //                 util.request(api.BingPhoneFind).then(function (resd) {
  //                   console.log(resd)
  //                   that.setData({
  //                     userinfo: resd.data.Result
  //                   })
  //                 });
  //               }, 1000)
  //               wx.showToast({
  //                 title: '分销员申请已提交 ！',
  //                 icon: 'none',
  //                 duration: 2000
  //               })

  //             }
  //           })
  //         }
  //       }
  //     } catch (e) {
  //       // Do something when catch error
  //     }
      
  //     // })
  //   }
  // },
  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    this.onloadaction()
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