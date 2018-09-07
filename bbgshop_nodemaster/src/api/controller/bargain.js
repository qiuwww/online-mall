const Base = require('./base.js');

module.exports = class extends Base {
  //查找所有开启砍价的商品
  async bargainlistAction() {
    const data = await this.model('bargain').where({
      is_abled: 1
    }).select();
    if (data.length > 0) {
      for (var i = 0; i < data.length; i++) {
        if (data[i].end_time > new Date().getTime()) {
          const bargain = await this.model('bargain').where({
            is_abled: 1
          }).select();
          for (var j = 0; j < bargain.length; j++) {
            let goodsdata = []
            goodsdata = await this.model('goods').where({
              id: bargain[j].goodsid
            }).find();
            bargain[j].goods = goodsdata
          }
          return this.success({
            data: bargain
          })
        } else {
          await this.model('bargain').where({
            id: data[i].id
          }).update({
            is_abled: 0
          });
          // console.log("已过期");
        }
      }
    } else {
      return this.success({
        data: data
      })
    }
  }
  //查找用户参与的砍价
  async userbargainlistAction() {
    const userId = this.post('userId')
    const data = await this.model('bargain_user').where({
      user_id: userId
    }).select();
    // let boedel = []
    // for (var i = 0; i < data.length; i++) {
    //   if (data[i].iscut == '5') {} else {
    //     boedel.push(data[i])
    //   }
    // }
    return this.success({
      data: data
    })
  }
  // //查找用户是否参与过此条砍价
  async finduseriscutAction() {
    const userId = this.post('userId')
    const barId = this.post('barId')
    const have = await this.model('bargain_user').where({
      user_id: userId,
      bargain_id: barId
    }).select()
    if (have.length > 0) {
      return this.fail(17, '您已发起过此次砍价 ！')
    } else {
      return this.success({
        have
      })
    }
  }
  //按商品id商品sku信息
  async findgoodskuAction() {
    const goodsId = this.get("id")
    const model = this.model('goods');
    const info = await model.where({ id: goodsId }).find();
    return this.success({
      goodsinfo: info,
      specificationList: await model.getSpecificationList(goodsId),
      productList: await model.getProductList(goodsId)
    });
  }
  //按砍价id查找砍价信息
  async findbargainbyidAction() {
    const barid = this.post("id")
    const data = await this.model('bargain').where({
      id: barid,
      is_abled: 1
    }).find();
    let goods = []
      let goodsdata = []
      goodsdata = await this.model('goods').where({
        id: data.goodsid
      }).find();
      data.goods = goodsdata
    return this.success({
      data: data
    })
  }
  //发起者的砍价
  async setlaunchuserbarAction() {
    const userInfo = this.post('userInfo')
    const bargoods = this.post('bargoods')
    const skuInfo = this.post('skuInfo')
    const skuValue = this.post('skuValue')
    if (think.isEmpty(userInfo) || think.isEmpty(bargoods) || think.isEmpty(skuInfo) || skuValue == '' ) {
      console.log(userInfo);
      console.log(bargoods);
      console.log(skuInfo);
      console.log(skuValue);
    }else {
      console.log("正常");
      //先产生砍价的价格
      let cutprice = 0
      let surplus = 0
      let rend = (parseInt(100 * Math.random()) / 1000).toFixed(3);
      console.log(0.08 + Number(rend));
      cutprice = (skuInfo.retail_price * (0.08 + Number(rend))).toFixed(2)
      surplus = ((skuInfo.retail_price - cutprice) / 1).toFixed(2)
      console.log(cutprice);
      console.log(surplus);
      // 再加入砍价用户表
      const bargain_user_table_id = await this.model('bargain_user').add({
        user_id: userInfo.id,
        bargain_id: bargoods.id,
        goods_id: bargoods.goodsid,
        goods_sn: skuInfo.goods_sn,
        product_id: skuInfo.id,
        goods_name: bargoods.goods.name,
        goods_rel_price: skuInfo.retail_price,
        goods_lowest_price: bargoods.lowest_price,
        duration_time: bargoods.user_duration_time,
        most_init_num: bargoods.most_init_num,
        least_cut_num: bargoods.least_cut_num,
        only_cut_num: bargoods.only_cut_num,
        have_cut_num: 1,
        have_cut_price: cutprice,
        have_cut_lest: surplus,
        created_time: new Date().getTime(),
        end_time: new Date().getTime() + Number(bargoods.user_duration_time),
        goods_sku_id: skuInfo.id,
        goods_spec_ids: skuInfo.goods_specification_ids,
        goods_sku_value: skuValue,
        goods_pic: bargoods.goods.list_pic_url
      })
      console.log(bargain_user_table_id);
      //最后加入砍价用户的帮助表
      const data = await this.model('bargain_user_friend').add({
        bargain_user_table_id: bargain_user_table_id,
        bargain_main_table_id: bargoods.id,
        user_id: userInfo.id,
        friend_nick_name: userInfo.nickname,
        friend_avatar: userInfo.avatar,
        goods_id: bargoods.goodsid,
        goods_name: bargoods.goods_name,
        goods_rel_price: skuInfo.retail_price,
        goods_lowest_price: bargoods.lowest_price,
        cut_price: cutprice,
        surplus_price: surplus,
      })
      //再更新砍价主表
      const bargain_main = await this.model('bargain').where({id: bargoods.id}).find()
      await this.model('bargain').where({id: bargoods.id}).update({
        launched_num: Number(bargain_main.launched_num) + 1,
        participate_num: Number(bargain_main.participate_num) + 1
      })
      console.log("砍价发起很成功");
      return this.success(bargain_user_table_id)
    }
  }
  //按id查找用户已发起的砍价信息
  async finduserbargainAction() {
    const bargainid = this.post("bargainid")
    let id = parseInt(bargainid)
    const bargainuser_table_info = await this.model('bargain_user').where({
      id: id
    }).find();
    const goods = await this.model('goods').where({ id: bargainuser_table_info.goods_id }).find();
    const launched_userInfo = await this.model('user').where({ id: bargainuser_table_info.user_id }).find();
    const othergoods = await this.model('goods').where({ category_id: goods.category_id }).limit(6).select();
    const bargainmain_table_info = await this.model('bargain').where({ id: bargainuser_table_info.bargain_id }).find();
    const cuted_user_list = await this.model('bargain_user_friend').where({
      bargain_main_table_id: bargainmain_table_info.id,
      bargain_user_table_id: bargainuser_table_info.id,
    }).select()
    return this.success({
      bargainuser_table_info: bargainuser_table_info,
      bargainmain_table_info: bargainmain_table_info,
      launched_userInfo: launched_userInfo,
      cuted_user_list: cuted_user_list,
      goods: goods,
      othergoods: othergoods
    })
  }
  // //好友砍价
  async friendcutAction() {
    const user_INInfo = this.post('user_INInfo')
    const launcheduser = this.post('launcheduser')
    const bargainUserInfo = this.post('bargainUserInfo')
    const data = await this.model('bargain_user_friend').where({
      bargain_main_table_id: bargainUserInfo.bargain_id,
      bargain_user_table_id: bargainUserInfo.id,
      user_id: user_INInfo.id,
    }).select();
    // if (data.length <= 0) {
    if (data.length > 0) {
      return this.fail(217, '用户已砍过！');
    } else {
      //用户没有参与过砍价 开始砍价
      // 查找砍价主表
      // const bargainMainInfo = await this.model('bargain').where({})
      let cutprice = 0
      let surplus = 0
      let rend = (parseInt(100 * Math.random()) / 1000).toFixed(3);
      cutprice = (bargainUserInfo.have_cut_lest * ((bargainUserInfo.have_cut_num / bargainUserInfo.least_cut_num) * (0.08 + rend * 10))).toFixed(2)
      let cutAllPrice = (Number(bargainUserInfo.have_cut_price) + Number(cutprice)).toFixed(2)
      surplus = (Number(bargainUserInfo.goods_rel_price) - cutAllPrice).toFixed(2)
      console.log(cutAllPrice); //所有砍掉的价格
      console.log(cutprice); //砍掉的价格
      console.log(surplus); //剩余的价格
      //先设置user表里的价格参数
      await this.model('bargain_user').where({id: bargainUserInfo.id}).update({
        have_cut_price: Number(cutAllPrice),
        have_cut_lest: Number(surplus),
        have_cut_num: Number(bargainUserInfo.have_cut_num) + 1
      })
      await this.model('bargain_user_friend').add({
        bargain_user_table_id: bargainUserInfo.id,
        bargain_main_table_id: bargainUserInfo.bargain_id,
        user_id: user_INInfo.id,
        friend_nick_name: user_INInfo.nickname,
        friend_avatar: user_INInfo.avatar,
        goods_id: bargainUserInfo.goods_id,
        goods_name: bargainUserInfo.goods_name,
        goods_rel_price: bargainUserInfo.goods_rel_price,
        goods_lowest_price: bargainUserInfo.goods_lowest_price,
        cut_price: cutprice,
        surplus_price: surplus,
      })
      //再更新砍价主表
      const bargain_main = await this.model('bargain').where({id: bargainUserInfo.bargain_id}).find()
      await this.model('bargain').where({id: bargainUserInfo.bargain_id}).update({
        // launched_num: Number(bargain_main.launched_num) + 1,
        participate_num: Number(bargain_main.participate_num) + 1
      })
      if (Number(surplus) <= 0.00) {
        await this.model('bargain_user').where({id:bargainUserInfo.id}).update({
          is_success: 1,
          iscut: 1,
          success_time: new Date().getTime()
        })

        return this.fail(999,'砍价已完成 !',cutprice)
      }else {
        return this.success(cutprice)
      }
    }
  }
  //不是发起者 核对进入用户是否参与过此次砍价
  async checkfriendiscutAction() {
    const user_IN_id = this.post('user_IN_id')
    const barId = this.post('barId')
    const have = await this.model('bargain_user_friend').where({
      bargain_user_table_id: barId,
      user_id:user_IN_id
    }).select()
    // if (have.length <= 0) {
    if (have.length > 0) {
      return this.fail(17,'您已经参与过此次砍价啦 ~')
    }else {
      return this.success(have)
    }
  }
  //好友用户砍价完成之后 再次查找砍价表的信息
  async afterbargainfindinfoagainAction() {
    const barid = this.post('barId')
    const bargainUserInfo = await this.model('bargain_user').where({ id:barid }).find()
    const joinInBargainUserList = await this.model('bargain_user_friend').where({
      bargain_user_table_id:barid
    }).select()
    return this.success({
      bargainUserInfo: bargainUserInfo,
      joinInBargainUserList: joinInBargainUserList
    })
  }
  //发起者点击领取按钮获取用户收货地址
  async afterbargainsuccessadresslistAction() {
    const userId = this.post('userId')
    const addressList = await this.model('address').where({
      user_id: userId
    }).select();
    let itemKey = 0;
    for (const addressItem of addressList) {
      addressList[itemKey].province_name = await this.model('region').getRegionName(addressItem.province_id);
      addressList[itemKey].city_name = await this.model('region').getRegionName(addressItem.city_id);
      addressList[itemKey].district_name = await this.model('region').getRegionName(addressItem.district_id);
      addressList[itemKey].full_region = addressList[itemKey].province_name + addressList[itemKey].city_name + addressList[itemKey].district_name;
      itemKey += 1;
    }
    return this.success(addressList);
  }
  //用户点击收货地址之后查找收货地址详情
  async afterbargainsuccessadressdetailAction() {
    const addressId = this.post('id');
    console.log(addressId);
    const addressInfo = await this.model('address').where({
      id: addressId
    }).find();
    if (!think.isEmpty(addressInfo)) {
      addressInfo.province_name = await this.model('region').getRegionName(addressInfo.province_id);
      addressInfo.city_name = await this.model('region').getRegionName(addressInfo.city_id);
      addressInfo.district_name = await this.model('region').getRegionName(addressInfo.district_id);
      addressInfo.full_region = addressInfo.province_name + addressInfo.city_name + addressInfo.district_name;
    }
    return this.success(addressInfo);
  }
  //用户确认后生成砍价订单
  async afterbargainsuccesssetorderAction() {
    const _ = require('lodash');
    const selectAdressId = this.post('selectAdressId')
    const orderUserId = this.post('orderUserId')
    const orderBargainId = this.post('orderBargainId')

    const date = new Date();
    let sn = date.getFullYear() + _.padStart(date.getMonth() + 1, 2, '0') + _.padStart(date.getDate(), 2, '0') +
      _.padStart(date.getHours(), 2, '0') + _.padStart(date.getMinutes(), 2, '0') +
      _.padStart(date.getSeconds(), 2, '0') + _.random(100000, 999999);
    console.log(sn);
    console.log(selectAdressId);
    console.log(orderUserId);
    console.log(orderBargainId);
    const AddressInfo = await this.model('address').where({id:selectAdressId}).find()
    const bargainUserInfo = await this.model('bargain_user').where({id:orderBargainId}).find()
    const bargainMainInfo = await this.model('bargain').where({id:bargainUserInfo.bargain_id}).find()
    const userInfo = await this.model('user').where({id:orderUserId}).find()
    //加入订单表
    if (bargainUserInfo.order_sn == 0) {
      const order_table_id = await this.model('order').add({
        order_sn: sn,
        user_id: orderUserId,
        order_status: 0,
        consignee: AddressInfo.name,
        country: AddressInfo.country_id,
        province: AddressInfo.province_id,
        city: AddressInfo.city_id,
        district: AddressInfo.district_id,
        address: AddressInfo.address,
        mobile: AddressInfo.mobile,
        postscript: '',
        shipping_fee: bargainUserInfo.have_cut_price,
        pay_name: '砍价订单',
        pay_id: 1,
        actual_price: bargainUserInfo.goods_lowest_price,
        order_price: bargainUserInfo.goods_lowest_price,
        goods_price: bargainUserInfo.goods_rel_price,
        add_time: new Date().getTime(),
      })
      console.log(order_table_id);
      const order_goods_table = await this.model("order_goods").add({
        order_id: parseInt(order_table_id),
        goods_id: bargainUserInfo.goods_id,
        goods_sn: bargainUserInfo.goods_sn,
        product_id: bargainUserInfo.goods_sku_id,
        goods_name: bargainUserInfo.goods_name,
        list_pic_url: bargainUserInfo.goods_pic,
        market_price: bargainUserInfo.goods_rel_price,
        retail_price: bargainUserInfo.goods_rel_price,
        number: 1,
        goods_specifition_name_value: bargainUserInfo.goods_sku_value,
        goods_specifition_ids: bargainUserInfo.goods_spec_ids
      })
      //更新砍价用户表 写入订单编号 sn
      await this.model('bargain_user').where({id: orderBargainId}).update({iscut: 2 ,order_sn: sn})
      //更新订单主表
      await this.model("bargain").where({ id:bargainUserInfo.bargain_id }).update({
        purchased_num: parseInt(bargainMainInfo.purchased_num) + 1
      })
      //订单生成成功后 返回订单编号和订单价格
      return this.success({
        orderSn: sn,
        orderPrice: bargainUserInfo.goods_lowest_price
      })
    }else {
      return this.fail(17,'订单已存在 !')
    }


    //
    // const barmain = await this.model("bargain").where({
    //   goodsid: bargaingoods.goods_id,
    // }).find()
    // await this.model('bargain_user').where({
    //   goods_sku_id: bargaingoods.goods_sku_id,
    // }).update({
    //   iscut: '2',
    //   order_sn: sn
    // })
    // await this.model("bargain").where({
    //   goodsid: bargaingoods.goods_id,
    // }).update({
    //   purchased_num: parseInt(barmain.purchased_num) + 1
    // })
    // const order = await this.model('order').add({
    //   order_sn: sn,
    //   user_id: bargaingoods.user_id,
    //   order_status: 0,
    //   consignee: addressInfo.name,
    //   country: addressInfo.country_id,
    //   province: addressInfo.province_id,
    //   city: addressInfo.city_id,
    //   district: addressInfo.district_id,
    //   address: addressInfo.address,
    //   mobile: addressInfo.mobile,
    //   postscript: '',
    //   shipping_fee: bargaingoods.have_cut_price,
    //   pay_name: '砍价订单',
    //   pay_id: 1,
    //   actual_price: bargaingoods.goods_lowest_price,
    //   order_price: bargaingoods.goods_lowest_price,
    //   goods_price: bargaingoods.goods_rel_price,
    //   add_time: tmp,
    //   goods_sku_id: bargaingoods.goods_sku_id
    //   // confirm_time: 0 ,
    // })
    // console.log(order);
    // const order_goods = await this.model("order_goods").add({
    //   order_id: parseInt(order),
    //   goods_id: bargaingoods.goods_id,
    //   goods_sn: bargaingoods.goods_sn,
    //   product_id: bargaingoods.goods_sku_id,
    //   goods_name: bargaingoods.goods_name,
    //   list_pic_url: bargaingoods.goods_pic,
    //   market_price: bargaingoods.goods_rel_price,
    //   retail_price: bargaingoods.goods_rel_price,
    //   number: 1,
    //   goods_specifition_name_value: bargaingoods.goods_sku_value,
    //   goods_specifition_ids: bargaingoods.goods_spec_ids
    // })
    //
    // return this.success({
    //   orderId: sn,
    //   orderPrice: bargaingoods.goods_lowest_price
    // })
  }
  //支付砍价订单
  async paybargainorderAction() {
    const ordersn = this.post('ordersn')
    const status = this.post('status')
    const orderInfo = await this.model('order').where({order_sn:ordersn}).find()
    const bargainUserInfo = await this.model('bargain_user').where({order_sn:ordersn}).find()
    const bargainMainInfo = await this.model('bargain').where({id: bargainUserInfo.bargain_id}).find()
    await this.model('order').where({order_sn:ordersn}).update({
      order_status: status,
      pay_time: new Date().getTime()
     })
    await this.model('bargain_user').where({order_sn:ordersn}).update({ iscut: 3 })
    const data = await this.model('bargain').where({id: bargainUserInfo.bargain_id}).update({
      purchased_num: Number(bargainMainInfo.purchased_num) + 1
    })
    return this.success(data)
  }
  //查找砍价订单详情
  async findbarorderinfoAction() {
    const barid = this.post('barid')
    console.log(barid);
    const bargainUserInfo = await this.model('bargain_user').where({id:barid }).find()
    console.log(bargainUserInfo);
    const bargainOrderInfo = await this.model('order').where({order_sn: bargainUserInfo.order_sn}).find()
    return this.success({
      order_sn: bargainUserInfo.order_sn,
      price: bargainOrderInfo.actual_price
    })
  }

};
