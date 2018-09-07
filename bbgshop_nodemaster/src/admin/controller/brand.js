const Base = require('./base.js');

module.exports = class extends Base {
  /**
   * index action
   * @return {Promise} []
   */
  async indexAction() {
    const page = this.get('page') || 1;
    const size = this.get('size') || 10;
    const name = this.get('name') || '';

    const model = this.model('brand');
    const data = await model.field(['id', 'name', 'floor_price', 'app_list_pic_url', 'is_new', 'sort_order', 'is_show']).where({name: ['like', `%${name}%`]}).order(['id DESC']).page(page, size).countSelect();

    return this.success(data);
  }



  // async infoAction() {
  //   const id = this.get('id');
  //   const model = this.model('goods');
  //   const data = await model.where({id: id}).find();
  //
  //   return this.success(data);
  // }
  async infoAction() {
    const id = this.post('id');
    const model = this.model('goods');
    const data = await model.where({id: id}).find();

    return this.success(data);
  }

  // async addgoodsAction() {
  //   // const id = this.post('id');
  //   const adddata = this.post('add');
  //   // const model = this.model('goods');
  //   // const data = await model.where({id: id}).find();
  //
  //   return this.success(adddata);
  // }

  async addspecAction() {
    const goodsid = this.post('goodsid');
    const columnData = this.post('columnData');
    const titleData = this.post('titleData');
    const tableData = this.post('tableData');
    const model = this.model('specification');
    const modeltwo = this.model('goods_specification');
    const modelthird = this.model('product');
    const goods_spec_arr = [];
    const spec_id = [];
    const a1 = [];
    const a2 = [];
    const a3 = [];
    const spids = [];
    const lan = [];

    let itemKey = 0;
    const specifications = [];
      for (const title of titleData){
        const simal = await model.where({name:title}).getField('id')
        if (!think.isEmpty(simal)) {
          specifications.push({id: simal[0], name: title})
          //如果有则获取到id值
        }else {
          await model.add({name:title,sort_order:itemKey+1})
          const addid = await model.where({name:title}).find()
          specifications.push({id: addid.id, name: title})
        }
          // 否则插入新记录，获得id值
          itemKey += 1;
      }
      //有数据就删除此商品的所有规格，重新生成id
      await modeltwo.where({goods_id:goodsid}).delete()
      for (var i = 0; i < titleData.length; i++) {
        for (const list of columnData[i]) {
           await modeltwo.add({ goods_id:goodsid, specification_id:specifications[i].id, value:list.value })
           const addspec = await modeltwo.where({ goods_id:goodsid, specification_id:specifications[i].id, value:list.value }).select();
           goods_spec_arr.push(addspec)
         }
      }
      // console.log(goods_spec_arr);
      for (var k = 0; k < goods_spec_arr.length; k++) {
        spec_id[k] = goods_spec_arr[k][0].id+''
      }
      // console.log(spec_id);
      // var b1 = columnData[0].length
      // console.log(spec_id.substring(0,3));

      // console.log(a1,a2,a3);
      // console.log(columnData[0].length);
      // console.log(columnData[1].length);
      // console.log(columnData[2].length);
      //笛卡尔乘积
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

      if ( titleData.length == 1){
        for (var l = 0; l < columnData[0].length; l++) {
          a1.push(spec_id[l])
        }
          var data=[a1];
      }else if ( titleData.length == 2 ){
        for (var l = 0; l < columnData[0].length; l++) {
          a1.push(spec_id[l])
        }
        for (var m = columnData[0].length; m < (columnData[0].length + columnData[1].length); m++) {
          a2.push(spec_id[m])
        }
          var data=[a1,a2];
      }else if ( titleData.length == 3 ){
        for (var l = 0; l < columnData[0].length; l++) {
          a1.push(spec_id[l])
        }
        for (var m = columnData[0].length; m < (columnData[0].length + columnData[1].length); m++) {
          a2.push(spec_id[m])
        }
        for (var n = (columnData[0].length + columnData[1].length); n < (columnData[0].length + columnData[1].length+ columnData[2].length); n++) {
          a3.push(spec_id[n])
        }
          var data=[a1,a2,a3];
      }

      var arr=multiCartesian(data);
      spids.push(arr)
      // console.log(arr);
      // console.log(spids);
      await modelthird.where({goods_id:goodsid}).delete()
      if ( titleData.length == 1){
        for (var qo = 0; qo < tableData.length; qo++) {
          var goods_snn = "F"+goodsid + qo
          await modelthird.add({
            goods_id:goodsid,
            goods_specification_ids:spids[0][qo],
            goods_sn: goods_snn,
            goods_number:tableData[qo].stock,
            retail_price:tableData[qo].price,
          })
        }
      }else if ( titleData.length == 2 ){
        for (var ow = 0; ow < spids[0].length; ow++) {
          lan.push(spids[0][ow][0]+"_"+spids[0][ow][1])
        }
        for (var rq = 0; rq < tableData.length; rq++) {
          var goods_snn = "S"+goodsid + rq
          await modelthird.add({
            goods_id:goodsid,
            goods_specification_ids:lan[rq],
            goods_sn: goods_snn,
            goods_number:tableData[rq].stock,
            retail_price:tableData[rq].price,
          })
        }
      }else if ( titleData.length == 3 ){
        for (var o = 0; o < spids[0].length; o++) {
          lan.push(spids[0][o][0]+"_"+spids[0][o][1]+"_"+spids[0][o][2])
        }
        for (var q = 0; q < tableData.length; q++) {
          var goods_snn = "T"+goodsid + q
          await modelthird.add({
            goods_id:goodsid,
            goods_specification_ids:lan[q],
            goods_sn: goods_snn,
            goods_number:tableData[q].stock,
            retail_price:tableData[q].price,
          })
        }
      }
      //写入product表
      //
      // for (var j = 0; j < tableData.length; j++) {
      //   // console.log(j);
      // }
      // console.log(prodcopy);

      return this.success({
        // aaa:abc,
        // id:ID,
        specifications:specifications,
        columnData:columnData,
        goodsid:goodsid,
        titleData:titleData,
        tableData:tableData,
      });
  }



  async storeAction() {
    if (!this.isPost) {
      return false;
    }

    const values = this.post();
    const id = this.post('id');

    const model = this.model('goods');
    values.is_show = values.is_show ? 1 : 0;
    values.is_new = values.is_new ? 1 : 0;
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
    await this.model('brand').where({id: id}).limit(1).delete();
    // TODO 删除图片

    return this.success();
  }
};
