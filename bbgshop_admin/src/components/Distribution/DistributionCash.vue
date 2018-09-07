<template lang="html">
  <div class="content-page">
      <div class="content-nav" >
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>分销管理</el-breadcrumb-item>
              <el-breadcrumb-item>佣金提现</el-breadcrumb-item>
          </el-breadcrumb>
          <div class="operation-nav">
              <el-button type="primary" size="small" @click="Refresh">刷新</el-button>
          </div>
      </div>
      <div class="content-main">
          <div class="filter-box" style="float:left;">
              <el-form :inline="true" :model="filterForm" class="demo-form-inline">
                  <el-form-item label="用户名称">
                      <el-input v-model="filterForm.user_name" @keyup.13.native="onSubmitFilter()" placeholder="请输入用户名称"></el-input>
                  </el-form-item>
                  <el-form-item>
                      <el-button type="primary"@click="onSubmitFilter">查询</el-button>
                  </el-form-item>
              </el-form>
          </div>
          <el-select style="float:right;margin-left:50px;" clearable v-model="bank_state_value" placeholder="选择处理状态" @change='changebanklist'>
            <el-option
              v-for="item in bank_list"
              :key="item.id"
              :label="item.lable"
              :value="item.id">
            </el-option>
          </el-select>
          <!-- <div class="filter-box" style="float:right;text-align:right">
            <el-button style="height:36px;line-height:36px;padding:0 15px;" v-if="ratechange" type="info" plain>当前佣金返还率
             <span style="color:#ff4444;font-weight:bold;font-size:18px;">{{localrate}}</span>
             %</el-button>
             <el-input v-if="!ratechange" :min="0" :max="100" style="width:125px;" type="number" v-model="localrate" placeholder="">
               <template slot="append">%</template>
             </el-input>
             <el-button style="height:36px;line-height:36px;padding:0 15px;" v-if="rateprice" type="info" plain>当前提现最低金额
               ￥<span style="color:#ff4444;font-weight:bold;font-size:18px;">{{localprice}}</span>
             </el-button>
             <el-input v-if="!rateprice" :min="0" style="width:125px;" type="number" v-model="localprice" placeholder="">
               <template slot="prepend">￥</template>
             </el-input>
             <el-button style="margin-top:-5px !important;" v-if="ratechange && rateprice" type="info" plain @click="changeopen">修改</el-button>
             <el-button v-if="!ratechange && !rateprice" type="info" plain @click="canelrate">取消</el-button>
             <el-button v-if="!ratechange && !rateprice" type="danger" @click="changerate">完成</el-button>
          </div> -->


          <div class="form-table-box">
              <el-table :data="tableData" :default-sort = "{prop: 'date', order: 'descending'}" style="width: 100%" border stripe>
                <el-table-column align="center" label="申请时间" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      {{tableData[scope.$index].add_localtime}}
                    </span>
                  </template>
                </el-table-column>
                <el-table-column align="center" label="手机号" >
                  <template slot-scope="scope">
                      {{tableData[scope.$index].maininfo[0].user_mobile}}
                  </template>
                </el-table-column>
                <!-- <el-table-column align="center" label="当前用户信息"> -->
                <el-table-column align="center" label="用户昵称" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      {{tableData[scope.$index].user_name}}
                    </span>
                  </template>
                </el-table-column>
                <el-table-column align="center" label="提现前金额" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      ￥{{(tableData[scope.$index].befor_catch/1).toFixed(2)}}
                    </span>
                  </template>
                </el-table-column>
                <el-table-column align="center" label="提现金额" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      <span style="color:#ff4444;font-weight:bold;font-size:16px;">
                        ￥{{(tableData[scope.$index].catch_money/1).toFixed(2)}}
                      </span>
                    </span>
                  </template>
                </el-table-column>
                <el-table-column align="center" label="提现后金额" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      ￥{{(tableData[scope.$index].after_catch/1).toFixed(2)}}
                    </span>
                  </template>
                </el-table-column>
                <el-table-column align="center" label="目标账户" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      <el-tooltip placement="left">
                        <div slot="content">
                          <div>{{tableData[scope.$index].cash_order.openid}}</div>
                        </div>

                        <el-button class="noborderbtn" v-if="tableData[scope.$index].cash_order.cash_type === 0 ">微信零钱</el-button>
                      </el-tooltip>
                      <el-tooltip placement="left">
                        <div slot="content">
                          <div>{{tableData[scope.$index].cash_order.card_bank_name}}
                            <span style="float:right">{{tableData[scope.$index].cash_order.card_bank_code}}</span></div>
                          <div>卡号 <span style="float:right">{{tableData[scope.$index].cash_order.card_code}}</span></div>
                          <div>姓名 <span style="float:right">{{tableData[scope.$index].cash_order.true_name}}</span></div>
                        </div>
                        <el-button class="noborderbtn" v-if="tableData[scope.$index].cash_order.cash_type !== 0 ">银行卡</el-button>
                      </el-tooltip>
                    </span>
                  </template>
                </el-table-column>
                <el-table-column width="120" align="center" label="状态" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      {{tableData[scope.$index].state_text}}
                    </span>
                  </template>
                </el-table-column>
                <el-table-column label="操作" width="145" align="center">
                    <template slot-scope="scope">
                        <el-button size="small" style="float:left" type="primary" v-if="tableData[scope.$index].is_success == 0"
                        @click="handleRowSure(scope.$index, scope.row)">同意 </el-button>
                        <el-button size="small" type="danger" v-if="tableData[scope.$index].is_success == 0"
                        @click="handleRowCanel(scope.$index, scope.row)">拒绝</el-button>
                        <!-- <el-tooltip placement="left">
                          <div slot="content">
                            <div class=""> {{tableData[scope.$index].handel_localtime}} 提交银行处理 </div>
                            <div class=""> {{tableData[scope.$index].pay_success_time}} 银行处理成功 </div>
                          </div> -->
                        <div class="" v-if="tableData[scope.$index].is_success == 1 || tableData[scope.$index].is_success == 2">
                          {{tableData[scope.$index].handel_localtime}} 处理成功
                        </div>
                        <!-- </el-tooltip> -->
                          <el-button size="small" type="danger" v-if="tableData[scope.$index].is_success == 3"
                          @click="handleRowQuery(scope.$index, scope.row)">查询进度</el-button>
                        <el-button size="small" style="float:left" type="primary" v-if="tableData[scope.$index].is_success == 4"
                        @click="handleRowReboot(scope.$index, scope.row)">异常,点击资金退回 </el-button>
                        <div class="" v-if="tableData[scope.$index].is_success == 5"> 提现异常，资金已退回 </div>
                    </template>
                </el-table-column>
              </el-table>
          </div>
          <div class="page-box">
              <el-pagination @current-change="handlePageChange" :current-page="page" :page-size="10" layout="total, prev, pager, next, jumper" :total="total">
              </el-pagination>
          </div>
      </div>
    </div>
</template>

<script>
import { Toast } from 'vant'
export default {
  data() {
     return {
       // distriLiveValue: '',
       bank_state_value: '',
       bank_list: [{
           id:0,
           lable:'待处理'
         },{
           id:1,
           lable:'已成功'
         },{
           id:2,
           lable:'已拒绝'
         },{
           id:3,
           lable:'处理中'
         },{
           id:4,
           lable:'异常待处理'
         },{
           id:5,
           lable:'异常已处理'
       }],
       rateprice: true,
       localprice: 0,
       beforeprice: 0,
       localrate: 0,
       beforerate: 0,
       ratechange: true,
       page: 1,
       total: 0,
       rate: 0,
       tableData:[],
       row:[],
       filterForm:{
         user_name: '',
         success_state: '',
       },
       uploaderHeader: {
         'X-Nideshop-Token': localStorage.getItem('token') || '',
       },
     };
   },
   mounted(){
     // this.axios.get()
     this.getList()
   },
   methods: {
     changebanklist(e){
       console.log(e);
       this.filterForm.success_state = e
       this.Refresh()
     },
     changerate(){
       this.$confirm('此操作将修改分销商返还佣金的比例和最低提现金额，修改立即生效 ！ ！ ！，修改立即生效 ！ ！ ！，修改立即生效 ！ ！ ！，务必谨慎修改, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.axios.post('distribution/setdistributionrate',{
            rate:Number(this.localrate / 100),
            price: Number(this.localprice)
          }).then((res) => {
            console.log(res);
            if (res.data.errno === 0) {
              this.ratechange = true
              this.Refresh()
              this.$message({
                type: 'success',
                message: '操作成功 !'
              });
            }
          })
          // this.localrate = this.beforerate
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消 !'
          });
          this.Refresh()
        });
     },
     changeopen() {
       this.ratechange = false
       this.rateprice = false
     },
     canelrate() {
       this.ratechange = true
       this.rateprice = true
       this.localrate = this.beforerate
       this.localprice = this.beforeprice
     },
     Refresh() {
       this.getList()
       Toast('已刷新 !')
       this.canelrate()
     },
     handleRowQuery(index,row){
       console.log(row);
       this.axios.post('pay/query_bank',{
         info:row
       }).then(res => {
         console.log(res);
         if (res.data.data.return_code == 'SUCCESS' && res.data.data.result_code == 'SUCCESS') {
           if (res.data.data.status === 'PROCESSING') {
             this.$notify({
               title: res.data.data.err_code_des,
               type: 'success',
               message: '银行处理中... ！',
               duration: 2000
             });
           }else if (res.data.data.status === 'SUCCESS') {
             this.axios.post('distribution/setcash_orderstate_success',{
               data: res.data.data,
               state: 1,
               id: row.id
             }).then((ress) => {
               console.log(ress);
               if (ress.data.errno === 0) {
                 this.$notify({
                   title: '提示',
                   type: 'success',
                   message: '提现成功,状态已更新 ！',
                   duration: 2000
                 });
                 this.getList()
               }
             })
           }else {
             this.axios.post('distribution/setcash_orderstate',{
               state: 4,
               id: row.id
             }).then((resd) => {
               console.log(resd);
               if (resd.data.errno === 0) {
                 this.$notify.error({
                   title: '提示',
                   message: '提现失败,未知原因,状态已更新 ！',
                   duration: 2000
                 });
                 this.getList()
               }
             })
           }
         }else {
           this.$notify.error({
             title: '提示',
             message: '查询失败 ！',
             duration: 2000
           });
         }
       })
     },
     handleRowSure(index,row) {
       console.log(row);
       if (row.cash_order.cash_type === 0) {
         this.$confirm('此操作将同意用户' + row.user_name + '的提现申请,用户将得到 ￥' + row.catch_money + '元, 是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.axios.post('pay/catchpay',{
              info:row
            }).then((res) => {
              console.log(res);


              // }
            // })
            // this.axios.post('distribution/surecash',{
            //   info:row
            // }).then((res) => {
            //   console.log(res);
            //   if (res.data.errno == 0) {
            //     this.$message({
            //       type: 'success',
            //       message: '操作成功 !'
            //     });
            //     this.getList()
          })
            // })

          }).catch(() => {
            this.$message({
              type: 'info',
              message: '已取消 !'
            });
          });
       }else if(row.cash_order.cash_type !== 0){
         this.$confirm('此操作将同意用户' + row.user_name + '的提现申请,将从商城账户失去 ￥' + row.catch_money + '元，打入用户银行卡, 是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.axios.post('pay/catchBabkCardPay',{
              info:row
            }).then(res => {
              console.log(res);
              if (res.data.data.return_key !== '') {
                // console.log("789798798");
                this.$notify({
                  title: '提示',
                  type: 'success',
                  message: '银行卡密码和姓名加密成功 ！',
                  duration: 2000
                });
                this.axios.post('pay/SubmissionToBank',{
                  pub_key:res.data.data.return_key,
                  info:row
                }).then((ress) => {
                  console.log(ress);
                  if (ress.data.data.return_code == 'SUCCESS' && ress.data.data.result_code == 'SUCCESS') {
                    this.$notify({
                      title: '提示',
                      type: 'success',
                      message: '已提交，微信侧受理成功 ！',
                      duration: 2000
                    });
                    this.axios.post('distribution/setcash_orderstate',{
                      state: 3,
                      id: row.id
                    }).then((reseer) => {
                      console.log(reseer);
                      if (reseer.data.errno === 0) {
                        this.$notify({
                          title: '提示',
                          type: 'success',
                          message: '状态已更新 ！',
                          duration: 2000
                        });
                        this.getList()
                      }
                    })
                  }
                })
              }
            })
          }).catch(() => {
            this.$message({
              type: 'info',
              message: '已取消 !'
            });
          });
       }
     },
     handleRowCanel(index,row){
       this.$confirm('此操作将拒绝用户' + row.user_name + '的提现申请, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.axios.post('distribution/canelcash',{
            state: 2,
            info:row
          }).then((res) => {
            console.log(res);
            if (res.data.errno == 0) {
              this.$message({
                type: 'success',
                message: '操作成功 !'
              });
              this.getList()
            }
          })
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消 !'
          });
        });
     },
     handleRowSee(index,row) {
       console.log(index,row);
     },
     handleRowReboot(index,row){
       this.axios.post('distribution/canelcash',{
         state: 5,
         info:row
       }).then((res) => {
         console.log(res);
         if (res.data.errno == 0) {
           this.$message({
             type: 'success',
             message: '操作成功 !'
           });
           this.getList()
         }
       })
     },
     getList(){
       this.axios.get('distribution/cashpage', {
         params: {
           page: this.page,
           username: this.filterForm.user_name,
           success_state: this.filterForm.success_state,
         }
       }).then((res) => {
         console.log(res);
         this.tableData = res.data.data.data.data
         for (var i = 0; i < this.tableData.length; i++) {
           console.log(i);
           this.tableData[i].add_localtime = this.timestampToTime(parseInt(this.tableData[i].add_time))
           this.tableData[i].handel_localtime = this.timestampToTime(parseInt(this.tableData[i].handel_time))
           // this.tableData[i].paysuccess_localtime = this.timestampToTime(parseInt(this.tableData[i].pay_success_time))
           if (this.tableData[i].is_success === 0) {
             this.tableData[i].state_text = '待处理'
           }else if (this.tableData[i].is_success === 1) {
             this.tableData[i].state_text = '已成功'
           }else if (this.tableData[i].is_success === 2) {
             this.tableData[i].state_text = '已拒绝'
           }else if (this.tableData[i].is_success === 3) {
             this.tableData[i].state_text = '已提交银行处理'
           }
         }
         this.beforerate = Number(res.data.data.rate[0].rate * 100).toFixed(2)
         this.localrate = Number(res.data.data.rate[0].rate * 100).toFixed(2)
         this.beforeprice = Number(res.data.data.rate[0].price * 1).toFixed(2)
         this.localprice = Number(res.data.data.rate[0].price * 1).toFixed(2)
         this.page = res.data.data.data.currentPage
         this.total = res.data.data.data.count
         this.check_bankstate()
       })

     },
     check_bankstate() {

     },
     timestampToTime(timestamp) {
         var date = new Date(timestamp * 1);
         var Y = date.getFullYear() + '/';
         var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '/';
         var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + '  ';
         var h = (date.getHours() < 10 ? '0'+date.getHours() : date.getHours()) + ':';
         var m = (date.getMinutes() < 10 ? '0'+date.getMinutes() : date.getMinutes()) + ':';
         var s = (date.getSeconds() < 10 ? '0'+date.getSeconds() : date.getSeconds());
         return Y+M+D+h+m+s;
     },
     //清空查询信息
     onClear(){
       this.distriLiveValue = ''
     },
     //优惠券种类
     DistributionLivechange(e){
       console.log(e);
       this.getList()
     },
     //下一页优惠券列表
     handlePageChange(){
       this.page = val;
       //保存到localStorage
       localStorage.setItem('page', this.page)
       this.getList()
     },
     //查询优惠券
     onSubmitFilter(){
       this.getList()
     }

   }
  }
  </script>

<style lang="css" scoped>
.noborderbtn {
  border: none !important;
  background: none !important;
}
.username_one {
  overflow : hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
}
</style>
