const _ = require('lodash');

module.exports = class extends think.Model {
  // 以下为重构的订单状态
  // /**
  //  * 生成订单的编号order_sn
  //  * @returns {string}
  //  */
  // generateOrderNumber() {
  //   const date = new Date();
  //   return date.getFullYear() + _.padStart(date.getMonth()+1, 2, '0') + _.padStart(date.getDate(), 2, '0')
  //   + _.padStart(date.getHours(), 2, '0') + _.padStart(date.getMinutes(), 2, '0')
  //   + _.padStart(date.getSeconds(), 2, '0') +  _.random(100000, 999999);
  // }
  /**
   * 获取订单可操作的选项
   * @param orderId
   * @returns {Promise.<{cancel: boolean, delete: boolean, pay: boolean, comment: boolean, delivery: boolean, confirm: boolean, return: boolean}>}
   */
  async GetOrderHandleOption_Rest(orderId) {
    const handleOption = {
      cancel: false, // 取消操作
      delete: false, // 删除操作
      pay: false, // 支付操作
      comment: false, // 评论操作
      delivery: false, // 确认收货操作
      confirm: false, // 完成订单操作
      return: false, // 退换货操作
      buy: false, // 再次购买
      logistics: false // 查看物流
    };

    const orderInfo = await this.where({id: orderId}).find();

    // 订单流程：下单成功－》支付订单－》发货－》收货－》评论

    if (orderInfo.order_status === 2) { //被动取消订单 （如超时未支付）
      handleOption.buy = true //再次购买
      handleOption.delete = true // 删除订单  操作后状态更新为 1
    }

    // //正常状态  订单已生成但用户未付款
    if (orderInfo.order_status === 101) {
      handleOption.pay = true // 支付操作 支付成功后状态更新为200 支付失败更新为102 或 103
      handleOption.cancel = true // 取消订单  操作后状态更新为 2
    }

    ////异常状态 订单支付失败  主动支付失败 （网络原因或其他原因）
    if (orderInfo.order_status === 102) {
      handleOption.pay = true // 支付操作  102 的付款失败 后续 支付成功后状态更新为200 支付失败更新为 102 或 103
      handleOption.cancel = true // 取消订单  操作后状态更新为 2
    }

    // //异常状态 订单支付失败  被动支付失败 （适用于需要生成订单后被动判断是否付款成功的情况）（如拼团失败）
    if (orderInfo.order_status === 103) {
      handleOption.cancel = true // 取消订单  操作后状态更新为 2
      handleOption.delete = true  // 删除订单  操作后状态更新为 1
    }

    ////正常状态 订单已被支付且支付成功 或进行中的订单状态更新
    if (orderInfo.order_status === 200) {
      handleOption.return = true  //退款或售后服务
      handleOption.cancel = true  // 取消订单  操作后状态更新为 2
    }

    /////异常状态 订单后台发货失败 （异常状态）
    if (orderInfo.order_status === 201) {
      handleOption.return = true  //退款或售后服务
    }
    // //正常状态 订单已在后台发货
    if (orderInfo.order_status === 300) {
      handleOption.logistics = true //查看物流
      handleOption.delivery = true  // 确认收货操作 （确认物流到达）
    }

    // //异常状态 物流发生异常  （可发起退款）
    if (orderInfo.order_status === 301) {
      handleOption.logistics = true //查看物流
      handleOption.return = true  //退款或售后服务
    }

    ////正常状态 物流已被签收但用户未确认收货
    if (orderInfo.order_status === 302) {
      handleOption.logistics = true //查看物流
      handleOption.delivery = true  // 确认收货操作 （确认物流到达）
    }

    //正常状态 物流已被签收且用户已确认收货 （伪状态 已完成）
    if (orderInfo.order_status === 400) {
      handleOption.comment = true  // 评论操作
      handleOption.buy = true //再次购买
    }

    ////正常状态 订单已评价
    if (orderInfo.order_status === 401) {
      handleOption.buy = true  //再次购买
      handleOption.delete = true  // 删除订单  操作后状态更新为 1
    }

    //////正常状态 订单完全完成 如确认收货后七天后订单已完全完成 （结算分销员提成）
    if (orderInfo.order_status === 506) {
      handleOption.buy = true //再次购买
      handleOption.delete = true  // 删除订单  操作后状态更新为 1
    }

    return handleOption;
  }
  /**
    订单状态对应的状态

  */
  async GetOrderStatusText_Rest(orderId) {
    const orderInfo = await this.where({id: orderId}).find();
    let statusText = '';
    switch (orderInfo.order_status) {
      case 1: statusText = '已删除'; //用户主动删除订单 // 用户主动删除订单不会再前台显示 所以没有可用操作
        break;
      case 2: statusText = '已取消'; //超出时间订单未支付 被动取消
        break;
      case 101: statusText = '未付款'; //正常状态  订单已生成但用户未付款
        break;
      case 102: statusText = '付款失败'; //异常状态 订单支付失败  主动支付失败 （网络原因或其他原因）
        break;
      case 103: statusText = '付款失败'; //异常状态 订单支付失败  被动支付失败 （适用于需要生成订单后被动判断是否付款成功的情况）（如拼团失败）
        break;
      case 107: statusText = '进行中'; //半异常状态  适用于订单生成但需要被动支付 （仅有拼团）（用户付款后生成已付款订单参与拼团，拼团成功后变为200）
        //此状态下按具体情况 不能有订单的相关操作
        break;
      case 200: statusText = '待发货'; //正常状态 订单已被支付且支付成功 或进行中的订单状态更新
        break;
      case 201: statusText = '发货失败'; //异常状态 订单后台发货失败 （异常状态）
        //极少数异常状态
        break;
      case 300: statusText = '待收货'; //正常状态 订单已在后台发货
        break;
      case 301: statusText = '物流异常'; //异常状态 物流发生异常  （可发起退款）
        //极少数异常状态
        break;
      case 302: statusText = '物流已完成'; //正常状态 物流已被签收但用户未确认收货
        break;
      case 400: statusText = '待评价'; //正常状态 物流已被签收且用户已确认收货 （伪状态 已完成）
        break;
      case 401: statusText = '已完成'; //正常状态 订单已评价
        break;
      case 506: statusText = '已完成'; //正常状态 订单完全完成 如确认收货后七天后订单已完全完成 （结算分销员提成）
        break;
    }
    return statusText;
  }
  // 、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、
  /**
   * 生成订单的编号order_sn
   * @returns {string}
   */
  generateOrderNumber() {
    const date = new Date();
    return date.getFullYear() + _.padStart(date.getMonth()+1, 2, '0') + _.padStart(date.getDate(), 2, '0')
    + _.padStart(date.getHours(), 2, '0') + _.padStart(date.getMinutes(), 2, '0')
    + _.padStart(date.getSeconds(), 2, '0') +  _.random(100000, 999999);
  }

  /**
   * 获取订单可操作的选项
   * @param orderId
   * @returns {Promise.<{cancel: boolean, delete: boolean, pay: boolean, comment: boolean, delivery: boolean, confirm: boolean, return: boolean}>}
   */
  async getOrderHandleOption(orderId) {
    const handleOption = {
      cancel: false, // 取消操作
      delete: false, // 删除操作
      pay: false, // 支付操作
      comment: false, // 评论操作
      delivery: false, // 确认收货操作
      confirm: false, // 完成订单操作
      return: false, // 退换货操作
      buy: false // 再次购买
    };

    const orderInfo = await this.where({id: orderId}).find();

    // 订单流程：下单成功－》支付订单－》发货－》收货－》评论
    // 订单相关状态字段设计，采用单个字段表示全部的订单状态
    // 1xx表示订单取消和删除等状态 0订单创建成功等待付款，101订单已取消，102订单已删除
    // 2xx表示订单支付状态,201订单已付款，等待发货
    // 3xx表示订单物流相关状态,300订单已发货，301用户确认收货
    // 4xx表示订单退换货相关的状态,401没有发货，退款402,已收货，退款退货
    // 如果订单已经取消或是已完成，则可删除和再次购买
    if (orderInfo.order_status === 101) {
      handleOption.delete = true;
      handleOption.buy = true;
    }

    // 如果订单没有被取消，且没有支付，则可支付，可取消
    if (orderInfo.order_status === 0) {
      handleOption.cancel = true;
      handleOption.pay = true;
    }

    // 如果订单已付款，没有发货，则可退款操作
    if (orderInfo.order_status === 201) {
      handleOption.return = true;
    }

    // 如果订单已经发货，没有收货，则可收货操作和退款、退货操作
    if (orderInfo.order_status === 300) {
      handleOption.cancel = true;
      handleOption.pay = true;
      handleOption.return = true;
    }

    // 如果订单已经支付，且已经收货，则可完成交易、评论和再次购买
    if (orderInfo.order_status === 301) {
      handleOption.delete = true;
      handleOption.comment = true;
      handleOption.buy = true;
    }

    return handleOption;
  }

  async getOrderStatusText(orderId) {
    const orderInfo = await this.where({id: orderId}).find();
    let statusText = '';
    switch (orderInfo.order_status) {
      case 0:
        statusText = '待付款';
        break;
      case 201:
        statusText = '待发货';
        break;
      case 300:
        statusText = '待收货';
        break;
      case 301:
        statusText = '已完成';
        break;
      case 400:
        statusText = '退款中';
        break;
      case 503:
        statusText = '已完成';
        break;
    }
    return statusText;
  }

  /**
   * 更改订单支付状态
   * @param orderId
   * @param payStatus
   * @returns {Promise.<boolean>}
   */
  // async updatePayStatus(orderId, payStatus = 0) {
  //   return this.where({id: orderId}).limit(1).update({pay_status: parseInt(payStatus)});
  // }

  /**
   * 根据订单编号查找订单信息
   * @param orderSn
   * @returns {Promise.<Promise|Promise<any>|T|*>}
   */
  async getOrderByOrderSn(orderSn) {
    if (think.isEmpty(orderSn)) {
      return {};
    }
    return this.where({order_sn: orderSn}).find();
  }
};
