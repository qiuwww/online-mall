const Base = require('./base.js');

module.exports = class extends Base {
  async Commonformwork(data) {
    function timestampToTime(timestamp) {
            var date = new Date(timestamp * 1);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
            var Y = date.getFullYear() + '/';
            var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '/';
            var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + '  ';
            var h = (date.getHours() < 10 ? '0'+date.getHours() : date.getHours()) + ':';
            var m = (date.getMinutes() < 10 ? '0'+date.getMinutes() : date.getMinutes()) + ':';
            var s = (date.getSeconds() < 10 ? '0'+date.getSeconds() : date.getSeconds());
            return Y+M+D+h+m+s;
      }
    let export_from = []
    for (const item of data.data) {
      item.order_info = await this.model('order').where({id:item.order_id}).field(['id' ,'user_id', 'province',
       'city' ,'district' ,'address', 'add_time' , 'order_sn', 'consignee', 'mobile','postscript','admin_message']).find()
       // console.log(item.order_info);
      item.order_status_text = await this.model('order').getOrderStatusText(item.order_info.id);
      item.user_info = await this.model('user').where({id:item.order_info.user_id})
      .field(['nickname', 'mobile', 'mobile_country', 'mobile_code', 'mobile_country_e']).find()
      item.supplier_name = await this.model('supplier').where({id:item.supplier_id}).find()
      item.province_name = await this.model('region').where({ id: item.order_info.province }).getField('name', true);
      item.city_name = await this.model('region').where({ id: item.order_info.city }).getField('name', true);
      item.district_name = await this.model('region').where({ id: item.order_info.district }).getField('name', true);
      item.full_region = item.province_name + item.city_name + item.district_name + item.order_info.address;
      item.express = await this.model('order_express').where({ order_id: item.order_info.id }).find();
      let obj = {}
      obj.order_sn = item.order_info.order_sn
      obj.goods_name = item.goods_name
      obj.supplier_name = item.supplier_name.name
      obj.goods_num = item.number
      obj.order_status = item.order_status_text
      obj.consignee = item.order_info.consignee
      obj.mobile = item.order_info.mobile
      obj.full_region = item.full_region
      obj.user_message = item.order_info.postscript == '' ? '无' : item.order_info.postscript
      obj.admin_message = item.order_info.admin_message == '' ? '无' : item.order_info.admin_message
      obj.is_Identity = item.is_Identity == 0 ? '一般' : '跨境'
      obj.Identity_Input = item.Identity_Input == 0 ? '无需' : item.Identity_Input
      obj.express_shipper_name = item.express.shipper_name ? item.express.shipper_name : '无'
      obj.express_logistic_code = item.express.logistic_code ? item.express.logistic_code : '无'
      obj.user_country = item.user_info.mobile_country_e + ' - ' + item.user_info.mobile_country + '  +'+item.user_info.mobile_code
      obj.add_time = timestampToTime(item.order_info.add_time)
      export_from.push(obj)
    }
    data.export_from = export_from
    return data.export_from
  }
  async EXPORT_TO_EXLECEAction() {
    const supplier = this.post('supplier') || '';
    const limit_time_start = this.post('limit_time_start');
    const limit_time_end = this.post('limit_time_end');
    if (think.isEmpty(supplier) && limit_time_start == 0 && limit_time_end == 0) {
      console.log('没有指定供货商没有限制时间');//没有指定供货商没有限制时间
      const lan = await this.model('order_goods').select();
      let data = {}
      data.data = lan
      const list = await this.Commonformwork(data)
      return this.success(list);
    }else if(think.isEmpty(supplier) && limit_time_start !== 0 && limit_time_end !== 0){ //指定供货商 限制时间
      console.log('没有指定供货商 限制时间');
      const lan = await this.model('order_goods').where({add_time: ['between', limit_time_start, limit_time_end]}).select();
      let data = {}
      data.data = lan
      const list = await this.Commonformwork(data)
      return this.success(list);
    }else if(!think.isEmpty(supplier) && limit_time_start == 0 && limit_time_end == 0){ //指定供货商 没有限制时间
      console.log('指定供货商 没有限制时间');
      const lan = await this.model('order_goods').where({supplier_id:supplier}).select();
      let data = {}
      data.data = lan
      const list = await this.Commonformwork(data)
      return this.success(list);
    }else if(!think.isEmpty(supplier) && limit_time_start !== 0 && limit_time_end !== 0){ //指定供货商 没有限制时间
      console.log('指定供货商 限制时间');
      const lan = await this.model('order_goods').where({supplier_id:supplier,add_time: ['between', limit_time_start, limit_time_end]}).select();
      let data = {}
      data.data = lan
      const list = await this.Commonformwork(data)
      return this.success(list);
    }
  }
  async getallordergoodsAction() {
    const page = this.get('page') || 1;
    const size = this.get('size') || 10;
    const supplier = this.get('supplier') || '';
    const limit_time_start = this.get('limit_time_start');
    const limit_time_end = this.get('limit_time_end');
    if (think.isEmpty(supplier) && limit_time_start == 0 && limit_time_end == 0) {
      console.log('没有指定供货商没有限制时间');//没有指定供货商没有限制时间
      const data = await this.model('order_goods').page(page, size).countSelect();
      const list = await this.Commonformwork(data)
      data.data = list
      return this.success(data);
    }else if(think.isEmpty(supplier) && limit_time_start !== 0 && limit_time_end !== 0){ //指定供货商 限制时间
      console.log('没有指定供货商 限制时间');
      const data = await this.model('order_goods').where({add_time: ['between', limit_time_start, limit_time_end]}).page(page, size).countSelect();
      const list = await this.Commonformwork(data)
      data.data = list
      return this.success(data);
    }else if(!think.isEmpty(supplier) && limit_time_start == 0 && limit_time_end == 0){ //指定供货商 没有限制时间
      console.log('指定供货商 没有限制时间');
      const data = await this.model('order_goods').where({supplier_id:supplier}).page(page, size).countSelect();
      const list = await this.Commonformwork(data)
      data.data = list
      return this.success(data);
    }else if(!think.isEmpty(supplier) && limit_time_start !== 0 && limit_time_end !== 0){ //指定供货商 没有限制时间
      console.log('指定供货商 限制时间');
      const data = await this.model('order_goods').where({supplier_id:supplier,add_time: ['between', limit_time_start, limit_time_end]}).page(page, size).countSelect();
      const list = await this.Commonformwork(data)
      data.data = list
      return this.success(data);
    }
  }
  /**
   * index action
   * @return {Promise} []
   */
  async changeorderpriceAction() {
    const _ = require('lodash');
    const id = this.post('id')
    const price = this.post('price')
    const orderinfo = await this.model('order').where({id:id}).find()
    const date = new Date();
    let sn = date.getFullYear() + _.padStart(date.getMonth() + 1, 2, '0') + _.padStart(date.getDate(), 2, '0') +
      _.padStart(date.getHours(), 2, '0') + _.padStart(date.getMinutes(), 2, '0') +
      _.padStart(date.getSeconds(), 2, '0') + _.random(100000, 999999);
    console.log(id,price,sn);
    const data = await this.model('order').where({id:id}).update({
      order_sn:sn,
      actual_price:price,
      change_price_num: Number(orderinfo.change_price_num) + 1
    })
    return this.success(data)

  }
  async indexAction() {
    const page = this.get('page') || 1;
    const size = this.get('size') || 10;
    const orderSn = this.get('orderSn') || '';
    const consignee = this.get('consignee') || '';
    const status = this.get('status');

    const model = this.model('order');
    console.log(status);
    if (status == '') {
        const data = await model.where({order_sn: ['like', `%${orderSn}%`], consignee: ['like', `%${consignee}%`]}).order(['id DESC']).page(page, size).countSelect();
        // console.log("9879879878");
        const newList = [];
        for (const item of data.data) {
          item.order_status_text = await this.model('order').getOrderStatusText(item.id);
          newList.push(item);
        }
        data.data = newList;
        return this.success(data);
      }else {
      const data = await model.where({order_status:status,order_sn: ['like', `%${orderSn}%`], consignee: ['like', `%${consignee}%`]}).order(['id DESC']).page(page, size).countSelect();
      const newList = [];
      for (const item of data.data) {
        item.order_status_text = await this.model('order').getOrderStatusText(item.id);
        newList.push(item);
      }
      data.data = newList;
      return this.success(data);
    }

  }
  async allAction() {
    const page = this.get('page') || 1;
    const size = this.get('size') || 10;
    const orderSn = this.get('orderSn') || '';
    const consignee = this.get('consignee') || '';
    const status = this.get('status') || '';
    const type = this.get('type') || '';
    const supplier_id = this.get('supplier_id') || '';
    // const user = this.get('user') || '';
    const limit_day_start = this.get('limit_day_start') || 0
    const limit_day_end = this.get('limit_day_end') || 0
    console.log(limit_day_start,limit_day_end);
    const model = this.model('order');
    if (status == '' && parseInt(limit_day_start) !== 0 && parseInt(limit_day_end) !== 0 ) {
      console.log('所有订单 限制时间');
        const data = await model.where({
         order_sn: ['like', `%${orderSn}%`],
         consignee: ['like', `%${consignee}%`],
         pay_id: ['like', `%${type}%`],
         add_time: ['between', limit_day_start, limit_day_end ]
       }).order(['id DESC']).page(page, size).countSelect();
        const newList = [];
        for (const item of data.data) {
          item.order_status_text = await this.model('order').getOrderStatusText(item.id);
          // item.supplier_ids = item.supplier_ids ? item.supplier_ids.split(',') : null
          // item.supplier_ids_list = item.supplier_ids ? item.supplier_ids.map(num=>Number(num)) : null
          // item.supplier = item.supplier_ids ? await this.model('supplier').where({id:['IN', item.supplier_ids_list]}).select() : null
          // item.supplier = await this.model('supplier').where({id:['IN', item.supplier_ids_list]}).select()
          // item.locgic = await this.model('order_express').where({order_id:item.id}).find()
          item.refund = await this.model('order_refund').where({order_sn:item.order_sn}).find()
          item.user = await this.model('user').where({id:item.user_id}).find()
          item.province_name = await this.model('region').where({ id: item.province }).getField('name', true);
          item.city_name = await this.model('region').where({ id: item.city }).getField('name', true);
          item.district_name = await this.model('region').where({ id: item.district }).getField('name', true);
          item.full_region = item.province_name + item.city_name + item.district_name + item.address;
          newList.push(item);
        }
        data.data = newList;
        return this.success(data);
      }else if(status == '' && parseInt(limit_day_start) == 0 && parseInt(limit_day_end) == 0){
        console.log('所有订单 不限制时间');
        const data = await model.where({
          pay_id: ['like', `%${type}%`],
          order_sn: ['like', `%${orderSn}%`],
          consignee: ['like', `%${consignee}%`],
        }).order(['id DESC']).page(page, size).countSelect();
        const newList = [];
        for (const item of data.data) {
          item.order_status_text = await this.model('order').getOrderStatusText(item.id);
          // item.supplier_ids = item.supplier_ids ? item.supplier_ids.split(',') : null
          // item.supplier_ids_list = item.supplier_ids ? item.supplier_ids.map(num=>Number(num)) : []
          // item.supplier = item.supplier_ids ? await this.model('supplier').where({id:['IN', item.supplier_ids_list]}).select() : []
          // item.locgic = await this.model('order_express').where({order_id:item.id}).find()
          item.refund = await this.model('order_refund').where({order_sn:item.order_sn}).find()
          item.user = await this.model('user').where({id:item.user_id}).find()
          item.province_name = await this.model('region').where({ id: item.province }).getField('name', true);
          item.city_name = await this.model('region').where({ id: item.city }).getField('name', true);
          item.district_name = await this.model('region').where({ id: item.district }).getField('name', true);
          item.full_region = item.province_name + item.city_name + item.district_name + item.address;
          newList.push(item);
        }
        data.data = newList;
        if (!think.isEmpty(supplier_id)) {
          let list = []
          console.log(supplier_id);
          for (var i = 0; i < data.data.length; i++) {
            console.log(data.data[i].supplier_ids_list);
            // console.log(supplier_id);
            let is_have = data.data[i].supplier_ids_list.indexOf(parseInt(supplier_id))
            console.log(is_have);
            if (Number(is_have + 1) == 0) {
              data.data.splice(i, 1)
            }
            // for (var j = 0; j < data.data[i].supplier.length; j++) {
               // if (supplier_id == data.data[i].supplier[j]) {
                 // is_have = true
               // }else {

               // }
            // }
          }

          return this.success(data);
        }else {
          console.log("未指定供货商");
          return this.success(data);
        }
      }else if (status !== '' && parseInt(limit_day_start) !== 0 && parseInt(limit_day_end) !== 0) {
        console.log('限制订单 限制时间');
        const data = await model.where({
          order_status:status,
          order_sn: ['like', `%${orderSn}%`],
          pay_id: ['like', `%${type}%`],
          consignee: ['like', `%${consignee}%`],
          add_time: ['between', limit_day_start, limit_day_end]
       }).order(['id DESC']).page(page, size).countSelect();
        const newList = [];
        for (const item of data.data) {
          item.order_status_text = await this.model('order').getOrderStatusText(item.id);
          // item.supplier_ids = item.supplier_ids ? item.supplier_ids.split(',') : null
          // item.supplier_ids_list = item.supplier_ids ? item.supplier_ids.map(num=>Number(num)) : null
          // item.supplier = item.supplier_ids ? await this.model('supplier').where({id:['IN', item.supplier_ids_list]}).select() : null
          // item.supplier = await this.model('supplier').where({id:['IN', item.supplier_ids_list]}).select()
          // item.order_status_text = await this.model('order').getOrderStatusText(item.id);
          // item.locgic = await this.model('order_express').where({order_id:item.id}).find()
          item.refund = await this.model('order_refund').where({order_sn:item.order_sn}).find()
          item.user = await this.model('user').where({id:item.user_id}).find()
          item.province_name = await this.model('region').where({ id: item.province }).getField('name', true);
          item.city_name = await this.model('region').where({ id: item.city }).getField('name', true);
          item.district_name = await this.model('region').where({ id: item.district }).getField('name', true);
          item.full_region = item.province_name + item.city_name + item.district_name + item.address;
          newList.push(item);
        }
        data.data = newList;
        return this.success(data);
      }else if(status !== '' && parseInt(limit_day_start) == 0 && parseInt(limit_day_end) == 0){
        console.log('限制订单 不限制时间');
        const data = await model.where({
          order_status:status,
          order_sn: ['like', `%${orderSn}%`],
          pay_id: ['like', `%${type}%`],
          consignee: ['like', `%${consignee}%`]
        }).order(['id DESC']).page(page, size).countSelect();
        const newList = [];
        for (const item of data.data) {
          item.order_status_text = await this.model('order').getOrderStatusText(item.id);
          // item.supplier_ids = item.supplier_ids ? item.supplier_ids.split(',') : null
          // item.supplier_ids_list = item.supplier_ids ? item.supplier_ids.map(num=>Number(num)) : null
          // item.supplier = item.supplier_ids ? await this.model('supp//lier').where({id:['IN', item.supplier_ids_list]}).select() : null
          // item.supplier = await this.model('supplier').where({id:['IN', item.supplier_ids_list]}).select()
          // item.order_status_text = await this.model('order').getOrderStatusText(item.id);
          // item.locgic = await this.model('order_express').where({order_id:item.id}).find()
          item.refund = await this.model('order_refund').where({order_sn:item.order_sn}).find()
          item.user = await this.model('user').where({id:item.user_id}).find()

          item.province_name = await this.model('region').where({ id: item.province }).getField('name', true);
          item.city_name = await this.model('region').where({ id: item.city }).getField('name', true);
          item.district_name = await this.model('region').where({ id: item.district }).getField('name', true);
          item.full_region = item.province_name + item.city_name + item.district_name + item.address;
          newList.push(item);
        }
        data.data = newList;
        return this.success(data);
    }
  }
  async pendoutorderAction() {
    const page = this.post('page') || 1;
    const size = this.post('size') || 10;
    const orderSn = this.post('orderSn') || '';
    const consignee = this.post('consignee') || '';

    const model = this.model('order');
    const data = await model.where({order_status:201, order_sn: ['like', `%${orderSn}%`], consignee: ['like', `%${consignee}%`]}).order(['id DESC']).page(page, size).countSelect();
    const newList = [];
    for (const item of data.data) {
      item.order_status_text = await this.model('order').getOrderStatusText(item.id);
      newList.push(item);
    }
    data.data = newList;
    return this.success(data);
  }

  async pendpayorderAction() {
    const page = this.post('page') || 1;
    const size = this.post('size') || 10;
    const orderSn = this.post('orderSn') || '';
    const consignee = this.post('consignee') || '';

    const model = this.model('order');
    const data = await model.where({is_del:0,order_status:0, order_sn: ['like', `%${orderSn}%`], consignee: ['like', `%${consignee}%`]}).order(['id DESC']).page(page, size).countSelect();
    const newList = [];
    for (const item of data.data) {
      item.order_status_text = await this.model('order').getOrderStatusText(item.id);
      newList.push(item);
    }
    data.data = newList;
    return this.success(data);
  }

  async alreadyoutorderAction() {
    const page = this.post('page') || 1;
    const size = this.post('size') || 10;
    const orderSn = this.post('orderSn') || '';
    const consignee = this.post('consignee') || '';

    const model = this.model('order');
    const data = await model.where({order_status:300, order_sn: ['like', `%${orderSn}%`], consignee: ['like', `%${consignee}%`]}).order(['id DESC']).page(page, size).countSelect();
    const newList = [];
    for (const item of data.data) {
      item.order_status_text = await this.model('order').getOrderStatusText(item.id);
      item.locgic = await this.model('order_express').where({order_id:item.id}).find()
      newList.push(item);
    }
    data.data = newList;
    return this.success(data);
  }
  async refundorderAction() {
    const page = this.post('page') || 1;
    const size = this.post('size') || 10;
    const orderSn = this.post('orderSn') || '';
    const consignee = this.post('consignee') || '';

    const model = this.model('order');
    const data = await model.where({order_status:400, order_sn: ['like', `%${orderSn}%`], consignee: ['like', `%${consignee}%`]}).order(['id DESC']).page(page, size).countSelect();
    const newList = [];
    for (const item of data.data) {
      item.order_status_text = await this.model('order').getOrderStatusText(item.id);
      item.locgic = await this.model('order_express').where({order_id:item.id}).find()
      item.refund = await this.model('order_refund').where({order_sn:item.order_sn}).find()
      item.user = await this.model('user').where({id:item.user_id}).find()
      item.province_name = await this.model('region').where({ id: item.province }).getField('name', true);
      item.city_name = await this.model('region').where({ id: item.city }).getField('name', true);
      item.district_name = await this.model('region').where({ id: item.district }).getField('name', true);
      item.full_region = item.province_name + item.city_name + item.district_name;
      newList.push(item);
    }
    data.data = newList;
    return this.success(data);
  }

  async findpendpaygoodslistAction(){
    const orderId = this.post('orderid')
    console.log(orderId);
    const goodslist = await this.model('order_goods').where({order_id:orderId}).select()
    let true_list = []
    for (var i = 0; i < goodslist.length; i++) {
      // let obj = {}
      let a = await this.model('goods').where({id:goodslist[i].goods_id}).find()
      true_list.push(a)
      // return true_list
      // obj.
    }
    const goodsPrice = await this.model('order').where({id:orderId}).find()

    goodsPrice.province_name = await this.model('region').where({ id: goodsPrice.province }).getField('name', true);
    goodsPrice.city_name = await this.model('region').where({ id: goodsPrice.city }).getField('name', true);
    goodsPrice.district_name = await this.model('region').where({ id: goodsPrice.district }).getField('name', true);
    goodsPrice.full_region = goodsPrice.province_name + goodsPrice.city_name + goodsPrice.district_name;
    const logiclist = await this.model('shipper').select()
    const user = await this.model('user').where({id:goodsPrice.user_id}).find()
    // return this.success(goodslist,goodsPrice)
    return this.success({
      user:user,
      logiclist:logiclist,
      true_list:true_list,
      goodslist:goodslist,
      goodsPrice:goodsPrice
    })
  }

  async findTypeRegionAction(){
    const type = this.post('type')
    if (parseInt(type) == 1) {
      const list = await this.model('region').where({type: type}).select()
      return this.success({
        list:list
      })
    }else if (parseInt(type) == 2){
      const id = this.post('id')
      const list = await this.model('region').where({type: type,parent_id:id}).select()
      return this.success({
        list:list
      })
    }else if (parseInt(type) == 3){
      const id = this.post('id')
      const list = await this.model('region').where({type: type,parent_id:id}).select()
      return this.success({
        list:list
      })
    }

  }


  async setpendpayaddressAction(){
    const address = this.post('address')
    const orderid = this.post('orderid')
    const addresscode = this.post('regioncode')
    console.log(address);
    console.log(orderid);
    console.log(addresscode);
    const data = await this.model('order').where({id:orderid}).update({
      province:addresscode.first,
      city:addresscode.second,
      district:addresscode.third,
      consignee:address.name,
      address:address.address,
      mobile:address.phone,
    })
    return this.success(data)
  }

  async setpendpaymessageAction(){
    const message = this.post('message')
    const orderid = this.post('orderid')
    console.log(message);
    console.log(orderid);
    const data = await this.model('order').where({id:orderid}).update({
      postscript: message.buy_mes,
      admin_message: message.admin_mes
    })
    return this.success(data)
  }

  async setpendpaygoodsAction(){
    const price = this.post('all_price')
    const list = this.post('list')
    console.log(list);

    for (var i = 0; i < list.length; i++) {
      // array[i]
      await this.model('order_goods').where({id:list[i].id}).update({
        retail_price: parseInt(list[i].chaged_price)
      })
    }
    const data = await this.model('order').where({id: list[0].order_id}).update({
      actual_price: Number(price)
    })

    // const goodslist = await this.model('order_goods').where({order_id:orderId}).select()
    return this.success(data)
  }
  //发货
  async setlogiccompyAction(){
    const orderinfo = this.post('orderinfo')
    const goodslist = this.post('goodslist')
    const locgic = this.post('locgic')
    console.log(orderinfo);
    console.log(goodslist);
    console.log(locgic);
    const locgicinfo = await this.model('shipper').where({id:locgic.compy}).find()

    const have = await this.model('order_express').where({order_id:orderinfo.id}).select()
    if (have.length == 0) {
      const locgicc = await this.model('order_express').add({
        order_id:orderinfo.id,
        shipper_id: locgic.compy,
        shipper_name: locgicinfo.name,
        shipper_code: locgicinfo.code,
        logistic_code: locgic.compycode,
        add_time: new Date().getTime(),
      })
      await this.model('order').where({id:orderinfo.id}).update({
        order_status: 300,
        logistics_time: new Date().getTime(),
      })
      return this.success(locgicc)
    }else {
      return this.fail(17,'已存在!')
    }

  }

  //
  // async infoAction() {
  //   const id = this.post('id');
  //   const model = this.model('order');
  //   const data = await model.where({id: id}).find();
  //
  //   return this.success(data);
  // }

  async detailAction() {
    const orderId = this.post('orderId');
    const orderInfo = await this.model('order').where({ id: orderId }).find();

    if (think.isEmpty(orderInfo)) {
      return this.fail('订单不存在');
    }
    const userInfo = await this.model('user').where({ id: orderInfo.user_id }).find();
    const refundInfo = await this.model('order_refund').where({ order_sn: orderInfo.order_sn }).select();
    orderInfo.province_name = await this.model('region').where({ id: orderInfo.province }).getField('name', true);
    orderInfo.city_name = await this.model('region').where({ id: orderInfo.city }).getField('name', true);
    orderInfo.district_name = await this.model('region').where({ id: orderInfo.district }).getField('name', true);
    orderInfo.full_region = orderInfo.province_name + orderInfo.city_name + orderInfo.district_name;

    // const latestExpressInfo = await this.model('order_express').getLatestOrderExpress(orderId);
    // orderInfo.express = latestExpressInfo;

    const orderGoods = await this.model('order_goods').where({ order_id: orderId }).select();

    // 订单状态的处理
    orderInfo.order_status_text = await this.model('order').getOrderStatusText(orderId);
    orderInfo.add_time = orderInfo.add_time

    // orderInfo.final_pay_time = moment('001234', 'Hmmss').format('mm:ss');
    // // 订单最后支付时间
    // if (orderInfo.order_status === 0) {
    //   // if (moment().subtract(60, 'minutes') < moment(orderInfo.add_time)) {
    //   orderInfo.final_pay_time = moment('001234', 'Hmmss').format('mm:ss');
    //   // } else {
    //   //     //超过时间不支付，更新订单状态为取消
    //   // }
    // }

    // 订单可操作的选择,删除，支付，收货，评论，退换货
    // const handleOption = await this.model('order').getOrderHandleOption(orderId);

    return this.success({
      orderInfo: orderInfo,
      refundInfo: refundInfo,
      userInfo:userInfo,
      orderGoods: orderGoods,
    });
  }

  //退款成功后状态更新
  async refundSuccessAction(){
    const orderid = this.post('orderId');
    const time = this.post('time') || 0 ;
    console.log(orderid);
    console.log(time);
    const orderInfo = await this.model('order').where({id:orderid}).find()
    console.log(orderInfo);
    const refundorderInfo = await this.model('order_refund').where({order_sn:orderInfo.order_sn}).find()
    console.log(refundorderInfo);
    const updateRefund = await this.model('order_refund').where({order_sn:orderInfo.order_sn}).update({
      isRefund:1,
      refund_time: new Date().getTime(),
      state_text:"退款成功",
      state:503,//退款成功状态
    })
    const updateOrder = await this.model('order').where({id:orderid}).update({
      order_status:301,
      refund_is_success:1,
      refund_time: new Date().getTime(),


    })
  }
  async storeAction() {
    if (!this.isPost) {
      return false;
    }

    const values = this.post();
    const id = this.post('id');

    const model = this.model('order');
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
    await this.model('order').where({id: id}).limit(1).delete();

    // 删除订单商品
    await this.model('order_goods').where({order_id: id}).delete();

    // TODO 事务，验证订单是否可删除（只有失效的订单才可以删除）

    return this.success();
  }
  //拒绝申请的退款订单
  async canelrefundAction() {
    const orderid = this.post('orderid')
    // console.log(orderid);
    const orderinfo = await this.model('order').where({id:orderid}).find()
    const refundorderinfo = await this.model('order_refund').where({order_sn:orderinfo.order_sn}).find()
    await this.model('order').where({id:orderid}).update({
      order_status: refundorderinfo.back_state,
      refund_is_success: 2,
    })
    const data = await this.model('order_refund').where({order_sn:orderinfo.order_sn}).update({
      state:1017,
      state_text:'已拒绝',
      handle_time:new Date().getTime(),
      rerund_num: Number(refundorderinfo.rerund_num) + 1
    })
    console.log(orderid,orderinfo,refundorderinfo);
    return this.success(data)
  }
  /**
   * 查询
   * @returns {Promise.<void>}
   */
  async expressAction() {
    const orderId = this.post('orderId');
    console.log(orderId);
    if (think.isEmpty(orderId)) {
      return this.fail('订单不存在');
    }
    const latestExpressInfo = await this.model('order_express').getLatestOrderExpress(orderId);
    return this.success(latestExpressInfo);
  }
};
