const Base = require('./base.js');

module.exports = class extends Base {
  async getallcategoryAction() {
    const id = this.post("id")
    // console.log(id);
    const page = this.post("page")
    const size = this.post("size")

    let category_info = await this.model('category').where({id: id}).find()
    console.log(category_info);
    if (category_info.parent_id == 0) {
      const main_catelog = await this.model('category').field(['id', 'name', 'front_name', 'parent_id', 'sort_order'])
      .order(['sort_order ASC']).where({parent_id: 0,is_show: 1}).select();
      for (var i = 0; i < main_catelog.length; i++) {
        let second_catelog = []
        second_catelog = await this.model('category').order(['sort_order ASC']).where({parent_id: main_catelog[i].id,is_show: 1}).select()
        let second_catelog_ids = []
        for (var j = 0; j < second_catelog.length; j++) {
          second_catelog_ids.push(second_catelog[j].id)
        }
        // main_catelog[i].second_catelog_ids = second_catelog_ids
        let point_catelog_goods = await this.model('goods').where({category_id: {'in': second_catelog_ids},is_on_sale:1}).field(['id', 'name', 'list_pic_url', 'retail_price', 'have_pay_num'])
        .order(['short_order DESC']).page(page, size).countSelect();
        // console.log(point_catelog_goods);
        main_catelog[i].point_catelog_goods = point_catelog_goods
      }
      return this.success(main_catelog)
    }else {
      const main_catelog = await this.model('category').field(['id', 'name', 'front_name', 'parent_id', 'sort_order'])
      .order(['sort_order ASC']).where({is_show: 1,parent_id: category_info.parent_id}).select();
      console.log(main_catelog);
      for (var i = 0; i < main_catelog.length; i++) {
        let point_catelog_goods = await this.model('goods').where({category_id: main_catelog[i].id,is_on_sale:1}).field(['id', 'name', 'list_pic_url', 'retail_price', 'have_pay_num'])
        .order(['short_order DESC']).page(page, size).countSelect();
        main_catelog[i].point_catelog_goods = point_catelog_goods
      }
      return this.success(main_catelog)
    }
  }
  // //下拉刷新获取数据
  // async onreachbottomcategoryAction() {
  //   const id = this.post("id")
  //   const page = this.post("page")
  //   const size = this.post("size")
  //   console.log(id,page,size);
  //   let category_info = await this.model('category').where({id: id}).find()
  //   console.log(category_info);
  // }
  //分类tabbar 获取分类数据
  async getallcatelogAction() {
    const main_catelog = await this.model('category').order(['sort_order ASC']).where({parent_id: 0,is_show:1}).select();
    for (var i = 0; i < main_catelog.length; i++) {
      let second_catelog = []
      second_catelog = await this.model('category').order(['sort_order ASC']).where({parent_id: main_catelog[i].id,is_show:1}).select()
      main_catelog[i].second_catelog = second_catelog
    }
    return this.success({
      main_catelog:main_catelog
    })
  }
  /**
   * 获取分类栏目数据
   * @returns {Promise.<Promise|void|PreventPromise>}
   */
  async indexAction() {
    const categoryId = this.get('id');

    const model = this.model('category');
    const data = await model.order(['sort_order ASC']).where({parent_id: 0,is_show:1}).select();
    let currentCategory = null;
    if (categoryId) {
      currentCategory = await model.where({'id': categoryId}).find();
    }

    if (think.isEmpty(currentCategory)) {
      currentCategory = data[0];
    }

    // 获取子分类数据
    if (currentCategory && currentCategory.id) {
      currentCategory.subCategoryList = await model.where({'parent_id': currentCategory.id}).select();
    }

    return this.success({
      categoryList: data,
      currentCategory: currentCategory
    });
  }
  async getchildrencategoryidbyfatherAction() {
    const id = this.post('id')
    const fathercategory = await this.model('category').where({id: id,is_show:1}).find();
    const childrencategory = await this.model('category').order(['sort_order ASC']).where({parent_id: id,is_show:1}).select();
    const return_id = childrencategory[0].id
    return this.success({
      return_id:return_id,
      fathercategoryTitle: fathercategory.name
    })
  }
  async currentAction() {
    const categoryId = this.get('id');
    const model = this.model('category');

    let currentCategory = null;
    if (categoryId) {
      currentCategory = await model.where({'id': categoryId}).find();
    }
    // 获取子分类数据
    if (currentCategory && currentCategory.id) {
      currentCategory.subCategoryList = await model.where({'parent_id': currentCategory.id}).select();
    }

    return this.success({
      currentCategory: currentCategory
    });
  }
};
