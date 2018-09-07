const Base = require('./base.js');

module.exports = class extends Base {
  async getdisconfigAction() {
    const data = await this.model('distribution_rate').select()
    return this.success(data);
  }
  async updateconfigAction() {
    const info = this.post('info')
    console.log(info);
    const data = await this.model('distribution_rate').where({id:1}).update({
      rate: info.localrate,
      secondrate: info.localsecondrate,
      ownrate: info.localownrate,
      price: info.localprice,
      rules_text: info.rules_value,
    })
    return this.success(data)
  }
  async indexAction() {
    const page = this.get('page') || 1;
    const size = this.get('size') || 5;
    const username = this.get('username') || '';
    // const consignee = this.get('consignee') || '';
    const model = this.model('distribution_main');
    const data = await model.where({
      user_name: ['like', `%${username}%`]
    }).order(['id DESC']).page(page, size).countSelect();
    for (var i = 0; i < data.data.length; i++) {
      // console.log(data.data[i]);
      const father = await this.model('distribution_user').where({children_id:data.data[i].user_id}).select()
      data.data[i].father = father
    }
    const rate = await this.model('distribution_rate').select()

    return this.success({
      data:data,
      rate:rate
    });
  }
  async cashpageAction() {
    const page = this.get('page') || 1;
    const size = this.get('size') || 5;
    const username = this.get('username') || '';
    const success_state = this.get('success_state') || '';
    const model = this.model('distribution_cash');
    const data = await model.where({
      user_name: ['like', `%${username}%`],
      is_success: ['like', `%${success_state}%`]
    }).order(['id DESC']).page(page, size).countSelect();
    for (var i = 0; i < data.data.length; i++) {
      // console.log(data.data[i]);
      const maininfo = await this.model('distribution_main').where({
        user_id:data.data[i].user_id}).select()
      const cashorder = await this.model('distribution_cash_order').where({
        cash_id:data.data[i].id}).find()
      data.data[i].maininfo = maininfo
      data.data[i].cash_order = cashorder
    }
    const rate = await this.model('distribution_rate').select()

    return this.success({
      data:data,
      rate:rate
    });
  }
  async canelcashAction(){
    const info = this.post('info');
    const state = this.post('state');
    console.log(info);
    let user_id = info.user_id
    const dismain = await this.model('distribution_main').where({user_id:user_id}).select()
    const discash = await this.model('distribution_cash').where({user_id:user_id,id:info.id}).find()
    await this.model('distribution_cash').where({id:info.id}).update({
      is_success:state,
      handel_time:new Date().getTime(),
    })
    const data = await this.model('distribution_main').where({user_id:user_id}).update({
      can_withdraw_cash: Number(dismain[0].can_withdraw_cash) + Number(info.catch_money),
      have_withdraw_cash: Number(dismain[0].have_withdraw_cash) - Number(info.catch_money),
      have_catch_num: Number(dismain[0].have_catch_num) - 1
    })
    return this.success(data)
  }
  async setcash_orderstateAction() {
    const state = this.post('state')
    const id = this.post('id')
    const data = await this.model('distribution_cash').where({id:id}).update({
      is_success: state,
      handel_time:new Date().getTime(),
    })
    return this.success(data)
  }
  async surecashAction() {
    const info = this.post('info')
    console.log("8797897987");
    // const data = await this.model('distribution_cash').where({id:info.id}).update({
    //   is_success:1,
    //   handel_time:new Date().getTime(),
    // })


    return this.success(data)
  }
  async setcash_orderstate_successAction() {
    const state = this.post('state')
    const id = this.post('id')
    const dataa = this.post('data')
    console.log(state,id);
    const data = await this.model('distribution_cash').where({id:id}).update({
      pay_success_time: dataa.pay_succ_time,
      is_success: state,
      handel_time:new Date().getTime(),
    })
    return this.success(data)
  }
  async surecashAction() {
    const info = this.post('info')
    console.log("8797897987");
    // const data = await this.model('distribution_cash').where({id:info.id}).update({
    //   is_success:1,
    //   handel_time:new Date().getTime(),
    // })


    return this.success(data)
  }
  async detailpageAction() {
    const page = this.get('page') || 1;
    const size = this.get('size') || 5;
    const children_name = this.get('children_name') || '';
    const father_name = this.get('father_name') || '';
    // const consignee = this.get('consignee') || '';
    const model = this.model('distribution_goods');
    const data = await model.where({
      children_name: ['like', `%${children_name}%`],
      farther_user_name: ['like', `%${father_name}%`]
    }).order(['id DESC']).page(page, size).countSelect();
    for (var i = 0; i < data.data.length; i++) {
      // console.log(data.data[i]);
      const father = await this.model('distribution_user').where({farther_user_id:data.data[i].children_id}).select()
      data.data[i].father = father
      const maindis = await this.model('distribution_main').where({user_id:data.data[i].children_id}).select()
      data.data[i].maindis = maindis
      const ordergoods = await this.model('order_goods').where({order_id:data.data[i].order_id}).select()
      data.data[i].ordergoods = ordergoods
    }
    // const rate = await this.model('distribution_rate').select()

    return this.success({
      data:data
    });
  }
  async applyAction(){
    const page = this.get('page') || 1;
    const size = this.get('size') || 5;
    const username = this.get('username') || '';
    const model = this.model('distribution_apply');
    const data = await model.where({
      user_name: ['like', `%${username}%`]
    }).order(['id DESC']).page(page, size).countSelect();
    const rate = await this.model('distribution_rate').select()
    return this.success({
      data:data,
      rate:rate
    });
  }
  async sureapplyAction(){
    const info = this.post('info');
    await this.model('distribution_apply').where({id:info.id}).update({
      status:1,
      handel_time:new Date().getTime(),
    })
    const userinfo = await this.model('user').where({id:info.user_id}).find()
    console.log(userinfo);
    const have = await this.model('distribution_main').where({user_id:userinfo.id}).select()
    if (have.length == 0) {
      const data = await this.model('distribution_main').add({
        user_mobile: info.user_mobile,
        user_name: userinfo.nickname,
        user_id: userinfo.id,
        add_time: new Date().getTime(),
        own_have_deal_money: 0.00,
        children_have_deal_money: 0.00,
        can_withdraw_cash: 0.00,
        have_deal_order_num: 0,
        secret_code: Math.random().toString(36).substr(2),
      })
      return this.success(data)
    }else {
      console.log(have);
    }
  }
  async canelapplyAction(){
    const info = this.post('info');
    const data = await this.model('distribution_apply').where({id:info.id}).update({
      status:2,
      handel_time:new Date().getTime(),
    })
    return this.success(data)
  }
  async setdistributionrateAction() {
    const rate = this.post('rate')
    const price = this.post('price')
    const data = await this.model('distribution_rate').where({id:1}).update({
      rate:rate,
      price:price
    })
    return this.success(data)
  }
};
