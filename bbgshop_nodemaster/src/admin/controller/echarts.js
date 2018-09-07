const Base = require('./base.js');

module.exports = class extends Base {
  async getechartsinfoAction(){
    const now = new Date().toLocaleString()
    let day_time = now.split(' ')
    let day = day_time[0].split('-')
    day[1] = day[1] < 10 ? '0' + day[1] : day[1]
    day[2] = day[2] < 10 ? '0' + day[2] : day[2]
    let today_pase = day[0] + '-' + day[1] + '-' + day[2] + ' 00:00:00:000'
    let today_pase_local = new Date(today_pase).getTime()
    let today_limit_stamp = []
    today_limit_stamp[0] = Number(today_pase_local)
    today_limit_stamp[1] = Number(today_pase_local) + 86400000
    console.log(today_limit_stamp);
    console.log("9999999999999999999999999999");
    const order_all = await this.model('order').where({is_del: 0}).field(['add_time','order_status']).select();
    console.log(order_all);
    let order_all_today = []
    let order_all_weekday = {}
    let Monday = []
    let Tuesday = []
    let Wednesday = []
    let Thursday = []
    let Friday = []
    let Saturday = []
    let Sunday = []
    let obj = {}
    let timeStampmin = new Date().getTime()
    // const timeStampmin = await this.model('order').field('add_time').min()
    for (var i = 0; i < order_all.length; i++) {
      // 今天的订单
      if (order_all[i].add_time > today_limit_stamp[0] && order_all[i].add_time < today_limit_stamp[1]) {
        order_all_today.push(order_all[i]) }
      //历史一周订单对比
      let week = new Date(parseInt(order_all[i].add_time)).getDay()
      if (week == 1) { Monday.push(order_all[i]) }
      else if (week == 2) { Tuesday.push(order_all[i]) }
      else if (week == 3) { Wednesday.push(order_all[i]) }
      else if (week == 4) { Thursday.push(order_all[i]) }
      else if (week == 5) { Friday.push(order_all[i]) }
      else if (week == 6) { Saturday.push(order_all[i]) }
      else if (week == 0) { Sunday.push(order_all[i]) }
      obj.Monday = Monday
      obj.Tuesday = Tuesday
      obj.Wednesday = Wednesday
      obj.Thursday = Thursday
      obj.Friday = Friday
      obj.Saturday = Saturday
      obj.Sunday = Sunday
      // 历史所有订单按每一天
      if (order_all[i].add_time < timeStampmin ) {
        timeStampmin = order_all[i].add_time
      }
    }
    console.log(timeStampmin);
    var date = new Date(timeStampmin * 1);
    var Y = date.getFullYear() + '-';
    var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
    var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate());
    const past_time = Y+M+D+' 00:00:000'
    const past_localtime = new Date(past_time).getTime()
    console.log(past_time);
    console.log('第一笔订单的起始日期的0点' + past_localtime);
    console.log('明天的起始0点' + today_limit_stamp[1]);
    let differ = Number(today_limit_stamp[1]) - Number(past_localtime)
    console.log('相差天数的时间戳'+ differ);
    let differ_local = differ/86400000
    console.log('相差天数' + differ_local);
    let past_localtime_chage_start = past_localtime
    let past_localtime_chage_list = []
    let final_past_time = []
    for (var r = 0; r < differ_local; r++) {
      let final_past_localtime = []
      past_localtime_chage_list[0] = Number(past_localtime_chage_start)
      past_localtime_chage_list[1] = Number(past_localtime_chage_start) + 86400000
      var date = new Date(past_localtime_chage_list[0] * 1);
      var Y = date.getFullYear() + '/';
      var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '/';
      var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate());
      final_past_localtime[0] = Y + M + D
      const matching_order = await this.model('order').where({
        add_time: {'>': past_localtime_chage_list[0], '<':  past_localtime_chage_list[1], _logic: 'AND'},is_del: 0
      }).field(['add_time','order_status']).select();
      console.log(r);
      final_past_localtime[1] = matching_order
      past_localtime_chage_start = Number(past_localtime_chage_start) + 86400000
      final_past_time.push(final_past_localtime)
    }
    console.log(final_past_time);
    order_all_weekday = obj
    return this.success({
      order_all_today:order_all_today,
      order_all_weekday:order_all_weekday,
      final_past_time:final_past_time
    })
  }
  async getechartspriceAction() {
    const now = new Date().toLocaleString()
    let day_time = now.split(' ')
    let day = day_time[0].split('-')
    day[1] = day[1] < 10 ? '0' + day[1] : day[1]
    day[2] = day[2] < 10 ? '0' + day[2] : day[2]
    let today_pase = day[0] + '-' + day[1] + '-' + day[2] + ' 00:00:00:000'
    let today_pase_local = new Date(today_pase).getTime()
    let today_limit_stamp = []
    let yesterday_limit_stamp = []
    today_limit_stamp[0] = Number(today_pase_local)
    today_limit_stamp[1] = Number(today_pase_local) + 86400000
    yesterday_limit_stamp[0] = Number(today_pase_local) - 86400000
    yesterday_limit_stamp[1] = Number(today_pase_local)
    const order_all = await this.model('order').where({is_del: 0}).field(['add_time','order_status','actual_price','refund_is_success']).select();
    // console.log(order_all);
    let order_all_today = []
    let order_all_yesterday = []
    for (var i = 0; i < order_all.length; i++) {
      // 今天的订单
      if (order_all[i].add_time > today_limit_stamp[0] && order_all[i].add_time < today_limit_stamp[1]) {
        order_all_today.push(order_all[i])
      }
      if (order_all[i].add_time > yesterday_limit_stamp[0] && order_all[i].add_time < yesterday_limit_stamp[1]) {
        order_all_yesterday.push(order_all[i])
      }
    }

    return this.success({
      order_all_today:order_all_today,
      order_all_yesterday:order_all_yesterday
    })
  }

};
