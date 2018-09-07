const Base = require('./base.js');
const VaptchaSdk = require('vaptcha-sdk');

module.exports = class extends Base {
  async getVaptchaAction(){
    const vaptcha = new VaptchaSdk(think.config('vaptcha.vid'),think.config('vaptcha.key'));
    let data = ''
    await vaptcha.getChallenge().then((res) => {
      console.log(res)
      data = res
    })
    return this.success(data)
  }
  async checkpwdAction() {
    const info = this.post('info')
    console.log(info);
    const beforinfo = await this.model('admin').where({id:1}).find()
    if (info.befor_code == beforinfo.password_salt) {
      if (think.md5(info.befor_pwd + '' + beforinfo.password_salt) !== beforinfo.password) {
        return this.fail(18,'密码匹配错误 ！')
      }else{
        return this.success(beforinfo)
      }
    }else {
      return this.fail(17,'特征码匹配错误 ！')
    }
  }
  async changepwdAction() {
    const info = this.post('info')
    // console.log(info);
    const beforinfo = await this.model('admin').where({id:1}).find()
    let pwd = think.md5(info.after_pwd + '' + info.after_code)
    const data = await this.model('admin').where({id:1}).update({
      password_salt: info.after_code,
      password: pwd,
      change_pwd_time: parseInt(beforinfo.change_pwd_time) + 1
    })
    return this.success(data)
  }
  async loginAction() {
    const username = this.post('username');
    const password = this.post('password');
    const admin = await this.model('admin').where({ username: username }).find();
    if (think.isEmpty(admin)) {
      return this.fail(401, '用户名或密码不正确 ！');
    }
    if (think.md5(password + '' + admin.password_salt) !== admin.password) {
      return this.fail(400, '用户名或密码不正确 ！');
    }
    // 更新登录信息
    await this.model('admin').where({ id: admin.id }).update({
      last_login_time: parseInt(Date.now() / 1000),
      last_login_ip: this.ctx.ip
    });
    const TokenSerivce = this.service('token', 'admin');
    const sessionKey = await TokenSerivce.create({
      user_id: admin.id
    });

    if (think.isEmpty(sessionKey)) {
      return this.fail('登录失败');
    }

    const userInfo = {
      id: admin.id,
      username: admin.username,
      avatar: admin.avatar,
      admin_role_id: admin.admin_role_id
    };

    return this.success({ token: sessionKey, userInfo: userInfo });
  }
};
