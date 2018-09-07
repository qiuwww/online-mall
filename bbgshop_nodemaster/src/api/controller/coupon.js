const Base = require('./base.js');

module.exports = class extends Base {
  async listAction() {
    // const price = this.post('price');
    const listall = await this.model('coupon_main').where({
      coupon_isabled:1,
      // point_user:''
    }).select()
    let list = []
    console.log(list);
    for (var i = 0; i < listall.length; i++) {
      if (listall[i].point_user !== '') {
        var userid = listall[i].point_user
        let useridlist = userid.split(',')
        for (var j = 0; j < useridlist.length; j++) {
          if (useridlist[j] == think.userId) {
            list.push(listall[i])
          }
        }
      }
      if(listall[i].point_user == ''){
        list.push(listall[i])
      }
    }
    for (var i = 0; i < list.length; i++) {
      if (list[i].point_goods !== '') {
        console.log(list[i].point_goods);
        var goodsid = list[i].point_goods
        let goodsidlist = goodsid.split(',')
        console.log(goodsidlist);
        let goods = []
        for (var k = 0; k < goodsidlist.length; k++) {
          let obj = {}
          const goodsll = await this.model('goods').where({id:goodsidlist[k]}).find()
          obj = goodsll
          goods.push(obj)
        }
        list[i].goods = goods
      }
    }
    return this.success(list)
    // console.log(price);

  }
  async findinputAction() {
    const id = this.post('id')
    const list = await this.model('coupon_main').where({
      coupon_id:id
    }).select()
    if (list.length == 0) {
      return this.fail(11,"失败")
    }else {
      return this.success(list)

    }
  }
  async usergetAction() {
    const id = this.post('id')
    const coupon_main = await this.model('coupon_main').where({coupon_id:id}).find()
    console.log(coupon_main);
    const have = await this.model('coupon_user').where({coupon_id:id,user_id:think.userId}).select()
    if (have.length !== 0) {
      return this.fail(217,'已存在！')
    }else {
      await this.model('coupon_main').where({coupon_id:id}).update({
        obtained_num: Number(coupon_main.obtained_num) + 1
      })
      const coupon_user_id = await this.model('coupon_user').add({
        user_id:think.userId,
        coupon_id:id,
        coupon_name:coupon_main.coupon_name,
        coupon_number:coupon_main.coupon_number,
        coupon_type:coupon_main.coupon_type,
        coupon_value:coupon_main.coupon_value,
        coupon_limit:coupon_main.coupon_limit,
        coupon_limit_value:coupon_main.coupon_limit_value,
        coupon_user_getnumber:coupon_main.coupon_user_getnumber,
        validity_type:coupon_main.validity_type,
        validity_create:coupon_main.validity_create,
        validity_start:new Date().getTime(),
        validity_end: parseInt(new Date().getTime()) + parseInt(coupon_main.validity_limit_day),
        point_goods:coupon_main.point_goods,
        point_user:coupon_main.point_user,
        Instructions:coupon_main.Instructions
      })
      console.log(coupon_user_id);
      const coupon_user = await this.model('coupon_user').where({id:coupon_user_id}).find()
      return this.success(coupon_user)
    }


  }
  async userlistAction(){
    const list = await this.model('coupon_user').where({user_id:think.userId}).select()
    let unablelist = []
    let ablelist = []
    let usedlist = []
    for (var i = 0; i < list.length; i++) {
      if (list[i].point_goods !== '') {
        console.log(list[i].point_goods);
        var goodsid = list[i].point_goods
        let goodsidlist = goodsid.split(',')
        console.log(goodsidlist);
        let goods = []
        for (var k = 0; k < goodsidlist.length; k++) {
          // array[i]
          let obj = {}
          const goodsll = await this.model('goods').where({id:goodsidlist[k]}).find()
          obj = goodsll
          goods.push(obj)

        }
        list[i].goods = goods
        // console.log(list); ,841662,636004,622336
      }
      // console.log();
      if (list[i].validity_end <= new Date().getTime() || list[i].used_type == 2) {
        console.log("已过期");
        await this.model('coupon_user').where({id:list[i].id}).update({
          used_type:2
        })
        unablelist.push(list[i])
      }else if(list[i].used_type == 1){
        usedlist.push(list[i])
      }else if(list[i].used_type == 0){
        ablelist.push(list[i])
      }
    }
    return this.success({
      ablelist:ablelist,
      unablelist:unablelist,
      usedlist:usedlist
    })
  }

//   async repcuplistAction() {
//     const tab = this.post('tabid')
//     const list = this.post('list')
//     console.log(list);
//     if (tab == 0){
//       // let obj = {}
//       let replist = []
//       for (var i = 0; i < list.length; i++) {
//       let obj = {}
//       obj.name = list[i].coupon_name
//       obj.value = list[i].coupon_value
//       obj.coupon_type = list[i].coupon_type
//       obj.validity_end = list[i].validity_end
//       if (list[i].coupon_limit == 1) {
//         obj.limit = '满 ' + list[i].coupon_limit_value + ' 可用'
//       } else {
//         obj.limit = "无门槛"
//       }
//       if (list[i].point_goods !== '') {
//         // obj.src = 'null'
//         if (list[i].goods.length > 1) {
//           // obj.src = 'null'
//           obj.ispoint = '2'
//           obj.goods = list[i].goods
//         } else {
//           obj.ispoint = '1'
//         }
//       }
//       console.log(obj);
//       replist.push(obj)
//     }
//     console.log(replist);
//
//       return this.success({
//         replist:replist
//       })
//     }else if (tab == 2) {
//
//   }
// }
  async findAction() {
    const id = this.post('couponId')
    console.log(id);
    if (parseInt(id) == 0) {
      return this.success({
        couponList: 0
      })
    }else {
      const select = await this.model('coupon_user').where({coupon_id:id}).find()
      return this.success({
        couponList:select
      })
    }

  }
  async checkcuplistAction(){
    const price = this.post('price')
    const idList = this.post('idList')
    console.log(price);
    console.log(idList);
    const list = await this.model('coupon_user').where({user_id:think.userId}).select()
    // console.log(list);
    let unablelist = []
    let ablelist = []
    let usedlist = []
    for (var i = 0; i < list.length; i++) {
      if (list[i].point_goods !== '') {
        // console.log(list[i].point_goods);
        var goodsid = list[i].point_goods
        let goodsidlist = goodsid.split(',')
        // console.log(goodsidlist);
        let goods = []
        for (var k = 0; k < goodsidlist.length; k++) {
          let obj = {}
          const goodsll = await this.model('goods').where({id:goodsidlist[k]}).find()
          obj = goodsll
          goods.push(obj)
        }
        list[i].goods = goods
      }
      if (list[i].validity_end <= new Date().getTime() || list[i].used_type == 2) {
        await this.model('coupon_user').where({id:list[i].id}).update({
          used_type:2
        })
        unablelist.push(list[i])
      }else if(list[i].used_type == 1){
        usedlist.push(list[i])
      }else if(list[i].used_type == 0){
        ablelist.push(list[i])
      }
    }
    console.log(ablelist);
    let extlimit = []
    for (var l = 0; l < ablelist.length; l++) {
      if (parseInt(ablelist[l].coupon_limit_value * 1000 / 1) >= parseInt(price * 1000)) {
        console.log("没有达到门槛金额");
      }else {
        extlimit.push(ablelist[l])
      }
    }
    console.log("extlimit"+extlimit);
    let finall = []
    let finallall = []
    for (var m = 0; m < extlimit.length; m++) {
      if (extlimit[m].point_goods == "") {
        finallall.push(extlimit[m])
        console.log('没有指定商品');
      }else {
        for (var n = 0; n < extlimit[m].goods.length; n++) {
          for (var o = 0; o < idList.length; o++) {
            if (extlimit[m].goods[n].id == idList[o]  ) {
              finallall.push(extlimit[m])
            }
          }
        }
      }
    }
    // console.log("999999999999999999999999999999999999999");
    console.log(finallall);
    // finallall = finall
    // return this.success(finall)
    return this.success({
      finall:finallall
    })
    // for (var m = 0; m < idList.length; m++) {
    //   // array[i]
    //   // console.log(idList[m]);
    //   for (var n = 0; n < extlimit.length; n++) {
    //     // array[i]
    //     console.log(idList[m],extlimit[n].goods);
    //     // if (true) {
    //     //
    //     // }
    //   }
    //
    // }

  }
};
