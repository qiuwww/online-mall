<template>
<div class="content-page">
  <div class="content-nav">
    <el-breadcrumb class="breadcrumb" separator="/">
      <el-breadcrumb-item :to="{ path: '/dashboard' }">数据总览</el-breadcrumb-item>
    </el-breadcrumb>
    <div class="operation-nav">
        <el-button type="primary" size="small" @click="Refresh">刷新</el-button>
    </div>
  </div>
  <div class="content-main">
    <el-row class="content_elrow">
      <el-col :span="24" class="content_elcol">
        <div id="allChart" :style="{width: '100%', height: '100%'}"></div>
      </el-col>
    </el-row>
    <el-row class="content_elrowbottom">
      <el-col :span="24" style="height:98%;margin-top:2%;">
        <div id="weekChart" :style="{width: '100%', height: '100%'}"></div>
      </el-col>
    </el-row>
    <el-row class="content_elrow">
      <el-col :span="12" class="content_elcol" >
        <div id="dayChart" :style="{width: '100%', height: '100%'}"></div>
      </el-col>
    </el-row>
  </div>
</div>
</template>

<script>
import echarts from 'echarts'
// import echarts from 'echarts'
// 引入基本模板
// let echarts = require('echarts/lib/echarts')
// // 引入柱状图组件
// require('echarts/lib/chart/bar')
// // 引入饼图。
// require('echarts/lib/chart/pie')
// // import 'echarts/src/chart/pie';
// // 引入提示框和title组件
// require('echarts/lib/component/tooltip')
// require('echarts/lib/component/title')
// import Schart from 'vue-schart';
export default {
  data() {
    return {
      dayeChart: '',
      alleChart: '',
      weekeChart: '',
      dayData:[],
      oneDayData:[],
      weekData:[
        [0, 0, 0, 0, 0, 0, 0], //每周待付款
        [0, 0, 0, 0, 0, 0, 0], //每周待发货
        [0, 0, 0, 0, 0, 0, 0], //每周待收货
        [0, 0, 0, 0, 0, 0, 0], //每周已完成
        [0, 0, 0, 0, 0, 0, 0], //每周退款订单
        [0, 0, 0, 0, 0, 0, 0] //每周所有订单
      ],
      weekDayData: [],
      allData:[],
      pastDayData:[]
    }
  },
  components:{
      // Schart
  },
  mounted() {
    this.mountedAction()
    // this.drawWeek()
    // this.drawAll()
  },
  methods:{
    mountedAction() {
      // 基于准备好的dom，初始化echarts实例
      // this.dayeChart = echarts.init(document.getElementById('dayChart'))
      // 基于准备好的dom，初始化echarts实例
      this.alleChart = echarts.init(document.getElementById('allChart'))
      // 基于准备好的dom，初始化echarts实例
      this.weekeChart = echarts.init(document.getElementById('weekChart'))
      // this.dayeChart.showLoading();
      this.alleChart.showLoading();
      this.weekeChart.showLoading();
      this.getInfo();
      // this.drawWeek();
      // this.drawDay();
      // this.drawAll();
    },
    getInfo(){
      this.axios.post('echarts/getechartsinfo').then((res) => {
        console.log(res);
        // this.oneDayData = res.data.data.order_all_today
        this.weekDayData = res.data.data.order_all_weekday
        this.pastDayData = res.data.data.final_past_time
        // this.reformoneDayData()
        this.reformweekDayData()
        this.reformpastDayData()
      })
    },
    reformpastDayData() {
      // console.log(this.pastDayData);
      this.allData = []
      for (var i = 0; i < this.pastDayData.length; i++) {
        // this.allData.length = this.pastDayData.length
        let obj = []
        let past_time = this.pastDayData[i][0]
        let past_order = this.pastDayData[i][1]
        let all_order = []
        let refund_order = []
        let already_order = []
        for (var j = 0; j < past_order.length; j++) {
            all_order.push(past_order[j])
          if(past_order[j].order_status === 400){
            refund_order.push(past_order[j])
          }else if (past_order[j].order_status === 301) {
            already_order.push(past_order[j])
          }
        }
        // console.log(past_time);
        obj[0] = past_time
        obj[1] = all_order.length
        obj[2] = refund_order.length
        obj[3] = already_order.length
        // console.log(obj);
        this.allData.push(obj)
      }
      this.drawAll();
    },
    reformweekDayData() {
      // console.log(this.weekDayData);
      let Monday_0 = [],Monday_1 = [],Monday_2 = [],Monday_3 = [],Monday_4 = []
      if (this.weekDayData.Monday && this.weekDayData.Tuesday && this.weekDayData.Wednesday
      && this.weekDayData.Thursday && this.weekDayData.Friday && this.weekDayData.Saturday
      && this.weekDayData.Sunday) {
        for (var i = 0; i < this.weekDayData.Monday.length; i++) {
          if (this.weekDayData.Monday[i].order_status === 0) {
            Monday_0.push(this.weekDayData.Monday[i])
          }else if (this.weekDayData.Monday[i].order_status === 201) {
            Monday_1.push(this.weekDayData.Monday[i])
          }else if (this.weekDayData.Monday[i].order_status === 300) {
            Monday_2.push(this.weekDayData.Monday[i])
          }else if (this.weekDayData.Monday[i].order_status === 301) {
            Monday_3.push(this.weekDayData.Monday[i])
          }else if (this.weekDayData.Monday[i].order_status === 400) {
            Monday_4.push(this.weekDayData.Monday[i])
          }
        }
        this.weekData[0][0] = Monday_0.length
        this.weekData[1][0] = Monday_1.length
        this.weekData[2][0] = Monday_2.length
        this.weekData[3][0] = Monday_3.length
        this.weekData[4][0] = Monday_4.length
        this.weekData[5][0] = this.weekDayData.Monday.length
        let Tuesday_0 = [],Tuesday_1 = [],Tuesday_2 = [],Tuesday_3 = [],Tuesday_4 = []
        for (var j = 0; j < this.weekDayData.Tuesday.length; j++) {
          if (this.weekDayData.Tuesday[j].order_status === 0) {
            Tuesday_0.push(this.weekDayData.Tuesday[j])
          }else if (this.weekDayData.Tuesday[j].order_status === 201) {
            Tuesday_1.push(this.weekDayData.Tuesday[j])
          }else if (this.weekDayData.Tuesday[j].order_status === 300) {
            Tuesday_2.push(this.weekDayData.Tuesday[j])
          }else if (this.weekDayData.Tuesday[j].order_status === 301) {
            Tuesday_3.push(this.weekDayData.Tuesday[j])
          }else if (this.weekDayData.Tuesday[j].order_status === 400) {
            Tuesday_4.push(this.weekDayData.Tuesday[j])
          }
        }
        this.weekData[0][1] = Tuesday_0.length
        this.weekData[1][1] = Tuesday_1.length
        this.weekData[2][1] = Tuesday_2.length
        this.weekData[3][1] = Tuesday_3.length
        this.weekData[4][1] = Tuesday_4.length
        this.weekData[5][1] = this.weekDayData.Tuesday.length
        let Wednesday_0 = [],Wednesday_1 = [],Wednesday_2 = [],Wednesday_3 = [],Wednesday_4 = []
        for (var k = 0; k < this.weekDayData.Wednesday.length; k++) {
          if (this.weekDayData.Wednesday[k].order_status === 0) {
            Wednesday_0.push(this.weekDayData.Wednesday[k])
          }else if (this.weekDayData.Wednesday[k].order_status === 201) {
            Wednesday_1.push(this.weekDayData.Wednesday[k])
          }else if (this.weekDayData.Wednesday[k].order_status === 300) {
            Wednesday_2.push(this.weekDayData.Wednesday[k])
          }else if (this.weekDayData.Wednesday[k].order_status === 301) {
            Wednesday_3.push(this.weekDayData.Wednesday[k])
          }else if (this.weekDayData.Wednesday[k].order_status === 400) {
            Wednesday_4.push(this.weekDayData.Wednesday[k])
          }
        }
        this.weekData[0][2] = Wednesday_0.length
        this.weekData[1][2] = Wednesday_1.length
        this.weekData[2][2] = Wednesday_2.length
        this.weekData[3][2] = Wednesday_3.length
        this.weekData[4][2] = Wednesday_4.length
        this.weekData[5][2] = this.weekDayData.Wednesday.length
        let Thursday_0 = [],Thursday_1 = [],Thursday_2 = [],Thursday_3 = [],Thursday_4 = []
        for (var l = 0; l < this.weekDayData.Thursday.length; l++) {
          if (this.weekDayData.Thursday[l].order_status === 0) {
            Thursday_0.push(this.weekDayData.Thursday[l])
          }else if (this.weekDayData.Thursday[l].order_status === 201) {
            Thursday_1.push(this.weekDayData.Thursday[l])
          }else if (this.weekDayData.Thursday[l].order_status === 300) {
            Thursday_2.push(this.weekDayData.Thursday[l])
          }else if (this.weekDayData.Thursday[l].order_status === 301) {
            Thursday_3.push(this.weekDayData.Thursday[l])
          }else if (this.weekDayData.Thursday[l].order_status === 400) {
            Thursday_4.push(this.weekDayData.Thursday[l])
          }
        }
        this.weekData[0][3] = Thursday_0.length
        this.weekData[1][3] = Thursday_1.length
        this.weekData[2][3] = Thursday_2.length
        this.weekData[3][3] = Thursday_3.length
        this.weekData[4][3] = Thursday_4.length
        this.weekData[5][3] = this.weekDayData.Thursday.length
        for (var m = 0; m < this.weekDayData.Friday.length; m++) {
          this.weekData[5][4] = this.weekDayData.Friday.length
          if (this.weekDayData.Friday[m].order_status === 0) {
            let Friday_0 = []
            Friday_0.push(this.weekDayData.Friday[m])
            this.weekData[0][4] = Friday_0.length
          }else if (this.weekDayData.Friday[m].order_status === 201) {
            let Friday_1 = []
            Friday_1.push(this.weekDayData.Friday[m])
            this.weekData[1][4] = Friday_1.length
          }else if (this.weekDayData.Friday[m].order_status === 300) {
            let Friday_2 = []
            Friday_2.push(this.weekDayData.Friday[m])
            this.weekData[2][4] = Friday_2.length
          }else if (this.weekDayData.Friday[m].order_status === 301) {
            let Friday_3 = []
            Friday_3.push(this.weekDayData.Friday[m])
            this.weekData[3][4] = Friday_3.length
          }else if (this.weekDayData.Friday[m].order_status === 400) {
            let Friday_4 = []
            Friday_4.push(this.weekDayData.Friday[m])
            this.weekData[4][4] = Friday_4.length
          }
        }
        let Saturday_0 = [],Saturday_1 = [],Saturday_2 = [],Saturday_3 = [],Saturday_4 = []
        for (var n = 0; n < this.weekDayData.Saturday.length; n++) {
          if (this.weekDayData.Saturday[n].order_status === 0) {
            Saturday_0.push(this.weekDayData.Saturday[n])
          }else if (this.weekDayData.Saturday[n].order_status === 201) {
            Saturday_1.push(this.weekDayData.Saturday[n])
          }else if (this.weekDayData.Saturday[n].order_status === 300) {
            Saturday_2.push(this.weekDayData.Saturday[n])
          }else if (this.weekDayData.Saturday[n].order_status === 301) {
            Saturday_3.push(this.weekDayData.Saturday[n])
          }else if (this.weekDayData.Saturday[n].order_status === 400) {
            Saturday_4.push(this.weekDayData.Saturday[n])
          }
        }
        this.weekData[0][5] = Saturday_0.length
        this.weekData[1][5] = Saturday_1.length
        this.weekData[2][5] = Saturday_2.length
        this.weekData[3][5] = Saturday_3.length
        this.weekData[4][5] = Saturday_4.length
        this.weekData[5][5] = this.weekDayData.Saturday.length
        let Sunday_0 = [],Sunday_1 = [],Sunday_2 = [],Sunday_3 = [],Sunday_4 = []
        for (var o = 0; o < this.weekDayData.Sunday.length; o++) {
          if (this.weekDayData.Sunday[o].order_status === 0) {
            Sunday_0.push(this.weekDayData.Sunday[o])
          }else if (this.weekDayData.Sunday[o].order_status === 201) {
            Sunday_1.push(this.weekDayData.Sunday[o])
          }else if (this.weekDayData.Sunday[o].order_status === 300) {
            Sunday_2.push(this.weekDayData.Sunday[o])
          }else if (this.weekDayData.Sunday[o].order_status === 301) {
            Sunday_3.push(this.weekDayData.Sunday[o])
          }else if (this.weekDayData.Sunday[o].order_status === 400) {
            Sunday_4.push(this.weekDayData.Sunday[o])
          }
        }
        this.weekData[0][6] = Sunday_0.length
        this.weekData[1][6] = Sunday_1.length
        this.weekData[2][6] = Sunday_2.length
        this.weekData[3][6] = Sunday_3.length
        this.weekData[4][6] = Sunday_4.length
        this.weekData[5][6] = this.weekDayData.Sunday.length
        // console.log(this.weekData);
        this.drawWeek();
      }else {
        this.drawWeek();
      }

    },
    drawWeek() {
      // 绘制图表
      this.weekeChart.hideLoading()
      let  option = {
          title: {
              text: '历史订单量对比'
          },
          tooltip : {
              trigger: 'axis',
              axisPointer: {
                  type: 'cross',
                  label: {
                      backgroundColor: '#6a7985'
                  }
              }
          },
          legend: {
              data:['待付款','待发货','待收货','已完成','退款订单','所有订单']
          },
          toolbox: {
              feature: {
                  saveAsImage: {}
              }
          },
          grid: {
              left: '3%',
              right: '4%',
              bottom: '3%',
              containLabel: true
          },
          xAxis : [
              {
                  type : 'category',
                  boundaryGap : false,
                  data : ['周一','周二','周三','周四','周五','周六','周日']
              }
          ],
          yAxis : [
              {
                  type : 'value'
              }
          ],
          series : [
              {
                  name:'待付款',
                  type:'line',
                  stack: '总量',
                  areaStyle: {normal: {}},
                  data: this.weekData[0]
              },
              {
                  name:'待发货',
                  type:'line',
                  stack: '总量',
                  areaStyle: {normal: {}},
                  data: this.weekData[1]
              },
              {
                  name:'待收货',
                  type:'line',
                  stack: '总量',
                  areaStyle: {normal: {}},
                  data:this.weekData[2]
              },
              {
                  name:'已完成',
                  type:'line',
                  stack: '总量',
                  areaStyle: {normal: {}},
                  data:this.weekData[3]
              },
              {
                  name:'退款订单',
                  type:'line',
                  stack: '总量',
                  areaStyle: {normal: {}},
                  data:this.weekData[4]
              },
              {
                  name:'所有订单',
                  type:'line',
                  stack: '总量',
                  smooth: true,
                  label: {
                      normal: {
                          show: true,
                          position: 'top'
                      }
                  },
                  areaStyle: {normal: {}},
                  data:this.weekData[5]
              }
          ]
      };
      // 使用刚指定的配置项和数据显示图表。
      this.weekeChart.setOption(option);
      // 处理点击事件并且跳转到相应的百度搜索页面
      this.weekeChart.on('click', function (params) {
        console.log(params);
          // window.open('https://www.baidu.com/s?wd=' + encodeURIComponent(params.name));
      });
    },
    drawAll(){
      // 绘制图表
      let rawData = this.allData
      // let dates = [['2016/01/01'],['2016/01/02'],['2016/01/03'],['2016/01/04']]
      // let data = [['7521.2'],['4541.2'],['3286.2'],['32431.2'],['32131.2']]
      var dates = rawData.map(function (item) {
          return item[0];
      });
      var dataall = rawData.map(function (item) {
          return item[1];
      });
      var datarefund = rawData.map(function (item) {
          return item[2];
      });
      var dataready = rawData.map(function (item) {
          return item[3];
      });
      this.alleChart.hideLoading()
      let option = {
        title: {
            text: '历史总订单量',
        },
        backgroundColor: '#fff',
        legend: {
            data: ['总订单','已完成','退款订单'],
            inactiveColor: '#777',
            textStyle: {
                color: '#333'
            }
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                animation: false,
                type: 'cross',
                lineStyle: {
                    color: '#333',
                    width: 2,
                    opacity: 1
                }
            }
        },
        xAxis: {
            type: 'category',
            data: dates,
            axisLine: { lineStyle: { color: '#333' } }
        },
        yAxis: {
            scale: true,
            axisLine: { lineStyle: { color: '#333' } },
            splitLine: { show: false }
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          // containLabel: true,
          bottom: 80
        },
        dataZoom: [{
            textStyle: {
                color: '#333'
            },
            handleIcon: 'M10.7,11.9v-1.3H9.3v1.3c-4.9,0.3-8.8,4.4-8.8,9.4c0,5,3.9,9.1,8.8,'+
            '9.4v1.3h1.3v-1.3c4.9-0.3,8.8-4.4,8.8-9.4C19.5,16.3,15.6,12.2,10.7,11.9z M13.3,'+
            '24.4H6.7V23h6.6V24.4z M13.3,19.6H6.7v-1.4h6.6V19.6z',
            handleSize: '80%',
            dataBackground: {
                areaStyle: {
                    color: '#8392A5'
                },
                lineStyle: {
                    opacity: 0.8,
                    color: '#8392A5'
                }
            },
            handleStyle: {
                color: '#fff',
                shadowBlur: 3,
                shadowColor: 'rgba(0, 0, 0, 0.6)',
                shadowOffsetX: 2,
                shadowOffsetY: 2
            }
        }, {
            type: 'inside'
        }],
        animation: true,
        series: [
            {
                name: '总订单',
                type: 'line',
                data: dataall,
                smooth: true,
                showSymbol: false,
                lineStyle: {
                    normal: {
                        width: 1
                    }
                }
            },
            {
                name: '已完成',
                type: 'line',
                data: dataready,
                smooth: true,
                showSymbol: false,
                lineStyle: {
                    normal: {
                        width: 1
                    },
                }
            },
            {
                name: '退款订单',
                type: 'line',
                data: datarefund,
                smooth: true,
                showSymbol: false,
                lineStyle: {
                    normal: {
                        width: 1
                    }
                }
            }
        ]
      };
      // 使用刚指定的配置项和数据显示图表。
      this.alleChart.setOption(option);
      // 处理点击事件并且跳转到相应的百度搜索页面
      this.alleChart.on('click', function (params) {
        console.log(params);
          // window.open('https://www.baidu.com/s?wd=' + encodeURIComponent(params.name));
      });
    },
    Refresh() {
      this.mountedAction()
      // console.log(this.allData[0][0]);
    },
  }
}
</script>

<style scoped>
.content_elrowbottom {
  height: 46vh;
  padding-bottom: 1.45vh;
  border-bottom: 1px solid #ddd;
}
.content_elcol {
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
