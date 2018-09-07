const Base = require('./base.js');

module.exports = class extends Base {
  async colgoodspay_findAction(){
    const orderid = this.post('orderid')
    console.log(orderid);
    const orderInfo = await this.model('order').where({id:orderid}).find()
    const collageUser = await this.model('collage_user').where({order_id:orderid}).find()
    const collageGoods = await this.model('order_goods').where({order_id:orderid}).find()
    return this.success({
      orderid:orderid,
      // otherGoods: otherGoods,
      // userInfo:userInfo,
      orderInfo:orderInfo,
      collageUser:collageUser,
      // collageUserFriend:collageUserFriend,
      // collageMain:collageMain,
      collageGoods:collageGoods,
    });
  }
  async paypaycollageorderuserAction() {
    const orderId = this.get("orderId")
    const status = this.get("status")
    // const collageid = this.get("collageid")
    const cancelorderList = await this.model('order').where({ id: orderId}).update({
      order_status: status,
      pay_time:new Date().getTime()
    });



    //////////////////////////////////////////////////////////////
    // const collageuser = await this.model('collage_user_friend').where({order_id:orderId}).find()
    const data = await this.model('collage_user_friend').where({order_id:orderId}).update({
      is_pay:1,
      // end_time: Number(collageuser.user_duration_time) + Number(new Date().getTime()),
    })
    // console.log(Number(collageuser.user_duration_time) + Number(new Date().getTime()));
    // const collagelist = await this.model('collage').where({id:collageid}).find()
    // const data = await this.model('collage').where({id:collageid}).update({
    //   launched_num:Number(collagelist.launched_num) + 1
    // })
    return this.success(data)

  }
  async writecollageorderAction() {
    const _ = require('lodash');
    const orderid = this.post("orderid")
    const user_in = this.post("user_in")
    const addressid = this.post("addressid")
    console.log(orderid);
    const addresslist = await this.model('address').where({id:addressid}).find()
    const collageUser = await this.model('collage_user').where({order_id:orderid}).find()
    const ordergoodslocal = await this.model('order_goods').where({order_id:orderid}).find()
    const date = new Date();
    let sn = date.getFullYear() + _.padStart(date.getMonth()+1, 2, '0') + _.padStart(date.getDate(), 2, '0')
    + _.padStart(date.getHours(), 2, '0') + _.padStart(date.getMinutes(), 2, '0')
    + _.padStart(date.getSeconds(), 2, '0') +  _.random(100000, 999999);
    console.log(sn);
    const orderInfo = await this.model("order").where({id:orderid}).find()

    const have = await this.model('order').where({
      user_id: user_in.userInfo.id,
      goods_sku_id: orderInfo.goods_sku_id,
      pay_name:'拼团订单(Participant)',
      pay_id: 2,
    }).select()
    if (have.length == 0) {
      const setOrder = await this.model("order").add({
        order_sn:sn,
        user_id:user_in.userInfo.id,
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
        pay_name:'拼团订单(Participant)',
        pay_id: 2 ,
        collage_type: 1,
        actual_price: orderInfo.actual_price,
        order_price: orderInfo.order_price,
        goods_price: orderInfo.goods_price,
        add_time: new Date().getTime(),
        goods_sku_id: orderInfo.goods_sku_id
      })
      const ordergoods = await this.model('order_goods').add({
        order_id:setOrder,
        goods_id:ordergoodslocal.goods_id,
        goods_name:ordergoodslocal.goods_name,
        goods_sn:ordergoodslocal.goods_sn,
        product_id:ordergoodslocal.product_id,
        number: 1,
        market_price: ordergoodslocal.market_price,
        retail_price: ordergoodslocal.retail_price,
        goods_specifition_name_value: ordergoodslocal.goods_specifition_name_value,
        goods_specifition_ids: ordergoodslocal.goods_specifition_ids,
        list_pic_url:ordergoodslocal.list_pic_url
      })
      const orderuserfriend = await this.model('collage_user_friend').add({
        collage_main:collageUser.collage_main,
        collage_user_tab_id:collageUser.id,
        collage_user_id:collageUser.user_id,
        user_in_id:user_in.userInfo.id,
        is_pay: 0,
        order_id: setOrder,
        user_in_nickname:user_in.userInfo.nickname,
        user_in_avatar:user_in.userInfo.avatar,
        goodsid:collageUser.goodsid,
        goods_name:collageUser.goods_name,
        collage_price:collageUser.collage_price,
        retail_price:collageUser.retail_price,
        most_init_num:collageUser.most_init_num,
        least_coll_num:collageUser.least_coll_num,
        is_abled: 1,
        virtual:collageUser.virtual,
        goods_sku_id:collageUser.goods_sku_id,
        goods_sku_value:collageUser.goods_sku_value,
        is_finish: 0,
      })
      return this.fail(0,"写入成功",setOrder)
    }else {
      return this.fail(17,"订单已存在",have)
    }

  }
};
