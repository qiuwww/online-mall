module.exports = class extends think.Controller {
  async testAction() {
    // 如果不是定时任务调用，则拒绝
    // if(!this.isCli) return this.fail(1000, 'deny');
      const collsgelist = await this.model('collage_user').select()
        // console.log(collsgelist);
        ////////////////////////////定时清理砍价和拼团
        for (var i = 0; i < collsgelist.length; i++) {
          // console.log(i);
          // console.log(collsgelist[i].end_time);
          if ((collsgelist[i].end_time !== 0) && (collsgelist[i].end_time <= new Date().getTime()) ) {
            await this.model("collage_user").where({id:collsgelist[i].id}).update({
              is_outtime:1
            })
            await this.model("order").where({id:collsgelist[i].order_id}).update({
              collage_isouttime: 1
            })
          }
      }
      console.log("拼团过期时间已清理 ！");
      const bargainlist = await this.model('bargain_user').select()
        for (var j = 0; j < bargainlist.length; j++) {
          if ((bargainlist[j].end_time !== 0) && (bargainlist[j].end_time <= new Date().getTime()) ) {
            await this.model("bargain_user").where({id:bargainlist[j].id}).update({
              is_outtime:1
            })
        }
      }
      console.log("砍价过期时间已清理 ！");
      //清理未支付订单
      const orderlist = await this.model('order').where({
          add_time: {'>': new Date().getTime() - 7200000, '<': new Date().getTime() , _logic: 'AND'},is_del: 0,pay_time: 0
        }).select();
        // console.log(orderlist);
        for (var h = 0; h < orderlist.length; h++) {
          // console.log(h);
          if (orderlist[h].add_time < new Date().getTime() - 7200000) {
            await this.model('order').where({id:orderlist[h].id}).update({
              is_del: 2
            })
          }
      }
      console.log("未支付订单超时已清理 ！");
      const luckdrawlist = await this.model('luckdraw').where({abled:1,is_del:0,is_open:0}).select()
      for (var k = 0; k < luckdrawlist.length; k++) {
          if (parseInt(luckdrawlist[k].luck_limit_time) <= new Date().getTime() ) {
            console.log('已达到开奖截止时间 !');
            if (Number(luckdrawlist[k].luck_people_num) > Number(luckdrawlist[k].have_join_people_num)) {
              await this.model("luckdraw").where({id:luckdrawlist[k].id}).update({
                luck_limit_time: new Date().getTime() + 86000000,
                luck_open_time: new Date().getTime() + 172000000
              })
              console.log('未达到开奖人数___开奖失败___开奖截止时间与开奖时间都已延迟 !');
            }else {
              console.log('已达到开奖人数___开奖已截止__准备开奖 !');
              await this.model("luckdraw").where({id:luckdrawlist[k].id}).update({
                is_out_time:1 //抽奖已达到截止时间
              })
              if (parseInt(luckdrawlist[k].luck_open_time) <= new Date().getTime() ) {
                console.log('已达到开奖人数___已达到开奖时间___正在开奖 !');
                let looppeople = luckdrawlist[k].luck_goods_num
                let alljoinpeople = await this.model('luckdraw_user').where({luckdraw_main_id:luckdrawlist[k].id}).select()
                let aii = []
                for (var l = 0; l < parseInt(looppeople); l++) {
                  let obj = Math.floor(Math.random() * alljoinpeople.length )
                  aii.push(obj)
                }
                let point_user_id_list = []
                for (var m = 0; m < aii.length; m++) {
                  let point_user = alljoinpeople[aii[m]]
                  point_user_id_list.push(point_user.join_user_id)
                }
                let aiistr = point_user_id_list.join(',')
                console.log(aiistr);
                await this.model("luckdraw").where({id:luckdrawlist[k].id}).update({
                  is_open:1,
                  luck_draw_user_id: aiistr
                })
                console.log('已达到开奖人数___已达到开奖时间___开奖成功 !');
                if (point_user_id_list.length == 0) {
                  console.log('异常 ! ! 没有产生中奖者 !');
                }else {
                  console.log('中奖者已产生 !');
                  console.log(point_user_id_list);
                }
              }else {
                console.log('已达到开奖人数___未达到开奖时间 !');
              }
            }
          }else {
            console.log("未达到开奖截止时间 ！");
          }
        }
      //以下为每日凌晨两点半更新会员状态
      //判断今日零点
      console.log("开始判断是否为每日凌晨两点半 ...");
      var date = new Date();
      var Y = date.getFullYear() + '-';
      var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
      var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate());
      const past_time = Y+M+D+' 00:00:000'
      const past_localtime = new Date(past_time).getTime()
      let halfpasttwo = past_localtime + 9000000
      let updateTime = [halfpasttwo - 280000,halfpasttwo + 280000]
      if (new Date().getTime() > updateTime[0] && new Date().getTime() < updateTime[1]) {
        console.log('每日凌晨两点半更新（误差270秒，4分30秒，至少更新一次）');
        const rules = await this.model('user_level_rules').select()
        let rules_type = rules[0].type
        // console.log(rules_type);
        if (rules_type == 0) { //会员只开启金额充值
            console.log('金额充值');
            const all_user_list = await this.model('user').where({user_level_is_fockers: 0}).field(['id','user_recharge_monery']).select()
            const level_list = await this.model('user_level').field(['recharge_monery','discount_scale']).order(['recharge_monery ASC']).select()
            for (var i = 0; i < all_user_list.length; i++) {
              let point_index = []
              for (var j = 0; j < level_list.length; j++) {
                if (all_user_list[i].user_recharge_monery > level_list[j].recharge_monery) {
                  point_index.push(j)
                }
              }
              if (point_index.length == 0) {
                await this.model('user').where({id:all_user_list[i].id}).update({
                  user_level: 0,
                  user_discount: 1,
                  user_level_name: '普通用户',
                })
              }else {
                let index = point_index[point_index.length - 1]
                await this.model('user').where({id:all_user_list[i].id}).update({
                  user_level: index + 1,
                  user_discount: level_list[index].discount_scale,
                  user_level_name: level_list[index].name,
                })
              }
            }
          }else if (rules_type == 1) { //会员只开启累计消费
            console.log('累计消费');
            const all_user_list = await this.model('user').where({user_level_is_fockers: 0}).field(['id','user_all_price']).select()
            const level_list = await this.model('user_level').field(['consumption_monery','discount_scale']).order(['consumption_monery ASC']).select()
            for (var i = 0; i < all_user_list.length; i++) {
              let point_index = []
              for (var j = 0; j < level_list.length; j++) {
                if (all_user_list[i].user_all_price > level_list[j].consumption_monery) {
                  point_index.push(j)
                }
              }
              if (point_index.length == 0) {
                await this.model('user').where({id:all_user_list[i].id}).update({
                  user_level: 0,
                  user_discount: 1,
                  user_level_name: '普通用户',
                })
              }else {
                let index = point_index[point_index.length - 1]
                await this.model('user').where({id:all_user_list[i].id}).update({
                  user_level: index + 1,
                  user_discount: level_list[index].discount_scale,
                  user_level_name: level_list[index].name,
                })
              }
            }
          }else if (rules_type == 2) { //同时开启金额充值和累计消费
            console.log('同时开启金额充值和累计消费,满足其一条件');
            const all_user_list = await this.model('user').where({user_level_is_fockers: 0}).field(['id','user_recharge_monery','user_all_price']).select()
            const level_list = await this.model('user_level').field(['consumption_monery','recharge_monery','discount_scale','name']).order(['recharge_monery ASC']).select()
            for (var i = 0; i < all_user_list.length; i++) {
              let point_index = []
              for (var j = 0; j < level_list.length; j++) {
                if ((all_user_list[i].user_recharge_monery > level_list[j].recharge_monery) || (all_user_list[i].user_all_price > level_list[j].consumption_monery)) {
                  point_index.push(j)
                }
              }
              if (point_index.length == 0) {
                await this.model('user').where({id:all_user_list[i].id}).update({
                  user_level: 0,
                  user_discount: 1,
                  user_level_name: '普通用户',
                })
              }else {
                let index = point_index[point_index.length - 1]
                await this.model('user').where({id:all_user_list[i].id}).update({
                  user_level: index + 1,
                  user_discount: level_list[index].discount_scale,
                  user_level_name: level_list[index].name,
                })
              }
            }
          }
      }else {
        console.log("不处于每日凌晨两点半 ...");
      }
      console.log('定时任务__5分钟一次');
    }
    async TimingUpdateAction() {
      console.log('************-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**');
    }

  // async contactAction() {
  //   console.log('contact');
  // }
}
