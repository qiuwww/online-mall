const ApiRootUrl = 'http://127.0.0.1:8360/api/';

module.exports = {
  uploadaddress: '', //七牛上传地址
  IndexUrl: ApiRootUrl + 'index/index', //首页数据接口
  CatalogList: ApiRootUrl + 'catalog/index',  //分类目录全部分类数据接口
  CatalogCurrent: ApiRootUrl + 'catalog/current',  //分类目录当前分类数据接口

  AuthLoginByWeixin: ApiRootUrl + 'auth/loginByWeixin', //微信登录

  GoodsCount: ApiRootUrl + 'goods/count',  //统计商品总数
  GoodsList: ApiRootUrl + 'goods/list',  //获得商品列表
  GoodsCategory: ApiRootUrl + 'goods/category',  //获得分类数据
  GoodsDetail: ApiRootUrl + 'goods/detail',  //获得商品的详情
  GoodsNew: ApiRootUrl + 'goods/new',  //新品
  GoodsHot: ApiRootUrl + 'goods/hot',  //热门
  GoodsRelated: ApiRootUrl + 'goods/related',  //商品详情页的关联商品（大家都在看）

  BrandList: ApiRootUrl + 'brand/list',  //品牌列表
  BrandDetail: ApiRootUrl + 'brand/detail',  //品牌详情

  CartList: ApiRootUrl + 'cart/index', //获取购物车的数据
  CartAdd: ApiRootUrl + 'cart/add', // 添加商品到购物车
  CartUpdate: ApiRootUrl + 'cart/update', // 更新购物车的商品
  CartDelete: ApiRootUrl + 'cart/delete', // 删除购物车的商品
  CartChecked: ApiRootUrl + 'cart/checked', // 选择或取消选择商品
  CartGoodsCount: ApiRootUrl + 'cart/goodscount', // 获取购物车商品件数

  CartAddcopy: ApiRootUrl + 'cart/addcopy',
  CartCheckeder: ApiRootUrl + 'cart/checkeder',
  CartCheckout: ApiRootUrl + 'cart/checkout', // 下单前信息确认
  CartCheckSku: ApiRootUrl + 'cart/checksku', // 下单前信息确认
  CartDelChangeSku: ApiRootUrl + 'cart/delchangesku', // 下单前信息确认

  OrderSubmit: ApiRootUrl + 'order/submit', // 提交订单
  PayPrepayId: ApiRootUrl + 'pay/prepay', //获取微信统一下单prepay_id
  RefundOrder: ApiRootUrl + 'pay/refund', //退款订单
  CanelRefundOrder: ApiRootUrl + 'pay/canelrefund', //撤销退款申请

  CollectList: ApiRootUrl + 'collect/list',  //收藏列表
  CollectAddOrDelete: ApiRootUrl + 'collect/addordelete',  //添加或取消收藏

  CommentList: ApiRootUrl + 'comment/list',  //评论列表
  CommentCount: ApiRootUrl + 'comment/count',  //评论总数
  CommentLunch: ApiRootUrl + 'comment/lunch',   //发表评论
  CheckComment: ApiRootUrl + 'comment/checkcomment',
  ListIsComment: ApiRootUrl + 'comment/listiscomment',
  UpdateComment: ApiRootUrl + 'comment/updatecomment',
  // ListIsCommented: ApiRootUrl + 'comment/listiscommented',

  TopicList: ApiRootUrl + 'topic/list',  //专题列表
  TopicDetail: ApiRootUrl + 'topic/detail',  //专题详情
  TopicRelated: ApiRootUrl + 'topic/related',  //相关专题

  SearchIndex: ApiRootUrl + 'search/index',  //搜索页面数据
  SearchResult: ApiRootUrl + 'search/result',  //搜索数据
  SearchHelper: ApiRootUrl + 'search/helper',  //搜索帮助
  SearchClearHistory: ApiRootUrl + 'search/clearhistory',  //搜索帮助

  AddressList: ApiRootUrl + 'address/list',  //收货地址列表
  AddressDetail: ApiRootUrl + 'address/detail',  //收货地址详情
  AddressSave: ApiRootUrl + 'address/save',  //保存收货地址
  AddressDelete: ApiRootUrl + 'address/delete',  //保存收货地址

  RegionList: ApiRootUrl + 'region/list',  //获取区域列表

  OrderList: ApiRootUrl + 'order/list',  //订单列表
  OrderDetail: ApiRootUrl + 'order/detail',  //订单详情
  OrderCancel: ApiRootUrl + 'order/cancel',  //取消订单
  OrderExpress: ApiRootUrl + 'order/express', //物流详情

  FootprintList: ApiRootUrl + 'footprint/list',  //足迹列表
  FootprintDelete: ApiRootUrl + 'footprint/delete',  //删除足迹


  AddressTextphone: ApiRootUrl + 'address/textphone',  //保存收货地址
  BingPhoneFind: ApiRootUrl + 'bingphone/find',  //保存收货地址
  BingPhoneBing: ApiRootUrl + 'bingphone/bing',  //保存收货地址
  BingPhoneText: ApiRootUrl + 'bingphone/text',  //保存收货地址

  FeedBackExchange: ApiRootUrl + 'feedback/exchange',  //保存收货地址 OrderFind

  CartFind: ApiRootUrl + 'Cart/find',  //保存收货地址
  FindValues: ApiRootUrl + 'goods/findvalueprice',  //保存收货地址

  CheckOrderIsPay: ApiRootUrl + 'order/checkorderispay',
  SetOrder: ApiRootUrl + 'pay/setorder',
  CheckSode: ApiRootUrl + 'bingphone/checksode',




  FindBarValues: ApiRootUrl + 'goods/findvalueprice',



  // //砍价
  // FindCutList: ApiRootUrl + 'bargain/findcutlist',
  // Cut: ApiRootUrl + 'bargain/cut',
  // FindCutAgain: ApiRootUrl + 'bargain/cutagain',
  // FindIsCut: ApiRootUrl + 'bargain/iscut',

  // BarAddressList: ApiRootUrl + 'bargain/addresslist',
  // BarAddressDetail: ApiRootUrl + 'bargain/addressdetail',
  // CheckIsLaunch: ApiRootUrl + 'bargain/checkislaunch',
  // BarsetOrder: ApiRootUrl + 'bargain/barsetorder',
  CheckErrPrice: ApiRootUrl + 'pay/checkerrprice',
  // FindBarOrder: ApiRootUrl + 'bargain/findbarorder',
  // DelBarOrder: ApiRootUrl + 'bargain/delbarorder',
  // BargainOutTime: ApiRootUrl + 'bargain/bargainouttime',

    //  优惠券中心
  CouponList: ApiRootUrl + 'coupon/list',
  CouponFind: ApiRootUrl + 'coupon/find',
  FindInputCup: ApiRootUrl + 'coupon/findinput',
  UserGetCup: ApiRootUrl + 'coupon/userget',

  //  用户优惠券
  UserCouponList: ApiRootUrl + 'coupon/userlist',
  RepCupList: ApiRootUrl + 'coupon/repcuplist',

  //订单界面优惠券
  CheckCupList: ApiRootUrl + 'coupon/checkcuplist',

  //上传图片到七牛云
  GetTooken: ApiRootUrl + 'upload/token', //获取token


  // 拼团
  CollageFindGoods: ApiRootUrl + 'collage/findgoods', //查找拼团商品
  PrepayCollage: ApiRootUrl + 'pay/prepayCollage', //支付拼团订单
  setCollageOrder: ApiRootUrl + 'collage/setCollageorder', //写入拼团订单
  PaypayCollageOrder: ApiRootUrl + 'collage/payCollageorder', //拼团订单 付款
  FindCollageUser: ApiRootUrl + 'collage/findCollageuaer', //用户是否已发起过

  //拼团goods
  ColGoodsFindInfo: ApiRootUrl + 'collagegoods/colgoodsfindinfo',  //查找拼团信息
  ColSuccess: ApiRootUrl + 'collagegoods/collagesuccess',  //拼团成功
  SnFindOrder: ApiRootUrl + 'collagegoods/snfindorder',  //拼团成功SnFindOrder

  //拼团用户进入付款
  ColGoodsPayFind: ApiRootUrl + 'collageuserin_pay/colgoodspay_find',  //查找拼团信息
  WriteCollageOrder: ApiRootUrl + 'collageuserin_pay/writecollageorder',  //写入拼团订单
  PaypayCollageOrderUser: ApiRootUrl + 'collageuserin_pay/paypaycollageorderuser',  //支付拼团订单

  //订单界面跳转到拼团界面判断是否为发起者或拼团者
  ColFriendFindMain: ApiRootUrl + 'collagegoods/colfriendfindmain', //拼团者查找拼团主订单
  CollageIsOutTime: ApiRootUrl + 'collagegoods/collage_isouttime', //拼团者查找拼团主订单

  SetDistriUser: ApiRootUrl + 'distribution/bedistribution', //成为分销员
  ApplyDistribution: ApiRootUrl + 'distribution/applydistribution', //申请成为分销员
  CheckUserIsDistribution: ApiRootUrl + 'index/checkisdistribution', //判断是否成为分销员
  SetInviterMaster: ApiRootUrl + 'distribution/setinvitermaster',//设置分销关系
  FindDistributionInfo: ApiRootUrl + 'distribution/findisdistribution',//查找分销信息
  AddDistributionPrice: ApiRootUrl + 'distribution/adddistributionprice',//设置分销金额
  CheckIsDistributionHaveFather: ApiRootUrl + 'distribution/checkisdistributionhavefather',//确认收货时核对是否有邀请者
  FindDistributionInfoCatch: ApiRootUrl + 'distribution/findisdistribution_catch',//提现时查找分销信息
  ApplyDistributionCatch: ApiRootUrl + 'distribution/applyisdistribution_catch',//提现时提交申请

  SetDistributionOwnDis: ApiRootUrl + 'distribution/setdistributionowndis',//分销员自身购买也能获得提成

  //绑定银行卡
  FindBingBankCardType: ApiRootUrl + 'bankcard/findbingbankcardtype',//查找银行卡 银行和类型
  AddBingBankCard: ApiRootUrl + 'bankcard/addbingbankcard',//添加银行卡 写入数据库
  FindBankCard: ApiRootUrl + 'bankcard/findbankcard',//添加银行卡 写入数据库
  DelBankCard: ApiRootUrl + 'bankcard/delbankcard',//删除英银行卡

  //抽奖
  SelectAllLuckList: ApiRootUrl + 'luckdraw/selectallluckdrawlist',//'我的'界面查找所有抽奖的商品
  FindLuckDrawInfo: ApiRootUrl + 'luckdraw/findinfo',//进入抽奖页面查询抽奖详情
  CheckUserIsJoin: ApiRootUrl + 'luckdraw/checkisjoin',//进入抽奖页面检测用户是否参与抽奖

  CheckUserIsJoin: ApiRootUrl + 'luckdraw/checkisjoin',//进入抽奖页面检测用户是否参与抽奖
  JoinLuckDraw: ApiRootUrl + 'luckdraw/joinluckdraw',//用户加入抽奖
  FindJoinPeople: ApiRootUrl + 'luckdraw/findjoinpeople',//查找参与的用户
  SelectAllJoiner: ApiRootUrl + 'luckdraw/selectalljoiner',// 查找所有参与者

  FindLucklyPeople: ApiRootUrl + 'luckdraw/findlucklypeople',// 查找中奖用户
  CheckIsGet: ApiRootUrl + 'luckdraw/checkisget',//核实用户是否领取过此商品
  LucksetOrder: ApiRootUrl + 'luckdraw/lucksetorder', //中奖用户生成订单

  //砍价 2.0
  BargainList: ApiRootUrl + 'bargain/bargainlist',  //获取所有砍价类表
  UserBargainList: ApiRootUrl + 'bargain/userbargainlist', //查找用户发起过的砍价
  FindUserIsCut: ApiRootUrl + 'bargain/finduseriscut',//在发起砍价前 就核实用户是否参与过砍价
  FindGoodSku: ApiRootUrl + 'bargain/findgoodsku',//显示sku弹层是查找商品的sku
  FindBargainById: ApiRootUrl + 'bargain/findbargainbyid', //按砍价id查找砍价信息
  SetUserLaunchBargain: ApiRootUrl + 'bargain/setlaunchuserbar', //发起者的砍价
  FindUserBargain: ApiRootUrl + 'bargain/finduserbargain', //bargain_goods界面按id查找信息
  FriendCut: ApiRootUrl + 'bargain/friendcut',//好友砍价
  CheckFriendIsCut: ApiRootUrl + 'bargain/checkfriendiscut',//(不是发起者) 核对进入用户是否参与过砍价
  AfterBargainFindInfoAgain: ApiRootUrl + 'bargain/afterbargainfindinfoagain',//用户好友砍价完成后再次查询砍价信息 ，用于回显
  AfterBargainSuccessAdressList: ApiRootUrl + 'bargain/afterbargainsuccessadresslist',//用户点击领取按钮获取用户的收货地址
  AfterBargainSuccessAdressDetail: ApiRootUrl + 'bargain/afterbargainsuccessadressdetail',//用户点击收货地址后查询收货地址的详情 用于提示框
  AfterBargainSuccessSetOrder: ApiRootUrl + 'bargain/afterbargainsuccesssetorder',//确认后生成订单
  PayBargainOrder: ApiRootUrl + 'bargain/paybargainorder',//支付砍价的订单
  FindBargainOrderInfo: ApiRootUrl + 'bargain/findbarorderinfo',//查找砍价订单的信息


  //部分重构api 减少api请求次数 数据缓存在本地 由用户主动下拉刷新
  getAllCatelog: ApiRootUrl + 'catalog/getallcatelog',//获取所有分类数据 分类tabbar页
  getAllCategory: ApiRootUrl + 'catalog/getallcategory', //获取所有分类的数据
  getchildrenCategoryIdByFather: ApiRootUrl + 'catalog/getchildrencategoryidbyfather', //获取所有分类的数据
  // onReachBottomCategory: ApiRootUrl + 'catalog/onreachbottomcategory',//分类页下拉刷新获取数据

  SelectAllCollageList: ApiRootUrl + 'collage/selectallcollagelist',//获取所有砍价类表

  getUserLevelInfo: ApiRootUrl + 'user/getuserlevelinfo',//会员中心获取会员详情
  SetRechangeOrder: ApiRootUrl + 'user/setrechangeorder',//会员中心生成会员充值订单
  payRechangeOrder: ApiRootUrl + 'user/payrechangeorder',//调起付款
  SetRechangeOrderStatus: ApiRootUrl + 'user/setrechangeorderstatus',//设置回调支付状态
  GetDisRules: ApiRootUrl + 'distribution/getdisrules', //查询分销页规则
  GetNoviceGuide: ApiRootUrl + 'guide/getnoviceguide', //查询新手指南
  GetAfterGuide: ApiRootUrl + 'guide/getafterguide', //查询售后指南

  GetCountryCode: ApiRootUrl + 'bingphone/getcountrycode',//查询所有国家的区号
  SedDomesticSode: ApiRootUrl + 'bingphone/sedDomesticsode',//发送国内短信
  SedAbroadSode: ApiRootUrl + 'bingphone/sedAbroadsode',//发送国际短信

};
