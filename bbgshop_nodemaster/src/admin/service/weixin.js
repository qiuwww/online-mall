const WeiXinPay = require('../../weixinpay/index.js');
const crypto = require('crypto');
const md5 = require('md5');

module.exports = class extends think.Service {
  /**
   * 解析微信登录用户数据
   * @param sessionKey
   * @param encryptedData
   * @param iv
   * @returns {Promise.<string>}
   */
  async decryptUserInfoData(sessionKey, encryptedData, iv) {
    // base64 decode
    const _sessionKey = Buffer.from(sessionKey, 'base64');
    encryptedData = Buffer.from(encryptedData, 'base64');
    iv = Buffer.from(iv, 'base64');
    let decoded = '';
    try {
      // 解密
      const decipher = crypto.createDecipheriv('aes-128-cbc', _sessionKey, iv);
      // 设置自动 padding 为 true，删除填充补位
      decipher.setAutoPadding(true);
      decoded = decipher.update(encryptedData, 'binary', 'utf8');
      decoded += decipher.final('utf8');

      decoded = JSON.parse(decoded);
    } catch (err) {
      return '';
    }

    if (decoded.watermark.appid !== think.config('weixin.appid')) {
      return '';
    }

    return decoded;
  }

  /**
   * 统一下单
   * @param payInfo
   * @returns {Promise}
   */
  createUnifiedOrder(payInfo) {
    console.log("进入admin的createUnifiedOrder事件");
    // const WeiXinPay = require('weixinpay');
    const weixinpay = new WeiXinPay({
      appid: think.config('weixin.appid'), // 微信小程序appid
      openid: payInfo.openid, // 用户openid
      mch_id: think.config('weixin.mch_id'), // 商户帐号ID
      partner_key: think.config('weixin.partner_key') // 秘钥
    });
    return new Promise((resolve, reject) => {
      weixinpay.createUnifiedOrder({
        body: payInfo.body,
        out_trade_no: payInfo.out_trade_no,
        total_fee: payInfo.total_fee,
        spbill_create_ip: payInfo.spbill_create_ip,
        notify_url: think.config('weixin.notify_url'),
        trade_type: 'JSAPI',
      }, (res) => {
        if (res.return_code === 'SUCCESS' && res.result_code === 'SUCCESS') {
          const returnParams = {
            'appid': res.appid,
            'timeStamp': parseInt(Date.now() / 1000) + '',
            'nonceStr': res.nonce_str,
            'package': 'prepay_id=' + res.prepay_id,
            'signType': 'MD5'
          };
          const paramStr = `appId=${returnParams.appid}&nonceStr=${returnParams.nonceStr}&package=${returnParams.package}&signType=${returnParams.signType}&timeStamp=${returnParams.timeStamp}&key=` + think.config('weixin.partner_key');
          returnParams.paySign = md5(paramStr).toUpperCase();
          resolve(returnParams);
        } else {
          reject(res);
        }
      });
    });
  }


  /**
   * 查询企业打款_银行
   * @param payInfo
   * @returns {Promise}
   */
  async queryBankPay(payInfo) {
    console.log("进入admin的queryBankPay事件");
    console.log(payInfo);
    const weixinpay = new WeiXinPay({
      partner_key: think.config('weixin.partner_key'), // 秘钥
      mch_id: think.config('weixin.mch_id'),
    });
    return new Promise((resolve, reject) => {
      weixinpay.query_BankPay({
        partner_trade_no: payInfo.partner_trade_no,
        // mch_id: think.config('weixin.mch_id'),
      }, (res) => {
        console.log(res);
          if (res.return_code === 'SUCCESS' && res.result_code === 'SUCCESS') {
            const returnParams = {
              'status': res.status,
              'return_code': res.return_code,
              'result_code': res.result_code,
              'err_code_des': res.err_code_des,
              'pay_succ_time': res.pay_succ_time,
              'partner_trade_no': res.partner_trade_no,
              'cmms_amt': res.cmms_amt,
              'amount': res.amount,
              'create_time': res.create_time,
              'reason':res.reason
            };
            resolve(returnParams);
          } else {
            reject(res);
          }
      });
    });

  }


  /**
   * 企业打款_银行——rsa公钥
   * @param payInfo
   * @returns {Promise}
   */
  async createEnterprisePay_BankCard(payInfo) {
    console.log("进入admin的createEnterprisePay_BankCard事件");
    // console.log(payInfo);
    const weixinpay = new WeiXinPay({
      partner_key: think.config('weixin.partner_key') // 秘钥
    });
    return new Promise((resolve, reject) => {
      weixinpay.getrsaCodePay_BankCard({
        mch_id: think.config('weixin.mch_id'),
      }, (res) => {
        console.log(res);
          if (res.return_code === 'SUCCESS' && res.result_code === 'SUCCESS') {
            const returnParams = {
              'return_key': res.pub_key,
            };
            resolve(returnParams);
          } else {
            reject(res);
          }
          })
      });
    // });

  }
  /**
   * 企业打款_银行
   * @param payInfo
   * @returns {Promise}
   */
  async bankpay(payInfo) {
    // console.log(payInfo,bank_code,true_name);
    const weixinpay = new WeiXinPay({
      enc_bank_no_ras: payInfo.enc_bank_no,
      enc_true_name_ras: payInfo.enc_true_name,
      partner_key: think.config('weixin.partner_key') // 秘钥
    });
    return new Promise((resolve, reject) => {
      weixinpay.createEnterprisePay_BankCard({
        mch_id: think.config('weixin.mch_id'),
        partner_trade_no: payInfo.partner_trade_no,
        bank_code: payInfo.bank_code,
        amount: payInfo.amount
      }, (res) => {
        console.log(res);
        if (res.return_code === 'SUCCESS' && res.result_code === 'SUCCESS') {
          const returnParams = {
            'return_code': res.return_code,
            'result_code': res.result_code,
            'return_msg': res.return_msg,
            'partner_trade_no': res.partner_trade_no,
            'amount': res.amount,
            'payment_no': res.payment_no,
            'cmms_amt':  res.cmms_amt,
            'err_code_des':  res.err_code_des
          };
          resolve(returnParams);
        } else {
          reject(res);
        }
      });
    });
  }
  /**
   * 企业打款_零钱
   * @param payInfo
   * @returns {Promise}
   */

  async createEnterprisePay(payInfo) {
    console.log("进入admin的createEnterprisePay事件");
    // console.log(payInfo);
    const disInfo = await think.model('distribution_cash_order').where({
      partner_trade_no:payInfo.out_trade_no
    }).find()
    console.log(disInfo);
    const weixinpay = new WeiXinPay({
      // mch_appid: disInfo.mch_appid, // 微信小程序appid
      // mchid: disInfo.mchid,
      // partner_trade_no: disInfo.partner_trade_no,
      // openid: disInfo.openid,
      // amount: disInfo.amount,
      // spbill_create_ip: disInfo.spbill_create_ip,
      // check_name: disInfo.check_name,
      // desc: disInfo.desc,
    });
    return new Promise((resolve, reject) => {
      weixinpay.createEnterprisePay({
        mch_appid: disInfo.mch_appid, // 微信小程序appid
        mchid: disInfo.mchid,
        partner_trade_no: disInfo.partner_trade_no,
        openid: disInfo.openid,
        amount: disInfo.amount,
        spbill_create_ip: disInfo.spbill_create_ip,
        check_name: disInfo.check_name,
        desc: disInfo.desc,
      }, (res) => {
        console.log(res);
        // if (res.return_code === 'SUCCESS' && res.result_code === 'SUCCESS') {
        //   const returnParams = {
        //     'appid': res.appid,
        //     'timeStamp': parseInt(Date.now() / 1000) + '',
        //     'nonceStr': res.nonce_str,
        //     'package': 'prepay_id=' + res.prepay_id,
        //     'signType': 'MD5'
        //   };
        //   const paramStr = `appId=${returnParams.appid}&nonceStr=${returnParams.nonceStr}&package=${returnParams.package}&signType=${returnParams.signType}&timeStamp=${returnParams.timeStamp}&key=` + think.config('weixin.partner_key');
        //   returnParams.paySign = md5(paramStr).toUpperCase();
        //   resolve(returnParams);
        // } else {
        //   reject(res);
        // }
      });
    });
  }

  /**
   * 退款
   * @param payInfo
   * @returns {Promise}
   */
  async createRefundOrder(payInfo) {
    console.log("进入admin的createRefundOrder事件");
    // const WeiXinPay = require('weixinpay');
    const weixinpay = new WeiXinPay({
      appid: think.config('weixin.appid'), // 微信小程序appid
      // openid: payInfo.openid, // 用户openid
      mch_id: think.config('weixin.mch_id'), // 商户帐号ID
      partner_key: think.config('weixin.partner_key') // 秘钥
    });
    console.log(payInfo);
    // console.log("98798798798789");
    if (payInfo.pay_id == 2) {
      // refundInfo.out_refund_no = "拼团退款:"+payInfo.out_trade_no
      // refundInfo.refund_fee = payInfo.actual_price
      return new Promise((resolve, reject) => {
        weixinpay.createRefundOrder({
          out_trade_no: payInfo.out_trade_no,
          out_refund_no: "Collagerefund_"+payInfo.out_trade_no,
          total_fee: parseInt(payInfo.actual_price * 100),
          refund_fee: parseInt(payInfo.actual_price * 100),
          notify_url: think.config('weixin.notify_url'),
        }, (res) => {
          console.log(res)
          if (res.return_code === 'SUCCESS' && res.result_code === 'SUCCESS') {
            const returnParams = {
              'appid': res.appid,
              'timeStamp': parseInt(Date.now() / 1000) + '',
              'nonceStr': res.nonce_str,
              'package': 'prepay_id=' + res.prepay_id,
              'signType': 'MD5'
            };
            const paramStr = `appId=${returnParams.appid}&nonceStr=${returnParams.nonceStr}&package=${returnParams.package}&signType=${returnParams.signType}&timeStamp=${returnParams.timeStamp}&key=` + think.config('weixin.partner_key');
            returnParams.paySign = md5(paramStr).toUpperCase();
            resolve(returnParams);
          } else {
            reject(res);
          }
        });
      });
    }else {
      console.log(weixinpay);
      const refundInfo = await think.model('order_refund').where({order_sn:payInfo.out_trade_no}).find()
      console.log(refundInfo);
      return new Promise((resolve, reject) => {
        weixinpay.createRefundOrder({
          out_trade_no: payInfo.out_trade_no,
          out_refund_no: refundInfo.refund_sn,
          total_fee: payInfo.total_fee,
          refund_fee: parseInt(refundInfo.refund_price * 100),
          notify_url: think.config('weixin.notify_url'),
        }, (res) => {
          if (res.return_code === 'SUCCESS' && res.result_code === 'SUCCESS') {
            const returnParams = {
              'appid': res.appid,
              'timeStamp': parseInt(Date.now() / 1000) + '',
              'nonceStr': res.nonce_str,
              'package': 'prepay_id=' + res.prepay_id,
              'signType': 'MD5'
            };
            const paramStr = `appId=${returnParams.appid}&nonceStr=${returnParams.nonceStr}&package=${returnParams.package}&signType=${returnParams.signType}&timeStamp=${returnParams.timeStamp}&key=` + think.config('weixin.partner_key');
            returnParams.paySign = md5(paramStr).toUpperCase();
            resolve(returnParams);
          } else {
            reject(res);
          }
        });
      });
    }
    // console.log(refundInfo);
    // console.log("11111111111111111111111111111111111111111111111111");
    // console.log("已获取退款详情");
    // return new Promise((resolve, reject) => {
    //   weixinpay.createRefundOrder({
    //     out_trade_no: payInfo.out_trade_no,
    //     out_refund_no: refundInfo.refund_sn,
    //     total_fee: payInfo.total_fee,
    //     refund_fee: parseInt(refundInfo.refund_price * 100),
    //     notify_url: think.config('weixin.notify_url'),
    //   }, (res) => {
    //     if (res.return_code === 'SUCCESS' && res.result_code === 'SUCCESS') {
    //       const returnParams = {
    //         'appid': res.appid,
    //         'timeStamp': parseInt(Date.now() / 1000) + '',
    //         'nonceStr': res.nonce_str,
    //         'package': 'prepay_id=' + res.prepay_id,
    //         'signType': 'MD5'
    //       };
    //       const paramStr = `appId=${returnParams.appid}&nonceStr=${returnParams.nonceStr}&package=${returnParams.package}&signType=${returnParams.signType}&timeStamp=${returnParams.timeStamp}&key=` + think.config('weixin.partner_key');
    //       returnParams.paySign = md5(paramStr).toUpperCase();
    //       resolve(returnParams);
    //     } else {
    //       reject(res);
    //     }
    //   });
    // });
  }
  /**
   * 生成排序后的支付参数 query
   * @param queryObj
   * @returns {Promise.<string>}
   */
  buildQuery(queryObj) {
    const sortPayOptions = {};
    for (const key of Object.keys(queryObj).sort()) {
      sortPayOptions[key] = queryObj[key];
    }
    let payOptionQuery = '';
    for (const key of Object.keys(sortPayOptions).sort()) {
      payOptionQuery += key + '=' + sortPayOptions[key] + '&';
    }
    payOptionQuery = payOptionQuery.substring(0, payOptionQuery.length - 1);
    return payOptionQuery;
  }

  /**
   * 对 query 进行签名
   * @param queryStr
   * @returns {Promise.<string>}
   */
  signQuery(queryStr) {
    queryStr = queryStr + '&key=' + think.config('weixin.partner_key');
    const md5 = require('md5');
    const md5Sign = md5(queryStr);
    return md5Sign.toUpperCase();
  }

  /**
   * 处理微信支付回调
   * @param notifyData
   * @returns {{}}
   */
  payNotify(notifyData) {
    if (think.isEmpty(notifyData)) {
      return false;
    }

    const notifyObj = {};
    let sign = '';
    for (const key of Object.keys(notifyData)) {
      if (key !== 'sign') {
        notifyObj[key] = notifyData[key][0];
      } else {
        sign = notifyData[key][0];
      }
    }
    if (notifyObj.return_code !== 'SUCCESS' || notifyObj.result_code !== 'SUCCESS') {
      return false;
    }
    const signString = this.signQuery(this.buildQuery(notifyObj));
    if (think.isEmpty(sign) || signString !== sign) {
      return false;
    }
    return notifyObj;
  }
};
