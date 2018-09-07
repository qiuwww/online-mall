const Base = require('./base.js');

module.exports = class extends Base {
  async indexAction() {
    const banner = await this.model('ad').where({ad_position_id: 1}).select();
    const channel = await this.model('channel').order({sort_order: 'asc'}).select();
    const luckdraw = await this.model('luckdraw').where({abled:1,is_del:0}).select();
    const collage = await this.model('collage').where({is_abled:1,is_delete:0}).select();
    const newGoodsList = await this.model('goods').field(['id', 'name', 'list_pic_url', 'retail_price', 'have_pay_num']).order(['short_order DESC']).limit(8).where({
      is_new: 1,
      is_on_sale:1
    }).select();
    const hotGoodsList = await this.model('goods').field(['id', 'name', 'list_pic_url', 'retail_price', 'goods_brief', 'have_pay_num']).order(['short_order DESC']).limit(6).where({
      is_hot: 1,
      is_on_sale:1
    }).select();
    // const brandList = await this.model('brand').where({is_new: 1}).order({new_sort_order: 'asc'}).limit(7).select();
    // const topicList = await this.model('topic').limit(5).select();

    const categoryList = await this.model('category').order(['sort_order DESC']).where({parent_id: 0,is_show: 1, name: ['<>', '推荐']}).select();
    const newCategoryList = [];
    for (const categoryItem of categoryList) {
      const childCategoryIds = await this.model('category').where({parent_id: categoryItem.id}).getField('id', 100);
      const categoryGoods = await this.model('goods').field(['id', 'name', 'list_pic_url', 'retail_price', 'have_pay_num']).order(['short_order DESC']).where({
        category_id: ['IN', childCategoryIds],
        is_on_sale:1
      }).limit(8).select();
      newCategoryList.push({
        id: categoryItem.id,
        name: categoryItem.name,
        banner_url: categoryItem.banner_url,
        goodsList: categoryGoods
      });
    }
    return this.success({
      luckdraw: luckdraw,
      banner: banner,
      channel: channel,
      newGoodsList: newGoodsList,
      hotGoodsList: hotGoodsList,
      collage:collage,
      // brandList: brandList,
      // topicList: topicList,
      categoryList: newCategoryList.reverse()
    });
  }
  async checkisdistributionAction() {
    const userid = this.post('userid')
    console.log(userid);
    const data = await this.model('distribution_main').where({user_id:userid}).select()
    if (data.length == 0) {
      return this.fail(17,'未购买过商品,未成为分销员')
    }else {
      return this.fail(503,'已成为分销员',data)
    }

  }


};
