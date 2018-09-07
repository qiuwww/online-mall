const Base = require('./base.js');

module.exports = class extends Base {
  async ruleslistAction() {
    const page = this.post('page') || 1;
    const size = this.post('size') || 10;
    const name = this.post('name') || '';
    const data = await this.model('cart_rules').where({rules_name: ['like', `%${name}%`]}).order(['id DESC']).page(page, size).countSelect();
    return this.success(data);
  }
  async updaterulesAction() {
    const id = this.post('id')
    const rules = this.post('rules')
    console.log(id,rules);
    if (parseInt(id) == 0) {
      await this.model('cart_rules').add({
        rules_name: rules.rules_name,
        is_abled: 0,
        rules_limit_price: rules.limit_price,
        rules_type: rules.type_model,
        rules_discount_price: rules.discount_price,
        rules_minus_price: rules.minus_price,
        rules_limit: rules.limit_model,
        rules_suit: rules.suit_model,
        rules_suit_catelog: rules.suit_catelog,
        create_time: new Date().getTime(),
      })
      return this.fail(1,'金额结算规则添加成功 ！')
    }else {
      await this.model('cart_rules').where({id:id}).update({
        rules_name: rules.rules_name,
        rules_limit_price: rules.limit_price,
        rules_type: rules.type_model,
        rules_discount_price: rules.discount_price,
        rules_minus_price: rules.minus_price,
        rules_limit: rules.limit_model,
        rules_suit: rules.suit_model,
        rules_suit_catelog: rules.suit_catelog,
        handel_time: new Date().getTime(),
      })
      return this.fail(2,'金额结算规则更新成功 ！')

    }
  }
  async delrulesAction() {
    const id = this.post("id")
    const data = await this.model('cart_rules').where({id:id}).delete()
    return this.success(data)
  }
  async rulesisableAction() {
    const id = this.post('id')
    const info = this.post('data')
    const list = await this.model('cart_rules').where({rules_suit:0}).select()
    if (parseInt(info) == 1) {
      console.log('*******************************=1');
      for (var i = 0; i < list.length; i++) {
        if (list[i].id == id) {
          console.log(id);
          await this.model('cart_rules').where({id:list[i].id}).update({is_abled: 1})
        }else {
          await this.model('cart_rules').where({id:list[i].id}).update({is_abled: 0})
        }
      }
      return this.fail(0)
    }else {
      console.log('*******************************=0');
      const data = await this.model('cart_rules').where({id:id}).update({is_abled: 0})
      return this.success(data);
    }
  }
  async findrulesinfoByIdAction() {
    const id = this.post('id')
    const data = await this.model('cart_rules').where({id:id}).find()
    return this.success(data);
  }
}
