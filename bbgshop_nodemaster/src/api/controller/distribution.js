const Base = require('./base.js');

module.exports = class extends Base {
  async getdisrulesAction() {
    const data = await this.model("distribution_rate").where({id:1}).find()
    return this.success(data)
  }
  async checkisdistributionhavefatherAction() {
    const userId = this.post('userId')
    // const userdis = await this.model('distribution_user').where({user_id:think.userId}).select()
    const maindis = await this.model('distribution_main').where({user_id:userId}).select()
    console.log(maindis);
    const userdis = maindis.length == 0 ? [] : await this.model('distribution_user').where({children_id:maindis[0].user_id}).select()
    console.log(userdis);
    console.log('9999999999999999999999999999999999999');
    if (maindis.length == 0 && userdis.length == 0) {
      return this.fail(444,'当前用户没有成为分销商，没有邀请者,可设置邀请者')
    }else if(maindis.length !== 0 && userdis.length == 0){
      return this.fail(555,'当前用户为分销商，没有邀请者,可设置邀请者')
    }else if(maindis.length == 0 && userdis.length !== 0){
      return this.fail(666,'当前用户没有成为分销商，但已有邀请者,不可设置邀请者')
    }else if(maindis.length !== 0 && userdis.length !== 0){
      return this.fail(777,'当前用户为分销商，已有邀请者,不可设置邀请者')
    }

  }
  async findisdistributionAction() {
    const orderId = this.post('orderId')
    const applydata = await this.model('distribution_apply').where({user_id:orderId}).select()
    if (applydata.length !== 0) {
      if (applydata[0].status === 0) {
        return this.fail(17,applydata)
      }else if(applydata[0].status === 1){
        const disdata = await this.model('distribution_main').where({user_id:applydata[0].user_id}).select()
        const ratedata = await this.model('distribution_rate').select()
        const discatch = await this.model('distribution_cash').where({user_id:applydata[0].user_id}).select()
        const disgoods = await this.model('distribution_goods').where({farther_user_id:disdata[0].user_id}).select()
        const peoplenum = await this.model('distribution_user').where({farther_user_id:disdata[0].user_id}).select()
        disdata[0].peoplenum = peoplenum.length
        disdata[0].rate = ratedata[0].rate
        disdata[0].price = ratedata[0].price
        return this.fail(503,{
          disdata:disdata,
          disgoods:disgoods,
          discatch:discatch
        })
      }else if(applydata[0].status === 2){
        return this.fail(99,applydata)
      }
    }
  }
  async findisdistribution_catchAction() {
    const user = this.post('userinfo')
    console.log(user);
    const data = await this.model('distribution_main').where({user_id:user.id}).select()
    return this.success(data)
  }
  async applyisdistribution_catchAction() {
    const userInfo = this.post('userInfo')
    const value = this.post('value')
    const cashtype = this.post('cashtype')
    const selectbankcard = this.post('selectbankcard')
    console.log(userInfo,value,cashtype,selectbankcard);

    const dismain = await this.model('distribution_main').where({user_id:userInfo.id}).select()
    const cashdata = await this.model('distribution_cash').add({
      user_id:userInfo.id,
      user_name: userInfo.nickname,
      befor_catch: dismain[0].can_withdraw_cash,
      catch_money: Number(value),
      after_catch: Number(dismain[0].can_withdraw_cash) - Number(value),
      is_success: 0,
      add_time: new Date().getTime(),
    })
    const lastcash = await this.model('distribution_main').where({user_id:userInfo.id}).update({
      have_catch_num: Number(dismain[0].have_catch_num) + 1,
      can_withdraw_cash: Number(dismain[0].can_withdraw_cash) - Number(value),
      have_withdraw_cash: Number(dismain[0].have_withdraw_cash) + Number(value)
    })
    const user = await this.model('user').where({id:userInfo.id}).find()
    const dis_order = await this.model('distribution_cash_order').add({
      cash_id: cashdata,
      add_time: new Date().getTime(),
      mch_appid: think.config('weixin.appid'),
      mchid: think.config('weixin.mch_id'),
      partner_trade_no: 'LH' + new Date().getTime(),
      openid: user.weixin_openid,
      amount: parseInt(Number(value) * 100),
      desc: '佣金',
      check_name: 'NO_CHECK',
      cash_type: cashtype,
      card_code: selectbankcard.card_code,
      card_bank_name: selectbankcard.card_bank_name,
      card_bank_code: selectbankcard.card_bank_code,
      user_id: selectbankcard.user_id,
      user_nickname: selectbankcard.user_nickname,
      true_name: selectbankcard.user_true_name
    })
    return this.success({
      cashdata:cashdata,
      lastcash:lastcash,
      dis_order: dis_order
    })

  }
  async adddistributionpriceAction() {
    const sn = this.post('sn')
    const typec = this.post('typec')
    const nowuser = this.post('nowuser')
    const orderinfo = await this.model('order').where({order_sn:sn}).find()
    // console.log(orderinfo);
    // const userdis = await this.model('distribution_user').where({user_id:think.userId}).select()
    // console.log(pasteruser);
    // console.log(userdis);
    // console.log(userdis[0].farther_user_id);
    const userdis = await this.model('distribution_user').where({children_id:nowuser.id}).select()
    const maindis = await this.model('distribution_main').where({user_id:userdis[0].farther_user_id}).select()
    const goodsdis = await this.model('distribution_goods').where({order_id:orderinfo.id}).select()
    console.log(goodsdis);
    if (goodsdis.length >= 2) {
      return this.fail(444,'当前订单已被记录分销 ！')
    }else {
      console.log("增加分销金额",maindis,userdis,goodsdis,orderinfo);
      //记录分销商品
      const rate = await this.model('distribution_rate').select()
      let rateasp = (typec !== 0 && typec == 666) ? Number(rate[0].rate) : Number(rate[0].secondrate)
      console.log('*********************************分销返利率');
      console.log(rateasp);
      await this.model('distribution_goods').add({
        order_id:orderinfo.id,
        order_price:orderinfo.actual_price,
        children_id:userdis[0].children_id,
        children_name:userdis[0].children_name,
        add_time:new Date().getTime(),
        withdraw_cash: Number(0.00) + (Number(orderinfo.actual_price) * (rateasp / 100)),
        farther_user_id:userdis[0].farther_user_id,
        farther_user_name:userdis[0].farther_user_name,
        dis_type: (typec !== 0 && typec == 666) ? '一次分销' : '二次分销',
        dis_rate: rateasp
      })
      //设置分销员提成
      await this.model('distribution_main').where({user_id:userdis[0].farther_user_id}).update({
        children_have_deal_money:Number(maindis[0].children_have_deal_money) + Number(orderinfo.actual_price),
        have_deal_order_num:Number(maindis[0].have_deal_order_num) + 1,
        have_deal_order_id: maindis[0].have_deal_order_id + ',' + parseInt(orderinfo.id),
        can_withdraw_cash: Number(maindis[0].can_withdraw_cash) + (Number(orderinfo.actual_price) * (rateasp / 100))
      })
      return this.fail(555,'设置分销员提成成功 ！')
    }
  }
  async applydistributionAction() {
    const phone = this.post('phone')
    const userid = this.post('userid')
    const selectedcountry = this.post('selectedcountry')
    console.log(selectedcountry);
    const userinfo = await this.model('user').where({id:userid}).find()
    console.log(userinfo);
    const have = await this.model('distribution_apply').where({user_id:userinfo.id}).select()
    if (have.length == 0) {
      const data = await this.model('distribution_apply').add({
        user_mobile: phone,
        user_name: userinfo.nickname,
        user_id: userinfo.id,
        apply_time: new Date().getTime(),
        mobile_country: selectedcountry.country_name_chinese,
        mobile_country_code: selectedcountry.country_code,
        mobile_code: selectedcountry.phone_code,
        mobile_country_e: selectedcountry.country_name_english,
        status: 0,
      })
      return this.success(data)
    }else {
      const data = await this.model('distribution_apply').where({user_id:userinfo.id}).update({
        user_mobile: phone,
        user_name: userinfo.nickname,
        user_id: userinfo.id,
        apply_time: new Date().getTime(),
        mobile_country: selectedcountry.country_name_chinese,
        mobile_country_code: selectedcountry.country_code,
        mobile_code: selectedcountry.phone_code,
        mobile_country_e: selectedcountry.country_name_english,
        status: 0,
      })
      return this.success(data)
    }
  }
  async setinvitermasterAction() {
    const nowuser = this.post('nowuser')
    const pasteruser = this.post('pasteruser')
    console.log(nowuser,pasteruser);
    // if (parseInt(nowuser.id) === pasteruser[0] || pasteruser.length == 0) {
    if (pasteruser.length == 0) {

    }else {
      console.log(nowuser,pasteruser)
      const pastuserinfo = await this.model('user').where({id:pasteruser[0]}).select()
      const isfather = await this.model('distribution_user').where({children_id:nowuser.id}).select()
      if (pastuserinfo.length == 0 || isfather.length >= 1) {
        return this.fail(506,'父级用户不存在 ！')
      }else {
        //设置分销关系
        const data = await this.model('distribution_user').add({
          children_id:nowuser.id,
          children_name:nowuser.nickname,
          add_time:new Date().getTime(),
          farther_user_id:pastuserinfo[0].id,
          farther_user_name:pastuserinfo[0].nickname,
        })
        return this.fail(11,'设置分销信息成功 ！')
      }
    }


  }
  async setdistributionowndisAction() {
    const userId = this.post('userId')
    const sn = this.post('sn')
    // const
    console.log(userId);
    const isDis = await this.model('distribution_apply').where({user_id:userId,status:1}).select()
    if (isDis.length > 0) {
      // 为分销员
      const orderinfo = await this.model('order').where({order_sn:sn}).find()
      const userdis = await this.model('user').where({id:userId}).find()
      const goodsInfo = await this.model('order_goods').where({order_id:orderinfo.id}).select()
      const maindis = await this.model('distribution_main').where({user_id:userId}).find()
      const rate = await this.model('distribution_rate').select()
      let rateasp = Number(rate[0].ownrate)
      await this.model('distribution_goods').add({
        order_id:orderinfo.id,
        order_price:orderinfo.actual_price,
        children_id: userdis.id,
        children_name: userdis.nickname,
        add_time:new Date().getTime(),
        withdraw_cash: Number(0.00) + (Number(orderinfo.actual_price) * (rateasp / 100)),
        farther_user_id: userdis.id,
        farther_user_name: userdis.nickname,
        dis_type: '自身提成',
        dis_rate: rateasp
      })
      //设置分销员提成
      await this.model('distribution_main').where({user_id:userId}).update({
        children_have_deal_money:Number(maindis.children_have_deal_money) + Number(orderinfo.actual_price),
        have_deal_order_num:Number(maindis.have_deal_order_num) + 1,
        have_deal_order_id: maindis.have_deal_order_id + ',' + parseInt(orderinfo.id),
        can_withdraw_cash: Number(maindis.can_withdraw_cash) + (Number(orderinfo.actual_price) * (rateasp / 100))
      })
      return this.fail(999,'设置分销员自身提成成功 ！')
    }else {

    }
  }


};
