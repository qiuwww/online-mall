const Base = require('./base.js');

module.exports = class extends Base {
  //设置用户等级固定与否
  async setisfockersAction() {
    const id = this.post('id')
    const status = this.post('data')
    console.log(id,status);
    const data = await this.model('user').where({id:id}).update({
      user_level_is_fockers:status
    })
    return this.success(data)

  }
  //设置用户的固定等级
  async setPointLevelAction() {
    const dis = this.post('dis')
    const level = this.post('level')
    const userid = this.post('userid')
    const levelname = this.post('levelname')
    // console.log(dis,userid);
    console.log(levelname);
    const data = await this.model('user').where({id:userid}).update({
      user_level_is_fockers: 1,
      user_level: level + 1,
      user_discount: dis,
      user_level_name: levelname
    })
    return this.success(data)
  }
  //设置等级类型
  async setlevelrulesAction() {
    const e = this.post('e')
    const data = await this.model('user_level_rules').where({id:1}).update({
      type: e
    })
    return this.success(data)
  }
  //添加等级信息
  async adduserlevelAction() {
    const info = this.post('info')
    console.log(info);
    if (info.id) {
      const data = await this.model('user_level').where({id:info.id}).update({
        name: info.name,
        recharge_monery: info.recharge_monery,
        consumption_monery: info.consumption_monery,
        discount_scale: info.discount_scale,
      })
      return this.success(data)
    }else {
      const data = await this.model('user_level').add({
        name: info.name,
        recharge_monery: info.recharge_monery,
        consumption_monery: info.consumption_monery,
        discount_scale: info.discount_scale,
      })
      return this.success(data)
    }
  }
  //删除等级信息
  async dellevelinfoAction() {
    const id = this.post('id')
    const data = await this.model('user_level').where({id:id}).limit(1).delete()
    return this.success(data)
  }
  //获取等级信息
  async getuserlevelAction() {
    const rules = await this.model('user_level_rules').select()
    if (rules[0].type == 0) {
      const data = await this.model('user_level').order(['recharge_monery ASC']).select()
      return this.success({
        data:data,
        rules:rules
      })
    }else if (rules[0].type == 1 || rules[0].type == 2) {
      const data = await this.model('user_level').order(['consumption_monery ASC']).select()
      return this.success({
        data:data,
        rules:rules
      })
    }

  }
  /**
   * index action
   * @return {Promise} []
   */
  async indexAction() {
    const page = this.get('page') || 1;
    const size = this.get('size') || 10;
    const name = this.get('name') || '';

    const model = this.model('user');
    const data = await model.where({username: ['like', `%${name}%`]}).order(['id DESC']).page(page, size).countSelect();
    const rules = await this.model('user_level_rules').select()

    return this.success(data,rules);
  }

  async infoAction() {
    const id = this.get('id');
    const model = this.model('user');
    const data = await model.where({id: id}).find();

    return this.success(data);
  }

  async feedbackAction() {
    const page = this.get('page') || 1;
    const size = this.get('size') || 10;
    const name = this.get('name') || '';

    const model = this.model('feedback');
    const data = await model.where({msg_content: ['like', `%${name}%`]}).order(['id DESC']).page(page, size).countSelect();

    return this.success(data);
  }
  async delfeedbackAction() {
    const id = this.post('id');
    await this.model('feedback').where({id: id}).limit(1).delete();
    // TODO 删除图片

    return this.success();
  }


  async storeAction() {
    if (!this.isPost) {
      return false;
    }

    const values = this.post();
    const id = this.post('id');

    const model = this.model('user');
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
    await this.model('user').where({id: id}).limit(1).delete();
    // TODO 删除图片

    return this.success();
  }
};
