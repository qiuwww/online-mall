<template lang="html">
  <div class="content-page">
      <div class="content-nav" >
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>分销管理</el-breadcrumb-item>
              <el-breadcrumb-item>分销用户</el-breadcrumb-item>
          </el-breadcrumb>
          <div class="operation-nav">
              <el-button type="primary" size="small" @click="Refresh">刷新</el-button>
          </div>
          <!-- <div class="operation-nav">
            <router-link to="/dashboard/addcoupon">
              <el-button type="primary" icon="plus">添加优惠券</el-button>
            </router-link>
          </div> -->
      </div>
      <!-- <div class="operation-nav">
        <router-link to="/dashboard/addcoupon">
          <el-button type="primary" icon="plus">添加商品</el-button>
        </router-link>
      </div> -->
    <!-- </div> -->
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
          <!-- <div class="filter-box" style="float:right;text-align:right">
            <el-button v-if="ratechange" type="info" plain>当前佣金返还率
             <span style="color:#ff4444;font-weight:bold;font-size:18px;">{{localrate}}</span>
             %</el-button>
             <el-input v-if="!ratechange" :min="0" :max="100" style="width:125px;" type="number" v-model="localrate" placeholder="">
               <template slot="append">%</template>
             </el-input>
             <el-button v-if="rateprice" type="info" plain>当前提现最低金额
               ￥<span style="color:#ff4444;font-weight:bold;font-size:18px;">{{localprice}}</span>
             </el-button>
             <el-input v-if="!rateprice" :min="0" style="width:125px;" type="number" v-model="localprice" placeholder="">
               <template slot="prepend">￥</template>
             </el-input>
             <el-button v-if="ratechange && rateprice" type="info" plain @click="changeopen">修改</el-button>
             <el-button v-if="!ratechange && !rateprice" type="info" plain @click="canelrate">取消</el-button>
             <el-button v-if="!ratechange && !rateprice" type="danger" @click="changerate">完成</el-button>
          </div> -->
          <div class="form-table-box">
              <el-table :data="tableData" :default-sort = "{prop: 'date', order: 'descending'}" style="width: 100%" border stripe>
                <el-table-column width="175" align="center" label="加入时间" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      {{tableData[scope.$index].add_localtime}}
                    </span>
                  </template>
                </el-table-column>
                <el-table-column prop="user_mobile" width="130" align="center" label="手机号" >
                </el-table-column>
                <!-- <el-table-column align="center" label="当前用户信息"> -->
                <el-table-column align="center" label="用户昵称" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      {{tableData[scope.$index].user_name}}
                    </span>
                  </template>
                </el-table-column>
                <el-table-column align="center" label="邀请者" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      {{tableData[scope.$index].father.length >= '1' ? tableData[scope.$index].father[0].farther_user_name : ' - - '}}
                    </span>
                  </template>
                </el-table-column>
                <el-table-column width="120" align="center" label="成交金额" >
                  <template slot-scope="scope">
                    <span class="username_one">
                        ￥{{tableData[scope.$index].children_have_deal_money}}</span>
                    </span>
                  </template>
                </el-table-column>
                <el-table-column prop="have_deal_order_num" width="130" align="center" label="总成交订单数" >
                </el-table-column>

                <el-table-column width="140" align="center" label="可提现金额" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      <span style="color:#ff4444;font-weight:bold;font-size:16px;">
                        ￥{{tableData[scope.$index].can_withdraw_cash}}
                      </span>
                    </span>
                  </template>
                </el-table-column>
                <el-table-column width="140" align="center" label="已提现金额" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      <span style="color:#ff4444;font-weight:bold;font-size:16px;">
                        ￥{{tableData[scope.$index].have_withdraw_cash}}
                      </span>
                    </span>
                  </template>
                </el-table-column>
                <!-- <el-table-column prop="secret_code" width="130" align="center" label="特征码" >
                </el-table-column> -->
                <!-- <el-table-column prop="distribution_live" width="70" align="center" label="等级" >
                </el-table-column> -->

                <!-- <el-table-column label="操作" width="78"  align="center">
                    <template slot-scope="scope">
                        <el-button size="small" @click="handleRowSee(scope.$index, scope.row)">查看</el-button>
                    </template>
                </el-table-column> -->
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
  name:"DistributionUser",
  data() {
     return {
       // distriLiveValue: '',
       page: 1,
       total: 0,
       rateprice: true,
       localprice: 0,
       beforeprice: 0,
       localrate: 0,
       beforerate: 0,
       tableData:[],
       ratechange: true,
       row:[],
       filterForm:{
         user_name: '',
       },
       uploaderHeader: {
         'X-Nideshop-Token': localStorage.getItem('token') || '',
       },
     };
   },
   mounted(){
     console.log("分销页面");
     // this.axios.get()
     this.getList()
   },
   methods: {
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
     handleRowSee(index,row) {
       console.log(index,row);
     },
     getList(){
       this.axios.get('distribution/index', {
         params: {
           page: this.page,
           username: this.filterForm.user_name,
         }
       }).then((res) => {
         console.log(res);
         this.tableData = res.data.data.data.data
         for (var i = 0; i < this.tableData.length; i++) {
           this.tableData[i].add_localtime = this.timestampToTime(parseInt(this.tableData[i].add_time))
         }
         this.beforerate = Number(res.data.data.rate[0].rate * 100).toFixed(2)
         this.localrate = Number(res.data.data.rate[0].rate * 100).toFixed(2)
         this.beforeprice = Number(res.data.data.rate[0].price * 1).toFixed(2)
         this.localprice = Number(res.data.data.rate[0].price * 1).toFixed(2)
         console.log(this.tableData);

         this.page = res.data.data.data.currentPage
         this.total = res.data.data.data.count
       })

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
.username_one {
  overflow : hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
}
</style>
