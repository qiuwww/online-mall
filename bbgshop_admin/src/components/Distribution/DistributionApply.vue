<template lang="html">
  <div class="content-page">
      <div class="content-nav" >
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>分销管理</el-breadcrumb-item>
              <el-breadcrumb-item>分销申请</el-breadcrumb-item>
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
          <!-- <div class="filter-box" style="float:right;">
            <el-button type="info" plain @click="onClear">当前佣金返还率
              <span style="color:#ff4444;font-weight:bold;font-size:18px;">{{rate}}</span>
              %</el-button>
          </div> -->
          <div class="form-table-box">
              <el-table :data="tableData" :default-sort = "{prop: 'date', order: 'descending'}" style="width: 100%" border stripe>
                <el-table-column width="170" align="center" label="申请时间" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      {{tableData[scope.$index].add_localtime}}
                    </span>
                  </template>
                </el-table-column>
                <el-table-column prop="user_mobile" align="center" label="手机号" >
                </el-table-column>
                <!-- <el-table-column align="center" label="当前用户信息"> -->
                <el-table-column align="center" label="用户昵称" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      {{tableData[scope.$index].user_name}}
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
                <el-table-column align="center" label="地区" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      <el-tooltip placement="left">
        								<div slot="content">
        								  {{tableData[scope.$index].mobile_country_e}} - {{tableData[scope.$index].mobile_country}}   +{{tableData[scope.$index].mobile_code}}
        								</div>
        								<div>{{tableData[scope.$index].mobile_country_e}} - {{tableData[scope.$index].mobile_country}}   +{{tableData[scope.$index].mobile_code}}</div>
        							</el-tooltip>

                    </span>
                  </template>
                </el-table-column>
                <el-table-column label="操作" align="center">
                    <template slot-scope="scope">
                        <el-button size="small" type="primary" v-if="tableData[scope.$index].status == 0" @click="handleRowSure(scope.$index, scope.row)">同意申请</el-button>
                        <el-button size="small" type="danger" v-if="tableData[scope.$index].status == 0" @click="handleRowCanel(scope.$index, scope.row)">拒绝申请</el-button>
                        <div class="" v-if="tableData[scope.$index].status !== 0">
                          {{tableData[scope.$index].handel_localtime}} 处理
                        </div>
                        <!-- <el-button size="small" type="danger" @click="handleRowDelete(scope.$index, scope.row)">删除</el-button> -->
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
  name:"DistributionPage",
  data() {
     return {
       // distriLiveValue: '',
       page: 1,
       total: 0,
       rate: 0,
       tableData:[],
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
     handleRowSure(index,row) {
       this.$confirm('此操作将同意用户' + row.user_name + '的分销员申请,用户将成为分销员, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.axios.post('distribution/sureapply',{
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
     handleRowCanel(index,row){
       this.$confirm('此操作将拒绝用户' + row.user_name + '的分销员申请, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.axios.post('distribution/canelapply',{
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
     Refresh() {
       this.getList()
       Toast('刷新成功 !')
     },
     handleRowSee(index,row) {
       console.log(index,row);
     },
     getList(){
       this.axios.get('distribution/apply', {
         params: {
           page: this.page,
           username: this.filterForm.user_name,
         }
       }).then((res) => {
         console.log(res);
         this.tableData = res.data.data.data.data
         for (var i = 0; i < this.tableData.length; i++) {
           console.log(i);
           this.tableData[i].add_localtime = this.timestampToTime(parseInt(this.tableData[i].apply_time))
           this.tableData[i].handel_localtime = this.timestampToTime(parseInt(this.tableData[i].handel_time))
           if (this.tableData[i].status === 0) {
             this.tableData[i].state_text = '待处理'
           }else if (this.tableData[i].status === 1) {
             this.tableData[i].state_text = '已通过'
           }else if (this.tableData[i].status === 2) {
             this.tableData[i].state_text = '已拒绝'
           }
         }
         this.rate = Number(res.data.data.rate[0].rate * 100)
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
