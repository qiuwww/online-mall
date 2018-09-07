const Base = require('./base.js');

module.exports = class extends Base {
  /**
   * index action
   * @return {Promise} []
   */
  async indexAction() {
    const model = this.model('category');
    const data = await model.order(['sort_order ASC']).select();
    const topCategory = data.filter((item) => {
      return item.parent_id === 0;
    });
    const categoryList = [];
    topCategory.map((item) => {
      item.level = 1;
      categoryList.push(item);
      data.map((child) => {
        if (child.parent_id === item.id) {
          child.level = 2;
          categoryList.push(child);
        }
      });
    });
    return this.success(categoryList);
  }

  async wapimageAction() {
    const model = this.model('category');
    const id = this.post('id')
    const data = await model.where({id: id}).find();

    return this.success(data);
  }

  async storeimgAction() {
    const model = this.model('category');
    const url = this.post('url')
    const id = this.post('id')
    const result = await model.where({id:id}).update({
      wap_banner_url:url[0]
    })
    // const data = await model.where({id: id}).find();

    return this.success(result);
  }

  async updatastoreallAction() {
    const categoryId = this.post('categoryId')
    const categoryName = this.post('categoryName')
    const categoryParent_id = this.post('categoryParent_id')
    const categoryFont_name = this.post('categoryFont_name')
    const categorySort_order = this.post('categorySort_order')
    const categoryIs_show = this.post('categoryIs_show')
    const GoodsMainImg = this.post('GoodsMainImg')
    const banner_url = this.post('banner_url')

    const level = ''
    if (categoryParent_id == 0) {
      // console.log(99999999999999999999);
      this.level = "L1"
    }else {
      this.level = "L2"
    }

    console.log(this.level);
    const model = this.model('category');
    const data = await model.where({id:categoryId}).update({
      name:categoryName,
      font_desc:categoryFont_name,
      parent_id:categoryParent_id,
      sort_order:categorySort_order,
      is_show:categoryIs_show,
      banner_url:banner_url,
      icon_url:GoodsMainImg[0],
      image_url:GoodsMainImg[0],
      wap_banner_url:GoodsMainImg[0],
      level:this.level,
      type:0,
      front_name:categoryFont_name,
    })
    // const data = await model.where({parent_id: 0}).order(['id ASC']).select();

    return this.success(data);
  }


    async addstoreallAction() {
      const categoryName = this.post('categoryName')
      const categoryParent_id = this.post('categoryParent_id')
      const categoryFont_name = this.post('categoryFont_name')
      const categorySort_order = this.post('categorySort_order')
      const categoryIs_show = this.post('categoryIs_show')
      const GoodsMainImg = this.post('GoodsMainImg')
      const banner_url = this.post('banner_url')
      const level = ''
      if (categoryParent_id == 0) {
        // console.log(99999999999999999999);
        this.level = "L1"
      }else {
        this.level = "L2"
      }
      console.log(this.level);
      console.log(categoryFont_name);
      console.log(categoryParent_id);
      console.log(categorySort_order);
      console.log(categoryIs_show);
      console.log(GoodsMainImg[0]);
      // console.log(this.level);
      const model = this.model('category');
      const data = await model.add({
        name:categoryName,
        front_desc:categoryFont_name,
        parent_id:categoryParent_id,
        sort_order:categorySort_order,
        is_show:categoryIs_show,
        banner_url:banner_url,
        icon_url:GoodsMainImg[0],
        image_url:GoodsMainImg[0],
        wap_banner_url:GoodsMainImg[0],
        level:this.level,
        type:0,
        front_name:categoryFont_name,
      })
      // const data = await model.where({parent_id: 0}).order(['id ASC']).select();

      return this.success(data);
    }


    async findsmallloopAction() {
      const id = this.post('id')
      let idid = parseInt(id)
      // console.log(id);
      // console.log(idid);
      const data = await this.model('channel').where({category_id:idid}).select()
      console.log(data);
      if (data.length == 0) {
        this.fail(503,"不存在首页")
      }else {
        this.fail(217,"存在首页",data)
      }
      // console.log(data);
      // return this.success(data)
    }
    async delsmallAction() {
      const id = this.post('id')
      const data = await this.model('channel').where({category_id:id}).delete()
      console.log(data);
      // return this.success(data)
    }
    async setsmallAction() {
      const name = this.post('name')
      const url = this.post('tourl')
      const icon_url = this.post('icon')
      const category = this.post('category_id')
      console.log(icon_url);
      console.log("99999999999999999999999999999999999");
      const sort = this.post('sort')
      const have = await this.model('channel').where({sort_order:sort}).select()
      if (have.length == 0) {
        await this.model('channel').add({
          name:name,
          url:url,
          icon_url:icon_url.url,
          sort_order:sort,
          category_id:category
        })

      }else{
        await this.model('channel').where({sort_order:sort}).delete()
        await this.model('channel').add({
          name:name,
          url:url,
          icon_url:icon_url.url,
          sort_order:sort,
          category_id:category
        })
      }
      // const data = await this.model('channel').where({name:name}).delete()
      return this.success(have)
    }





  async topCategoryAction() {
    const model = this.model('category');
    const data = await model.where({parent_id: 0}).order(['id ASC']).select();

    return this.success(data);
  }

  async infoAction() {
    const id = this.get('id');
    const model = this.model('category');
    const data = await model.where({id: id}).find();

    return this.success(data);
  }

  async storeAction() {
    if (!this.isPost) {
      return false;
    }

    const values = this.post();
    const id = this.post('id');

    const model = this.model('category');
    values.is_show = values.is_show ? 1 : 0;
    if (id > 0) {
      await model.where({id: id}).update(values);
    } else {
      delete values.id;
      await model.add(values);
    }
    return this.success(values);
  }

  async destoryAction() {
    const id = this.post('id');
    await this.model('category').where({id: id}).limit(1).delete();
    // await this.model('category').where({parent_id: id}).limit(1).delete();
    await this.model('channel').where({parent_id: id}).limit(1).delete();


    return this.success();
  }
};
