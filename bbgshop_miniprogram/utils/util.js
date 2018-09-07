var api = require('../config/api.js');

function formatTime(date) {
  var year = date.getFullYear()
  var month = date.getMonth() + 1
  var day = date.getDate()

  var hour = date.getHours()
  var minute = date.getMinutes()
  var second = date.getSeconds()


  return [year, month, day].map(formatNumber).join('-') + ' ' + [hour, minute, second].map(formatNumber).join(':')
}

function formatNumber(n) {
  n = n.toString()
  return n[1] ? n : '0' + n
}

/**
 * 封封微信的的request
 */
function request(url, data = {}, method = "GET") {
  return new Promise(function (resolve, reject) {
    wx.request({
      url: url,
      data: data,
      method: method,
      header: {
        'Content-Type': 'application/json',
        'X-Nideshop-Token': wx.getStorageSync('token')
      },
      success: function (res) {
        // console.log("success");
        // console.log(res)
        if (res.statusCode == 200) {

          if (res.data.errno == 401) {
            //需要登录后才可以操作

            let code = null;
            return login().then((res) => {
              code = res.code;
              return getUserInfo();
            }).then((userInfo) => {
              //登录远程服务器
              request(api.AuthLoginByWeixin, { code: code, userInfo: userInfo }, 'POST').then(res => {
                if (res.errno === 0) {
                  //存储用户信息
                  wx.setStorageSync('userInfo', res.data.userInfo);
                  wx.setStorageSync('token', res.data.token);
                  
                  resolve(res);
                } else {
                  reject(res);
                }
              }).catch((err) => {
                reject(err);
              });
            }).catch((err) => {
              reject(err);
            })
          } else {
            resolve(res.data);
          }
        } else {
          reject(res.errMsg);
        }

      },
      fail: function (err) {
        reject(err)
        console.log("failed")
        wx.hideLoading()
        wx.showToast({
          title: '服务器故障或没有网络连接！',
          icon: 'none',
          duration: 2500,
          mask: true,
          success: function(res) {},
          fail: function(res) {},
          complete: function(res) {},
        })
      }
    })
  });
}

/**
 * 检查微信会话是否过期
 */
function checkSession() {
  return new Promise(function (resolve, reject) {
    wx.checkSession({
      success: function () {
        resolve(true);
      },
      fail: function () {
        reject(false);
      }
    })
  });
}

/**
 * 调用微信登录
 */
function login() {
  return new Promise(function (resolve, reject) {
    wx.login({
      success: function (res) {
        if (res.code) {
          //登录远程服务器
          console.log(res)
          resolve(res);
        } else {
          reject(res);
        }
      },
      fail: function (err) {
        reject(err);
      }
    });
  });
}
function getUserInfo() {
  return new Promise(function (resolve, reject) {
    wx.getUserInfo({
      withCredentials: true,
      success: function (res) {
        // console.log(res)
        resolve(res);
      },
      fail: function (err) {
        reject(err);
      }
    })
  });
}

function redirect(url) {

  //判断页面是否需要登录
  if (false) {
    wx.redirectTo({
      url: '/pages/auth/login/login'
    });
    return false;
  } else {
    wx.redirectTo({
      url: url
    });
  }
}

function showErrorToast(msg) {
  wx.showToast({
    title: msg,
    image: '/static/images/icon_error.png'
  })
}

function timestampToDate(timestamp){
  // console.log(timestamp)
  var H = parseInt((timestamp % 86400000) / 3600000);
  var M = parseInt((timestamp % 3600000) / 60000);
  var S = ((timestamp % 60000) / 1000).toFixed(0);
  var localH = H < 10 ? '0' + H : H;
  var localM = M < 10 ? '0' + M : M;
  var localS = S < 10 ? '0' + S : S;
  return localH + ":" + localM + ":" + localS  
}
function timestampToTime(timestamp){
  var date = new Date(timestamp * 1); //时间戳为10位需*1000，时间戳为13位的话不需乘1000
  var Y = date.getFullYear() + '/';
  var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '/';
  var D = (date.getDate() < 10 ? '0' + date.getDate() : date.getDate()) + '  ';
  var h = (date.getHours() < 10 ? '0' + date.getHours() : date.getHours()) + ':';
  var m = (date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes()) + ':';
  var s = (date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds());
  return Y + M + D + h + m + s;
}

function timestampToDateSec(timestamp) {
  // console.log(new Date(timestamp).toLocaleTimeString('zh-CN'))
  var time = (timestamp / 1000).toFixed(2)
  var H = (time / 3600).toFixed(2)
  var HL = H.split('.')
  var M = ((time - HL[0] * 3600) / 60).toFixed(2)
  var ML = M.split('.')
  var S = (time - HL[0] * 3600 - ML[0] * 60).toFixed(0)
  var localH = HL[0] < 10 ? '0' + HL[0] : HL[0];
  var localM = ML[0] < 10 ? '0' + ML[0] : ML[0];
  var localS = S < 10 ? '0' + S : S;
  return localH + ":" + localM + ":" + localS
  
}
function timestampToTw(timestamp){
  // console.log(timestamp)
  var H = parseInt((timestamp % 86400000) / 3600000);
  var M = parseInt((timestamp % 3600000) / 60000);
  var S = ((timestamp % 60000) / 1000).toFixed(1);
  var localH = H < 10 ? '0' + H : H;
  var localM = M < 10 ? '0' + M : M;
  var localS = S < 10 ? '0' + S : S;
  return localH + ":" + localM + ":" + localS
}
module.exports = {
  formatTime,
  timestampToDate,
  timestampToDateSec,
  timestampToTw,
  timestampToTime,
  request,
  redirect,
  showErrorToast,
  checkSession,
  login,
  getUserInfo,
}


