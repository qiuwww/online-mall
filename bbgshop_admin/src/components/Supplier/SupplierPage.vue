<template lang="html">
  <div class="content-page">
      <div class="content-nav" >
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>商品管理</el-breadcrumb-item>
              <el-breadcrumb-item>供货商管理</el-breadcrumb-item>
          </el-breadcrumb>
          <div class="operation-nav">
            <!-- <router-link to="/dashboard/AddFreightTem"> -->
              <el-button @click="addSupplier" type="primary" icon="plus">添加供货商</el-button>
            <!-- </router-link> -->
          </div>
      </div>
      <div class="content-main">
        <div class="filter-box">
          <el-form :inline="true" :model="filterForm" class="demo-form-inline">
            <el-form-item label="供货商名称">
              <el-input v-model="filterForm.name" @keyup.13.native="onSubmitFilter()" placeholder="供货商名称"></el-input>
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
            <el-table-column prop="create_localtime" width="170" align="center" label="添加时间">
            </el-table-column>
            <el-table-column prop="handel_localtime" width="170" align="center" label="修改时间">
            </el-table-column>
            <el-table-column label="供货商名称">
              <template slot-scope="scope">
                <div class="goodsnamehh">
                  {{tableData[scope.$index].name }}
                </div>
              </template>
            </el-table-column>
            <!-- <el-table-column label="模板规则" align="center" width="100">
              <template slot-scope="scope">
                <div class="goodsnamehh">
                  {{tableData[scope.$index].point_rules}} 条
                </div>
              </template>
            </el-table-column> -->
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
      <!-- ////////////////////////////////////////////////////////添加供货商弹层 -->
      <van-popup class="addSupplerPopover" @click-overlay="closeaddpopup" v-model="show_suppler_popup">
        <div class="addSupplerPopover_title">
          添加供货商
          <!-- {{abc}} -->
        </div>
        <div class="addSupplerPopover_from">
          <el-form label-width="120px" :model="formLabelAlign">
            <el-form-item label="供货商名称">
              <el-input v-model="formLabelAlign.name"></el-input>
            </el-form-item>
          </el-form>
        </div>
        <div class="addSupplerPopover_btn">
          <el-button type="text"  @click="closeaddpopup">取消</el-button>
          <el-button type="danger"  @click="addSupplierSure">确定</el-button>
        </div>
      </van-popup>
  </div>
</template>

<script>
export default {
  data(){
    return {
      page:1,
      total:0,
      // abc: '',
      show_suppler_popup: false,
      filterForm:{
        name:''
      },
      formLabelAlign: {
        name: '',
        id: 0
      },
      row:[],
      tableData: [],

    }
  },
   mounted(){
     this.getList()
     // this.abc = Number(2.01 * 100).toFixed(2)
   },
  methods:{
    //添加供货商到数据库
    addSupplierSure() {
      if (this.formLabelAlign.name == '') {
        this.$message.error('请输入供货商名称 !')
        return false
      }
      this.axios.post('supplier/addsupplieraction',{
        name: this.formLabelAlign.name,
        id: this.formLabelAlign.id,
      }).then(res => {
        console.log(res);
        if (res.data.errno === 0) {
          this.$message({
            type: 'success',
            message: '更新成功 ！'
          })
          this.closeaddpopup()
          this.getList()
        }else {
          this.$message.error(res.data.errmsg)
        }
      })
    },
    //关闭增加供货商的弹层
    closeaddpopup() {
      this.formLabelAlign.id = 0
      this.formLabelAlign.name = ''
      this.show_suppler_popup = false
      console.log(this.formLabelAlign);
    },
    //添加供货商
    addSupplier() {
      this.show_suppler_popup = true
    },
    //删除运费模板
    handleRowDelete(index,row) {
      this.$confirm('此操作将永久删除此信息, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.axios.post('supplier/delsupplier',{
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
    //编辑运费模板 跳转到添加运费模板页
    handleRowEdit(index,row) {
      this.formLabelAlign.id = row.id
      this.formLabelAlign.name = row.name
      this.addSupplier()
      // this.$router.push({
      //   name: 'AddFreightTem',
      //   query: {
      //     id: row.id
      //   }
      // })
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
      console.log(this.filterForm.name);
      this.axios.post('supplier/findallsupplierlist',{
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
          this.tableData[i].handel_localtime = this.timestampToTime(this.tableData[i].handel_time)
          // this.tableData[i].duration_localtime = this.timestampToDay(this.tableData[i].user_duration_time)

          // let obj = {}
          // obj.is_abled = this.tableData[i].is_abled == 1 ? true : false
          // obj.is_disable =  false
          // this.row.push(obj)
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
.addSupplerPopover_btn {
  /* text-align: right; */
  /* border:1px solid black; */
  height: 50px;
  width: 90%;
  margin: 40px auto;
  margin-bottom: 10px;
  display: flex;
  justify-content: flex-end;
  align-items: center;
}
.addSupplerPopover_from {
  /* border:1px solid black; */
  width: 80%;
  margin: 50px auto;
}
.addSupplerPopover_title {
  margin: 10px 20px;
  /* border:1px solid black; */
  text-align: center;
  font-size: 20px;
  padding: 10px 0px;
  border-bottom: 1px solid #eee;

}
.addSupplerPopover {
  width: 500px;
  /* height: 300px; */
  border-radius: 5px;
}
/* .goodsnamehh {
  overflow : hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
} */
</style>
