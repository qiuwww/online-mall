// pages/ucenter/bingphone/bingphone.js
var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');
var app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    second: 45,
    isbing:false,
    inputMobile:"",
    inputcode:"",
    userinfo: "",
    truesode: 0,
    codeloading:false,
    codedisabled:false,
    checkdisabled:true,
    sendcodetext:" 发送验证码 ",
    changeisabled:false,
    // auth:false,
    show_mask: false,
    AreacodeArray_index: 215,//区号下标
    selectedcountry: {},
    AreacodeArray: [],//区号列表
    AllAreacodeArray: [],
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    var that = this
    wx.showLoading({
      title: '核实中...',
      mask: true,
    })
      that.findphone();
  },
  startBingPhone(){
    let that = this
    that.getcountrycode()
    that.setData({
      show_mask: true
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
  getcountrycode() {
    let that = this
    util.request(api.GetCountryCode, {}, 'POST').then(res => {
      console.log(res)
      if (res.errno == 0) {
        for (let i = 0; i < res.data.length; i++) {
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
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  findphone: function () {
    let that = this;
    try {
      var value = wx.getStorageSync('userInfo')
      if (value) {
        // Do something with return value
        util.request(api.BingPhoneFind, {
          userId: value.id
    }, 'POST').then(function (res) {
            console.log(res)
            wx.hideLoading()
            if (res.data.Result.mobile == "") {
              that.setData({
                isbing: false,
                userinfo: res.data.Result,
                bingisnottext: "您还没有绑定手机号！",
                show_mask: true
              })
              that.getcountrycode()
            } else {
              that.setData({
                isbing: true,
                userinfo: res.data.Result
              })
            }
          });
      }
    } catch (e) {
      // Do something when catch error
    }
    
  },
  getcode() {
    var that = this
    if (this.data.inputMobile == "") {
      wx.showToast({
        title: '请先输入手机号 ！',
        icon: 'none',
        duration: 1000,
        mask: true,
      })
      // return false;
    } else {
      util.request(api.BingPhoneText, {
        Phone: that.data.inputMobile,
        selectedcountry: that.data.selectedcountry
      }, 'POST').then(function (res) {
        console.log(res)
        if (res.errno === 1001) {
          wx.showToast({
            title: '手机号格式错误 ！',
            icon: 'none',
            duration: 1000,
            mask: true,
          })
        } else if (res.data.type === 1) {
          //发送国际短信
          console.log('发送国际短信')
          util.request(api.SedAbroadSode, {
            phone: that.data.inputMobile,
            selectedcountry: that.data.selectedcountry,
          }, 'POST').then(function (res) {
            console.log(res)
            if (res.errno === 0) {
              wx.showToast({
                title: res.data.message,
                icon: 'none',
                duration: 2000
              })
              if (res.data.message == '短信发送成功 ！') {
                setTimeout(() => {
                  wx.showToast({
                    title: '您即将收到一条来自' + app.CorporateData.title + '的短信，请注意查收 ！',
                    icon: 'none',
                    duration: 2000
                  })
                }, 2000)
              } else {
                setTimeout(() => {
                  wx.showToast({
                    title: '异常状态 ！ 短信发送失败 ！',
                    icon: 'none',
                    duration: 2000,
                  })
                }, 2000)
              }

              console.log(res.data.num)
              that.setData({
                truesode: res.data.num
              })
            } else {
              wx.showToast({
                title: '短信发送失败 ！',
                icon: 'none',
                duration: 2000,
                mask: true,
              })
            }
          })
          //按钮倒计时
          var second = that.data.second;
          that.setData({
            sendcodetext: second + '秒',
            codedisabled: true,
            codeloading: true,
            checkdisabled: false,
          })
          const timer = setInterval(() => {
            second--;
            if (second) {
              that.setData({
                sendcodetext: second + '秒',
                codedisabled: true,
                codeloading: true,
              })
            } else {
              clearInterval(timer);
              that.setData({
                sendcodetext: ' 获取验证码 ',
                codedisabled: false,
                codeloading: false,
              })
            }
          }, 1000);

        } else if (res.data.type === 0) {
          //发送国内短信
          console.log('发送国内短信')
          //验证手机号
          //发送验证码
          util.request(api.SedDomesticSode, {
            phone: that.data.inputMobile,
            selectedcountry: that.data.selectedcountry,
          }, 'POST').then(function (res) {
            console.log(res)
            if (res.errno === 0) {
              wx.showToast({
                title: res.data.message,
                icon: 'none',
                duration: 2000
              })
              if (res.data.message == '短信发送成功 ！') {
                setTimeout(() => {
                  wx.showToast({
                    title: '您即将收到一条来自' + app.CorporateData.title + '的短信，请注意查收 ！',
                    icon: 'none',
                    duration: 2000
                  })
                }, 2000)
              } else {
                setTimeout(() => {
                  wx.showToast({
                    title: '异常状态 ！ 短信发送失败 ！',
                    icon: 'none',
                    duration: 2000,
                  })
                }, 2000)
              }

              console.log(res.data.num)
              that.setData({
                truesode: res.data.num
              })
            } else {
              wx.showToast({
                title: '短信发送失败 ！',
                icon: 'none',
                duration: 2000,
                mask: true,
              })
            }
          })
          //按钮倒计时
          var second = that.data.second;
          that.setData({
            sendcodetext: second + '秒',
            codedisabled: true,
            codeloading: true,
            checkdisabled: false,
          })
          const timer = setInterval(() => {
            second--;
            if (second) {
              that.setData({
                sendcodetext: second + '秒',
                codedisabled: true,
                codeloading: true,
              })
            } else {
              clearInterval(timer);
              that.setData({
                sendcodetext: ' 获取验证码 ',
                codedisabled: false,
                codeloading: false,
              })
            }
          }, 1000);
        }
      })
    }
  },
  checked: function () {
    var that = this
    console.log(that.data.truesode)
    console.log(that.data.inputMobile)
    if (that.data.inputcode == '') {
      util.showErrorToast('验证码为空！');
    } else {
      //验证手机号
      // util.request(api.CheckSode,{
      //   phone: that.data.inputMobile,
      //   code: that.data.inputcode,
      // }, 'POST').then(function (res){
      //   console.log(res)
      if (that.data.truesode !== that.data.inputcode){
          util.showErrorToast('验证码错误！');
        }else {
        //  console.log("124879")
        console.log(that.data.inputMobile)
          util.request(api.BingPhoneBing,{
            bingphone: that.data.inputMobile,
            selectedcountry: that.data.selectedcountry,
            userid: that.data.userinfo.id
          },'POST').then(function(res){
            console.log(res)
            if ( res.data.Findresult === 1){
              wx.showToast({
                title: '绑定成功',
                icon: 'success',
                duration: 2000
              })
              util.request(api.BingPhoneFind, {
                userId: that.data.userinfo.id
              }, 'POST').then(function (res) {
                console.log(res)
                that.setData({
                  show_mask: false,
                  isbing: true,
                  inputMobile: '',
                  inputcode: '',
                  userinfo: res.data.Result
                })
              });
            }
          })
        }
      // })
    }
  },
  changed: function () {
    var that = this
    wx.showModal({
      title: '提示',
      content: '是否更换绑定手机号？',
      success: function (res) {
        if (res.confirm) {
          console.log('用户点击确定')
          that.setData({
            show_mask: true ,
            // bingisnottext: "更换绑定手机号"
          })
          that.getcountrycode()
        } else if (res.cancel) {
          console.log('用户点击取消')
        }
      }
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
  hide_model() {
    this.setData({
      show_mask: false,
      inputMobile: '',
      inputcode: '',
      selectedcountry: []
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