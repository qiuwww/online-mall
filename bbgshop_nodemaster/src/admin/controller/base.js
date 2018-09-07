// const schedule = require('node-schedule')

module.exports = class extends think.Controller {
  async __before() {
    // 根据token值获取用户id
    think.token = this.ctx.header['x-nideshop-token'] || '';
    const tokenSerivce = think.service('token', 'admin');
    think.userId = await tokenSerivce.getUserId();

    // 只允许登录操作
    if (this.ctx.controller !== 'auth') {
      if (think.userId <= 0) {
        return this.fail(401, '请先登录');
      }
    }
    // var date = new Date(2018, 6, 4, 15, 31, 0);
    //
    // var j = schedule.scheduleJob(date, function(){
    //  console.log('现在时间：',new Date());
    // });
    // var date = new Date(2017, 11, 16, 16, 43, 0);
    //
    // var j = schedule.scheduleJob(date, function(){
    //  console.log('现在时间：',new Date());
    // });
  }
};
