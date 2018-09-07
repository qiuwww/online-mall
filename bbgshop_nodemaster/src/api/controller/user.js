const Base = require('./base.js');
const fs = require('fs');
const _ = require('lodash');

module.exports = class extends Base {
  async getuserlevelinfoAction() {
    const userId = this.post('userId')
    console.log(userId);
    const data = await this.model('user').where({id:userId}).field(['user_all_price', 'user_recharge_monery', 'user_level', 'user_discount']).find()
    const rechange_list = await this.model('rechange_order').order(['id DESC']).where({user_id:userId}).select()
    const level_list = await this.model('user_level').order(['recharge_monery ASC']).select()
    return this.success({
      data: data,
      rechange_list: rechange_list,
      level_list: level_list
    })
  }
  async setrechangeorderAction() {
    const userId = this.post('userId')
    const rechangePrice = this.post('rechangePrice')
    console.log(userId,rechangePrice);
    const date = new Date();
    let order_sn = date.getFullYear() + _.padStart(date.getMonth()+1, 2, '0') + _.padStart(date.getDate(), 2, '0')
    + _.padStart(date.getHours(), 2, '0') + _.padStart(date.getMinutes(), 2, '0')
    + _.padStart(date.getSeconds(), 2, '0')
    console.log(order_sn);
    const data = await this.model('rechange_order').add({
      order_sn:order_sn,
      add_time: new Date().getTime(),
      rechange_price: Number(rechangePrice),
      user_id: userId
    })
    return this.success(data)
    // const openid = await this.model('user').where({ id:userId }).getField('weixin_openid', true);
    // if (think.isEmpty(openid)) {
    //   return this.fail('openid为空');
    // }
    // const WeixinSerivce = this.service('weixin', 'api');
    // try {
    //   const returnParams = await WeixinSerivce.createUnifiedOrder({
    //     openid: openid,
    //     body: '编号:' + order_sn,
    //     out_trade_no: order_sn,
    //     total_fee: parseInt(Number(rechangePrice) * 100),
    //     spbill_create_ip: '',
    //   });
    //   return this.success(returnParams);
    // } catch (err) {
    //   // console.log(err);
    //   return this.fail(err.return_msg);
    // }

  }
  async payrechangeorderAction() {
    const id = this.post('orderId')
    const orderInfo = await this.model('rechange_order').where({id:id}).find()
    const openid = await this.model('user').where({ id: orderInfo.user_id }).getField('weixin_openid', true);
    if (think.isEmpty(openid)) {
      return this.fail('openid为空');
    }
    const WeixinSerivce = this.service('weixin', 'api');
    try {
      const returnParams = await WeixinSerivce.createUnifiedOrder({
        openid: openid,
        body: '编号:' + orderInfo.order_sn,
        out_trade_no: orderInfo.order_sn,
        total_fee: parseInt(Number(orderInfo.rechange_price) * 100),
        spbill_create_ip: '',
      });
      return this.success(returnParams);
    } catch (err) {
      // console.log(err);
      return this.fail(err.return_msg);
    }
  }
  async setrechangeorderstatusAction() {
    const id = this.post('orderId')
    const status = this.post('status')
    const info = await this.model('rechange_order').where({id:id}).find()
    await this.model('rechange_order').where({id:id}).update({
      pay_status: 1
    })
    const user = await this.model('user').where({id:info.user_id}).find()
    console.log(user);
    console.log(info.rechange_price);
    console.log(user.user_recharge_monery);
    console.log(Number(user.user_recharge_monery) + Number(info.rechange_price));
    const data = await this.model('user').where({id:info.user_id}).update({
      user_recharge_monery: Number(user.user_recharge_monery) + Number(info.rechange_price)
    })
    return this.success(data)
  }

};
