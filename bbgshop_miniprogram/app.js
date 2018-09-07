var util = require('./utils/util.js');
var api = require('./config/api.js');
var user = require('./services/user.js');

App({
  onLaunch: function () {
    //获取用户的登录信息
    console.log('action')
    user.checkLogin().then(res => {
      console.log('app login')
      // console.log(res)
      this.globalData.userInfo = wx.getStorageSync('userInfo');
      this.globalData.token = wx.getStorageSync('token');
      console.log(this.globalData.token)
    }).catch(() => {
      console.log('login faild')
      // this.globalData.token = wx.getStorageSync('token');
      console.log(this.globalData.token)
    });
    // //动态加载字体
    // wx.loadFontFace({
    //   family: 'GoodNight',
    //   source: 'url("http://resource.bbgshop.com/font/%EF%BD%87%EF%BD%8F%EF%BD%8F%EF%BD%84%EF%BD%8E%EF%BD%89%EF%BD%87%EF%BD%88%EF%BD%94.ttf")',
    //   success: function (res) {
    //     console.log(res.status) //  loaded
    //     console.log(res)
    //   },
    //   fail: function (res) {
    //     console.log(res.status) //  error
    //   },
    //   complete: function (res) {
    //     console.log(res.status);
    //   }
    // });
  },

  globalData: {
    userInfo: {
      nickname: 'Hi,游客',
      username: 'login',
      avatar: 'http://yanxuan.nosdn.127.net/8945ae63d940cc42406c3f67019c5cb6.png'
    },
    token: '',
  },
  CorporateData: {
    name: 'bbg',
    title: '贝堡商城'
  }
})
