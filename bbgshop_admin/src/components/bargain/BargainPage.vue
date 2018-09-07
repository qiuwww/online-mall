<template lang="html">
  <div class="content-page">
      <div class="content-nav" >
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>店铺运营</el-breadcrumb-item>
              <el-breadcrumb-item>砍价管理</el-breadcrumb-item>
          </el-breadcrumb>
          <div class="operation-nav">
            <router-link to="/dashboard/bargain/bargainAdd">
              <el-button type="primary" icon="plus">发起砍价</el-button>
            </router-link>
          </div>
      </div>
      <div class="content-main">
        <div class="filter-box">
          <el-form :inline="true" :model="filterForm" class="demo-form-inline">
            <el-form-item label="砍价商品">
              <el-input v-model="filterForm.name" @keyup.13.native="onSubmitFilter()" placeholder="砍价商品"></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary"  @click="onSubmitFilter">查询</el-button>
            </el-form-item>
          </el-form>
        </div>
        <div class="form-table-box">
          <el-table :data="tableData" style="width: 100%" border stripe>
            <!-- <el-table-column prop="id" label="ID" width="100">
            </el-table-column> -->
            <el-table-column prop="create_localtime" width="170" align="center" label="创建时间">
            </el-table-column>
            <el-table-column label="商品名称">
              <template slot-scope="scope">
                <div class="goodsnamehh">
                  {{tableData[scope.$index].goods_name }}
                </div>
              </template>
            </el-table-column>
            <el-table-column label="砍价链接">
              <template slot-scope="scope">
                <div class="goodsnamehh">
                  pages/Resagin_bargain/Resagin_bargain
                </div>
              </template>
            </el-table-column>
            <el-table-column align="center" label="原价" width="80">
              <template slot-scope="scope">
                {{(tableData[scope.$index].retail_price / 1).toFixed(2)}}
              </template>
            </el-table-column>
            <el-table-column align="center" label="底价" width="80">
              <template slot-scope="scope">
                {{(tableData[scope.$index].lowest_price / 1).toFixed(2)}}
              </template>
            </el-table-column>
            <el-table-column align="center" label="已发起" width="90">
              <template slot-scope="scope">
                {{tableData[scope.$index].launched_num}}
              </template>
            </el-table-column>
            <el-table-column align="center" label="已参与" width="90">
              <template slot-scope="scope">
                {{tableData[scope.$index].participate_num}}
              </template>
            </el-table-column>
            <el-table-column align="center" label="已购买" width="90">
              <template slot-scope="scope">
                {{tableData[scope.$index].purchased_num}}
              </template>
            </el-table-column>
            <el-table-column width="170" align="center" label="结束时间">
              <template slot-scope="scope">
                {{tableData[scope.$index].end_localtime}}
              </template>
            </el-table-column>
            <el-table-column width="100" align="center" label="持续时间">
              <template slot-scope="scope">
                {{tableData[scope.$index].duration_localtime}}
              </template>
            </el-table-column>

            <el-table-column label="启用" align="center" width="92">
              <template slot-scope="scope">
                <el-switch :disabled="row[scope.$index].is_disable" v-model="row[scope.$index].is_abled" @change="changeIsable(scope.$index, scope.row)">
                </el-switch>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="140" align="center">
              <template slot-scope="scope">
                <el-button size="small" @click="handleRowEdit(scope.$index, scope.row)">编辑</el-button>
                <el-button size="small" type="danger" @click="handleRowDelete(scope.$index, scope.row)">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
        <div class="page-box">
          <el-pagination @current-change="handlePageChange" :current-page="page"
          :page-size="10" layout="total, prev, pager, next, jumper" :total="total">
          </el-pagination>
        </div>
      </div>
      <!-- <div class="operation-nav">
        <router-link to="/dashboard/addcoupon">
          <el-button type="primary" icon="plus">添加商品</el-button>
        </router-link>
      </div> -->
    <!-- </div> -->
  </div>
</template>

<script>
export default {
  name:"BargainPage",
  data(){
    return {
      page:1,
      total:0,
      filterForm:{
        name:''
      },
      row:[],
      tableData: [],

    }
  },
   mounted(){
     this.getList()
   },
  methods:{
    handleRowEdit(index,row) {
      this.$router.push({
        name: 'bargain_Add',
        query: {
          id: row.id
        }
      })
    },
    handleRowDelete(index,row){
      this.$confirm('此操作将永久删除该信息, 是否继续?', '提示', {
         confirmButtonText: '确定',
         cancelButtonText: '取消',
         type: 'warning'
       }).then(() => {
         this.axios.post('bargain/delbar',{
           id:row.id
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
    //启用禁用砍价
    changeIsable(index,row){
      console.log(index, row);
      this.$confirm('是否修改砍价信息' + row.goods_name + '的启用状态吗' + '?', '修改实时生效！', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.axios.post('bargain/setbarable', {
          id: row.id,
          data: this.row[index].is_abled ? 1 : 0
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
        this.row[index].is_abled = !this.row[index].is_abled
        this.$message({
          type: 'info',
          message: '已取消修改！'
        });
      });

    },
    onSubmitFilter(){
      this.getList()
    },
    handlePageChange(val){
      this.page = val;
      //保存到localStorage
      localStorage.setItem('goodsPage', this.page)
      localStorage.setItem('goodsFilterForm', JSON.stringify(this.filterForm));
      this.getList()
    },
    setUnAble(id){
      this.axios.post('bargain/setbarable', { id: id, data: '0' }).then((response) => { })
    },
    getList(){
      this.axios.get('bargain/findbargain',{
        params: {
          page: this.page,
          goodsname: this.filterForm.name
        }
      }).then((res) => {
        console.log(res);
        this.tableData = res.data.data.data
        this.page = res.data.data.currentPage
        this.total = res.data.data.count
        for (var i = 0; i < this.tableData.length; i++) {
          // this.tableData[i]
          this.tableData[i].create_localtime = this.timestampToTime(this.tableData[i].create_time)
          this.tableData[i].duration_localtime = this.timestampToDay(this.tableData[i].user_duration_time)

          if ( new Date().getTime() > this.tableData[i].end_time ){
              this.tableData[i].end_localtime = '已结束'
              this.setUnAble(this.tableData[i].id)
              let obj = {}
              obj.is_abled = this.tableData[i].is_abled == true
              obj.is_disable =  true
              this.row.push(obj)
            }else {
              this.tableData[i].end_localtime = this.timestampToTime(this.tableData[i].end_time)
              let obj = {}
              obj.is_abled = this.tableData[i].is_abled == 1 ? true : false
              obj.is_disable =  false
              this.row.push(obj)
            }

          // this.getList()
        }
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
    timestampToDay(timestamp){
        var Y = (timestamp / 3600000).toFixed(0)
        return Y + " 小时 "
    },
  }
}
</script>

<style lang="css">
.goodsnamehh {
  overflow : hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}
</style>
