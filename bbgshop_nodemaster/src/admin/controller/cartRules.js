const Base = require('./base.js');
// 这个人fail与success区分没有明确的界限
module.exports = class extends Base {
  // 查找list，并返回
  async ruleslistAction() {
    const page = this.post('page') || 1;
    const size = this.post('size') || 10;
    const name = this.post('name') || '';
    const data = await this.model('cart_rules').where({rules_name: ['like', `%${name}%`]}).order(['id DESC']).page(page, size).countSelect();
    return this.success(data);
  }
  // 新增和更新
  async updaterulesAction() {
    const id = this.post('id');
    const rules = this.post('rules');
    console.log(id, rules);
    if (parseInt(id) == 0) {
      await this.model('cart_rules').add({
        rules_name: rules.rules_name,
        rules_desc: rules.rules_desc,
        is_abled: 0,
        rules_limit_price: rules.limit_price,
        rules_type: rules.type_model,
        rules_discount_price: rules.discount_price,
        rules_minus_price: rules.minus_price,
        rules_limit: rules.limit_model,
        rules_suit: rules.suit_model,
        rules_suit_catelog: rules.suit_catelog,
        create_time: new Date().getTime()
      });
      return this.fail(1, '金额结算规则添加成功 ！');
    } else {
      await this.model('cart_rules').where({id: id}).update({
        rules_name: rules.rules_name,
        rules_desc: rules.rules_desc,
        rules_limit_price: rules.limit_price,
        rules_type: rules.type_model,
        rules_discount_price: rules.discount_price,
        rules_minus_price: rules.minus_price,
        rules_limit: rules.limit_model,
        rules_suit: rules.suit_model,
        rules_suit_catelog: rules.suit_catelog,
        handel_time: new Date().getTime()
      });
      return this.fail(2, '金额结算规则更新成功 ！');
    }
  }
  async delrulesAction() {
    const id = this.post('id');
    const data = await this.model('cart_rules').where({id: id}).delete();
    return this.success(data);
  }
  // 修改店铺管理下边/金额结算规则/是否启用操作
  async rulesisableAction() {
    // 获取post的data中的参数
    // id，用于查找
    const id = this.post('id');
    // info用于表示状态，其实这里用一个反转就可以了
    const info = this.post('data');
    // 在cart_rules表中查询 rules_suit 字段等于 0 的所有行
    const list = await this.model('cart_rules').where({rules_suit: 0}).select();
    // 根据是否启用来进行判断
    // 开启或者关闭， 这里是有个互斥的操作
    if (parseInt(info) === 1) {
      console.log('*******************************=1');
      // 这里使用each，或者some更符合
      for (var i = 0; i < list.length; i++) {
        // 这里的逻辑有点问题， 不过一般也能够用
        // 单个操作，不存在的时候就略过啊
        if (list[i].id == id) {
          console.log(id);
          // modal对应到表
          // 找到这个行，更新is_abled字段的状态为1, 并把其他的置为0
          await this.model('cart_rules').where({id: list[i].id}).update({is_abled: 1});
        } else {
          await this.model('cart_rules').where({id: list[i].id}).update({is_abled: 0});
        }
      }
      // 失败的返回
      console.log("失败的返回，这里的fail操作，不是很懂啊");
      // 综合我的想法，这里应该是success
      return this.fail(0, '这里是fail的结果');
    } else {
      console.log('*******************************=0');
      const data = await this.model('cart_rules').where({id: id}).update({is_abled: 0});
      return this.success(data);
    }
  }
  // 单纯的查找
  async findrulesinfoByIdAction() {
    const id = this.post('id');
    const data = await this.model('cart_rules').where({id: id}).find();
    return this.success(data);
  }
};
