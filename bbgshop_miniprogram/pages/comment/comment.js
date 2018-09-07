var app = getApp();
var util = require('../../utils/util.js');
var api = require('../../config/api.js');

Page({
  data: {
    comments: [],
    allCommentList: [],
    picCommentList: [],
    // typeId: 0,
    // valueId: 0,
    goodsid: 0,
    showType: 0,
    allCount: 0,
    hasPicCount: 0,
    // allPage: 1,
    // picPage: 1,
    // size: 20
  },
  getCommentCount: function () {
    let that = this;
    util.request(api.CommentList, { goodsId: that.data.goodsid, showType:3}).then(function (res) {
      // console.log(res)
      if (res.errno === 0) {
        that.setData({
          allCount: res.data.allCount,
          hasPicCount: res.data.hasPicCount
        });
      }
    });
  },
  getCommentList: function(){
    let that = this;
    util.request(api.CommentList, { 
      goodsId: that.data.goodsid, 
      // typeId: that.data.typeId, 
      // size: that.data.size,
      // page: (that.data.showType == 0 ? that.data.allPage : that.data.picPage),
      showType: that.data.showType 
      }).then(function (res) {
      if (res.errno === 0) {
        console.log(res)
        if (that.data.showType == 0) {
          that.setData({
            allCommentList: res.data.comments,
            comments: res.data.comments
          });
        } else {
          that.setData({
            picCommentList: res.data.comments,
            comments: res.data.comments
          });
        }
      }
    });
  },
  onLoad: function (options) {
    // 页面初始化 options为页面跳转所带来的参数
    this.setData({
      // typeId: options.typeId,
      goodsid: options.goodsid
    });
    console.log(options)
    this.getCommentCount();
    this.getCommentList();
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

  },
  switchTab: function (e) {
    let pictype = e.currentTarget.dataset.type
    this.setData({
      showType: pictype
    });
    this.setData({
      allCommentList: [],
      picCommentList: [],
    })
    this.getCommentList();
  },
  // onReachBottom: function(){
  //   console.log('onPullDownRefresh');
  //   if ( this.data.showType == 0) {

  //     if (this.data.allCount / this.data.size < this.data.allPage) {
  //       return false;
  //     }

  //     this.setData({
  //       'allPage' : this.data.allPage + 1
  //     });
  //   } else {
  //     if (this.data.hasPicCount / this.data.size < this.data.picPage) {
  //       return false;
  //     }

  //     this.setData({
  //       'picPage': this.data.picPage + 1
  //     });
  //   }



  //   this.getCommentList();
  // }
})