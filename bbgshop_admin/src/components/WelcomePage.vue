<template>
<div class="content-page">
  <div class="content-nav">
    <el-breadcrumb class="breadcrumb" separator="/">
      <el-breadcrumb-item :to="{ path: '/dashboard' }">后台主页</el-breadcrumb-item>
    </el-breadcrumb>
    <div class="operation-nav">
        <el-button type="primary" size="small" @click="Refresh">{{looptime}}  刷新</el-button>
    </div>
  </div>
  <div class="content-main">
    <el-row class="content_elrow">
      <el-col :span="12" class="content_elcolorder" style="border-right:1px solid #ddd">
        <el-row class="elrow_elrow">
          <el-col :span="8" class="elcol_elcol border_right" @click.native='toallorder(201)'>
            <div class="total_price">{{today_order_pend_out}}</div>
            <div class="total_price_text">待发货</div>
          </el-col>
          <el-col :span="8" class="elcol_elcol border_right" @click.native='toallorder(400)'>
            <div class="total_price">{{today_order_refund}}</div>
            <div class="total_price_text">待处理</div>
          </el-col>
          <el-col :span="8" class="elcol_elcol" @click.native='toallorder(301)'>
            <div class="total_price">
              <span style="font-size:20px;margin-right:2px">￥</span>{{today_price_pay}}</div>
            <div class="total_price_text">今日成交额</div>
          </el-col>
        </el-row>
        <el-row class="content_middle">
          <el-col :span="8" class="content_middle_text border_right">
            成交量较昨日
            <span v-if="rate_data.already_sign == '+'"
            style="font-size:14px;color:#ef5350;font-weight:bold">+ {{rate_data.already}}%</span>
            <span v-if="rate_data.already_sign == '-'"
            style="font-size:14px;color:#007bdf;font-weight:bold">- {{rate_data.already}}%</span>
          </el-col>
          <el-col :span="8" class="content_middle_text border_right">
            处理量较昨日
            <span v-if="rate_data.refund_sign == '+'"
            style="font-size:14px;color:#ef5350;font-weight:bold">+ {{rate_data.refund}}%</span>
            <span v-if="rate_data.refund_sign == '-'"
            style="font-size:14px;color:#007bdf;font-weight:bold">- {{rate_data.refund}}%</span>
          </el-col>
          <el-col :span="8" class="content_middle_text">
            成交额较昨日
            <!-- <span style="font-size:14px;color:#007bdf;font-weight:bold">- 23.12%</span> -->
            <span v-if="rate_data.price_sign == '+'"
            style="font-size:14px;color:#ef5350;font-weight:bold">+ {{rate_data.price}}%</span>
            <span v-if="rate_data.price_sign == '-'"
            style="font-size:14px;color:#007bdf;font-weight:bold">- {{rate_data.price}}%</span>
          </el-col>
        </el-row>
        <el-row class="elrow_elrow" style="margin-top:0">
          <el-col :span="8" class=" elcol_elcol border_right">
            <div class="total_price green">
              {{yesterday_order_already}}
            </div>
            <div class="total_price_text green">
              昨日成交
            </div>
          </el-col>
          <el-col :span="8" class="elcol_elcol border_right">
            <div class="total_price green">
              {{yesterday_order_refund}}
            </div>
            <div class="total_price_text green">
              昨日处理
            </div>
        </el-col>
          <el-col :span="8" class="elcol_elcol">
            <div class="total_price green">
              <span style="font-size:20px;margin-right:2px">￥</span>{{yesterday_order_pay.toFixed(2)}}</div>
            <div class="total_price_text green">
              昨日成交额
            </div>
          </el-col>
        </el-row>
      <!-- <span @click="to_already_order" class="total_price"><span style="font-size:25px;margin-right:6px">￥</span>{{today_price_pay}}</span>
      <span class="total_price_text">今日成交额</span> -->
      </el-col>
      <el-col :span="12" class="content_elcol">
        <div id="daypriceChart" :style="{width: '100%', height: '100%'}"></div>
      </el-col>
    </el-row>
    <el-row class="content_elrowbottom">
      <el-col :span="24" style="height:98%;margin-top:2%;">
        <div id="dayChart" :style="{width: '100%', height: '100%'}"></div>
      </el-col>
    </el-row>
  </div>
</div>
</template>

<script>
import echarts from 'echarts'
import { Toast } from 'vant'
export default {
  data() {
    return {
      looptime: '00:00',
      time: 120000,
      timeloop: '',
      dayepriceChart: '',
      order_all_today_Price: [],
      order_all_yesterday: [],
      dayData: [0,0,0,0,0],
      today_price: [0,0,0,0,0],
      today_price_pay: 9.99,
      today_order_pend_out: 99,
      today_order_refund: 99,
      today_order_already: 99,
      yesterday_order_already: 99,
      yesterday_order_refund: 99,
      yesterday_order_pay: 99,
      rate_data: {
        already: 9.99,
        already_sign: '+',
        refund: 9.99,
        refund_sign: '+',
        price: 9.99,
        price_sign: '+',
      }
    }
  },
  components:{
  },
  mounted() {
    this.mountedAction()
    this.looprefresh()
    // this.drawDay()
    // this.drawTodayPrice()
  },
  beforeDestroy() {
    clearInterval(this.timeloop);

  },
  // destoryed(){
  //   console.log("关闭页面");
  //   localStorage.removeItem('token');
  // },
  methods:{
    toallorder(state) {
      // console.log();
      this.$router.push({
        path: '/dashboard/order/all',
        query: {
          state: state
        }
      })
    },
    // to_pendout() {
    //   this.$router.push({name: 'pendoutorder'})
    // },
    // to_refund() {
    //   this.$router.push({name: 'refundorder'})
    // },
    // to_already_order() {
    //   this.$router.push({name: 'order'})
    // },
    mountedAction() {
      // 基于准备好的dom，初始化echarts实例
      this.dayepriceChart = echarts.init(document.getElementById('daypriceChart'))
      this.dayeChart = echarts.init(document.getElementById('dayChart'))
      this.dayepriceChart.showLoading();
      this.dayeChart.showLoading();
      this.getInfo();
    },
    getInfo(){
      this.axios.post('echarts/getechartsprice').then((res) => {
        console.log(res);
        this.order_all_today_Price = res.data.data.order_all_today
        this.order_all_yesterday = res.data.data.order_all_yesterday
        // this.today_price_refresh()
        this.yesterday_all_order()
        // this.reformoneDayData()
      })
    },
    looprefresh() {
      this.timeloop = setInterval(() => {
        this.time = this.time - 1000
        if (this.time == 0) {
          this.time = 120000
          this.mountedAction()
        }else {
          this.looptime = this.timestampToDate(this.time)
        }
      }, 1000);
    },
    timestampToDate(timestamp){
      var M = parseInt((timestamp % 3600000) / 60000);
      var S = ((timestamp % 60000) / 1000).toFixed(0);
      var localM = M < 10 ? '0' + M : M;
      var localS = S < 10 ? '0' + S : S;
      return localM + ":" + localS
    },
    today_price_refresh() {
      let payprice = 0
      let pendpayprice = 0
      let alreadyprice = 0
      let alreadysend = 0
      let refundprice = 0
      for (var i = 0; i < this.order_all_today_Price.length; i++) {
        if (this.order_all_today_Price[i].order_status === 301) {
          payprice = (Number(payprice) + Number(this.order_all_today_Price[i].actual_price)).toFixed(2)
        }else if (this.order_all_today_Price[i].order_status === 0) {
          pendpayprice = Number(pendpayprice) + Number(this.order_all_today_Price[i].actual_price)
        }else if (this.order_all_today_Price[i].order_status === 201) {
          alreadyprice = Number(alreadyprice) + Number(this.order_all_today_Price[i].actual_price)
        }else if (this.order_all_today_Price[i].order_status === 300) {
          alreadysend = Number(alreadysend) + Number(this.order_all_today_Price[i].actual_price)
        }else if (this.order_all_today_Price[i].order_status === 400) {
          refundprice = Number(refundprice) + Number(this.order_all_today_Price[i].actual_price)
        }
      }
      this.today_price[0] = pendpayprice
      this.today_price[1] = alreadyprice
      this.today_price[2] = alreadysend
      this.today_price[3] = Number(payprice).toFixed(2)
      this.today_price[4] = refundprice
      this.today_price_pay = payprice
      this.drawTodayPrice()
    },
    yesterday_all_order() {
      // console.log(this.order_all_yesterday);
      let yesterday_already = []
      let yesterday_order_refund = []
      let yesterday_order_pay = 0
      for (var i = 0; i < this.order_all_yesterday.length; i++) {
        if (this.order_all_yesterday[i].order_status === 301
          && this.order_all_yesterday[i].refund_is_success === 0) {
          yesterday_already.push(this.order_all_yesterday[i])
          yesterday_order_pay = Number(yesterday_order_pay) + Number(this.order_all_yesterday[i].actual_price)
        }else if(this.order_all_yesterday[i].order_status === 301
          && this.order_all_yesterday[i].refund_is_success === 1){
          yesterday_order_refund.push(this.order_all_yesterday[i])
        }
      }
      this.yesterday_order_pay = yesterday_order_pay
      this.yesterday_order_already = yesterday_already.length
      this.yesterday_order_refund = yesterday_order_refund.length
      this.today_price_refresh()


    },
    ratedata() {
      let today_order_already = []
      for (var m = 0; m < this.order_all_today_Price.length; m++) {
        if (this.order_all_today_Price[m].order_status === 301) {
          today_order_already.push(this.order_all_today_Price[m])
        }
      }
      this.today_order_already = today_order_already.length
      // this.yesterday_order_already = 102 //z昨日成交订单
      // this.today_order_already = 999 //今日成交订单
      // this.yesterday_order_refund = 32 //昨日退款
      // this.today_order_refund = 23 //今日退款
      // this.yesterday_order_pay = 88654.23 //昨日金额
      // this.today_price_pay = 9874.01 //今日金额
      if (Number(this.today_order_already) == 0 || Number(this.yesterday_order_already) == 0) {
          this.rate_data.already = ' - - '
        }else if (Number(this.today_order_already) >= Number(this.yesterday_order_already)) {
          this.rate_data.already_sign = '+'
          this.rate_data.already = ((Number(this.today_order_already) / Number(this.yesterday_order_already) - 1) * 100).toFixed(2)
        }else {
          this.rate_data.already_sign = '-'
          this.rate_data.already = ((Number(this.yesterday_order_already) / Number(this.today_order_already) - 1) * 100).toFixed(2)
      }
      if (Number(this.today_order_refund) == 0 || Number(this.yesterday_order_refund) == 0) {
          this.rate_data.refund = ' - - '
        }else if (Number(this.today_order_refund) >= Number(this.yesterday_order_refund)) {
          this.rate_data.refund_sign = '+'
          this.rate_data.refund = ((Number(this.today_order_refund) / Number(this.yesterday_order_refund) - 1) * 100).toFixed(2)
        }else {
          this.rate_data.refund_sign = '-'
          this.rate_data.refund = ((Number(this.yesterday_order_refund) / Number(this.today_order_refund) - 1) * 100).toFixed(2)
      }
      if (Number(this.today_price_pay) == 0 || Number(this.yesterday_order_pay) == 0) {
          this.rate_data.price = ' - - '
        }else if (Number(this.today_price_pay) >= Number(this.yesterday_order_pay)) {
          this.rate_data.price_sign = '+'
          this.rate_data.price = ((Number(this.today_price_pay) / Number(this.yesterday_order_pay) - 1) * 100).toFixed(2)
        }else {
          this.rate_data.price_sign = '-'
          this.rate_data.price = ((Number(this.yesterday_order_pay) / Number(this.today_price_pay) - 1) * 100).toFixed(2)
      }
      // console.log('昨日成交'+ this.yesterday_order_already);
      // console.log('昨日处理'+ this.yesterday_order_refund);
      // console.log('昨日成交额'+ this.yesterday_order_pay);
      // console.log('今日成交'+ this.today_order_already);
      // console.log('今日待发货'+ this.today_order_pend_out);
      // console.log('今日待处理'+ this.today_order_refund);
      // console.log('今日成交额'+ this.today_price_pay);
    },
    reformoneDayData() {
      let oneDayData_1 = [] //待付款
      let oneDayData_2 = [] //待发货
      let oneDayData_3 = [] //待收货
      let oneDayData_4 = [] //已完成
      let oneDayData_5 = [] //退款
      for (var i = 0; i < this.order_all_today_Price.length; i++) {
        if (this.order_all_today_Price[i].order_status === 0) {
          oneDayData_1.push(this.order_all_today_Price[i])
        }else if (this.order_all_today_Price[i].order_status === 201) {
          oneDayData_2.push(this.order_all_today_Price[i])
        }else if (this.order_all_today_Price[i].order_status === 300) {
          oneDayData_3.push(this.order_all_today_Price[i])
        }else if (this.order_all_today_Price[i].order_status === 301) {
          oneDayData_4.push(this.order_all_today_Price[i])
        }else if (this.order_all_today_Price[i].order_status === 400) {
          oneDayData_5.push(this.order_all_today_Price[i])
        }
      }
      this.dayData[0] = oneDayData_1.length
      this.dayData[1] = oneDayData_2.length
      this.dayData[2] = oneDayData_3.length
      this.dayData[3] = oneDayData_4.length
      this.dayData[4] = oneDayData_5.length
      this.today_order_pend_out = oneDayData_2.length
      this.today_order_refund = oneDayData_5.length
      // this.dayData[5] = this.order_all_today_Price.length
      this.drawDay();
    },
    drawTodayPrice() {
      // 绘制图表
      this.dayepriceChart.hideLoading()
      let option = {
        title: {
            text: '今日金额分布'
        },
          tooltip : {
              trigger: 'item',
              formatter: "{b} : ￥{c} ({d}%)"
          },
          legend: {
            type: 'scroll',
            orient: 'vertical',
            x: 'right',
            y: '5%',
            data: ['待付款','已付款','已发货','已成交','退款']
          },
          series : [
              {
                  type: 'pie',
                  radius : '60%',
                  center: ['47%', '50%'],
                  selectedMode: 'single',
                  data:[
                      {value:this.today_price[0],name: '待付款',},
                      {value:this.today_price[1],name: '已付款',},
                      {value:this.today_price[2],name: '已发货',},
                      {value:this.today_price[3],name: '已成交',selected:true},
                      {value:this.today_price[4],name: '退款',},
                  ],
                  itemStyle: {
                      emphasis: {
                          shadowBlur: 10,
                          shadowOffsetX: 0,
                          shadowColor: 'rgba(0, 0, 0, 0.5)'
                      }
                  }
              }
          ]
      };
      // 使用刚指定的配置项和数据显示图表。
      this.dayepriceChart.setOption(option);
      // 处理点击事件并且跳转到相应的百度搜索页面
      this.dayepriceChart.on('click', function (params) {
        console.log(params);
          // window.open('https://www.baidu.com/s?wd=' + encodeURIComponent(params.name));
      });
      this.reformoneDayData()


    },
    drawDay() {
      // 绘制图表
      this.dayeChart.hideLoading()
      // this.dayeChart.showLoading();
      var colors = ['#61a0a8', '#d53a35'];
      let option = {
        title: {
            text: '今日订单量与金额',
            top: '-13px',
        },
        color: colors,
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'cross'
            }
        },
        grid: {
            left: '7.5%',
            right: '7.5%'
        },
        toolbox: {
            feature: {
                saveAsImage: {show: false}
            }
        },
        legend: {
            data:['金额','订单量']
        },
        xAxis: [
          {
            type: 'category',
            axisTick: {
              alignWithLabel: true
            },
            data: ['待付款','已付款','已发货','已成交','退款']
          }
        ],
        yAxis: [
          {
            type: 'value',
            name: '订单',
            position: 'right',
            axisLine: {
              lineStyle: {
                color: colors[0]
              }
            },
              axisLabel: {
                formatter: '{value}'
              }
            },
            {
              type: 'value',
              name: '金额',
              position: 'left',
              axisLine: {
                lineStyle: {
                  color: colors[1]
                  }
                },
                axisLabel: {
                  formatter: '￥{value}'
                  }
                }
            ],
        series: [
          {
            name:'订单量',
            type:'bar',
            data:this.dayData
          },
          {
            name:'金额',
            type:'line',
            yAxisIndex: 1,
            smooth: true,
            data:this.today_price
          }
        ]
      };

      // 使用刚指定的配置项和数据显示图表。
      this.dayeChart.setOption(option);
      // 处理点击事件并且跳转到相应的百度搜索页面
      this.dayeChart.on('click', function (params) {
        console.log(params);
        // console.log(this.today_price);

          // window.open('https://www.baidu.com/s?wd=' + encodeURIComponent(params.name));
      });
      this.ratedata()
    },
    Refresh() {
      this.time = 120000
      // this.mountedAction()
      this.mountedAction()
      Toast('已刷新 !')
    },
  }
}
</script>

<style scoped>
.content_middle_text {
  font-size: 12px;
  color: #757575;
}
.border_right {
  border-right:1px solid #eee;
}
.green {
  color: #007bdf !important;
}
.content_middle {
  /* border: 1px solid black; */
  height: 4vh;
  margin-bottom: 1vh;
  display: flex;
  justify-content: center;
  align-items: center;
}
.elcol_elcol {
  /* border: 1px solid black; */
  height: 10vh;
  /* display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center; */
}
.elrow_elrow {
  /* border: 1px solid black; */
  height: 10vh;
  margin-top: 1.25vh;
  margin-bottom: 1vh;
}
.total_price_text {
  /* flex:1 */
  /* border: 1px solid black; */
  font-size: 12px;
  height: 2.25vh;
  line-height: 2.25vh;
  /* height: 8vh; */
  font-weight: bold;
  letter-spacing: 1px;
  color: #ef5350;
}
.total_price {
  /* border: 1px solid black; */
  margin-top:1.625vh;
  font-weight: bold;
  height: 4.5vh;
  line-height: 4.5vh;
  font-size: 26px;
  color: #ef5350;
}
.content_elrowbottom {
  height: 46vh;
}
.content_elcol {
  /* border: 1px solid black ; */
  height: 30vh;
}
.content_elcolorder {
  /* border: 1px solid black ; */
  height: 30vh;

}
.content_elrow {
  /* border: 1px solid black ; */
  border-bottom: 1px solid #ddd;
  text-align: center;
}
.content_img {
  width: 30px;
  height: 30px;
  /* border:1px solid black; */
}
</style>
