const Base = require('./base.js');

module.exports = class extends Base {
  async findnoviceguideinfoAction() {
    const data = await this.model('guide').where({type:1}).find()
    return this.success(data);
  }
  async setnoviceguideAction() {
    const info = this.post('info')
    if (think.isEmpty(info.id)) {
      const data = await this.model('guide').add({
        type: 1,
        rules_text: info.rules_value
      })
      return this.success(data)
    }else {
      const data = await this.model('guide').where({type:1}).update({
        rules_text: info.rules_value
      })
      return this.success(data)
    }
  }

  async findafterguideinfoAction() {
    const data = await this.model('guide').where({type:2}).find()
    return this.success(data);
  }
  async setafterguideAction() {
    const info = this.post('info')
    if (think.isEmpty(info.id)) {
      const data = await this.model('guide').add({
        type: 2,
        rules_text: info.rules_value
      })
      return this.success(data)
    }else {
      const data = await this.model('guide').where({type:2}).update({
        rules_text: info.rules_value
      })
      return this.success(data)
    }
  }
}
