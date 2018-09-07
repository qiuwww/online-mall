<template lang="html">
  <div class="content-page">
      <div class="content-nav" >
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>分销管理</el-breadcrumb-item>
              <el-breadcrumb-item>分销明细</el-breadcrumb-item>
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
                  <el-form-item label="">
                      <el-input style="width:200px;float:left;margin-right:15px;" v-model="filterForm.children_name" placeholder="输入用户昵称"></el-input>
                      <el-input style="width:200px;float:left" v-model="filterForm.father_name" placeholder="输入邀请者昵称"></el-input>

                  </el-form-item>
                  <el-form-item>
                      <el-button type="primary" plain @click="onClear">清空</el-button>
                      <el-button type="primary" @click="onSubmitFilter">查询</el-button>
                  </el-form-item>
              </el-form>
          </div>
          <div class="filter-box" style="float:right;">
          </div>
          <div class="form-table-box">
              <el-table :data="tableData" :default-sort = "{prop: 'date', order: 'descending'}" style="width: 100%" border stripe>
                <!-- <el-table-column width="175" align="center" label="加入时间" >
                  <template scope="scope">
                    <span class="username_one">
                      {{tableData[scope.$index].become_localtime}}
                    </span>
                  </template>
                </el-table-column> -->
                <el-table-column width="175" align="center" label="创建时间" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      {{tableData[scope.$index].add_localtime}}
                    </span>
                  </template>
                </el-table-column>
                <el-table-column width="130" align="center" label="手机号" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      {{tableData[scope.$index].maindis[0].user_mobile}}
                    </span>
                  </template>
                </el-table-column>
                <el-table-column align="center" label="用户昵称" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      {{tableData[scope.$index].children_name}}
                    </span>
                  </template>
                </el-table-column>
                <el-table-column align="center" label="邀请者" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      {{tableData[scope.$index].farther_user_name}}
                    </span>
                  </template>
                </el-table-column>
                <el-table-column align="center" min-width="222" label="购买商品" >
                  <template slot-scope="scope">
                    <span>
                      <!-- <el-tooltip class="item" effect="dark" content="Left Center 提示文字" placement="left"> -->
                      <el-tooltip placement="left">
                        <div slot="content">
                          <div v-for="item in tableData[scope.$index].ordergoods">
                            {{item.goods_name}}
                            <span style="float:right">￥{{(item.retail_price/1).toFixed(2)}}</span>
                            <span style="font-size:11px;float:right;">（{{item.goods_specifition_name_value}} x{{item.number}}）</span>
                          </div>
                        </div>
                        <el-button type="text" class="goods_oneline">
                          {{tableData[scope.$index].goods_all_name}}
                        </el-button>
                      </el-tooltip>
                      <!-- </el-tooltip> -->
                    </span>
                    <span class="rightstyle">
                      <el-button type="text" style="font-size:10px;color:#757575;font-weight:bold">
                        <span style="line-height: 1.35 !important;height: 1.35 !important;">
                          {{tableData[scope.$index].ordergoods.length}}件商品</span>
                      </el-button>
                      </span>
                  </template>
                </el-table-column>
                <el-table-column align="center" label="订单价格" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      ￥{{(tableData[scope.$index].order_price/1).toFixed(2)}}
                    </span>
                  </template>
                </el-table-column>
                <el-table-column align="center" label="分销类型" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      {{tableData[scope.$index].dis_type}}
                    </span>
                  </template>
                </el-table-column>
                <el-table-column align="center" label="返还率" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      {{(tableData[scope.$index].dis_rate * 1).toFixed(2)}} %
                    </span>
                  </template>
                </el-table-column>
                <el-table-column align="center" label="已获得佣金" >
                  <template slot-scope="scope">
                    <span class="username_one">
                      <span style="color:#ff4444;font-weight:bold;font-size:16px;">
                        ￥{{(tableData[scope.$index].withdraw_cash/1).toFixed(2)}}
                      </span>
                    </span>
                  </template>
                </el-table-column>
                <!-- <el-table-column label="操作" width="78"  align="center">
                    <template scope="scope">
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
  data() {
     return {
       // distriLiveValue: '',
       page: 1,
       total: 0,
       localrate: 0,
       beforerate: 0,
       tableData:[],
       ratechange: true,
       row:[],
       filterForm:{
         children_name: '',
         father_name: '',
       },
       uploaderHeader: {
         'X-Nideshop-Token': localStorage.getItem('token') || '',
       },
     };
   },
   mounted(){
     this.getList()

   },
   methods: {
     seegoods(index,row) {
       console.log(row);
     },
     Refresh() {
       this.getList()
       Toast('已刷新 ！')
     },
     handleRowSee(index,row) {
       console.log(index,row);
     },
     getList(){
       this.axios.get('distribution/detailpage', {
         params: {
           page: this.page,
           children_name: this.filterForm.children_name,
           father_name: this.filterForm.father_name,
         }
       }).then((res) => {
         console.log(res);
         this.tableData = res.data.data.data.data
         for (var i = 0; i < this.tableData.length; i++) {
           this.tableData[i].add_localtime = this.timestampToTime(parseInt(this.tableData[i].add_time))
           this.tableData[i].become_localtime = this.timestampToTime(parseInt(this.tableData[i].maindis[0].add_time))
           let obj = ''
           for (var j = 0; j < this.tableData[i].ordergoods.length; j++) {
             obj = obj + this.tableData[i].ordergoods[j].goods_name + ','
           }
           this.tableData[i].goods_all_name = obj
         }
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
       this.filterForm.children_name = ''
       this.filterForm.father_name = ''
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
       localStorage.setItem('children_name', this.filterForm.children_name)
       localStorage.setItem('father_name', this.filterForm.father_name)
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
.rightstyle {
  /* border:1px solid black; */
  float: right;
  width: 40px;
  text-align: center !important;
  font-size: 10px !important;
}
.goods_oneline {
  float: left;
  width: calc(100% - 40px);
  overflow : hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
}
.username_one {
  overflow : hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
}
</style>
