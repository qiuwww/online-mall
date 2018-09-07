// const Base = require('./base.js');

module.exports = class extends think.Controller {
  async exchangeAction() {
    const feedtype = this.post("feedtype");
    const content = this.post("content");
    const phone = this.post("phone");
    let newdata = new Date().toLocaleString();

    const id = think.userId;
    if (typeof(id) == 'undefined') {
      console.log("74465498745649878");
      const Resule = await this.model('feedback').add({
        user_id: 0,
        user_name: '匿名用户',
        msg_type:feedtype,
        msg_content:content,
        user_mobile:phone,
        msg_time:newdata,
      })
      return this.success({
        Resule:Resule
      });
    }else {
      const name = await this.model('user').where({id:think.userId}).find()
      const Resule = await this.model('feedback').add({
        user_id:think.userId,
        user_name:name.nickname,
        msg_type:feedtype,
        msg_content:content,
        user_mobile:phone,
        msg_time:newdata,
      })
      return this.success({
        Resule:Resule
      });
    }
    // console.log(name);

  }
};
