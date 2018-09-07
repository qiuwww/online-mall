const Base = require('./base.js');

module.exports = class extends Base {
  async getnoviceguideAction() {
    const data = await this.model('guide').where({type:1}).select()
    return this.success(data)
  }
  async getafterguideAction() {
    const data = await this.model('guide').where({type:2}).select()
    return this.success(data)
  }
}
