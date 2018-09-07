<template lang="html">
  <div class="content-page">
      <div class="content-nav" >
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item >店铺运营</el-breadcrumb-item>
              <el-breadcrumb-item>优惠券管理</el-breadcrumb-item>
              <!-- <el-breadcrumb-item>优惠券管理</el-breadcrumb-item> -->
          </el-breadcrumb>
          <div class="operation-nav">
            <router-link to="/dashboard/addcoupon">
              <el-button type="primary" icon="plus">添加优惠券</el-button>
            </router-link>
          </div>
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
                  <el-form-item label="优惠券名称">
                      <el-input v-model="filterForm.coupon_name" @keyup.13.native="onSubmitFilter()"  placeholder="请输入优惠券名称"></el-input>
                  </el-form-item>
                  <el-form-item>
                      <el-button type="primary"@click="onSubmitFilter">查询</el-button>
                  </el-form-item>
              </el-form>
          </div>
          <div class="filter-box" style="float:right;">
            <!-- <el-form ref="infoForm"  label-width="120px"> -->
            <!-- <el-form-item label="所属分类" > -->
            <el-select v-model="CouponCategory" placeholder="请选择优惠券种类" @change="CouponCategorychange">
              <el-option v-for="item in CouponCategoryList" :key="item.id" :label="item.name" :value="item.id"></el-option>
            </el-select>
            <!-- <el-button type="primary"  @click="onClear">清空</el-button> -->
            <el-button type="info" plain @click="onClear">清空</el-button>
            <!-- <router-link to="/dashboard/addcoupon">
              <el-button type="primary" icon="el-icon-star-off" circle>添加优惠券</el-button>
            </router-link> -->
            <!-- <el-button type="primary" icon="el-icon-star-off" circle>添加优惠券</el-button> -->

            <!-- </el-form-item> -->
            <!-- </el-form> -->
          </div>
          <div class="form-table-box">
              <el-table :data="tableData" style="width: 100%" border stripe>
                  <!-- <el-table-column prop="id" label="ID" align="center" sortable  width="80">
                  </el-table-column> -->
                  <el-table-column align="center" label="名称" >
                    <template slot-scope="scope">
                      <div class="username_one">
                        {{tableData[scope.$index].coupon_name}}
                      </div>
                    </template>
                  </el-table-column>
                  <el-table-column align="center"  label="注明">
                    <template slot-scope="scope">
                      <div class="username_one">
                        {{tableData[scope.$index].Instructions}}
                      </div>
                    </template>
                  </el-table-column>
                  <!-- <el-table-column prop="disprice" align="center" sortable width="150" label="减免价格(元)">
                  </el-table-column> -->
                  <el-table-column prop="create_localtime" align="center" width="170" label="创建时间">
                  </el-table-column>
                  <el-table-column  align="center" width="110" label="剩余(张)">
                    <template slot-scope="scope">
                      {{tableData[scope.$index].coupon_number}}/{{tableData[scope.$index].obtained_num}}
                    </template>
                  </el-table-column>
                  <el-table-column prop="" align="center" width="230" label="基本类型">
                    <template slot-scope="scope">
                      {{row[scope.$index].day_type}}{{row[scope.$index].limit_type}}{{row[scope.$index].type}}
                    </template>
                  </el-table-column>
                  <el-table-column prop="" align="center" width="200" label="有效期">
                    <template slot-scope="scope">
                      <span v-if="tableData[scope.$index].validity_start == '' || tableData[scope.$index].validity_end == ''">{{tableData[scope.$index].limit_localtime}}</span>
                      <span v-else>{{tableData[scope.$index].end_localtime}}</span>

                    </template>
                  </el-table-column>
                  <el-table-column prop="" align="center" width="133" label="指定信息">
                    <template slot-scope="scope">
                      <el-button style="float:left" v-show="tableData[scope.$index].point_goods !== ''" size="small" @click="handlepointgoods(scope.$index, scope.row)">商品</el-button>
                      <div style="float:left;width:44px;height:28px;line-height:28px;text-align:center;" v-show= "tableData[scope.$index].point_goods == ''" >无</div>
                      <el-button v-show="tableData[scope.$index].point_user !== ''" size="small" @click="handlepointuser(scope.$index, scope.row)">用户</el-button>
                      <div style="float:left;width:44px;height:28px;line-height:28px;text-align:center;margin-left:7px;" v-show= "tableData[scope.$index].point_user == ''" >无</div>
                      <!-- {{row[scope.$index].day_type}}{{row[scope.$index].limit_type}}{{row[scope.$index].type}} -->
                    </template>
                  </el-table-column>
                  <!-- <el-table-column prop="coupon_type" align="center" sortable width="100" label="类型">
                  </el-table-column> -->
                  <el-table-column prop="" align="center" width="92" label="启用">
                    <template slot-scope="scope">
                        <el-switch :disabled="row[scope.$index].is_outof" v-model="row[scope.$index].is_able" @change="changeIsable(scope.$index, scope.row)">
                        </el-switch>
                    </template>
                  </el-table-column>
                  <el-table-column label="操作" width="140"  align="center">
                      <template slot-scope="scope">
                          <el-button size="small" @click="handleRowEdit(scope.$index, scope.row)">编辑</el-button>
                          <el-button size="small" type="danger" @click="handleRowDelete(scope.$index, scope.row)">删除</el-button>
                      </template>
                  </el-table-column>
              </el-table>
          </div>
          <div class="page-box">
              <el-pagination @current-change="handlePageChange" :current-page="page" :page-size="10" layout="total, prev, pager, next, jumper" :total="total">
              </el-pagination>
          </div>
      </div>
<!-- ////////////////////////////////////////////////////////////////查看指定商品弹层 -->
      <van-popup v-model="pointgoods">
        <div class="Cuppointgoods_area">
          <div class="Cuppointgoods_area_title">
            指定商品列表
          </div>
          <div class="Cuppointgoods_area_table">
            <el-table :data="pointgoodsData" :default-sort = "{prop: 'date', order: 'descending'}" style="width: 100%" border stripe>
                <el-table-column prop="name" align="center"  label="商品名称" >
                </el-table-column>
            </el-table>
          </div>
        </div>
      </van-popup>
<!-- ////////////////////////////////////////////////////////////////查看指定用户弹层 -->

      <van-popup v-model="pointuser">
        <div class="Cuppointgoods_area">
          <div class="Cuppointgoods_area_title">
            指定用户列表
          </div>
          <div class="Cuppointgoods_area_table">
            <el-table :data="pointuserData" :default-sort = "{prop: 'date', order: 'descending'}" style="width: 100%" border stripe>
                <el-table-column prop="nickname" align="center"  label="用户名称" >
                </el-table-column>
                <el-table-column prop="mobile" align="center"  label="手机号码" >
                </el-table-column>
            </el-table>
          </div>
        </div>
      </van-popup>
    </div>
</template>

<script>
export default {
  name:"CouponPage",
  data() {
     return {
       CouponCategory:'',//优惠券
       CouponCategoryList:[],//优惠券种类列表
       pointgoods: false,
       pointuser: false,
       pointgoodsData: [],
       pointuserData: [],
       page: 1,
       total: 0,
       tableData:[],
       row:[],
       filterForm:{
         coupon_id: '',
       },
       uploaderHeader: {
         'X-Nideshop-Token': localStorage.getItem('token') || '',
       },
     };
   },
   mounted(){
     console.log("优惠券页面");
     // this.axios.get()
     this.getList()
   },
   methods: {
     handleRowEdit (index,row){
       this.$router.push({
         name: 'addcoupon',
         query: {
           id: row.id
         }
       })
     },
     handlepointgoods(index,row){
       // console.log(index,row);
       // console.log(row.point_goods);
       this.pointgoods = true
       let pointgoodsList = row.point_goods.split(",")
       console.log(pointgoodsList);
       this.axios.post('coupon/findpointgoods',{
         id:pointgoodsList
       }).then((res) => {
         console.log(res);
         this.pointgoodsData = res.data.data
       })
       // for (var i = 0; i < pointgoodsList.length; i++) {
       //   // array[i]
       //
       //
       // }
     },
     handlepointuser(index,row){
       // console.log(index,row);
       // console.log(row.point_goods);
       this.pointuser = true
       let pointuserList = row.point_user.split(",")
       for (var i = 0; i < pointuserList.length; i++) {
         // array[i]
         this.axios.post('coupon/findpointuser',{
           id:pointuserList[i]
         }).then((res) => {
           console.log(res);
           this.pointuserData = res.data.data
         })

       }
     },
     getList(){
       this.axios.get('coupon', {
         params: {
           page: this.page,
           couponname: this.filterForm.coupon_name,
         }
       }).then((response) => {
         // console.log(response);
         this.tableData = response.data.data.data
         console.log(this.tableData);
         for (var i = 0; i < this.tableData.length; i++) {
           // let is_able = {}
           let obj = {}
           obj.is_able = this.tableData[i].coupon_isabled == 1 ? true : false
           this.tableData[i].create_localtime = this.timestampToTime(this.tableData[i].validity_create)
           if (this.tableData[i].validity_start == '' || this.tableData[i].validity_end == '') {
             obj.is_outof = false
             this.tableData[i].limit_localtime = this.timestampToDay(this.tableData[i].validity_limit_day)
           }else {
             if (new Date().getTime() > this.tableData[i].validity_end) {
               console.log("已过期");
               this.tableData[i].end_localtime = "已过期"
               this.axios.post('coupon/setcupable', {
                 id: this.tableData[i].coupon_id,
                 data: 0
               }).then((response) => {
                 // console.log(response.data)
                 // if (response.data.errno === 0) {
                 //   this.$message({
                 //     type: 'success',
                 //     message: '修改成功!'
                 //   });
                 // }
               })
               obj.is_outof = true
             }else {
               this.tableData[i].end_localtime = this.timestampToTime(this.tableData[i].validity_end) + ' 到期 '
               obj.is_outof = false
             }
           }
           // this.row.is_able = this.tableData[i].coupon_isabled
           if (this.tableData[i].validity_type == 0) {
             obj.day_type = '固定日期' + '^'
           }else if (this.tableData[i].validity_type == 1) {
             obj.day_type = '即时生效' + '^'
           }else if (this.tableData[i].validity_type == 2) {
             obj.day_type = '次日生效' + '^'
           }
           if (this.tableData[i].coupon_limit == 0) {
             obj.limit_type = '通用' +'^'
           }else if (this.tableData[i].coupon_limit == 1) {
             obj.limit_type = '满'+ this.tableData[i].coupon_limit_value + '元'+ '^'
           }
           if (this.tableData[i].coupon_type == 0) {
             obj.type = '减' + (this.tableData[i].coupon_value / 1).toFixed(2) + '券'
           }else if (this.tableData[i].coupon_type == 1) {
             obj.type = this.tableData[i].coupon_value + '折券'
           }
           this.row.push(obj)
           // this.tableData[i].start_localtime = this.timestampToTime(this.tableData[i].validity_start)
           // this.tableData[i].end_localtime = this.timestampToTime(this.tableData[i].validity_end)
           this.tableData[i].disprice = (this.tableData[i].coupon_value / 1).toFixed(2)


         }
         this.page = response.data.data.currentPage
         this.total = response.data.data.count
       })

     },
     timestampToDay(timestamp){
       if (timestamp >= 86400000) {
         var D = (timestamp / 86400000).toFixed(2)
         var DL = D.split(".")
         var Y = ((timestamp - (DL[0] * 86400000)) / 3600000).toFixed(2)
         var YL = Y.split(".")
         var H = ((timestamp - (DL[0] * 86400000) - (YL[0] * 3600000)) / 60000).toFixed(2)
         var HL = H.split(".")
         var M = ((timestamp - (DL[0] * 86000000) - (YL[0] * 3600000) - (HL[0] * 60000)) / 60000).toFixed(2)
         var ML = M.split(".")
         return DL[0] + " 天 " + YL[0] + " 小时 " + HL[0] + ' 分钟 '
         // return DL[0] + " 天 " + YL[0] + " 小时 " + HL[0] + ' 分钟 '
       }
       if (timestamp == 0){
         return "有效期错误"
       }
       // }else if (timestamp < 86400000 && timestamp >= 3600000){
       //   var Y = (timestamp / 3600000).toFixed(2)
       //   var YL = Y.split(".")
       //   var H = ((timestamp - (YL[0] * 3600000)) / 60000).toFixed(2)
       //   var HL = H.split(".")
       //   // var M = ((timestamp  - (YL[0] * 3600000) - (HL[0] * 60000)) / 60000).toFixed(2)
       //   // var ML = M.split(".")
       //   return YL[0] + " 小时 " + HL[0] + ' 分钟 '
       // }else if ( timestamp < 3600000 && timestamp >= 60000){
       //   // var Y = (timestamp / 3600000).toFixed(2)
       //   // var YL = Y.split(".")
       //   var H = (timestamp / 60000).toFixed(2)
       //   var HL = H.split(".")
       //   // var M = ((timestamp - (HL[0] * 60000)) / 60000).toFixed(2)
       //   // var ML = M.split(".")
       //   return HL[0] + ' 分钟 '
       // }

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
     //启用禁用优惠券
     changeIsable(index,row){
       console.log(index, row);
       this.$confirm('是否修改优惠券' + row.coupon_name + '的启用状态吗' + '?', '修改实时生效！', {
         confirmButtonText: '确定',
         cancelButtonText: '取消',
         type: 'warning'
       }).then(() => {
         this.axios.post('coupon/setcupable', {
           id: row.coupon_id,
           data: this.row[index].is_able ? 1 : 0
         }).then((response) => {
           console.log(response.data)
           if (response.data.errno === 0) {
             this.$message({
               type: 'success',
               message: '修改成功!'
             });
           }
         })
       }).catch(() => {
         this.row[index].is_able = !this.row[index].is_able
         this.$message({
           type: 'info',
           message: '已取消修改！'
         });
       });

     },
     //清空查询信息
     onClear(){

     },
     //优惠券种类
     CouponCategorychange(){

     },
     //下一页优惠券列表
     handlePageChange(val){
       this.page = val;
       //保存到localStorage
       localStorage.setItem('page', this.page)
       this.getList()
     },
     //删除优惠券
     handleRowDelete(index,row){
       this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.axios.post('coupon/delcup',{
            id:row.coupon_id
          }).then((res) => {
            console.log(res);
            this.tableData = []
            this.row = []
            this.getList()
          })
          this.$message({
            type: 'success',
            message: '删除成功!'
          });
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消删除'
          });
        });

     },
     // //查看优惠券
     // handleRowEdit(){
     //
     // },
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
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}
.Cuppointgoods_area {
  margin: 12px;
  width: 400px;

}
.Cuppointgoods_area_title {
  text-align: center;
  font-weight: bold;
  padding: 15px 0 25px 0 ;
}
/* .el-upload--picture-card {
  width: 40px !important;
  height: 40px !important;
} */
</style>
