const Base = require('./base.js');

module.exports = class extends Base {
  async findallsupplierlistnocurrectAction() {
    const data = await this.model('supplier').select();
    return this.success(data)
  }
  //查找所有供货商
  async findallsupplierlistAction() {
    const name = this.post('name') || '';
    const page = this.post('page') || 1;
    const size = this.post('size') || 10;
    const data = await this.model('supplier').where({name: ['like', `%${name}%`]}).order(['id DESC']).page(page, size).countSelect();
    // const data = await this.model('supplier').select()
    return this.success(data)
  }
  async addsupplieractionAction() {
    const name = this.post('name');
    const id = this.post('id');
    if (parseInt(id) == 0) {
      const have = await this.model('supplier').where({name:name}).select()
      if (have.length > 0) {
        return this.fail(17,'已存在此供货商 !')
      }else {
        const data = await this.model('supplier').add({
          name:name,
          create_time: new Date().getTime(),
          handel_time: new Date().getTime(),
        })
        return this.success(data)
      }
    }else {
      const data = await this.model('supplier').where({id:id}).update({
        name:name,
        handel_time: new Date().getTime(),
      })
      return this.success(data)
    }
  }
  async delsupplierAction() {
    const id = this.post('id');
    const data = await this.model('supplier').where({id: id}).limit(1).delete();
    // TODO 删除图片

    return this.success(data);
  }
};
