const Base = require('./base.js');

module.exports = class extends Base {
  async addbingbankcardAction() {
    const user = this.post('userInfo')
    const bankcode = this.post('bankcode')
    const name = this.post('name')
    const bankname = this.post('bankname')
    const have = await this.model('bank_card').where({
      card_code: bankcode
    }).select()
    console.log(bankcode,name,bankname);
    //空map设值key-value
    var m = new Map();
    m.set("工商银行",1002);
    m.set("农业银行",1005);
    m.set("中国银行",1026);
    m.set("建设银行",1003);
    m.set("招商银行",1001);
    m.set("邮储银行",1066);
    m.set("交通银行",1020);
    m.set("浦发银行",1004);
    m.set("民生银行",1006);
    m.set("兴业银行",1009);
    m.set("平安银行",1010);
    m.set("中信银行",1021);
    m.set("华夏银行",1025);
    m.set("广发银行",1027);
    m.set("光大银行",1022);
    m.set("北京银行",1032);
    m.set("宁波银行",1056);
    const banck_local_code = m.get(bankname);
    console.log(banck_local_code);
    // console.log(have);
    if (have.length >= 1) {
      return this.fail(17,'已存在此银行卡 ！')
    }else {
      const data = await this.model('bank_card').add({
        card_code: bankcode,
        user_id:user.id,
        user_nickname: user.nickname,
        user_true_name: name,
        card_bank_name: bankname,
        card_bank_code: banck_local_code,
      })
      return this.success(data)
    }
  }
  async findbankcardAction() {
    const data = await this.model('bank_card').where({user_id:think.userId}).select()
    return this.success(data)
  }
  async delbankcardAction() {
    const id = this.post('id')
    const data = await this.model('bank_card').where({id:id}).delete()
    return this.success(data)
  }
};
