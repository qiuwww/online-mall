// const Base = require('./base.js');
const Base = require('./base.js');
const WeiXinPay = require('../../weixinpay');

module.exports = class extends Base {
  /**
   * 获取支付退款的请求参数
   * @returns {Promise<PreventPromise|void|Promise>}
   */
  async prerefundAction() {
    const orderId = this.post('orderId');
    console.log(orderId);
    const orderInfo = await this.model('order').where({ id: orderId }).find();
    // console.log("999999999999999999999999999999999");
    if (think.isEmpty(orderInfo)) {
      return this.fail(400, '订单已取消');
    }
    if (parseInt(orderInfo.pay_status) !== 0) {
      return this.fail(400, '订单已支付，请不要重复操作');
    }
    if (parseInt(orderInfo.actual_price * 100) == 0) {
      return this.fail(217, '订单价格为0');
    }
    const openid = await this.model('user').where({ id: orderInfo.user_id }).getField('weixin_openid', true);
    if (think.isEmpty(openid)) {
      return this.fail('openid为空');
    }
    const WeixinSerivce = this.service('weixin', 'admin');
    console.log(WeixinSerivce);
    try {
      const returnParams = await WeixinSerivce.createRefundOrder({
        out_trade_no: orderInfo.order_sn,
        total_fee: parseInt(orderInfo.actual_price * 100),
        spbill_create_ip: '',
        pay_id:orderInfo.pay_id,
        actual_price:orderInfo.actual_price,
      });
      console.log("77777777777777777777");
      // console.log(returnParams);
      console.log(orderInfo);
      return this.success(returnParams);
    } catch (err) {
      // console.log(err);
      return this.fail(err.return_msg);
    }
  }

  //  查询企业付款银行卡订单进度
  async query_bankAction() {
    const info = this.post('info')
    // console.log(info);
    let infocode = info.cash_order.partner_trade_no
    console.log(infocode);
    const WeixinSerivce = this.service('weixin', 'admin');
    try {
      const returnParams = await WeixinSerivce.queryBankPay({
        partner_trade_no: infocode,
      });
      console.log("77777777777777777777");
      return this.success(returnParams);
    } catch (err) {
      // console.log(err);
      return this.fail(err.return_msg);
    }
  }
  //  企业打款
  async catchpayAction() {
    const dis_cash = this.post('info');
    console.log(dis_cash);
    console.log(think.config('weixin.appid'));
    if (parseInt(dis_cash.catch_money * 100) == 0) {
      return this.fail(217, '价格为0');
    }
    const dis_order = await this.model('distribution_cash_order').where({cash_id:dis_cash.id}).find()
    console.log(dis_order);
    if (think.isEmpty(dis_order)) {
      return this.fail(217, '异常 !');
    }
    const WeixinSerivce = this.service('weixin', 'admin');
    try {
      const returnParams = await WeixinSerivce.createEnterprisePay({
        out_trade_no: dis_order.partner_trade_no,
        total_fee: parseInt(dis_order.amount),
        spbill_create_ip: dis_order.spbill_create_ip,
      });
      console.log("77777777777777777777");
      // console.log(orderInfo);
      console.log(returnParams);
      return this.success(returnParams);
    } catch (err) {
      // console.log(err);
      return this.fail(err.return_msg);
    }
  }
  // 企业付款到用户银行卡_获取rsa公钥
  async catchBabkCardPayAction() {
    const row = this.post('info')
    console.log(row);
    if (think.isEmpty(row)) {
      return this.fail(217, '异常 !');
    }
    const WeixinSerivce = this.service('weixin', 'admin');
    try {
      const returnParams = await WeixinSerivce.createEnterprisePay_BankCard({
        partner_trade_no: row.cash_order.partner_trade_no,
        enc_bank_no: row.cash_order.card_code, //rsa算法
        enc_true_name: row.cash_order.true_name, //rsa算法
        bank_code: row.cash_order.card_bank_code,
        amount: row.cash_order.amount,
      });
      console.log("77777777777777777777");
      // console.log(orderInfo);
      console.log(returnParams);
      return this.success(returnParams);
    } catch (err) {
      // console.log(err);
      return this.fail(err.return_msg);
    }
  }
  //加密后提交银行处理
  async SubmissionToBankAction() {
    const row = this.post('info')
    const pub_key = this.post('pub_key')
    console.log(row);
    console.log(pub_key);
    if (think.isEmpty(pub_key)) {
      return this.fail(217, '异常 !');
    }
    let RSA_PUBLIC_KEY = pub_key
    var NodeRSA = require('node-rsa');
    let clientKey = new NodeRSA(RSA_PUBLIC_KEY)
    clientKey.setOptions({encryptionScheme: 'pkcs1_oaep'})
    let bank_code = row.cash_order.card_code
    let bank_code_rsaed = clientKey.encrypt(bank_code, 'base64')
    let true_name = row.cash_order.true_name
    let true_name_rsaed = clientKey.encrypt(true_name, 'base64')
    console.log(bank_code_rsaed,true_name_rsaed);
    const WeixinSerivce = this.service('weixin', 'admin');
    try {
      const returnParams = await WeixinSerivce.bankpay({
        partner_trade_no: row.cash_order.partner_trade_no,
        enc_bank_no: bank_code_rsaed, //rsa算法
        enc_true_name: true_name_rsaed, //rsa算法
        bank_code: row.cash_order.card_bank_code,
        amount: row.cash_order.amount,
      });
      console.log("77777777777777777777");
      // console.log(orderInfo);
      console.log(returnParams);
      return this.success(returnParams);
    } catch (err) {
      // console.log(err);
      return this.fail(err.return_msg);
    }
  }

  async notifyAction() {
    const WeixinSerivce = this.service('weixin', 'api');
    const result = WeixinSerivce.payNotify(this.post('xml'));
    if (!result) {
      return `<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[支付失败]]></return_msg></xml>`;
    }

    const orderModel = this.model('order');
    const orderInfo = await orderModel.getOrderByOrderSn(result.out_trade_no);
    if (think.isEmpty(orderInfo)) {
      return `<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[订单不存在]]></return_msg></xml>`;
    }

    if (orderModel.updatePayStatus(orderInfo.id, 2)) {
    } else {
      return `<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[订单不存在]]></return_msg></xml>`;
    }

    return `<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>`;
  }
};
