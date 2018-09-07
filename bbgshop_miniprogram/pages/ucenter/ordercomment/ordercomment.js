// pages/ucenter/ordercomment/ordercomment.js
const qiniuUploader = require("../../../utils/qiniuUploader");
var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');
Page({

  /**
   * 页面的初始数据
   */
  data: {
    stars: [0, 1, 2, 3, 4],
    normalSrc: '../../../image/nomalstart.png',
    selectedSrc: '../../../image/selectstart.png',
    halfSrc: '../../../image/halfstart.png',
    key: 5,//评分
    list:[],
    refund_uploadimg: [],
    qiniuUpload: '',
    refund_resond: '',
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    // console.log(options)
    var that = this
    let bean = JSON.parse(options.nocomlist);
    // console.log(bean)
    this.setData({
      list: bean
    })
    util.request(api.GetTooken, 'POST').then(res => {
      console.log(res)
      that.setData({
        qiniuUpload: res.data.uploadToken
      })
    })
  },
  refund(e) {
    let that = this
    let goods = e.currentTarget.dataset.goods
    console.log(goods)
    if (that.data.refund_resond == '') {
      wx.showToast({
        title: '请填写评论内容！',
        icon: 'none',
        duration: 2000,
        mask: true,
      })
      return false
    }
    wx.showModal({
      title: '提示！',
      content: '是否提交' + goods.goods_name + '的评论？',
      success: function (res) {
        wx.showLoading({
          title: '评论中...',
          mask: true,
        })
        if (res.confirm) {
          console.log(that.data.refund_resond) //评价内容
          console.log(that.data.key) //评价星星
          console.log(that.data.refund_uploadimg) //评价图片
          util.request(api.CheckComment, {
            goods: goods,
          }, 'POST').then(res => {
            console.log(res)
            wx.hideLoading()
            if (res.errno == 2) {
              wx.showToast({
                title: '您已发表过此商品的评论！',
                icon: 'none',
                duration: 2000,
                mask: true,
                success: function (res) { 
                  setTimeout(function(){
                    wx.navigateBack({
                      delta: 1,
                    })
                  },2000)

                 },
                fail: function (res) { },
                complete: function (res) { },
              })
            } else {
              util.request(api.CommentLunch, {
                goods: goods,
                conent: that.data.refund_resond,
                starkey: that.data.key,
                imglist: that.data.refund_uploadimg
              }, 'POST').then(res => {
                console.log(res)
                if (res.errno == 0) {
                  wx.hideLoading()
                  wx.showToast({
                    title: '评论成功！',
                    icon: 'none',
                    duration: 2000,
                    mask: true,
                  })
                  // that.hideModalComment()
                  that.getdetlist(goods)
                  // that.getdetail(order)
                }

              })
            }
          })

        }
      },
      fail: function (res) { },
      complete: function (res) { },
    })

  // }
  },
  getdetlist(goods) {
    // console.log(order)
    var that = this
    util.request(api.OrderDetail, {
      orderId: goods.order_id
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
            // wx.navigateBack({
            //   delta: 1,
            // })
            wx.navigateTo({
              url: '../order/order',
              success: function(res) {
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
              },
              fail: function(res) {},
              complete: function(res) {},
            })
            // that.hideModalComment()

          }
        })
      }
    })
  },
  // getdetlist(){
  //   var that = this
  //   wx.showLoading({
  //     title: '核实是否评论...',
  //   })
  //   util.request(api.ListIsCommented, {
  //     goodslist: that.data.list
  //   }, 'POST').then(res => {
  //     console.log(res)
  //     wx.hideLoading()
  //     // that.setData({
  //     //   list: res.data
  //     // })
  //   })
  // },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
  
  },
  textinput(e) {
    this.setData({
      refund_resond: e.detail.value
    })
  },
  //点击右边,半颗星
  selectLeft: function (e) {
    var key = e.currentTarget.dataset.key
    if (this.data.key == 0.5 && e.currentTarget.dataset.key == 0.5) {
      //只有一颗星的时候,再次点击,变为0颗
      key = 0;
    }
    console.log(key + "分")
    this.setData({
      key: key
    })

  },
  //点击左边,整颗星
  selectRight: function (e) {
    var key = e.currentTarget.dataset.key
    console.log(key + "分")
    this.setData({
      key: key
    })
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
          obj.img = "http://resource.bbgshop.com/" + res.imageURL
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
  backbtn(){
    wx.navigateBack({
      delta: 1,
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