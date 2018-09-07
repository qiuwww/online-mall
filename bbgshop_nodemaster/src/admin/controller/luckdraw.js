const Base = require('./base.js');

module.exports = class extends Base {
  ///////////////////////////////////////编辑抽奖时的操作
  async findluckinfoByidAction() {
    const id = this.post('id')
    const data = await this.model('luckdraw').where({id:id}).find()
    // console.log(data)
    return this.success(data);
  }
  ///////////////////////////////////////
  async listAction() {
    const page = this.get('page') || 1;
    const size = this.get('size') || 10;
    const goodsname = this.get('goodsname') || '';
    // const consignee = this.get('consignee') || '';
    console.log(goodsname);
    const model = this.model('luckdraw');
    const data = await model.where({luck_goods_name: ['like', `%${goodsname}%`],is_del:0}).order(['id DESC']).page(page, size).countSelect();
    console.log(data);
    return this.success(data);
  }
  async setluckableAction() {
    const id = this.post('id');
    const is_able = this.post('data');
    const model = this.model('luckdraw');
    const data = await model.where({id: id}).update({
      abled:is_able
    });
    return this.success({
      id:id,
      data:data
    });
  }
  async delluckAction() {
    const id = this.post('id');
    const data = await this.model('luckdraw').where({id: id}).update({
      is_del: 1
    });

    return this.success(data);
  }
  async luckstoreAction() {
    const luck = this.post('Luck')
    const goods = this.post('goods')
    const luckId = this.post('luckId')
    // console.log(luck,goods);
    console.log(luckId);
    // const have = await this.model('luckdraw').where({luck_goods_id:goods.id}).select()
    if (luckId !== 0) {
      const data = await this.model('luckdraw').where({id:luckId}).update({
        luck_people_num: luck.LuckPeople,
        luck_goods_num: luck.LuckGoodsNum,
        // luck_create_time: luck.create_time,
        luck_limit_time: luck.limit_time_local,
        luck_open_time: luck.open_time_local,
        luck_goods_detail: luck.LuckDetailEdit,
        luck_goods_pic: goods.list_pic_url,
        luck_goods_price: goods.retail_price,
        luck_goods_name: goods.name
      })
      return this.success(data)
    }else{
      const data = await this.model('luckdraw').add({
        abled:0,
        luck_goods_id: goods.id,
        luck_people_num: luck.LuckPeople,
        luck_goods_num: luck.LuckGoodsNum,
        luck_create_time: luck.create_time,
        luck_limit_time: luck.limit_time_local,
        luck_open_time: luck.open_time_local,
        luck_goods_detail: luck.LuckDetailEdit,
        luck_goods_pic: goods.list_pic_url,
        luck_goods_price: goods.retail_price,
        luck_goods_name: goods.name
      })
      return this.success(data)
    }

  }
};
