const Base = require('./base.js');
const moment = require('moment');

module.exports = class extends Base {
  /**
   * 获取订单列表
   * @return {Promise} []
   */
  async listAction() {
    const index = this.post('index')
    let state = ''
    // let orderListno = []
    if(parseInt(index) == 0){state = 0} // 如果订单没有被取消，且没有支付，则可支付，可取消
    if(parseInt(index) == 1){state = 201} //如果订单已付款，没有发货，则可退款操作
    if(parseInt(index) == 2){state = 300}  // 如果订单已经发货，没有收货，则可收货操作和退款、退货操作
    if(parseInt(index) == 3){state = 301}  // 如果订单已经支付，且已经收货，则可完成交易、评论和再次购买  //已完成
    if(parseInt(index) == 4){
      const refundList = await this.model('order_refund').where({ user_id: think.userId,abled:0,isRefund:0,state:1001}).select();
      console.log(refundList);
      let list = []
      for (var i = 0; i < refundList.length; i++) {
        // array[i]
        let obj = {}
        obj = await this.model('order').where({ order_sn: refundList[i].order_sn,is_del:0}).find();
        obj.refund_sn = refundList[i].refund_sn
        obj.state = refundList[i].state
        obj.state_text = refundList[i].state_text
        obj.back_state = refundList[i].back_state

        list.push(obj)
      }
      const orderList = list
      // console.log("orderList");
      // console.log(orderList);
      // return orderListno
      const newOrderList = [];
      for (const item of orderList) {
        // 订单的商品
        item.goodsList = await this.model('order_goods').where({ order_id: item.id }).select();
        item.goodsCount = 0;
        item.goodsList.forEach(v => {
          item.goodsCount += v.number;
        });
        // 订单状态的处理
        item.order_status_text = await this.model('order').getOrderStatusText(item.id);
        // 可操作的选项
        item.handleOption = await this.model('order').getOrderHandleOption(item.id);
        newOrderList.push(item);
      }
      orderList.data = newOrderList;
      return this.success(orderList);
       // 退款中 售后中
    }else {

      const orderList = await this.model('order').where({ user_id: think.userId,order_status:state,is_del:0}).select();
      // console.log(orderList);
      const newOrderList = [];
      for (const item of orderList) {
        // 订单的商品
        // console.log(item);
        item.goodsList = await this.model('order_goods').where({ order_id: item.id }).select();
        item.goodsCount = 0;
        item.goodsList.forEach(v => {
          item.goodsCount += v.number;
        });
        // 订单状态的处理
        item.order_status_text = await this.model('order').getOrderStatusText(item.id);
        // 可操作的选项
        // item.handleOption_TRUE = await this.model('order').GetOrderStatusAndHandel(item.id);
        item.handleOption_TRUE = await this.model('order').GetOrderHandleOption_Rest(item.id);
        item.OrderStatus_TRUE = await this.model('order').GetOrderStatusText_Rest(item.id);

        item.handleOption = await this.model('order').getOrderHandleOption(item.id);
        newOrderList.push(item);
      }
      // console.log(newOrderList);
      orderList.data = newOrderList;
      return this.success(orderList);
      // console.log(orderListno);
      // let aa = orderListno
      // return orderListno

    }
    // console.log(aa);
    // console.log(orderListno);
    // let aa =
    // const orderList = orderListno

    // if(parseInt(index) == 4){state = 503}  // 已完成
    // console.log(state);

  }
  async checkorderispayAction() {
    const sn = this.post('orderId')
    console.log(sn);
    const orderInfo = await this.model('order').where({ order_sn: sn }).find();
    if (orderInfo.order_status == 0) {
      return this.fail(17,'订单未支付')
    }else {
      return this.fail(506,'订单已支付')

    }

  }
  async detailAction() {
    const orderId = this.get('orderId');
    const orderInfo = await this.model('order').where({ id: orderId }).find();
    const refundInfo = await this.model('order_refund').where({order_sn:orderInfo.order_sn}).select()
    if (think.isEmpty(orderInfo)) {
      return this.fail('订单不存在');
    }

    orderInfo.province_name = await this.model('region').where({ id: orderInfo.province }).getField('name', true);
    orderInfo.city_name = await this.model('region').where({ id: orderInfo.city }).getField('name', true);
    orderInfo.district_name = await this.model('region').where({ id: orderInfo.district }).getField('name', true);
    orderInfo.full_region = orderInfo.province_name + orderInfo.city_name + orderInfo.district_name;

    const latestExpressInfo = await this.model('order_express').getLatestOrderExpress(orderId);
    orderInfo.express = latestExpressInfo;

    const orderGoods = await this.model('order_goods').where({ order_id: orderId }).select();

    // 订单状态的处理
    orderInfo.order_status_text = await this.model('order').getOrderStatusText(orderId);
    orderInfo.add_time = orderInfo.add_time
    orderInfo.final_pay_time = moment('001234', 'Hmmss').format('mm:ss');
    // 订单最后支付时间
    if (orderInfo.order_status === 0) {
      // if (moment().subtract(60, 'minutes') < moment(orderInfo.add_time)) {
      orderInfo.final_pay_time = moment('001234', 'Hmmss').format('mm:ss');
      // } else {
      //     //超过时间不支付，更新订单状态为取消
      // }
    }

    // 订单可操作的选择,删除，支付，收货，评论，退换货
    const handleOption = await this.model('order').getOrderHandleOption(orderId);

    return this.success({
      orderInfo: orderInfo,
      refundInfo: refundInfo,
      orderGoods: orderGoods,
      handleOption: handleOption
    });
  }
  /**
   * 取消订单
   * @returns {Promise.<void>}
   */
   async cancelAction() {
     const orderId = this.get("orderId")
     // DELETE FROM 表名称 WHERE 列名称 = 值
     // const cancelorderList = await this.model('order').where({ user_id: think.userId, id: orderId }).update({ order_status: "1"});
     const cancelorderList = await this.model('order').where({ user_id: think.userId, id: orderId }).update({is_del:1});
     let pruids = await this.model('order_goods').where({order_id:orderId}).select()
     for (var i = 0; i < pruids.length; i++) {
       // array[i]
       let productlis = await this.model('product').where({id:pruids[i].product_id}).find()
       await this.model('product').where({id:pruids[i].product_id}).update({
         goods_number:parseInt(productlis.goods_number)+1
       })

     }
     return this.success({
       orderId,cancelorderList

     })
   }
  /**
   * 提交订单
   * @returns {Promise.<void>}
   */
  async submitAction() {
    // 获取收货地址信息和计算运费
    const addressId = this.post('addressId');
    const GoodsList = this.post('GoodsList');
    // 留言
    const postscript = this.post('postscript');
    const freightPrice = this.post('freightPrice')
    const couponPrice = this.post('couponPrice')
    const goodsTotalPrice = this.post('goodsTotalPrice')
    const couponId = this.post('couponId')
    const userId = this.post('userId')
    const actualPrice = this.post('actualPrice');
    const userDiscount_Price = this.post('userDiscount_Price')
    const IdentityInput = this.post('IdentityInput')
    // const supplier_ids = this.post('supplier_ids')
    const checkedAddress = await this.model('address').where({ id: addressId }).find();
    if (think.isEmpty(checkedAddress)) {
      return this.fail('请选择收货地址');
    }
    console.log("*********************************************************");
    console.log(IdentityInput);

    // 获取要购买的商品
    const checkedGoodsList = await this.model('cart').where({ user_id: userId, session_id: 1, checked: 1 }).select();
    if (think.isEmpty(checkedGoodsList)) {
      return this.fail('请选择商品');
    }
    const orderTotalPrice = (Number(goodsTotalPrice) + Number(freightPrice) - Number(couponPrice)).toFixed(2); // 订单的总价
    // const actualPrice = (Number(orderTotalPrice) / 1).toFixed(2) ;

    // const actualPrice = rlPrice
    // console.log(parseInt(couponId));
    if (parseInt(couponId) == 0) {
      // let checkcup = []
      console.log('没有选择优惠券');
    }else {
      console.log('选择了优惠券');
      // let checkcup = await this.model('coupon_user').where({user_id: userId,coupon_id:couponId}).find()
    }
    const checkedcouponlist = parseInt(couponId) == 0 ? [] : await this.model('coupon_user').where({coupon_id:couponId}).find()
    console.log(checkedcouponlist);
    const currentTime = new Date().getTime()
    for (var p = 0;p < GoodsList.length; p++){
      const product = await this.model('product').where({id:GoodsList[p].product_id}).find()
      await this.model('product').where({id:GoodsList[p].product_id}).update({
        goods_number:parseInt(product.goods_number) - 1
      })
    }
    let couponUpdate = parseInt(couponId) == 0 ? '' : await this.model('coupon_user').where({coupon_id:couponId}).update({
      used_type: 1,
      used_time: new Date().getTime()
    })
    console.log(couponUpdate);
    const orderInfo = {
      order_sn: this.model('order').generateOrderNumber(),
      user_id: think.userId,
      // 收货地址和运费
      consignee: checkedAddress.name,
      mobile: checkedAddress.mobile,
      province: checkedAddress.province_id,
      city: checkedAddress.city_id,
      district: checkedAddress.district_id,
      address: checkedAddress.address,
      freight_price: freightPrice,
      Identity_Input: IdentityInput,
      //供货商
      // supplier_ids: supplier_ids,
      // 留言
      postscript: postscript,
      // 使用的优惠券
      coupon_id: couponId,
      checkedcoupon_list:checkedcouponlist,
      coupon_price: couponPrice,
      user_level_discount: userDiscount_Price,
      add_time: currentTime,
      goods_price: goodsTotalPrice,
      order_price: orderTotalPrice,
      actual_price: actualPrice
    };
    console.log(orderInfo);
    //开启事务，插入订单信息和订单商品
    const orderId = await this.model('order').add(orderInfo);
    orderInfo.id = orderId;
    if (!orderId) {
      return this.fail('订单提交失败');
    }

    // 统计商品总价
    const orderGoodsData = [];
    for (const goodsItem of checkedGoodsList) {
      orderGoodsData.push({
        order_id: orderId,
        goods_id: goodsItem.goods_id,
        goods_sn: goodsItem.goods_sn,
        product_id: goodsItem.product_id,
        goods_name: goodsItem.goods_name,
        list_pic_url: goodsItem.list_pic_url,
        market_price: goodsItem.market_price,
        retail_price: goodsItem.retail_price,
        number: goodsItem.number,
        goods_specifition_name_value: goodsItem.goods_specifition_name_value,
        goods_specifition_ids: goodsItem.goods_specifition_ids,
        supplier_id: goodsItem.supplier_id ? goodsItem.supplier_id : '',
        add_time: new Date().getTime(),
        is_Identity: goodsItem.Identity,
        Identity_Input: goodsItem.Identity == 1 ? IdentityInput : 0,
      });
    }

    await this.model('order_goods').addMany(orderGoodsData);
    await this.model('cart').clearBuyGoods();

    return this.success({ orderInfo: orderInfo });
  }


/**
 * 查询
 * @returns {Promise.<void>}
 */
async expressAction() {
  const orderId = this.get('orderId');
  if (think.isEmpty(orderId)) {
    return this.fail('订单不存在');
  }
  const latestExpressInfo = await this.model('order_express').getLatestOrderExpress(orderId);
  return this.success(latestExpressInfo);
}
};
