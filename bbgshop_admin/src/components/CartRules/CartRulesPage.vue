<template lang="html">
  <div class="content-page">
      <div class="content-nav" >
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>店铺运营</el-breadcrumb-item>
              <el-breadcrumb-item>金额结算规则</el-breadcrumb-item>
          </el-breadcrumb>
          <div class="operation-nav">
            <router-link to="/dashboard/CartRulesAdd">
              <el-button type="primary" icon="plus">添加规则</el-button>
            </router-link>
          </div>
      </div>
      <div class="content-main">
        <div class="filter-box">
          <el-form :inline="true" :model="filterForm" class="demo-form-inline">
            <el-form-item label="规则名称">
              <el-input v-model="filterForm.name" @keyup.13.native="onSubmitFilter()" placeholder="规则名称"></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary"  @click="onSubmitFilter">查询</el-button>
            </el-form-item>
          </el-form>
        </div>
        <div class="form-table-box">
          <el-table :data="tableData" :default-sort = "{prop: 'date', order: 'descending'}" style="width: 100%" border stripe>
            <!-- <el-table-column prop="id" label="ID" width="100">
            </el-table-column> -->
            <el-table-column prop="create_localtime" width="170" align="center" label="创建时间">
            </el-table-column>
            <el-table-column label="规则名称">
              <template slot-scope="scope">
                <div class="goodsnamehh">
                  {{tableData[scope.$index].rules_name }}
                </div>
              </template>
            </el-table-column>
            <el-table-column label="规则详情" align="center">
              <template slot-scope="scope">
                {{row[scope.$index].str}}
              </template>
            </el-table-column>
            <el-table-column label="是否启用" align="center" width="100">
              <template slot-scope="scope">
                <!-- <div class="goodsnamehh"> -->
                <el-switch
                  v-model="row[scope.$index].is_abled" @change="is_abled_change(scope.$index, scope.row)">
                </el-switch>
                <!-- </div> -->
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
    //修改启用禁用
    is_abled_change(index,row) {
      this.$confirm('此操作将修改' + row.rules_name + '的启用状态, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.axios.post('cartRules/rulesisable',{
            id: row.id,
            data: this.row[index].is_abled ? 1 : 0
          }).then(res => {
            console.log(res);
            if (res.data.errno === 0) {
              for (var i = 0; i < this.row.length; i++) {
                if (this.row[i].rules_suit == 0) {
                  if (this.row[index].is_abled) {
                    if (index == i) {
                      this.row[i].is_abled = true
                    }else {
                      this.row[i].is_abled = false
                    }
                  }
                }
              }
              // this.row = []
              this.getList()
              this.$message({
                type: 'success',
                message: '修改成功 ！'
              });
            }
          })

        }).catch(() => {
          this.row[index].is_abled = !this.row[index].is_abled
          this.$message({
            type: 'info',
            message: '取消修改 ！'
          });
        });
    },
    //删除
    handleRowDelete(index,row) {
      this.$confirm('此操作将永久删除此信息, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.axios.post('cartRules/delrules',{
            id: row.id
          }).then(res => {
            console.log(res);
            if (res.data.errno === 0) {
              this.getList()
              this.$message({
                type: 'success',
                message: '删除成功 ！'
              });
            }
          })

        }).catch(() => {
          this.$message({
            type: 'info',
            message: '取消删除 ！'
          });
        });
    },
    //编辑
    handleRowEdit(index,row) {
      this.$router.push({
        name: 'CartRulesAdd',
        query: {
          id: row.id
        }
      })
    },
    onSubmitFilter(){
      this.getList()
    },
    handlePageChange(val){
      this.page = val;
      //保存到localStorage
      localStorage.setItem('page', this.page)
      localStorage.setItem('filterForm', JSON.stringify(this.filterForm));
      this.getList()
    },
    getList(){
      this.axios.post('cartRules/ruleslist',{
          page: this.page,
          name: this.filterForm.name
      },'POST').then((res) => {
        console.log(res);
        this.tableData = res.data.data.data
        this.page = res.data.data.currentPage
        this.total = res.data.data.count
        for (var i = 0; i < this.tableData.length; i++) {
          // this.tableData[i]
          this.tableData[i].create_localtime = this.timestampToTime(this.tableData[i].create_time)
          // this.tableData[i].duration_localtime = this.timestampToDay(this.tableData[i].user_duration_time)
          let obj = {}
          obj.is_abled = this.tableData[i].is_abled == 1 ? true : false
          obj.rules_suit = this.tableData[i].rules_suit
          let str = ''
          if (this.tableData[i].rules_suit == 0) {
            str = str + '全店通用'
          }else{
            str = str + '指定分类'
          }
          if (this.tableData[i].rules_limit == 1) {
            str = str + '^^满'+this.tableData[i].rules_limit_price + '元'
          }else {
            str = str + '^^无限制'
          }
          if (this.tableData[i].rules_type == 0) {
            str = str + '^^减运费'
          }else if(this.tableData[i].rules_type == 1){
            str = str + '^^减免' + this.tableData[i].rules_minus_price + '元'
          }else if(this.tableData[i].rules_type == 2){
            str = str + '^^折扣' + this.tableData[i].rules_discount_price + '折'
          }
          obj.is_disable =  false
          obj.str = str
          this.row.push(obj)
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
/* .goodsnamehh {
  overflow : hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
} */
</style>
