const Base = require('./base.js');

module.exports = class extends Base {
  async findGoodsClassifyFirstAction() {
    const data = await this.model('category').order({id: 'asc'}).where({parent_id:0}).select()
    return this.success(data)
  }
  // async findGoodsClassifySecondByIdAction() {
  //   const id = this.post('id')
  //   const data = await this.model('category').order({id: 'asc'}).where({parent_id:id}).select()
  //   return this.success(data)
  // }
  async findclassifybyidAction() {
    const id = this.post('id')
    const data = await this.model('category').where({id:id}).find()
    return this.success(data)
  }
  async findindexbariconAction() {
    const id = this.post('id')
    const data = await this.model('channel').where({parent_id:id}).find()
    return this.success(data)
  }
  async categorystoreAction() {
    const info = this.post('info')
    console.log(info);
    if (info.id == 0) {
      //新建分类
      const id = await this.model('category').add({
        name: info.name,
        front_desc: info.front_name,
        parent_id: info.FirstClassifyId,
        sort_order: info.sort_order,
        is_show: info.is_show ? 1 : 0,
        show_index: info.show_index ? 1 : 0,
        banner_url: info.index_catrgory_normal_imageUrl,
        icon_url: 'null',
        image_url: 'null',
        wap_banner_url: info.catrgory_normal_imageUrl,
        level: info.FirstClassifyId == 0 ? 'L1' : 'L2',
        type:0,
        front_name: info.front_name,
      })
      if (info.show_index == true) {
        await this.model('channel').add({
          name: id,
          url: '/pages/category/category?id=' + id,
          icon_url: info.index_bar_imageUrl,
          sort_order: info.bar_sort_order,
          category_id: id,
          parent_id: id,
        })
      }
    }else {
      //更新操作
      await this.model('category').where({id: info.id}).update({
        name: info.name,
        front_desc: info.front_name,
        parent_id: info.FirstClassifyId,
        sort_order: info.sort_order,
        is_show: info.is_show ? 1 : 0,
        show_index: info.show_index ? 1 : 0,
        banner_url: info.index_catrgory_normal_imageUrl,
        icon_url: 'null',
        image_url: 'null',
        wap_banner_url: info.catrgory_normal_imageUrl,
        level: info.FirstClassifyId == 0 ? 'L1' : 'L2',
        type:0,
        front_name: info.front_name,
      })
      // const id = await this.model('category').where({id: info.id}).find()
      if (info.show_index && info.is_show) {
        const ahannelinfo = await this.model('channel').where({parent_id:info.id}).select()
        if(ahannelinfo.length == 0){
          await this.model('channel').add({
            name: info.id,
            url: '/pages/category/category?id=' + info.id,
            icon_url: info.index_bar_imageUrl,
            sort_order: info.bar_sort_order,
            category_id: info.id,
            parent_id: info.id,
          })
        }else {
          await this.model('channel').where({parent_id:info.id,}).update({
            name: info.id,
            url: '/pages/category/category?id=' + info.id,
            icon_url: info.index_bar_imageUrl,
            sort_order: info.bar_sort_order,
            category_id: info.id,
          })
        }

      }else {
        await this.model('channel').where({parent_id:info.id}).delete()
        await this.model('category').where({id: info.id}).update({
          show_index: 0,
        })
      }
    }
  }
};
