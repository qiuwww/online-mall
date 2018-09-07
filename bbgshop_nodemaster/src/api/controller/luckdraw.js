const Base = require('./base.js');

module.exports = class extends Base {
  async selectallluckdrawlistAction() {
    const data = await this.model('luckdraw').where({abled:1,is_del:0}).select()
    return this.success(data)
  }
  async findinfoAction() {
    const id = this.post('id')
    console.log(id);
    const luckmain = await this.model('luckdraw').where({id:id}).find()
    if (think.isEmpty(luckmain)) {
      return this.fail(17,'异常 ！没有此抽奖 !')
    }else {
      const goods = await this.model('goods').where({id:luckmain.luck_goods_id}).find()
      const loopimage = await this.model('goods_gallery').where({goods_id:luckmain.luck_goods_id}).select()
      luckmain.goods = goods
      luckmain.loopimage = loopimage
      return this.success({
        luckmain: luckmain
      })
    }
  }
  async checkisjoinAction() {
    const userinfo = this.post('userinfo')
    const id = this.post('drawid')
    // console.log(userinfo,id);
    const have  = await this.model('luckdraw_user').where({
      luckdraw_main_id:id,
      join_user_id:userinfo.userInfo.id,
      join_user_openid:userinfo.sessionData.openid}).select()
    if (have.length > 0) {
      return this.fail(17,'用户已参与过此抽奖 !')
    }else {
      return this.success(have)
    }
  }
  async joinluckdrawAction() {
    const userinfo = this.post('userinfo')
    const id = this.post('drawid')
    console.log(userinfo,id);
    const luckmain = await this.model('luckdraw').where({id:id}).find()
    await this.model('luckdraw').where({id:id}).update({
      have_join_people_num: Number(luckmain.have_join_people_num) + 1
    })
    const data = await this.model('luckdraw_user').add({
      luckdraw_main_id:id,
      join_user_id:userinfo.userInfo.id,
      join_user_nickname: userinfo.userInfo.nickname,
      join_user_avatar: userinfo.userInfo.avatar,
      join_user_openid: userinfo.sessionData.openid,
    })

    return this.success(data)
  }
  async findjoinpeopleAction() {
    const id = this.post('id')
    const data = await this.model('luckdraw_user').order(['id DESC']).where({luckdraw_main_id:id}).limit(7).select()
    return this.success(data)
  }
  async selectalljoinerAction() {
    const id = this.post('id')
    const data = await this.model('luckdraw_user').where({luckdraw_main_id:id}).select()
    return this.success(data)
  }
  async findlucklypeopleAction() {
    const luckly = this.post('luckid')
    const id = this.post('id')
    console.log("中奖id");
    let luckly_list = luckly.split(',')
    console.log(luckly_list);
    console.log("id");
    console.log(id);
    let luckly_people_list = []
    for (var i = 0; i < luckly_list.length; i++) {
      let obj = {}
      obj  = await this.model('user').where({id:luckly_list[i]}).find()
      // console.log(obj);
      luckly_people_list.push(obj)
    }
    return this.success(luckly_people_list)
    // console.log(luckly);
  }
  async checkisgetAction() {
    const luckgoods = this.post('luckgoods')
    const luckid = this.post('luckid')
    const userInfo = this.post('userInfo')
    console.log(luckgoods);
    console.log(userInfo);
    const order = await this.model('order').where({
      user_id: userInfo.id,
      pay_id: 3,
      luckdraw_id: luckid
    }).select()
    if (order.length > 0) {
      return this.fail(17,'已经领取过此抽奖 !')
    }else if (order.length == 0) {
      return this.fail(503,'可以领取 !')
    }
  }
  async lucksetorderAction() {
    const _ = require('lodash');
    const addressInfo = this.post('addressInfo')
    const luckid = this.post('luckid')
    const luckgoods = this.post('luckgoods')
    const userInfo = this.post('userInfo')
    console.log(addressInfo);
    console.log(luckgoods);
    console.log(userInfo);

    const date = new Date();
    let sn = date.getFullYear() + _.padStart(date.getMonth()+1, 2, '0') + _.padStart(date.getDate(), 2, '0')
    + _.padStart(date.getHours(), 2, '0') + _.padStart(date.getMinutes(), 2, '0')
    + _.padStart(date.getSeconds(), 2, '0') +  _.random(100000, 999999);
    console.log(sn);
    var tmp = Date.parse( new Date() ).toString();
    tmp = tmp.substr(0,10);

    // const barmain = await this.model("bargain").where({
    //   goodsid:bargaingoods.goods_id,
    // }).find()
    // await this.model('bargain_user').where({
    //   goods_sku_id:bargaingoods.goods_sku_id,
    // }).update({ iscut: '2',order_sn:sn })
    // await this.model("bargain").where({
    //   goodsid:bargaingoods.goods_id,
    // }).update({
    //   purchased_num:parseInt(barmain.purchased_num) + 1
    // })

    // let sn = new Data().getTime()

    const order = await this.model('order').add({
      order_sn:sn,
      user_id:userInfo.id,
      order_status: 0 ,
      consignee:addressInfo.name,
      country:addressInfo.country_id,
      province:addressInfo.province_id,
      city:addressInfo.city_id,
      district:addressInfo.district_id,
      address:addressInfo.address,
      mobile:addressInfo.mobile,
      postscript:'',
      shipping_fee: luckgoods.retail_price,
      pay_name:'抽奖订单',
      pay_id: 3 ,
      actual_price: 0.00,
      order_price: 0.00,
      goods_price: luckgoods.retail_price,
      add_time: tmp,
      goods_sku_id: 0,
      luckdraw_id: luckid,
      // confirm_time: 0 ,
    })
    console.log(order);
    const order_goods = await this.model("order_goods").add({
      order_id: parseInt(order),
      goods_id: luckgoods.id,
      goods_sn: luckgoods.goods_sn,
      product_id: 0,
      goods_name: luckgoods.name,
      list_pic_url: luckgoods.list_pic_url,
      market_price: 0.00,
      retail_price: 0.00,
      number: 1,
      goods_specifition_name_value: '无',
      goods_specifition_ids: 0
    })

    return this.success({
      ordersn:sn,
      orderPrice: 0.00
    })

  }


};
