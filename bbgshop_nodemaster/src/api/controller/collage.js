const Base = require('./base.js');

module.exports = class extends Base {
  async selectallcollagelistAction() {
    const data = await this.model('collage').where({is_delete:0,is_abled:1}).select()
    return this.success(data)
  }
  async findgoodsAction() {
    const goodsid = this.post('goodsid')
    const skuid = this.post('skuid')
    const collageid = this.post('collageid')
    console.log(goodsid,skuid,collageid);
    const goodslist = await this.model('goods').where({id:goodsid}).find()
    const skulist = await this.model('product').where({id:skuid}).find()
    const collagelist = await this.model('collage').where({id:collageid}).find()
    return this.success({
      goodslist:goodslist,
      skulist:skulist,
      collagelist:collagelist,
    });
  }
  async findCollageuaerAction() {
    const goodsid = this.post('goodsid')
    const userInfo = await this.model('user').where({ id: think.userId }).find();
    const goodslist = await this.model('goods').where({id:goodsid}).find()
    const have = await this.model('collage_user').where({
      user_id:userInfo.id,
      goodsid:goodslist.id,
      goods_name:goodslist.name,
    }).select()
    return this.success(have)
  }
  async setCollageorderAction() {
    const _ = require('lodash');
    const goodsid = this.post('goodsid')
    const skuid = this.post('skuid')
    const collageid = this.post('collageid')
    const addressid = this.post('addressid')
    const skuvalue = this.post('skuvalue')

    const userInfo = await this.model('user').where({ id: think.userId }).find();
    const goodslist = await this.model('goods').where({id:goodsid}).find()
    const skulist = await this.model('product').where({id:skuid}).find()
    const collagelist = await this.model('collage').where({id:collageid}).find()
    const addresslist = await this.model('address').where({id:addressid}).find()
    // const date = new Date();
    console.log(collagelist,skulist,goodslist);

    const have = await this.model('collage_user').where({
      user_id:userInfo.id,
      goodsid:goodslist.id,
      goods_name:goodslist.name,
    }).select()
    if (have.length == 0) {
      const date = new Date();
      let sn = date.getFullYear() + _.padStart(date.getMonth()+1, 2, '0') + _.padStart(date.getDate(), 2, '0')
      + _.padStart(date.getHours(), 2, '0') + _.padStart(date.getMinutes(), 2, '0')
      + _.padStart(date.getSeconds(), 2, '0') +  _.random(100000, 999999);
      console.log(sn);
      const orderId = await this.model('order').add({
        order_sn:sn,
        user_id:userInfo.id,
        order_status: 0 ,
        consignee:addresslist.name,
        country:addresslist.country_id,
        province:addresslist.province_id,
        city:addresslist.city_id,
        district:addresslist.district_id,
        address:addresslist.address,
        mobile:addresslist.mobile,
        postscript:'',
        // shipping_fee: bargaingoods.have_cut_price,
        pay_name:'拼团订单(Initiator)',
        pay_id: 2 ,
        collage_type: 0,
        actual_price: collagelist.collage_price,
        order_price: collagelist.collage_price,
        goods_price: goodslist.retail_price,
        add_time: new Date().getTime(),
        goods_sku_id: skulist.id
      })
      console.log(orderId);
      const ordergoods = await this.model('order_goods').add({
        order_id:orderId,
        goods_id:skulist.goods_id,
        goods_name:goodslist.name,
        goods_sn:skulist.goods_sn,
        product_id:skulist.id,
        number: 1,
        market_price: skulist.retail_price,
        retail_price: skulist.retail_price,
        goods_specifition_name_value: skuvalue,
        goods_specifition_ids: skulist.goods_specification_ids,
        list_pic_url:goodslist.list_pic_url
      })
      console.log(ordergoods);
      const collage_user = await this.model('collage_user').add({
        user_id:userInfo.id,
        collage_main:collageid,
        goodsid:goodslist.id,
        goods_name:goodslist.name,
        collage_price:collagelist.collage_price,
        retail_price:skulist.retail_price,
        most_init_num:collagelist.most_init_num,
        least_coll_num:collagelist.least_coll_num,
        create_time: new Date().getTime(),
        user_duration_time:collagelist.user_duration_time,
        virtual:collagelist.virtual,
        is_pay: 0,
        order_id: orderId,
        goods_sku_id: skulist.id,
        goods_sku_value: skuvalue
      })
      console.log(collage_user);
      return this.success({
        orderId:orderId
      })
    }else {
      return this.fail(17,"已发起过此次拼团",have)


    }
  }
  async payCollageorderAction(){
    const orderId = this.get("orderId")
    const status = this.get("status")
    const collageid = this.get("collageid") || 0
    if (collageid == 0) {
      const ordertrueId = await this.model('order').where({order_sn:orderId}).find()
      const cancelorderList = await this.model('order').where({ id: ordertrueId.id}).update({
        order_status: status,
        pay_time:new Date().getTime()
      });
      const collageuser = await this.model('collage_user').where({order_id:ordertrueId.id}).find()
      const data = await this.model('collage_user').where({order_id:ordertrueId.id}).update({
        is_pay:1,
        pay_time:new Date().getTime(),
        end_time: Number(collageuser.user_duration_time) + new Date().getTime(),
      })
      console.log(ordertrueId);
      return this.success(ordertrueId)

    }else {
      const cancelorderList = await this.model('order').where({ id: orderId}).update({
        order_status: status,
        pay_time:new Date().getTime()
      });
      const collageuser = await this.model('collage_user').where({order_id:orderId}).find()
      await this.model('collage_user').where({order_id:orderId}).update({
        is_pay:1,
        pay_time:new Date().getTime(),
        end_time: Number(collageuser.user_duration_time) + new Date().getTime(),
      })
      console.log(Number(collageuser.user_duration_time) + new Date().getTime());
      const collagelist = await this.model('collage').where({id:collageid}).find()
      const data = await this.model('collage').where({id:collageid}).update({
        launched_num:Number(collagelist.launched_num) + 1
      })
      return this.success(data)
    }

  }

};
