// const schedule = require('node-schedule')
// 似乎就是一个中间件，过滤请求
module.exports = class extends think.Controller {
  // 前置操作 __before
  // 项目中，有时候需要在一个统一的地方做一些操作，如：判断是否已经登录，如果没有登录就不能继续后面行为。此种情况下，可以通过内置的 __before 来实现。
  async __before() {
    // 根据token值获取用户id
    // console.log("base think", think); // 类似vue全局变量了
    think.token = this.ctx.header['x-nideshop-token'] || '';
    const tokenSerivce = think.service('token', 'admin');
    think.userId = await tokenSerivce.getUserId();

    // 只允许登录操作
    if (this.ctx.controller !== 'auth') {
      if (think.userId <= 0) {
        return this.fail(401, '请先登录');
      }
    }
    // 这里 return false，那么 xxxAction 和 __after 不再执行
    // 
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
  async __after() {
    // indexAction 执行完成后执行，如果 indexAction 返回了 false 则不再执行
  }
  async __call() {
    // 这里可以对不存在的方法进行统一处理。
    // 如果相应的Action不存在则调用该方法
  }
};
