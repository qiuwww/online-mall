/* eslint-disable no-multi-spaces */
const Base = require('./base.js');
const _ = require('lodash');

module.exports = class extends Base {
  /**
   * 获取支付的请求参数
   * @returns {Promise<PreventPromise|void|Promise>}
   */
  async prepayAction() {
    const orderId = this.get('orderId');
    console.log(orderId);
    const orderInfo = await this.model('order').where({ order_sn: orderId }).find();
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
    const WeixinSerivce = this.service('weixin', 'api');
    console.log(WeixinSerivce);
    // console.log("9999999999");
    try {
      const returnParams = await WeixinSerivce.createUnifiedOrder({
        openid: openid,
        body: '编号:' + orderInfo.order_sn,
        out_trade_no: orderInfo.order_sn,
        total_fee: parseInt(orderInfo.actual_price * 100),
        spbill_create_ip: '',
      });
      // console.log(returnParams);
      console.log(orderInfo);
      console.log(orderInfo.coupon_id);
      if (orderInfo.coupon_id == 0) {

      }else {
        await this.model('coupon_user').where({coupon_id:orderInfo.coupon_id}).update({
          used_time: new Date().getTime(),
          used_type: 1
        })
      }
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

  /**
   * 支付订单
   * @returns {Promise.<void>}
   */
   async setorderAction() {
     const orderId = this.get("orderId")
     const status = this.get("status")
     console.log(status);
     console.log(parseInt(status));
     const orderInfo = await this.model('order').where({ order_sn: orderId}).find()
     const ordergoods = await this.model('order_goods').where({ order_id: orderInfo.id}).select()

     if (parseInt(status) == 201) {
       for (var i = 0; i < ordergoods.length; i++) {
         const goods_info = await this.model('goods').where({id:ordergoods[i].goods_id}).find()
         await this.model('goods').where({id:ordergoods[i].goods_id}).update({
           have_pay_num: Number(goods_info.have_pay_num) + 1
         })
       }
       const cancelorderList = await this.model('order').where({ order_sn: orderId}).update({
         order_status: status,
         pay_time:new Date().getTime()
       });
     }
     if (parseInt(status) == 301) {
       for (var j = 0; j < ordergoods.length; j++) {
         const goods_info = await this.model('goods').where({id:ordergoods[j].goods_id}).find()
         await this.model('goods').where({id:ordergoods[j].goods_id}).update({
           have_confirm_num: Number(goods_info.have_confirm_num) + 1
         })
       }
       const cancelorderList = await this.model('order').where({ order_sn: orderId}).update({
         order_status: status,
         confirLogic_time: new Date().getTime()
       });
       const userInfo = await this.model('user').where({id:orderInfo.user_id}).find()
       await this.model('user').where({id:orderInfo.user_id}).update({
         user_all_price: Number(userInfo.user_all_price) + Number(orderInfo.actual_price)
       })
     }
     const order = await this.model('order').where({ order_sn: orderId}).find()
     if (order.pay_id == 2) {
       const collageuser = await this.model('collage_user').where({order_id:order.id}).find()
       await this.model('collage_user').where({order_id:orderId}).update({
         is_pay:1,
         pay_time:new Date().getTime(),
         end_time: Number(collageuser.user_duration_time) + new Date().getTime(),
       })
       const collagemain = await this.model('collage').where({id:collageuser.collage_main}).find()
       await this.model('collage').where({id:collageuser.collage_main}).update({
         launched_num:parseInt(collagemain.launched_num) + 1
       })
     }
     return this.success({
       orderId
     })
   }
  //拼团订单支付
  async prepayCollageAction() {
    const orderId = this.get('orderId');
    console.log(orderId);
    console.log(orderId.length);
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
    const WeixinSerivce = this.service('weixin', 'api');
    try {
      const returnParams = await WeixinSerivce.createUnifiedOrder({
        openid: openid,
        body: '编号:' + orderInfo.order_sn,
        out_trade_no: orderInfo.order_sn,
        total_fee: Number(orderInfo.actual_price * 100),
        spbill_create_ip: '',
      });
      // console.log(returnParams);
      console.log(orderInfo);
      console.log(orderInfo.coupon_id);
      if (orderInfo.coupon_id == 0) {

      }else {
        await this.model('coupon_user').where({coupon_id:orderInfo.coupon_id}).update({
          used_time: new Date().getTime(),
          used_type: 1
        })
      }
      return this.success(returnParams);
    } catch (err) {
      // console.log(err);
      return this.fail(err.return_msg);
    }
  }

  async checkerrpriceAction() {
    const orderId = this.post("orderId")
    console.log(orderId);
    let order = parseInt(orderId)
    const ionfo = await this.model('order').where({order_sn:order}).find()
    if (ionfo.pay_id == 1) {
      const baruser = await this.model('bargain_user').where({
        order_sn:orderId
      }).find()
      await this.model('bargain_user').where({
        order_sn:orderId
      }).update({
        iscut: '3',
      })
      const barmain = await this.model('bargain').where({
        goodsid:baruser.goods_id
      }).find()
      await this.model('bargain').where({
        goodsid:baruser.goods_id
      }).update({
        purchased_num:parseInt(barmain.purchased_num) + 1
      })
      return this.fail(217,"正常！")

    }else if(ionfo.pay_id == 3){
      return this.fail(217,"正常！")
    }else {
      return this.fail(503,"异常！")
    }

  }

  async refundAction() {  //退款
    const ordersn = this.post("orderid")
    const refund_type = this.post("refund_type")
    const refund_reson = this.post("refund_reson")
    const refund_index = this.post("refund_index")
    const refund_uploadimg = this.post("refund_uploadimg")
    const refund_local_index = this.post("refund_local_index")
    const refundreson_index = this.post("refundreson_index")
    const refundreson_local_index = this.post("refundreson_local_index")
    const refund_order_price = this.post("refund_order_price")
    const refund_price = this.post("refund_price")
    console.log(ordersn,refund_type,refund_reson,refund_index,refund_local_index,refundreson_index,refundreson_local_index,refund_order_price,refund_price);
    let refund_order_id = 0
    const date = new Date();
    refund_order_id = date.getFullYear() + _.padStart(date.getMonth()+1, 2, '0') + _.padStart(date.getDate(), 2, '0')
    + _.padStart(date.getHours(), 2, '0') + _.padStart(date.getMinutes(), 2, '0')
    + _.padStart(date.getSeconds(), 2, '0') +  Math.random().toString(36).substr(2);
    console.log(refund_order_id);
    const have = await this.model('order_refund').where({order_sn:ordersn}).select()
    console.log(have);
    if (have.length == 0) {

      if (refund_type == 0) {
        await this.model('order').where({order_sn:ordersn}).update({order_status:400})
        const result = await this.model('order_refund').add({
          user_id:think.userId,
          refund_sn:refund_order_id.toUpperCase(),
          state: 1001,
          back_state: 201,
          state_text: '待受理',
          type:refund_type,
          order_sn:ordersn,
          refund_price:refund_price,
          reson:refund_reson,
          way_index:refund_index,
          way_value:refund_local_index,
          reson_index:refundreson_index,
          reson_value:refundreson_local_index,
          order_price:refund_order_price,
          creat_time:new Date().getTime()
        })
        return this.success(result)
      }else if (refund_type == 1){
        let imglist = []
        for (var l = 0; l < refund_uploadimg.length; l++) {
          console.log(refund_uploadimg[l]);
          let obj = {}
          obj = 'http://resource.bbgshop.com'+ refund_uploadimg[l].imageURL
          imglist.push(obj)
        }
        let refund_img = imglist.join(",")
        // console.log(refund_img);
        await this.model('order').where({order_sn:ordersn}).update({order_status:400})
        const result = await this.model('order_refund').add({
          user_id:think.userId,
          refund_sn:refund_order_id.toUpperCase(),
          type:refund_type,
          state: 1001,
          back_state: 300,
          state_text: '待受理',
          refund_img:refund_img,
          order_sn:ordersn,
          refund_price:refund_price,
          reson:refund_reson,
          way_index:refund_index,
          way_value:refund_local_index,
          reson_index:refundreson_index,
          reson_value:refundreson_local_index,
          order_price:refund_order_price,
          creat_time:new Date().getTime()
        })
        return this.success(result)
      }

    }else {
      if (refund_type == 0) {
        await this.model('order').where({order_sn:ordersn}).update({order_status:400})
        const result = await this.model('order_refund').where({order_sn:ordersn}).update({
          user_id:think.userId,
          refund_sn:refund_order_id.toUpperCase(),
          state: 1001,
          back_state: 201,
          state_text: '待受理',
          abled: 0,
          type:refund_type,
          refund_price:refund_price,
          reson:refund_reson,
          way_index:refund_index,
          way_value:refund_local_index,
          reson_index:refundreson_index,
          reson_value:refundreson_local_index,
          order_price:refund_order_price,
          creat_time:new Date().getTime()
        })
        return this.success(result)
      }else if (refund_type == 1){
        let imglist = []
        for (var l = 0; l < refund_uploadimg.length; l++) {
          console.log(refund_uploadimg[l]);
          let obj = {}
          obj = 'http://resource.bbgshop.com'+ refund_uploadimg[l].imageURL
          imglist.push(obj)
        }
        let refund_img = imglist.join(",")
        // console.log(refund_img);
        await this.model('order').where({order_sn:ordersn}).update({order_status:400})
        const result = await this.model('order_refund').where({order_sn:ordersn}).update({
          user_id:think.userId,
          refund_sn:refund_order_id.toUpperCase(),
          type:refund_type,
          state: 1001,
          back_state: 300,
          state_text: '待受理',
          abled: 0,
          refund_img:refund_img,
          refund_price:refund_price,
          reson:refund_reson,
          way_index:refund_index,
          way_value:refund_local_index,
          reson_index:refundreson_index,
          reson_value:refundreson_local_index,
          order_price:refund_order_price,
          creat_time:new Date().getTime()
        })
        return this.success(result)

    }
    }

  }
  async canelrefundAction() {
    const ordersn = this.post('ordersn')
    const backstate = this.post('backstate')
    await this.model('order_refund').where({order_sn:ordersn}).update({
      abled:1,
      del_time:new Date().getTime()
    })
    const result = await this.model('order').where({order_sn:ordersn}).update({
      order_status:parseInt(backstate)
    })
    return this.success(result)
  }


};
