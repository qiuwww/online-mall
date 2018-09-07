const Base = require('./base.js');

module.exports = class extends Base {
  /**
   * index action
   * @return {Promise} []
   */
  async changeinfoAction() {
    const changeinfo = this.post('changed_info')
    // console.log(changeinfo);
    const data = await this.model('goods').where({id:changeinfo.id}).update({
      name: changeinfo.name,
      goods_number: changeinfo.goods_number,
      counter_price: changeinfo.counter_price,
      retail_price: changeinfo.retail_price,
      freight_price: changeinfo.freight_price,
      cost_price: changeinfo.cost_price,
      short_order: changeinfo.short_order
    })
    return this.success(data)
  }
  async indexAction() {
    const page = this.post('page') || 1;
    const size = this.post('size') || 10;
    const name = this.post('name') || '';
    const isnew = this.post('isnew');
    const ishot = this.post('ishot');
    const issale = this.post('issale');
    console.log(isnew,ishot,issale);
    console.log(name);
    const params = name.replace(/\s/g,'%')
    console.log(params);
    const SecondClassifyId = this.post('SecondClassifyId');
    if (parseInt(SecondClassifyId) == 0) {
      const data = await this.model('goods').where({
        name: ['like', `%${params}%`],
        // is_new: isnew,
        // is_hot: ishot,
        // is_on_sale: issale
      }).order(['id DESC']).page(page, size).countSelect();
      return this.success(data);
    }else {
      const data = await this.model('goods').where({
        name: ['like', `%${params}%`],
        category_id: SecondClassifyId,
        // is_new: isnew,
        // is_hot: ishot,
        // is_on_sale: issale
      }).order(['id DESC']).page(page, size).countSelect();
      return this.success(data);
    }

  }
  async getgoodsskucandsAction() {
    const goodsid = this.post('id')
    const productlist = await this.model('product').where({
      goods_id: goodsid
    }).select()
    console.log(productlist);
    for (var i = 0; i < productlist.length; i++) {
      let idslist_title = []
      let idslist_value = []
      let idslist_id = []
      idslist_id = productlist[i].goods_specification_ids.split('_')
      productlist[i].ids_list_id = idslist_id
      for (var j = 0; j < idslist_id.length; j++) {
        let obj = {}
        obj = await this.model('goods_specification').where({
          id: idslist_id[j]
        }).find()
        idslist_value.push(obj)
      }
      productlist[i].ids_list_value = idslist_value
      console.log(idslist_value);
      for (var k = 0; k < idslist_value.length; k++) {
        let objj = {}
        objj = await this.model('specification').where({
          id: idslist_value[k].specification_id
        }).find()
        idslist_title.push(objj)
      }
      productlist[i].ids_list_title = idslist_title
    }
    let true_product_list = []
    let title = []
    let value_title_1 = []
    let value_title_2 = []
    let value_title_3 = []
    let all_value_cands_1 = []
    let all_value_cands_2 = []
    let all_value_cands_3 = []
    for (var l = 0; l < productlist.length; l++) {
      let prodect_table_id = ''
      let goods_number = ''
      let retail_price = ''
      let bigobj = {}
      let value = []
      // bigobj.prodect_table_id = productlist[l].id
      bigobj.stock = productlist[l].goods_number
      bigobj.price = productlist[l].retail_price
      title = productlist[l].ids_list_title
      value = productlist[l].ids_list_value
      for (var o = 0; o < value.length; o++) {
        if (o == 0) {
          all_value_cands_1.push(value[o])
        }else if (o == 1) {
          all_value_cands_2.push(value[o])
        }else if (o == 2) {
          all_value_cands_3.push(value[o])
        }
      }
      // console.log('all_value_cands-----------------------------------------start');
      // console.log(all_value_cands_1);
      // console.log(all_value_cands_2);
      // console.log(all_value_cands_3);
      // console.log('all_value_cands-----------------------------------------over');
      // console.log(value);
      // console.log(title);
      // console.log(title.length);
      let value_1 = ''
      let value_2 = ''
      let value_3 = ''
      if (title.length == 1) {
          value_1 = value[0].value
          bigobj.value_1 = value_1
          true_product_list.push(bigobj)
        }else if (title.length == 2) {
          value_1 = value[0].value
          value_2 = value[1].value
          bigobj.value_1 = value_1
          bigobj.value_2 = value_2
          true_product_list.push(bigobj)
        }else if (title.length == 3) {
          value_1 = value[0].value
          value_2 = value[1].value
          value_3 = value[2].value
          bigobj.value_1 = value_1
          bigobj.value_2 = value_2
          bigobj.value_3 = value_3
          true_product_list.push(bigobj)
        }
    }
    // for (var s = 0; s < all_value_cands_1.length; s++) {
    //   if (all_value_cands_1[s].id == all_value_cands_1[s - 1].id) {
    //     all_value_cands_1.splice(i,1)
    //   }
    // }
    let all_value_cands_1_id = []
    let all_value_cands_2_id = []
    let all_value_cands_3_id = []
    for (var s = 0; s < all_value_cands_1.length; s++) {
      all_value_cands_1_id.push(all_value_cands_1[s].id)
    }
    for (var t = 0; t < all_value_cands_2.length; t++) {
      all_value_cands_2_id.push(all_value_cands_2[t].id)
    }
    for (var u = 0; u < all_value_cands_3.length; u++) {
      all_value_cands_3_id.push(all_value_cands_3[u].id)
    }
    var all_value_cands_1_id_filer = all_value_cands_1_id.filter(function (element, index, array) {
        return array.indexOf(element) === index;
    });
    var all_value_cands_2_id_filer = all_value_cands_2_id.filter(function (element, index, array) {
        return array.indexOf(element) === index;
    });
    var all_value_cands_3_id_filer = all_value_cands_3_id.filter(function (element, index, array) {
        return array.indexOf(element) === index;
    });
    for (var v = 0; v < all_value_cands_1_id_filer.length; v++) {
      let objjj = {}
      objjj = await this.model('goods_specification').where({id:all_value_cands_1_id_filer[v]}).find()
      value_title_1.push(objjj)
    }
    for (var w = 0; w < all_value_cands_2_id_filer.length; w++) {
      let objjjj = {}
      objjjj = await this.model('goods_specification').where({id:all_value_cands_2_id_filer[w]}).find()
      value_title_2.push(objjjj)
    }
    for (var x = 0; x < all_value_cands_3_id_filer.length; x++) {
      let objjjjj = {}
      objjjjj = await this.model('goods_specification').where({id:all_value_cands_3_id_filer[x]}).find()
      value_title_3.push(objjjjj)
    }
    let value = []
    value[0] = value_title_1
    value[1] = value_title_2
    value[2] = value_title_3
    return this.success({
      // productlist: productlist,
      true_product_list: true_product_list,
      title: title,
      value: value
      // value_title_1: value_title_1,
      // value_title_2: value_title_2,
      // value_title_3: value_title_3,
    })
    // console.log(goodsid);
  }


  //后台修改商品身份信息
  async setisIdentityAction() {
    const model = this.model('goods');
    const id = this.post('id');
    const is_Identity = this.post('data');
    // const data = await model.where({parent_id: 0}).select();
    const data = await model.where({
      id: id
    }).update({
      Identity: is_Identity
    });
    return this.success({
      id: id,
      data: data
    });
  }
  //后台修改商品新品信息
  async setisnewAction() {
    const model = this.model('goods');
    const id = this.post('id');
    const is_new = this.post('data');
    // const data = await model.where({parent_id: 0}).select();
    const data = await model.where({
      id: id
    }).update({
      is_new: is_new
    });
    return this.success({
      id: id,
      data: data
    });
  }
  //后台修改商品人气信息
  async setishotAction() {
    const model = this.model('goods');
    const id = this.post('id');
    const is_hot = this.post('data');
    // const data = await model.where({parent_id: 0}).select();
    const data = await model.where({
      id: id
    }).update({
      is_hot: is_hot
    });
    return this.success({
      id: id,
      data: data
    });
  }
  //后台修改商品上架信息
  async setisonsaleAction() {
    const model = this.model('goods');
    const id = this.post('id');
    const is_on_sale = this.post('data');
    // const data = await model.where({parent_id: 0}).select();
    const data = await model.where({
      id: id
    }).update({
      is_on_sale: is_on_sale
    });
    return this.success({
      id: id,
      data: data
    });
  }


  //添加、编辑商品父组件查找商品
  async findgoodsinfoAction() {
    const id = this.post('id');
    const model = this.model('goods');
    const data = await model.where({
      id: id
    }).find();
    return this.success(data);
  }
  // //没有id时加载一级分类
  // async noIdGetFirstcateAction() {
  //   // const id = this.post('id');
  //   const model = this.model('category');
  //   const data = await model.where({
  //     parent_id: 0
  //   }).select();
  //   return this.success(data);
  // }
  // //根据一级分类查找二级分类
  // async secondCategoryAction() {
  //   const id = this.post('id');
  //   const data = await this.model('category').where({
  //     parent_id: id
  //   }).select()
  //   return this.success(data);
  // }
  // //根据二级分类id查找二级分类名字
  // async findsecondcateNameAction() {
  //   const id = this.post('id');
  //   const data = await this.model('category').where({
  //     id: id
  //   }).select()
  //   return this.success(data);
  // }
  // //根据二级分类parentid查找一级分类名字
  // async findfirstcateNameAction() {
  //   const id = this.post('id');
  //   const data = await this.model('category').where({
  //     id: id
  //   }).select()
  //   return this.success(data);
  // }
  // //根据一级分类id查找二级分类列表
  // async findSecondcateListAction() {
  //   const id = this.post('id');
  //   const data = await this.model('category').where({
  //     parent_id: id
  //   }).select()
  //   return this.success(data);
  // }
  //
  // async topCategoryAction() {
  //   const model = this.model('category');
  //   const data = await model.where({
  //     parent_id: 0
  //   }).select();
  //
  //   return this.success(data);
  // }
  // async findTopCategoryAction() {
  //   const id = this.post('id');
  //   const data = await this.model('category').where({
  //     id: id
  //   }).select()
  //
  //   return this.success(data);
  // }
  // async findTopCategoryNameAction() {
  //   const id = this.post('id');
  //   const data = await this.model('category').where({
  //     id: id
  //   }).find()
  //
  //   return this.success(data);
  // }
  // async findTopfindTopCategoryNameAction() {
  //   const name = this.post('name');
  //   const data = await this.model('category').where({
  //     name: name
  //   }).find()
  //
  //   return this.success(data);
  // }
  //
  // async findsecondsecondCategoryAction() {
  //   const name = this.post('name');
  //   const data = await this.model('category').where({
  //     name: name
  //   }).find()
  //
  //   return this.success(data);
  // }
  //
  //
  //
  // async aaacategoryAction() {
  //   const id = this.post('id');
  //   const model = this.model('category');
  //   const data = await model.where({
  //     parent_id: id
  //   }).select();
  //
  //   return this.success(data);
  // }

  async findLoopImgAction() {
    const id = this.post('id');
    const model = this.model('goods_gallery');
    const data = await model.where({
      goods_id: id
    }).select();
    console.log(data);
    return this.success(data);
  }


  async findSpecAction() {
    const id = this.post('id');
    const model1 = this.model('product')
    const product = await model1.where({
      goods_id: id
    }).select()
    return this.success({
      productList: product,
    });
  }

  //在商品页中安二级分类查找所有商品
  async findsecondgoodsAction() {
    const id = this.get('id');
    // const model1 = this.model('goods')
    const page = this.get('page') || 1;
    const size = this.get('size') || 12;
    // const name = this.get('name') || '';

    const model = this.model('goods');
    const data = await model.where({
      category_id: id
    }).order(['id DESC']).page(page, size).countSelect();

    return this.success(data);
    // const list = await model1.where({ category_id:id }).select()
    // return this.success(list);
  }






  async upgoodsAction() {
    const GoodsId = this.post('Goodsid');
    const LoopImgLength = this.post('LoopImgLength');
    const FirstCategoryId = this.post('FirstCategoryId');
    const SecondCategoryId = this.post('SecondCategoryId');
    const GoodsMainImg = this.post('GoodsMainImg');
    const GoodsParticEdit = this.post('GoodsParticEdit');
    const GoodsLoopImg = this.post('GoodsLoopImg');
    const GoodsName = this.post('GoodsName');
    const GoodsDesc = this.post('GoodsDesc');
    const GoodsStock = this.post('GoodsStock');
    const GoodsPrice = this.post('GoodsPrice');
    const GoodsExprice = this.post('GoodsExprice');
    const GoodsIsNew = this.post('GoodsIsNew');
    const GoodsSortOrder = this.post('GoodsSortOrder');
    const GoodsOnSale = this.post('GoodsOnSale');
    const GoodsIsHot = this.post('GoodsIsHot');

    const model = this.model('goods')
    const data = await model.where({
      id: GoodsId
    }).find()
    // console.log(GoodsLoopImg);
    const result = await model.where({
      id: GoodsId
    }).update({
      category_id: SecondCategoryId,
      name: GoodsName,
      goods_number: GoodsStock,
      goods_brief: GoodsDesc,
      goods_desc: GoodsParticEdit,
      is_on_sale: GoodsOnSale,
      add_time: '0',
      sort_order: GoodsSortOrder,
      is_new: GoodsIsNew,
      goods_unit: '个',
      primary_pic_url: GoodsMainImg[0],
      list_pic_url: GoodsMainImg[0],
      retail_price: GoodsPrice,
      extra_price: GoodsExprice,
      is_hot: GoodsIsHot,


    })
    // console.log(GoodsLoopImg);
    // console.log(LoopImgLength);
    // console.log(GoodsLoopImg.substring(0,LoopImgLength));
    // console.log(GoodsLoopImg.length);
    // for (var i = 0; i < GoodsLoopImg.length; i++) {
    //   if ( typeof(GoodsLoopImg[i].response.data) == 'undefind') {
    //     console.log("9999999");
    //     console.log(GoodsLoopImg[i]);
    //   }
    //   // console.log(GoodsLoopImg[i].response.data.fileUrl);
    // }
    console.log(GoodsLoopImg);
    await this.model("goods_gallery").where({
      goods_id: GoodsId
    }).delete()
    for (var i = 0; i < GoodsLoopImg.length; i++) {
      console.log(i);
      // console.log(GoodsLoopImg[i].response.data.fileUrl);
      const result2 = await this.model("goods_gallery").add({
        goods_id: GoodsId,
        img_url: GoodsLoopImg[i].fileUrl,
        img_desc: '',
        sort_order: 5,
      })
    }
    // return this.success(result);
  }


  async infoAction() {
    const id = this.get('id');
    const model = this.model('goods');
    const data = await model.where({
      id: id
    }).find();

    return this.success(data);
  }

  async storeAction() {
    if (!this.isPost) {
      return false;
    }

    const values = this.post();
    const id = this.post('id');

    const model = this.model('goods');
    values.is_on_sale = values.is_on_sale ? 1 : 0;
    values.is_new = values.is_new ? 1 : 0;
    values.is_hot = values.is_hot ? 1 : 0;
    if (id > 0) {
      await model.where({
        id: id
      }).update(values);
    } else {
      delete values.id;
      await model.add(values);
    }
    return this.success(values);
  }

  async destoryAction() {
    const id = this.post('id');
    const result = await this.model('goods').where({
      id: id
    }).limit(1).delete();
    // TODO 删除图片

    return this.success({
      result: result
    });
  }
};
