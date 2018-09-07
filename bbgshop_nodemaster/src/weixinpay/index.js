var md5 = require('md5');
const fs = require('fs');
var request = require('request');
var xml2js = require('xml2js');
var parseString = xml2js.parseString;
var builder = new xml2js.Builder();

/**
 * @description Extension method add
 * @param  {String} name  property
 * @param  {Object Or String} value property value
 * @return {Object}       function
 */
Function.prototype.add = Function.prototype.add || function(name, value) {
  this.prototype[name] = value;
  return this;
};

/**
 * @description Extension method inherits
 * @param  {Object} superConstructor superConstructor
 * @return {Object}                  function
 */
Function.prototype.inherits = Function.prototype.inherits || function(superConstructor) {
  var arr = arguments;
  if (Array.isArray(arguments[0]) && arguments.length === 1) {
    arr = arguments[0];
  }
  for (var item = arr.length; item >= 0; item--) {
    for (var key in arr[item]) {
      this.prototype[key] = arr[item][key];
    }
  }
  return this;
};

/**
 * @constructor WXPayUrl
 * @description微信支付URL
 */
function WXPayUrl() {}
WXPayUrl.add('url', {
  unifiedorder: 'https://api.mch.weixin.qq.com/pay/unifiedorder', //统一下单
  orderquery: 'https://api.mch.weixin.qq.com/pay/orderquery', //查询订单
  closeorder: 'https://api.mch.weixin.qq.com/pay/closeorder', //关闭订单
  refund: 'https://api.mch.weixin.qq.com/secapi/pay/refund', //申请退款
  refundquery: 'https://api.mch.weixin.qq.com/pay/refundquery', //查询退款
  downloadbill: 'https://api.mch.weixin.qq.com/pay/downloadbill', //下载对账单
  report: 'https://api.mch.weixin.qq.com/pay/report', //交易保障
  enterprise: 'https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers', //企业打款到零钱
  enterprise_bank: 'https://api.mch.weixin.qq.com/mmpaysptrans/pay_bank', //企业打款到银行卡
  getpublickey: 'https://fraud.mch.weixin.qq.com/risk/getpublickey', //获取rsa公钥
  querybankpay: '	https://api.mch.weixin.qq.com/mmpaysptrans/query_bank',//查询付款到银行卡进度
});
/**
 * @description 微信支付工具类函数
 */
function Utils() {
  this.init = function() {};
}
Utils
  .add('options', {})
  .add('parseWXReturnXML', function(xmlObject) {
    var newObject = {};
    xmlObject = xmlObject.xml || {};
    for (var key in xmlObject) {
      newObject[key] = xmlObject[key][0];
    }
    return newObject;
  })
  .add('createNonceStr', function() {
    return Math.random().toString(36).substr(2, 15);
  })
  .add('createTimeStamp', function() {
    return parseInt(new Date().getTime() / 1000) + '';
  })
  .add('sign', function(options) {
    var ops = options || {};
    var
      keys =
      Object.keys(ops)
      .filter(function(item) {
        return ops[item] !== undefined && ops[item] !== '' && ['pfx', 'partner_key', 'sign', 'key'].indexOf(item) < 0;
      })
      .sort()
      .map(function(key) {
        return key + '=' + ops[key];
      })
      .join('&') + '&key=' + this.partner_key;
    return md5(keys).toUpperCase();
  });

/**
 * @description 微信小程序支付
 * @constructor WeixinPay
 * @author kingwell
 * @Date(2016-11-22)
 */
function WeiXinPay() {
  this.init.apply(this, arguments);
}

WeiXinPay
  //继承
  .inherits(new Utils(), new WXPayUrl())
  /**
   * @description init
   */
  .add('init', function() {
    for (var key in arguments[0]) {
      this[key] = arguments[0][key];
    }
  })
  /**
   * 创建统一订单
   * @param  {[type]} options       [description]
   * @param  {[type]} fn)           {		var       that  [description]
   * @param  {[type]} }            [description]
   * @param  {[type]} function(err, response,     body) {			console.log('body', body);			parseString(body, function(err, result) {				fn(that.parseWXReturnXML(result));			} [description]
   * @return {[type]}               [description]
   */
  .add('createUnifiedOrder', function(param, fn) {
    var that = this;
    var ops = param || {};
    var nonce_str = that.createNonceStr();

    ops.appid = that.appid;
    ops.openid = that.openid;
    ops.mch_id = that.mch_id;
    ops.nonce_str = nonce_str;
    ops.sign = that.sign(ops);

    console.log(ops);
    // console.log(that.mch_id);
    request({
      url: that.url.unifiedorder,
      method: 'POST',
      body: builder.buildObject(ops),
      agentOptions: {
        pfx: that.pfx,
        passphrase: that.mch_id
      }
    }, function(err, response, body) {
      parseString(body, function(err, result) {
        console.log(builder.buildObject(ops));
        console.log(result);
        fn(that.parseWXReturnXML(result));
      });
    });
    return that;
  })



  /**
   * 查询付款到银行卡进度
   * @param  {[type]} options       [description]
   * @param  {[type]} fn)           {		var       that  [description]
   * @param  {[type]} }            [description]
   * @param  {[type]} function(err, response,     body) {			console.log('body', body);			parseString(body, function(err, result) {				fn(that.parseWXReturnXML(result));			} [description]
   * @return {[type]}               [description]
   */
  .add('query_BankPay', function(param, fn) {
    var that = this;
    console.log("进入weixinpay依赖的query_BankPay事件");
    var nonce_str = that.createNonceStr();
    var ops = param || {};
    ops.mch_id = that.mch_id
    ops.nonce_str = nonce_str
    ops.sign = that.sign(ops)
    console.log(ops);
    request({
      url: that.url.querybankpay,
      method: 'POST',
      body: builder.buildObject(ops),
      agentOptions: {
        pfx: fs.readFileSync("apiclient_cert.p12"),
        passphrase: ops.mch_id
      }
    }, function(err, res, body) {
      parseString(body, function(err, result) {
        fn(that.parseWXReturnXML(result));
      });
    });
    return that
  })


/**
 * 获取加密后的银行卡号和姓名
 * @param  {[type]} options       [description]
 * @param  {[type]} fn)           {		var       that  [description]
 * @param  {[type]} }            [description]
 * @param  {[type]} function(err, response,     body) {			console.log('body', body);			parseString(body, function(err, result) {				fn(that.parseWXReturnXML(result));			} [description]
 * @return {[type]}               [description]
 */
.add('getrsaCodePay_BankCard', function(param, fn) {
  var that = this;
  console.log("进入weixinpay依赖的getrsaCodePay_BankCard事件");
  var nonce_str = that.createNonceStr();
  var opskey = param || {};
  opskey.nonce_str = nonce_str
  opskey.sign_type = 'MD5'
  opskey.sign = that.sign(opskey)
  request({
    url: that.url.getpublickey,
    method: 'POST',
    body: builder.buildObject(opskey),
    agentOptions: {
      pfx: fs.readFileSync("apiclient_cert.p12"),
      passphrase: opskey.mch_id
    }
  }, function(err, res, body) {
    parseString(body, function(err, result) {
      fn(that.parseWXReturnXML(result));
    });
  });
  return that
})


  /**
   * 企业付款到用户银行卡
   * @param  {[type]} options       [description]
   * @param  {[type]} fn)           {		var       that  [description]
   * @param  {[type]} }            [description]
   * @param  {[type]} function(err, response,     body) {			console.log('body', body);			parseString(body, function(err, result) {				fn(that.parseWXReturnXML(result));			} [description]
   * @return {[type]}               [description]
   */
  .add('createEnterprisePay_BankCard', function(param, fn) {
      var that = this;
      var ops = param || {};
      var nonce_str = that.createNonceStr();
      // console.log(that);
      ops.enc_bank_no = that.enc_bank_no_ras
      ops.enc_true_name = that.enc_true_name_ras
      ops.nonce_str = nonce_str;
      ops.sign = that.sign(ops);
      console.log(that);
      console.log(ops);
      // console.log(ops);
			// console.log(opskey);
    request({
    	url: that.url.enterprise_bank,
    	method: 'POST',
    	body: builder.buildObject(ops),
    	agentOptions: {
    		pfx: fs.readFileSync("apiclient_cert.p12"),
    		passphrase: that.mch_id
    	}
    }, function(err, response, body) {
    	parseString(body, function(err, result) {
    		console.log(builder.buildObject(ops));
    		console.log(result);
    		fn(that.parseWXReturnXML(result));
    	});
    });
    return that
  })

/**
 * 退款订单
 * @param  {[type]} options       [description]
 * @param  {[type]} fn)           {		var       that  [description]
 * @param  {[type]} }            [description]
 * @param  {[type]} function(err, response,     body) {			console.log('body', body);			parseString(body, function(err, result) {				fn(that.parseWXReturnXML(result));			} [description]
 * @return {[type]}               [description]
 */
.add('createRefundOrder', function(param, fn) {
    var that = this;
    console.log('进入weixinpay依赖的createRefundOrder事件!');

    var ops = param || {};
    var nonce_str = that.createNonceStr();

    ops.appid = that.appid;
    // ops.openid = that.openid;
    ops.mch_id = that.mch_id;
    ops.nonce_str = nonce_str;
    ops.sign = that.sign(ops);

    console.log(ops);
    request({
      url: that.url.refund,
      method: 'POST',
      body: builder.buildObject(ops),
      agentOptions: {
        pfx: fs.readFileSync("apiclient_cert.p12"),
        passphrase: that.mch_id
      }
    }, function(err, response, body) {
      console.log(err);
      // console.log(response);
      console.log(body);
      parseString(body, function(err, result) {
        fn(that.parseWXReturnXML(result));
      });
    });
    return that;
  })

  /**
   * 企业打款
   * @param  {[type]} options       [description]
   * @param  {[type]} fn)           {		var       that  [description]
   * @param  {[type]} }            [description]
   * @param  {[type]} function(err, response,     body) {			console.log('body', body);			parseString(body, function(err, result) {				fn(that.parseWXReturnXML(result));			} [description]
   * @return {[type]}               [description]
   */
  .add('createEnterprisePay', function(param, fn) {
    var that = this;
    console.log('进入weixinpay依赖的createEnterprisePay事件!');
    // console.log(that);
    console.log(param);
    // console.log(that.mch_appid);
    var ops = param || {};
    var nonce_str = that.createNonceStr();
    //
    ops.nonce_str = nonce_str;
    ops.sign = that.sign(ops);
    //
    console.log(ops);
    request({
      url: that.url.enterprise,
      method: 'POST',
      body: builder.buildObject(ops),
      agentOptions: {
        pfx: fs.readFileSync("apiclient_cert.p12"),
        // passphrase: Buffer.from(param.mchid, 'utf8'),
        passphrase: param.mchid.toString('binary'),
        // passphrase: param.mchid
      }
    }, function(err, response, body) {
      console.log(fs.readFileSync("apiclient_cert.p12"));
      console.log(ops.mchid);
      console.log(err);
      console.log(response);
      console.log(body);
      // parseString(body, function(err, result) {
      // 	fn(that.parseWXReturnXML(result));
      // });
    });
    return that;
  })


  /**
   * @description 查寻订单
   * @param  {Object} param
   * @param  {Function} fn) callback
   * @return {Object} Constructor
   */
  .add('queryOrder', function(param, fn) {
    var that = this;
    param.nonce_str = param.nonce_str || that.createNonceStr();

    param.appid = that.appid;
    param.mch_id = that.mch_id;
    param.sign = that.sign(param);

    request({
      url: that.url.orderquery,
      method: 'POST',
      body: builder.buildObject(param)
    }, function(err, response, body) {
      parseString(body, function(err, result) {
        fn(that.parseWXReturnXML(result));
      });
    });
    return that;
  })
  /**
   * @description 关闭订单
   * @param  {Object} param
   * @param  {Function} fn) callback
   * @return {Object} Constructor
   */
  .add('closeorder', function(param, fn) {
    var that = this;
    param.appid = this.appid;
    param.mch_id = this.mch_id;
    param.nonce_str = param.nonce_str || that.createNonceStr();
    param.sign = that.sign(param);
    request({
      url: this.url.closeorder,
      method: 'POST',
      body: builder.buildObject(param)
    }, function(err, response, body) {
      parseString(body, function(err, result) {
        fn(that.parseWXReturnXML(result));
      });
    });

  });

module.exports = WeiXinPay;
