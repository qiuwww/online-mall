var util = require('../../utils/util.js');
var api = require('../../config/api.js');

Page({
  data: {
    // navList: [],
    // goodsList: [],
    navListId: [],
    allnavcategory: [],
    point_local_category: [],
    Reachnavcategory: [],
    id: 0,
    title: '商品分类',
    showSkeleton: true,//显示布局骨架
    fixed: false,
    currentCategory: {},
    scrollLeft: 0,
    scrollTop: 0,
    scrollHeight: 0,
    page: 1,
    count: 0,//当前选择的商品分类下的商品的总数量
    loading_text: '',//加载时的提示文字
    frompage: 0,
    size: 16,
    lastX: 0,
    lastY: 0,
    onPull: false
  },
  onLoad: function (options) {
    // 页面初始化 options为页面跳转所带来的参数
    var that = this;
    wx.showLoading({
      title: '加载中...',
      // mask: true,
      showSkeleton: true
    })
    console.log(options)
    if (options.id) {
      that.setData({
        id: parseInt(options.id),
        title: options.title,
        frompage: parseInt(options.page)
      });
    }
    wx.setNavigationBarTitle({
      title: that.data.title,
      success: function(res) {},
      fail: function(res) {},
      complete: function(res) {},
    })
    wx.getSystemInfo({
      success: function (res) {
        that.setData({
          scrollHeight: res.windowHeight
        });
      }
    });
    // this.getCategoryInfo()
    this.getAllCategory()
  },
  getAllCategory(typec) {
    let that = this
    // console.log(that.data.allnavcategory[0].point_catelog_goods.data)
    util.request(api.getAllCategory,{
      id: that.data.id,
      page: that.data.page,
      size: that.data.size
    },'POST').then(res => {
      console.log(res)
      that.setData({
        allnavcategory: res.data
      })
      // console.log(that.data.allnavcategory[0].point_catelog_goods.data)
      if (that.data.navListId.length == 0){
        for (let p = 0; p < that.data.allnavcategory.length; p++) {
          that.data.navListId.push(that.data.allnavcategory[p].id)
        }
        that.setData({
          navListId: that.data.navListId,
          Reachnavcategory: res.data
        })
      }


      that.getactivecategory(typec)
    })
  },
  // onPageScroll: function (e) { // 获取滚动条当前位置
  //   // let that = this
  //   // console.log(e.scrollTop)
  //   if (e.scrollTop == 0){
  //     this.setData({
  //       fixed: false
  //     })
  //   }else {
  //     if (!this.data.fixed){
  //       this.setData({
  //         fixed: true
  //       })
  //     }
  //   }
  // },
  // 下拉刷新
  onPullDownRefresh: function () {
    let that = this
    wx.showLoading({
      title: '加载中...',
      mask: true,
    })
    that.setData({
      page: 1,
      point_local_category: [],
    })
    this.getAllCategory(1)
    // console.log(that.data.id)
  },
  /**
   * 上拉加载
   */
  onReachBottom: function () {
    var that = this;
    // 显示加载图标
    if (that.data.count > that.data.point_local_category.length) {
      wx.showLoading({
        title: '加载中...',
        mask: true,
      })
      that.setData({
        loading_text: '正在努力加载...',
      })
      that.setData({
        page: that.data.page + 1,
      })
      that.getAllCategory()
    }else {
      // wx.showToast({
      //   title: '您已经到底啦 ！',
      //   icon: 'none',
      //   duration: 1000,
      //   mask: true,
      // })
    }
    

  },
  handletouchmove: function (event) {
    console.log(event)
    let that = this
    let currentX = event.changedTouches[0].pageX
    let currentY = event.changedTouches[0].pageY
    // console.log(this.data.id)
    console.log(currentX)
    console.log(that.data.lastX)
    // let index = 0
    for (let j = 0; j < that.data.navListId.length; j++){
      if (that.data.id == that.data.navListId[j]){
        // console.log(j)
        // index = j
        if ((currentX - that.data.lastX) > 30) {
          console.log("向右滑动")
          if (j >= 0 && j <= (that.data.navListId.length - 1)) {
            let id = j == 0 ? that.data.navListId[(that.data.navListId.length - 1)] : that.data.navListId[j - 1]
            // id = movedid
            // let id = 0
            let dataset = {}
            let currentTarget = {}
            let offsetLeft = 0
            let e = {}
            dataset.id = id
            currentTarget.dataset = dataset
            currentTarget.offsetLeft = j == 0 ? 0 : (102 * (j - 1))
            let detail = {}
            let x = 90
            detail.x = x
            e.currentTarget = currentTarget
            e.detail = detail
            console.log(that.data.id)
            console.log(e)
            that.switchCate(e)
          }
        } else if ((that.data.lastX - currentX) > 30) {
          console.log("向左滑动")
          if (j >= 0 && j <= (that.data.navListId.length - 1)) {
            let id = j == (that.data.navListId.length - 1) ? that.data.navListId[0] : that.data.navListId[j + 1]
            console.log(id)
            let dataset = {}
            let currentTarget = {}
            let offsetLeft = 0
            let e = {}
            dataset.id = id
            currentTarget.dataset = dataset
            currentTarget.offsetLeft = j == (that.data.navListId.length - 1) ? 0 : (102 * (j + 1))
            let detail = {}
            let x = 360
            detail.x = x
            e.currentTarget = currentTarget
            e.detail = detail
            console.log(that.data.id)
            console.log(e)
            that.switchCate(e)
          }
        }
        //将当前坐标进行保存以进行下一次计算
        that.data.lastX = currentX
        that.data.lastY = currentY
      }
      // console.log(that.data.navListId[j])
    }
    // console.log(index)
    // let index = that.data.navListId.indexOf(this.data.id)
    // console.log(index)
    // if (Number(index + 1) == 0){
    //   console.log('异常 ！')
    // }
    // console.log(currentX)
    // console.log(this.data.lastX)

  },

  handletouchtart: function (event) {
    console.log(event)
    this.data.lastX = event.touches[0].pageX
    this.data.lastY = event.touches[0].pageY
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
  getGoodsList: function () {
    var that = this;
    util.request(api.GoodsList, {categoryId: that.data.id, page: that.data.page, size: 500})
      .then(function (res) {
        console.log(res)
        if(res.errno === 0){
          that.setData({
            goodsList: res.data.goodsList,
          });
          setTimeout(() => {
            that.setData({
              showSkeleton: false
            });
            wx.hideLoading()
          },800)
        }else {
          wx.hideLoading()
          wx.showToast({
            title: '异常 ！',
            icon: 'none',
            duration: 2000,
            mask: true,
          })
        }

      });
  },
  onUnload: function () {
    // 页面关闭
  },
  switchCate: function (event) {
    let that = this
    if (that.data.id == event.currentTarget.dataset.id) {
      return false;
    }
    // wx.showLoading({
    //   title: '加载中...',
    //   mask: true,
    // })
    that.setData({
      // goodsList: {},
      // page: Math.floor((that.data.point_local_category.length + 1) / that.data.size),
      point_local_category: [],
      showSkeleton: true
    })
    // console.log(this.data.showSkeleton)
    // var that = this;
    var clientX = event.detail.x;
    var currentTarget = event.currentTarget;

    // console.log(currentTarget)
    if (clientX < 330) {
        that.setData({
          scrollLeft: currentTarget.offsetLeft - 150
        });
      } else if (clientX > 330) {
        that.setData({
          scrollLeft: currentTarget.offsetLeft - 150
        });
    }
    this.setData({
      id: event.currentTarget.dataset.id
    });
    this.getactivecategory()
  },
  getactivecategory(typec) {
    let that = this
    for (let j = 0; j < that.data.allnavcategory.length;j++){
      if (that.data.allnavcategory[j].id == that.data.id){
        that.setData({
          activemainCategory: that.data.allnavcategory[j],
          point_local_category: that.data.point_local_category.concat(that.data.allnavcategory[j].point_catelog_goods.data),
          count: that.data.allnavcategory[j].point_catelog_goods.count
        })
        that.data.Reachnavcategory[j].point_catelog_goods.data = that.data.point_local_category
      }else {
        that.data.allnavcategory[j].point_catelog_goods.data = that.data.Reachnavcategory[j].point_catelog_goods.data
        that.setData({
          allnavcategory: that.data.allnavcategory
        })
      }
    }
    //nav位置
    let currentIndex = 0;
    let navListCount = that.data.allnavcategory.length;
    for (let i = 0; i < navListCount; i++) {
      currentIndex += 1;
      if (that.data.allnavcategory[i].id == that.data.id) {
        break;
      }
    }
    if (currentIndex > navListCount / 2 && navListCount > 5) {
      that.setData({
        scrollLeft: currentIndex * 60
      });
    }
    // setTimeout(() => {
      that.setData({
        showSkeleton: false,
        page: Math.floor(that.data.point_local_category.length / that.data.size),
        loading_text: '加载更多'
      });
      wx.hideLoading()
      if (typec && typec == 1){
        wx.stopPullDownRefresh()
        wx.showToast({
          title: '已更新 ！',
          icon: 'none',
          duration: 1000,
          mask: true,
        })
      }
    // }, 400)
  }
})