const Base = require('./base.js');

module.exports = class extends Base {
  async findkeywordsAction() {
    const data = await this.model('keywords').select();
    return this.success(data);
  }
  async updatekeywordsAction() {
    const info = this.post('info')
    if (think.isEmpty(info.id)) {
      const data = await this.model('keywords').add({
        keyword: info.keywords,
        is_hot: info.is_hot
      })
      return this.success(data)
    }else {
      const data = await this.model('keywords').where({id:info.id}).update({
        keyword: info.keywords,
        is_hot: info.is_hot
      })
      return this.success(data)
    }
  }
  async delkeywordsAction() {
    const id = this.post('id')
    const data = await this.model('keywords').where({id:id}).limit(1).delete()
    return this.success(data)
  }
}
