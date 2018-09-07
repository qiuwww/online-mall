const Base = require('./base.js');

module.exports = class extends Base {

  //商品导出 表格
  async EXPORT_TO_EXLECE_GOODSAction() {
    const data = await this.model('goods').field(['name','retail_price','cost_price']).select()
    return this.success(data)
  }
  async getsupplierAction() {
    const data = await this.model('supplier').select()
    return this.success(data)
  }
  async getfrighttempletelistAction() {
    const data = await this.model('freight_template_main').select()
    return this.success(data)
  }
  async findGoodsInfoAction() {
    const id = this.post('id')
    const goodsInfo = await this.model('goods').where({id:id}).find()
    const loop_img = await this.model('goods_gallery').where({goods_id:id}).select()
    const supplier_list = await this.model('supplier').select()
    goodsInfo.loop_img = loop_img
    console.log(goodsInfo.category_id);
    const secondClassify = await this.model('category').where({id:goodsInfo.category_id}).find()
    const firstClassify = await this.model('category').where({id:secondClassify.parent_id}).find()
    return this.success({
      goodsInfo:goodsInfo,
      secondClassify:secondClassify,
      firstClassify:firstClassify,
      supplier_list:supplier_list
    })
    // return this.display();
  }
  async findGoodsClassifyFirstAction() {
    const data = await this.model('category').order({id: 'asc'}).where({parent_id:0}).select()
    return this.success(data)
  }
  async findGoodsClassifySecondByIdAction() {
    const id = this.post('id')
    const data = await this.model('category').order({id: 'asc'}).where({parent_id:id}).select()
    return this.success(data)
  }
  async goodsstoreAction() {
    const info = this.post('info')
    const classifyid = this.post('classifyid')
    console.log(info,classifyid);
    if (info.id == 0) {
      let goodsid = new Date().getTime() +''+ Math.round(Math.random() * 999)
      const addgoods = await this.model('goods').add({
          id: goodsid,
          category_id: classifyid,
          goods_sn: goodsid,
          name: info.name,
          goods_number: info.num,
          goods_brief: info.brief,
          goods_desc: info.desc,
          is_on_sale: info.is_sale,
          add_time: new Date().getTime(),
          is_new: info.is_new,
          primary_pic_url: info.main_img,
          list_pic_url: info.main_img,
          retail_price: info.price,
          extra_price: info.extraPrice,
          is_hot: info.is_hot,
          freight_price: info.freight_type == 0 ? info.freight_price : 0.00,
          freight_type: info.freight_type,
          freight_template: info.freight_type == 1 ? info.freight_template : 0,
          cost_price: info.cost_price,
          short_order: info.short_order,
          supplier_id: info.supplier_id,//供货商id
          supplier_name: info.supplier_name,//供货商名称
          Identity: info.Identity ? 1 : 0,
      })
      for (var i = 0; i < info.loop_img.length; i++) {
        await this.model("goods_gallery").add({
          goods_id: goodsid,
          img_url: info.loop_img[i].fileUrl,
          img_desc: '',
          sort_order: 5,
        })
      }
      return this.fail(200,'商品基本数据增加成功 ！',goodsid)
    }else {
      const updategoodsinfo = await this.model('goods').where({
        id: info.id
      }).update({
          category_id: classifyid,
          name: info.name,
          goods_number: info.num,
          goods_brief: info.brief,
          goods_desc: info.desc,
          is_on_sale: info.is_sale,
          update_time: new Date().getTime(),
          is_new: info.is_new,
          primary_pic_url: info.main_img,
          list_pic_url: info.main_img,
          retail_price: info.price,
          extra_price: info.extraPrice,
          is_hot: info.is_hot,
          freight_price: info.freight_type == 0 ? info.freight_price : 0.00,
          freight_type: info.freight_type,
          freight_template: info.freight_type == 1 ? info.freight_template : 0,
          cost_price: info.cost_price,
          short_order: info.short_order,
          supplier_id: info.supplier_id,//供货商id
          supplier_name: info.supplier_name,//供货商名称
          Identity: info.Identity ? 1 : 0,
      })
      await this.model("goods_gallery").where({
          goods_id: info.id
        }).delete()
        for (var i = 0; i < info.loop_img.length; i++) {
          console.log(i);
          console.log(info.loop_img.length);
          await this.model("goods_gallery").add({
            goods_id: info.id,
            img_url: info.loop_img[i].fileUrl,
            img_desc: '',
            sort_order: 5,
          })
        }
        return this.fail(400,'商品基本数据更新成功 ！',info.id)
    }
  }
  async specifystoreAction() {
    const id = this.post('id')
    const title = this.post('title')
    const oldtitle = this.post('oldtitle')
    const value = this.post('value')
    const unDeacartesList = this.post('unDeacartesList')
    // console.log(id);
    console.log(title);
    console.log(oldtitle);
    console.log(value);
    console.log(unDeacartesList);
    //有数据就删除此商品的所有规格，重新生成id
    if (unDeacartesList.length == 0) {
        //用户没有更新规格值操作！！
        console.log('-用户没有更新规格值******************************************************************');
        console.log('-循环匹配规格名开始******************************************************************');
        // 循环匹配title的值是否改变 改变的话就找到他的id更新他的值
        for (var a = 0; a < title.length; a++) {
          if (title[a] !== oldtitle[a]) {
            const changetitleid = await this.model('specification').where({name:oldtitle[a]}).find()
            console.log(changetitleid);
            await this.model('specification').where({id: changetitleid.id}).update({name: title[a]})
          }
        }
        console.log('-循环匹配规格名结束******************************************************************');
        return this.fail(200,'用户没有更新商品规格 ！')
      }else {
        console.log('-用户更新了规格值******************************************************************');
        console.log('-查找新建规格名开始******************************************************************');
        let specifications_Title = []
        for (var i = 0; i < title.length; i++) {
          const simal = await this.model('specification').where({name:title[i]}).getField('id')
          if (!think.isEmpty(simal)) {
            specifications_Title.push({id: simal[0], name: title[i]})
            //如果有则获取到id值
          }else {
            //如果米有则新建再获取到id值
            await this.model('specification').add({name:title[i],sort_order:i})
            const addid = await this.model('specification').where({name:title[i]}).find()
            specifications_Title.push({id: addid.id, name: title[i]})
          }
        }
        console.log('-查找新建规格名结束******************************************************************');
        console.log(specifications_Title);
        console.log('-删除重建操作开始******************************************************************');
        await this.model('goods_specification').where({goods_id:id}).delete()
        let oneD_rowlist = []
        let goods_spec_arr = []
        for (var j = 0; j < unDeacartesList.length; j++) {
          let second_row = []
          for (var k = 0; k < unDeacartesList[j].length; k++) {
            oneD_rowlist.push(unDeacartesList[j][k])
            await this.model('goods_specification').add({
              goods_id: id,
              specification_id:specifications_Title[j].id,
              value:unDeacartesList[j][k] })
            const addspec = await this.model('goods_specification').where({
              goods_id: id,
              specification_id:specifications_Title[j].id,
              value:unDeacartesList[j][k] }).find();
              second_row.push(addspec)
          }
          goods_spec_arr.push(second_row)
        }
        console.log('-******************************************************************');
        let spec_id = []
        for (var k = 0; k < goods_spec_arr.length; k++) {
          let second_row_id = []
          for (var l = 0; l < goods_spec_arr[k].length; l++) {
            let id = goods_spec_arr[k][l].id + '' //最后的''很重要不加会炸
            second_row_id.push(id)
          }
          spec_id.push(second_row_id)
        }
        console.log('-******************************************************************');
        //笛卡尔乘积 spec_id 所有情况 只能笛卡尔乘积
        function Cartesian(a,b){
            var ret=[];
            // console.log(a+" "+b);
            for(var i=0; i<a.length;i++){
                for(var j=0;j<b.length;j++){
                    ret.push(array(a[i],b[j]));
                }
            }
            return ret;
        }
        function array(a,b){
            var ret=[];
            if(!(a instanceof Array)){
                ret=Array.call(null,a);
            }
            else{
                ret=Array.apply(null,a);
            }
            ret.push(b);
            return ret;
        }
        function multiCartesian(data){
            var len=data.length;
            // console.log(len);
            if(len==0){
                return [];
            }
            else if(len==1){
                return data[0];
            }
            else{
                var ret=data[0];
                for(var i=1;i<len;i++){
                    ret=Cartesian(ret,data[i]);
                }
                return ret;
            }
        }
        console.log('-重组完之后的specid******************************************************************');
        let Deacartes_specList = multiCartesian(spec_id)
        console.log('-删除之前的product******************************************************************');
        await this.model('product').where({goods_id:id}).delete()
        console.log('-开始写入product表******************************************************************');
        console.log(Deacartes_specList);
        console.log(value);
        // let lan = []
        if ( title.length == 1 ) {
            for (var j = 0; j < Deacartes_specList.length; j++) {
              var goods_ann = "F" + id + j
              await this.model('product').add({
                goods_id: id,
                goods_specification_ids: Deacartes_specList[j],
                goods_sn: goods_ann,
                goods_number: value[j].stock,
                retail_price: value[j].price,
              })
            }
          }else if ( title.length == 2 ){
            for (var k = 0; k < Deacartes_specList.length; k++) {
              var goods_ann = "S" + id + k
              await this.model('product').add({
                goods_id: id,
                goods_specification_ids: Deacartes_specList[k][0] + '_' + Deacartes_specList[k][1],
                goods_sn: goods_ann,
                goods_number: value[k].stock,
                retail_price: value[k].price,
              })
            }
          }else if ( title.length == 3 ){
            for (var h = 0; h < Deacartes_specList.length; h++) {
              var goods_ann = "T" + id + h
              await this.model('product').add({
                goods_id: id,
                goods_specification_ids: Deacartes_specList[h][0] + '_' + Deacartes_specList[h][1] + '_' + Deacartes_specList[h][2],
                goods_sn: goods_ann,
                goods_number: value[h].stock,
                retail_price: value[h].price,
              })
            }
          }
    }
    console.log('-写入product表完成******************************************************************');
    return this.fail(400,'商品规格更新成功 ！')
  }
};
