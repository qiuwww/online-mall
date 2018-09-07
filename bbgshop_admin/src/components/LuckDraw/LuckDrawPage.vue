<template lang="html">
  <div class="content-page">
      <div class="content-nav" >
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>店铺运营</el-breadcrumb-item>
              <el-breadcrumb-item>抽奖管理</el-breadcrumb-item>
          </el-breadcrumb>
          <div class="operation-nav">
            <router-link to="/dashboard/Luckdraw_add">
              <el-button type="primary" icon="plus">添加抽奖</el-button>
            </router-link>
          </div>
      </div>
      <div class="content-main">
          <div class="filter-box" style="float:left;">
              <el-form :inline="true" :model="filterForm" class="demo-form-inline">
                  <el-form-item label="商品名称">
                      <el-input v-model="filterForm.goods_name" @keyup.13.native="onSubmitFilter()"  placeholder="请输入商品名称"></el-input>
                  </el-form-item>
                  <el-form-item>
                      <el-button type="primary"@click="onSubmitFilter">查询</el-button>
                  </el-form-item>
              </el-form>
          </div>
          <!-- <div class="filter-box" style="float:right;">
            <el-select v-model="CouponCategory" placeholder="请选择优惠券种类" @change="CouponCategorychange">
              <el-option v-for="item in CouponCategoryList" :key="item.id" :label="item.name" :value="item.id"></el-option>
            </el-select>
            <el-button type="info" plain @click="onClear">清空</el-button>
          </div> -->
          <div class="form-table-box">
              <el-table :data="tableData" style="width: 100%" border stripe>
                <el-table-column prop="create_localtime" align="center" width="170" label="创建时间">
                </el-table-column>
                  <el-table-column align="center" label="商品名称" >
                    <template slot-scope="scope">
                      <div class="username_one">
                        {{tableData[scope.$index].luck_goods_name}}
                      </div>
                    </template>
                  </el-table-column>
                  <el-table-column label="抽奖链接">
                    <template slot-scope="scope">
                      <div class="goodsnamehh">
                        pages/luckdraw/luckdraw?id={{tableData[scope.$index].id}}
                      </div>
                    </template>
                  </el-table-column>
                  <el-table-column prop="limit_localtime" align="center" width="170" label="截止时间">
                  </el-table-column>
                  <el-table-column prop="open_localtime" align="center" width="170" label="开奖时间">
                  </el-table-column>
                  <el-table-column align="center" label="状态">
                    <template slot-scope="scope">
                      {{row[scope.$index].state_text}}
                    </template>
                  </el-table-column>
                  <el-table-column align="center" label="参与 / 开奖（人）" width="150">
                    <template slot-scope="scope">
                      {{tableData[scope.$index].have_join_people_num}} / {{tableData[scope.$index].luck_people_num}}
                    </template>
                  </el-table-column>
                  <el-table-column prop="" align="center" width="92" label="启用">
                    <template slot-scope="scope">
                        <el-switch :disabled="row[scope.$index].is_out_time" v-model="row[scope.$index].is_able" @change="changeIsable(scope.$index, scope.row)">
                        </el-switch>
                    </template>
                  </el-table-column>
                  <el-table-column label="操作" width="140"  align="center">
                      <template slot-scope="scope">
                        <el-button size="small" :disabled="row[scope.$index].is_out_time" @click="handleRowEdit(scope.$index, scope.row)">编辑</el-button>
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
    </div>
</template>

<script>
export default {
  data() {
     return {
       page: 1,
       total: 0,
       tableData:[],
       row:[],
       filterForm:{
         goods_name: '',
       },
     };
   },
   mounted(){
     // this.axios.get()
     this.getList()
   },
   methods: {
     handleRowEdit(index,row) {
       this.$router.push({
         name: 'Luckdraw_add',
         query: {
           id: row.id
         }
       })
     },
     getList(){
       this.axios.get('luckdraw/list', {
         params: {
           page: this.page,
           goodsname: this.filterForm.goods_name,
         }
       }).then((res) => {
         // console.log(response);
         this.row = []
         this.tableData = res.data.data.data
         console.log(this.tableData);
         for (var i = 0; i < this.tableData.length; i++) {
           // let is_able = {}
           let obj = {}
           obj.is_able = this.tableData[i].abled == 1 ? true : false
           obj.state_text = this.tableData[i].abled == 1 ? '已启用' : '已禁用'
           obj.is_out_time = Number(this.tableData[i].luck_open_time) < new Date().getTime() ? true : false
           obj.state_text = Number(this.tableData[i].luck_limit_time) > new Date().getTime() ? obj.state_text + '^未结束' : obj.state_text + '^已结束'
           obj.state_text = Number(this.tableData[i].luck_open_time) > new Date().getTime() ? obj.state_text + '^未开奖' : obj.state_text + '^已开奖'

           this.tableData[i].create_localtime = this.timestampToTime(this.tableData[i].luck_create_time)
           this.tableData[i].limit_localtime = this.timestampToTime(this.tableData[i].luck_limit_time)
           this.tableData[i].open_localtime = this.timestampToTime(this.tableData[i].luck_open_time)
           this.row.push(obj)
         }
         this.page = res.data.data.currentPage
         this.total = res.data.data.count
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
       }
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
     //启用禁用
     changeIsable(index,row){
       console.log(index, row);
       this.$confirm('是否修改商品' + row.luck_goods_name + '的 抽奖 启用状态吗' + '?', '修改实时生效！', {
         confirmButtonText: '确定',
         cancelButtonText: '取消',
         type: 'warning'
       }).then(() => {
         this.axios.post('luckdraw/setluckable', {
           id: row.id,
           data: this.row[index].is_able ? 1 : 0
         }).then((res) => {
           console.log(res.data)
           this.getList()
           if (res.data.errno === 0) {
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
     //下一页
     handlePageChange(val){
       this.page = val;
       //保存到localStorage
       localStorage.setItem('page', this.page)
       localStorage.setItem('FilterForm', JSON.stringify(this.filterForm));

       this.getList()
     },
     //删除
     handleRowDelete(index,row){
       console.log(row);
       this.$confirm('此操作将永久删除此抽奖信息 ！, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.axios.post('luckdraw/delluck',{
            id:row.id
          }).then((res) => {
            console.log(res);
            if (res.data.errno === 0) {
              this.$message({
                type: 'success',
                message: '删除成功!'
              });
              this.tableData = []
              this.row = []
              this.getList()
            }
          })
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消删除'
          });
        });

     },
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
