const Base = require('./base.js');

module.exports = class extends Base {
  async colgoodsfindinfoAction() {
    const orderidd = this.post('orderid')
    let orderid = parseInt(orderidd)
    const orderInfo = await this.model('order').where({id:orderid}).find()
    const collageUser = await this.model('collage_user').where({order_id:orderid}).find()
    const collageMain = await this.model('collage').where({id:collageUser.collage_main}).find()
    const collageGoods = await this.model('order_goods').where({order_id:orderid}).find()
    const userInfo = await this.model('user').where({id:collageUser.user_id}).find()
    const goods = await this.model('goods').where({id:collageGoods.goods_id}).find()
    console.log(goods);
    console.log(goods.category_id);
    const collageUserFriend = await this.model('collage_user_friend').where({collage_user_tab_id:collageUser.id,is_pay:1}).select()
    const otherGoods = await this.model('goods').where({ category_id:goods.category_id }).limit(6).select();
    return this.success({
      orderid:orderid,
      otherGoods: otherGoods,
      userInfo:userInfo,
      orderInfo:orderInfo,
      collageUser:collageUser,
      collageUserFriend:collageUserFriend,
      collageMain:collageMain,
      collageGoods:collageGoods,
    });
  }
  async colfriendfindmainAction(){
    const orderidd = this.post('orderid')
    let orderid = parseInt(orderidd)
    // const orderInfo = await this.model('order').where({id:orderid}).find()
    const colUserFriend = await this.model('collage_user_friend').where({order_id:orderid}).find()
    const colUser = await this.model('collage_user').where({id:colUserFriend.collage_user_tab_id}).find()
    const ordermainid = colUser.order_id
    const orderinfo = await this.model('order').where({id:ordermainid}).find()
    return this.success({
      ordermainid:ordermainid,
      orderinfo:orderinfo
    })
  }
  async snfindorderAction(){
    const ordersn = this.post('ordersn')
    const orderinfo = await this.model('order').where({order_sn:ordersn}).find()
    return this.success({
      orderinfo:orderinfo
    })
  }
  async collage_isouttimeAction(){
    const orderid = this.post('orderid')
    console.log(orderid);
    await this.model('order').where({id:orderid}).update({
      order_status:301,
    })

  }
  async collagesuccessAction(){
    const orderidd = this.post('orderid')
    let orderid = parseInt(orderidd)
    console.log(orderid);
    const orderInfo = await this.model('order').where({id:orderid}).find()
    await this.model('order').where({id:orderid}).update({
      collage_is_success:1
    })
    const collageUser = await this.model('collage_user').where({order_id:orderid}).find()
    const collageMain = await this.model('collage').where({id:collageUser.collage_main}).find()
    await this.model('collage').where({id:collageUser.collage_main}).update({
      collage_success_num:Number(collageMain.collage_success_num) + 1
    })
    await this.model('collage_user').where({order_id:orderid}).update({
      is_success:1
    })
    let collagefriend = await this.model('collage_user_friend').where({collage_user_tab_id:collageUser.id}).select()
    for (var i = 0; i < collagefriend.length; i++) {
      // array[i]
      console.log(i);
      await this.model('collage_user_friend').where({collage_user_tab_id:collageUser.id}).update({
        is_success:1
      })
      console.log(collagefriend[i].order_id);
      await this.model('order').where({id:collagefriend[i].order_id}).update({
        collage_is_success:1
      })
    }
    return this.success(collagefriend)

  }

};
