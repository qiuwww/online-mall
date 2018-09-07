var util = require('../../utils/util.js');
var api = require('../../config/api.js');

Page({
  data: {
    // navList: [],
    // categoryList: [],
    // currentCategory: {},
    allcatelog: [],
    bindid: 0,
    selectindex: 0,
    scrollLeft: 0,
    scrollTop: 0,
    goodsCount: 0,
    scrollHeight: 0,
    showSkeleton: false,
  },
  onLoad: function (options) {
    // this.getCatalog();
    wx.showLoading({
      title: '获取中...',
      mask: true,
    })
    this.getAllCatelog(0)
  },
  getAllCatelog(typec){
    let that = this
    util.request(api.getAllCatelog,'POST').then(function (res) {
      console.log(res)
      that.setData({
        allcatelog: res.data.main_catelog,
        bindid: res.data.main_catelog[that.data.selectindex].id,
        activelist: res.data.main_catelog[that.data.selectindex]
      })
      wx.hideLoading()
      if (typec == 1){
        wx.stopPullDownRefresh()
        wx.showToast({
          title: '更新成功 ！',
          icon: 'none',
          duration: 500,
          mask: true,
        })
      } 
    })
  },
   //下拉刷新
  onPullDownRefresh: function () {
    let that = this
    // if(op == '0'){
    // this.checkauth('1')
    wx.showLoading({
      title: '更新中...',
      mask: true,
    })
    that.getAllCatelog(1)
    // that.getCatalog();
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
  JumpUrl(e) {
    let url = e.currentTarget.dataset.url
      let title = '商品分类'
      wx.navigateTo({
        url: url + '&title=' + title,
        success: function (res) { },
        fail: function (res) { },
        complete: function (res) { },
      })
  },
  switchCate: function (event) {
    var that = this;
    var currentTarget = event.currentTarget;
    that.setData({
      bindid: event.currentTarget.dataset.id,
      selectindex: event.currentTarget.dataset.index,
    })
    for (let j = 0; j < that.data.allcatelog.length; j++) {
      if (event.currentTarget.dataset.id == that.data.allcatelog[j].id){
        that.setData({
          activelist: that.data.allcatelog[j]
        })
      }
    }
  }
})