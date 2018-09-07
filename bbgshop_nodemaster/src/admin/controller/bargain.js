const Base = require('./base.js');

module.exports = class extends Base {
  async findbargaininfoByIdAction() {
    const id = this.post('id')
    const data = await this.model('bargain').where({id:id}).find()
    return this.success(data)
  }
  async bargainupdateAction() {
    const id = this.post('id')
    const bargain = this.post('bargain')
    const data = await this.model('bargain').where({id:id}).update({
      lowest_price: bargain.BargainMinPrice,
      most_init_num: bargain.BargainInitNumber,
      least_cut_num: bargain.BargainPeople,
      activity_detail: bargain.BargainDetailEdit,
    })
    return this.success(data)
  }
  /**00
   * index action
   * @return {Promise} []
   */
  async indexAction() {
    const page = this.get('page') || 1;
    const size = this.get('size') || 10;
    const couponname = this.get('couponname') || '';
    // const consignee = this.get('consignee') || '';
    console.log(couponname);
    const model = this.model('coupon_main');
    const data = await model.where({coupon_name: ['like', `%${couponname}%`]}).order(['id DESC']).page(page, size).countSelect();
    console.log(data);
    // const newList = [];
    // for (const item of data.data) {
    //   item.order_status_text = await this.model('order').getOrderStatusText(item.id);
    //   newList.push(item);
    // }
    // data.data = newList;
    return this.success(data);
  }

  /**
   * index action  添加砍价商品
   * @return {Promise} []
   */
  async bargaingoodsAction() {
    const page = this.get('page') || 1;
    const size = this.get('size') || 5;
    const goodsname = this.get('goodsname') || '';
    // const consignee = this.get('consignee') || '';

    const model = this.model('goods');
    const data = await model.where({name: ['like', `%${goodsname}%`]}).order(['id DESC']).page(page, size).countSelect();
    return this.success(data);
  }
  /**
   * index action  数据库添加数据 砍价商品
   * @return {Promise} []
   */
  async bargainstoreAction() {
    const bargain = this.post('bargain')
    const goods = this.post('goods')
    console.log(bargain);
    // console.log(bargain.LimitTimeUnix[0]);
    // console.log(bargain.LimitTimeUnix[1]);
    // console.log(bargain.BargainUserDurationUnix);
    const data = await this.model('bargain').add({
      goodsid: goods.id,
      goods_name: goods.name,
      create_time: bargain.create_time,
      start_time: bargain.LimitTimeUnix[0],
      end_time: bargain.LimitTimeUnix[1],
      user_duration_time: bargain.BargainUserDurationUnix,
      retail_price: goods.retail_price,
      lowest_price: bargain.BargainMinPrice,
      most_init_num: bargain.BargainInitNumber,
      least_cut_num: bargain.BargainPeople,
      only_cut_num: bargain.BargainPeopleTime,
      activity_rule: bargain.RulesActivity,
      activity_detail: bargain.BargainDetailEdit,
      purchased_num: 0,
      launched_num: 0,
    })
    return this.success(data);
  }

  /**
   * index action  查找砍价商品
   * @return {Promise} []
   */
  async findbargainAction() {
    const page = this.get('page') || 1;
    const size = this.get('size') || 10;
    const goodsname = this.get('goodsname') || '';
    // const consignee = this.get('consignee') || '';

    const model = this.model('bargain');
    const data = await model.where({goods_name: ['like', `%${goodsname}%`]}).order(['id DESC']).page(page, size).countSelect();
    return this.success(data);
  }
  /**
   * index action  查找砍价商品
   * @return {Promise} []
   */
  async setbarableAction() {
    const id = this.post('id')
    const abled = this.post('data')
    // const page = this.get('page') || 1;
    // const size = this.get('size') || 5;
    // const goodsname = this.get('goodsname') || '';
    // const consignee = this.get('consignee') || '';

    const model = this.model('bargain');
    const data = await model.where({id: id}).update({
      is_abled:abled
    });
    // const data = await model.where({ id: id).update({
    //
    // });
    // const data = await model.where({goods_name: ['like', `%${goodsname}%`]}).order(['id DESC']).page(page, size).countSelect();
    return this.success(data);
  }
  async delbarAction() {
    const id = this.post('id');
    await this.model('bargain').where({id: id}).limit(1).delete();

    // 删除订单商品
    // await this.model('order_goods').where({order_id: id}).delete();

    // TODO 事务，验证订单是否可删除（只有失效的订单才可以删除）

    return this.success();
  }
};
