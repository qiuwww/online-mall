<template>
<div class="content-page">
  <div class="content-nav">
    <el-breadcrumb class="breadcrumb" separator="/">
      <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>商品管理</el-breadcrumb-item>
      <el-breadcrumb-item>商品列表</el-breadcrumb-item>
    </el-breadcrumb>
    <div class="operation-nav">
      <!-- <el-button type="warning" style="margin-right:10px" @click="ExportExecle_SKU" :disabled='export_abled_button'>导出商品所有SKU</el-button> -->
      <el-button type="warning" style="margin-right:15px" @click="ExportExecle" :disabled='export_abled_button'>导出主商品</el-button>
      <router-link to="/dashboard/GoodsUpdatePage">
        <el-button type="primary" icon="plus">添加商品</el-button>
      </router-link>
    </div>
  </div>
  <div class="content-main">
    <div class="filter-box" style="float:left;">
      <el-form :inline="true" :model="filterForm" class="demo-form-inline">
        <el-form-item label="商品名称">
          <el-input v-model="filterForm.name" @keyup.13.native="show()" placeholder="商品名称"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="onSubmitFilter">查询</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="filter-box" style="float:right;">
      <el-select @change="FirstClassifyChange" v-model="FirstClassifyId" @clear="FirstClassifyClear" clearable placeholder="请选择一级分类">
        <el-option v-for="item in FirstClassifyList" :key="item.id" :label="item.name" :value="item.id">
        </el-option>
      </el-select>
      <el-select @change="SecondClassifyChange" v-model="SecondClassifyId" clearable placeholder="请选择二级分类">
        <el-option v-for="item in SecondClassifyList" :key="item.id" :label="item.name" :value="item.id">
        </el-option>
      </el-select>
    </div>
    <div class="form-table-box">
      <el-table :data="tableData" @cell-dblclick='doubleclick' :default-sort="{prop: 'retail_price', order: 'descending'}" style="width: 100%" border stripe>
        <!-- <el-table-column prop="id" align="center" sortable label="ID" width="100">
        </el-table-column> -->
        <el-table-column label="商品名称">
          <template slot-scope="scope">
            <div class="table_box">
              <img class="table_box_img" :src="tableData[scope.$index].list_pic_url" alt="">
              <div class="table_box_name" v-if="!row[scope.$index].name_edit">
                {{tableData[scope.$index].name}}
              </div>
              <el-input class="table_box_name_edit" v-if="row[scope.$index].name_edit"
                type="textarea"
                @blur="edit_blur"
                :rows="2"
                placeholder="请输入商品名称"
                v-model="tableData[scope.$index].name">
              </el-input>
            </div>
          </template>
        </el-table-column>
        <el-table-column align="center" label='添加时间' width="170">
          <template slot-scope="scope">
            {{row[scope.$index].add_localtime}}
          </template>
        </el-table-column>
        <el-table-column align="center" label="成本价" width="100">
          <template slot-scope="scope">
            <div class="" v-if="!row[scope.$index].cost_price_edit">
              {{tableData[scope.$index].cost_price}}
            </div>
            <el-input v-if="row[scope.$index].cost_price_edit"
            @blur="edit_blur"
            v-model="tableData[scope.$index].cost_price"
            placeholder="请输入成本价"></el-input>
          </template>
        </el-table-column>
        <el-table-column align="center" label="售价" width="100">
          <template slot-scope="scope">
            <div class="" v-if="!row[scope.$index].retail_price_edit">
              <span class="bold_text">{{tableData[scope.$index].retail_price}}</span>
            </div>
            <el-input @blur="edit_blur" v-if="row[scope.$index].retail_price_edit"
            v-model="tableData[scope.$index].retail_price"
            placeholder="请输入成本价"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="" label="库存" align="center" width="90">
          <template slot-scope="scope">
            <div class="" v-if="!row[scope.$index].goods_number_edit">
              {{tableData[scope.$index].goods_number}}
            </div>
            <el-input @blur="edit_blur" v-if="row[scope.$index].goods_number_edit"
            v-model="tableData[scope.$index].goods_number"
            placeholder="请输入成本价"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="" label="权重" align="center" width="100">
          <template slot-scope="scope">
            <div class="" v-if="!row[scope.$index].short_order_edit">
              {{tableData[scope.$index].short_order}}
            </div>
            <el-input @blur="edit_blur" v-if="row[scope.$index].short_order_edit"
            v-model="tableData[scope.$index].short_order"
            placeholder="请输入权重"></el-input>
          </template>
        </el-table-column>
        <el-table-column align="center" label="运费" width="100">
          <template slot-scope="scope">
            <div class="" v-if="!row[scope.$index].freight_edit">
              {{tableData[scope.$index].freight_type == 0 ? tableData[scope.$index].freight_price : '运费模板'}}
            </div>
            <el-input @blur="edit_blur" v-if="row[scope.$index].freight_edit"
            v-model="tableData[scope.$index].freight_price"
            placeholder="请输入成本价"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="is_new" label="身份" align="center" width="80">
          <template slot-scope="scope">
                          <el-switch v-model="row[scope.$index].Identity" @change="changeIdentity(scope.$index, scope.row)">
                          </el-switch>
                        </template>
        </el-table-column>
        <el-table-column prop="is_new" label="新品" align="center" width="80">
          <template slot-scope="scope">
              <el-switch v-model="row[scope.$index].is_new" @change="changeIsnew(scope.$index, scope.row)">
              </el-switch>
          </template>
        </el-table-column>

        <el-table-column prop="is_new" label="人气" align="center" width="80">
          <template slot-scope="scope">
                          <el-switch v-model="row[scope.$index].is_hot" @change="changeIshot(scope.$index, scope.row)">
                          </el-switch>
                        </template>
        </el-table-column>
        <el-table-column prop="is_show" label="上架" align="center" width="80">
          <template slot-scope="scope">
                          <el-switch v-model="row[scope.$index].is_on_sale" @change="changeIsonsale(scope.$index, scope.row)">
                          </el-switch>
                            <!-- {{ scope.row.is_on_sale == 1 ? '是' : '否' }} -->
                        </template>
        </el-table-column>
        <!-- <el-table-column prop="sort_order" label="排序" align="center" sortable width="90">
        </el-table-column> -->
        <el-table-column label="操作" width="140" fixed="right" align="center">
          <template slot-scope="scope">
                            <el-button size="small" style="float:left" @click="handleRowEdit(scope.$index, scope.row)">编辑</el-button>
                            <el-button size="small" style="float:right" type="danger" @click="handleRowDelete(scope.$index, scope.row)">删除</el-button>
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
import FileSaver from 'file-saver'
import XLSX from 'xlsx'
export default {
  data() {
    return {
      export_abled_button: false,
      click_row_index: 0,
      FirstClassifyList: [],
      FirstClassifyId: '',
      SecondClassifyList: [],
      SecondClassifyId: '',
      new_is_open: false,
      hot_is_open: false,
      sale_is_open: false,
      issearch: false, //是否处于搜索状态
      row: [],
      page: 1,
      total: 0,
      filterForm: {
        name: '',
        secondClassify: 0,
        isnew: 0,
        ishot: 0,
        issale: 0
      },
      tableData: []
    }
  },
  methods: {
    // 导出商品所有aku
    ExportExecle_SKU() {
      this.$confirm('是否确认导出为Excel表格 ?,( 此导出值包含商品所有的sku的商品名称，规格，售价 ) ', '提示', {
       confirmButtonText: '确定',
       cancelButtonText: '取消',
       type: 'warning'
     }).then(() => {
       this.axios.post('goodsUpdate/EXPORT_TO_EXLECE_GOODS_SKU',{

       }).then(res => {
         console.log(res);
         let info = res.data.data
         if (res.data.errno == 0) {
           this.export_abled_button = true
           this.loading_notify = this.$notify({
             title: '成功',
             message: '表格数据重组成功 ！ 正在导出 ！',
             type: 'success',
             duration: 0
           });
           setTimeout(() => {
             function formatJson(filterVal, jsonData) {
         　　　　return jsonData.map(v => filterVal.map(j => v[j]))
             }
             require.ensure([], () => { //require的路径因个人项目结构不同可能需要单独调整，请自行修改路径
   　　　　　　const { export_json_to_excel } = require('../../vendor/Export2Excel');
   　　　　　　const tHeader = ['商品名称','售价','成本价'];
   　　　　　　const filterVal = ['name','retail_price','cost_price'];
   　　　　　　const list = info;
   　　　　　　const data = formatJson(filterVal, list);
   　　　　　　export_json_to_excel(tHeader, data, '所有商品列表');
   　　　　})
             this.loading_notify.close()
             this.export_abled_button = false
             this.export_execle_popup = false
           },1000)
         }
       })
     }).catch(() => {
       this.$message({
         type: 'info',
         message: '取消导出 ！'
       });
     });
    },
    // 商品导出函数
    ExportExecle(){
      this.$confirm('是否确认导出为Excel表格 ?,( 此导出值包含商品名称,售价,成本价 ) ', '提示', {
       confirmButtonText: '确定',
       cancelButtonText: '取消',
       type: 'warning'
     }).then(() => {
       this.axios.post('goodsUpdate/EXPORT_TO_EXLECE_GOODS',{

       }).then(res => {
         console.log(res);
         let info = res.data.data
         if (res.data.errno == 0) {
           this.export_abled_button = true
           this.loading_notify = this.$notify({
             title: '成功',
             message: '表格数据重组成功 ！ 正在导出 ！',
             type: 'success',
             duration: 0
           });
           setTimeout(() => {
             function formatJson(filterVal, jsonData) {
         　　　　return jsonData.map(v => filterVal.map(j => v[j]))
             }
             require.ensure([], () => { //require的路径因个人项目结构不同可能需要单独调整，请自行修改路径
   　　　　　　const { export_json_to_excel } = require('../../vendor/Export2Excel');
   　　　　　　const tHeader = ['商品名称','售价','成本价'];
   　　　　　　const filterVal = ['name','retail_price','cost_price'];
   　　　　　　const list = info;
   　　　　　　const data = formatJson(filterVal, list);
   　　　　　　export_json_to_excel(tHeader, data, '所有商品列表');
   　　　　})
             this.loading_notify.close()
             this.export_abled_button = false
             this.export_execle_popup = false
           },1000)
         }
       })
     }).catch(() => {
       this.$message({
         type: 'info',
         message: '取消导出 ！'
       });
     });
    },
    // 以下为单元格双击事件、、、、、、、、、、、、、、、、、、
    edit_blur(){
      // console.log("123");
      let changed_info = this.tableData[this.click_row_index]
      console.log(changed_info);
      this.$confirm('此操作将永久修改此信息, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.axios.post('goods/changeinfo',{
            changed_info: changed_info
          }).then(res => {
            console.log(res);
          })
          this.getList()
          // this.tableData[this.click_row_index]
          this.$message({
            type: 'success',
            message: '修改成功 ！'
          });
        }).catch(() => {
          this.getList()
          this.$message({
            type: 'info',
            message: '取消修改 ！'
          });
        });

    },
    doubleclick(row, column, cell){
      console.log(row, column);
      for (var i = 0; i < this.row.length; i++) {
        if (this.row[i].id == row.id) {
          this.click_row_index = i
          if (column.label == '商品名称') {
            this.row[i].name_edit = true
          }else if(column.label == '成本价'){
            this.row[i].cost_price_edit = true
          }else if(column.label == '售价'){
            this.row[i].retail_price_edit = true
          }else if(column.label == '运费'){
            this.row[i].freight_edit = true
          }else if(column.label == '库存'){
            this.row[i].goods_number_edit = true
          }else if(column.label == '权重'){
            this.row[i].short_order_edit = true
          }
        }
      }
    },
    ///////////////////////////////////////////以下为分类改变事件
    //清空一级分类事件
    FirstClassifyClear() {
      setTimeout(() => {
        console.log("触发清空一级分类事件");
        this.SecondClassifyList = []
        this.FirstClassifyId = ''
        this.SecondClassifyId = ''
      },300)
      //注：延迟是因为清空一级分类也会导致一级分类改变从而搜索二级分类，所以要在搜索二级分类之后清空二级分类
    },
    //一级分类改变触发
    FirstClassifyChange(e) {
      // console.log(e);
      console.log('触发一级分类改变');
      this.FirstClassifyId = e
      this.is_classify_change = parseInt(this.is_classify_change) + 1
      //注: 因为页面刚展示也会触发一级分类改变事件，所以要判断一级分类改变过几次，若没有以下判断会导致刚进入时二级分类为空
      if (this.is_classify_change > 1) {
        this.SecondClassifyId = ''
      }
      this.axios.post('goodsUpdate/findGoodsClassifySecondById', {
        id: e
      }).then(res => {
        console.log(res);
        this.SecondClassifyList = res.data.data
      })
    },
    //二级分类改变事件
    SecondClassifyChange(e) {
      // console.log(e);
      console.log('触发二级分类改变');
      this.SecondClassifyId = e
      this.getList()
    },
    //获取一级分类列表
    findGoodsClassifyFirst() {
      this.axios.post('goodsUpdate/findGoodsClassifyFirst', {}).then(res => {
        console.log(res.data.data);
        this.FirstClassifyList = res.data.data
      })
    },
    ///////////////////////////////////////////////////以下为筛选事件
    new_is_open_change() {
      this.filterForm.isnew = this.new_is_open ? 1 : 0
      this.getList()
      // console.log(this.new_is_open_num);
    },
    hot_is_open_change() {
      this.filterForm.ishot = this.hot_is_open ? 1 : 0
      this.getList()
      // console.log(this.hot_is_open_num);
    },
    sale_is_open_change() {
      this.filterForm.issale = this.sale_is_open ? 1 : 0
      this.getList()
      // console.log(this.sale_is_open_num);
    },
    ///////////////////////////////////////////////////以下为乱七八糟事件
    show() {
      this.onSubmitFilter()
    },
    onClear() {
      this.issearch = false
      this.filterForm.name = ''
      // this.filterForm.name = ''
      // this.page = 1
      this.getList()
      // this.FirstCategoryName = ''
      // this.SecondCategoryName = ''
    },
    // firstCategorychange(item) {
    //   console.log(item);
    //   this.SecondCategoryName = ''
    //   this.axios.post('goods/secondCategory', {
    //     id: item
    //   }).then((res) => {
    //     console.log(res);
    //     this.SecondCategory = res.data.data
    //   })
    // },
    // secondCategorychange(item) {
    //   console.log(item);
    //   this.issearch = true
    //   this.SecondCategoryId = item
    //   this.getcatelist(item)
    // },
    // getcatelist(item) {
    //   this.axios.get('goods/findsecondgoods', {
    //     params: {
    //       page: this.page,
    //       id: item
    //     }
    //   }).then((res) => {
    //     console.log(res);
    //     this.tableData = res.data.data.data
    //     for (var i = 0; i < this.tableData.length; i++) {
    //       // array[i]
    //       let obj = {}
    //       obj.is_hot = this.tableData[i].is_hot == 1 ? true : false
    //       obj.is_new = this.tableData[i].is_new == 1 ? true : false
    //       obj.is_on_sale = this.tableData[i].is_on_sale == 1 ? true : false
    //       this.row.push(obj)
    //     }
    //     // console.log(this.row);
    //     // this.row.is_hot = response.data.data.data
    //     this.page = res.data.data.currentPage
    //     this.total = res.data.data.count
    //     // this.SecondCategory = res.data.data
    //   })
    // },
    /////////////////////////////////////////////////以下为表格选项改变事件
    changeIsnew(index, row) {
      console.log(index, row);
      this.$confirm('是否修改' + row.name + '的新品状态吗' + '?', '修改实时生效！', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.axios.post('goods/setisnew', {
          id: row.id,
          data: this.row[index].is_new ? 1 : 0
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
        this.row[index].is_new = !this.row[index].is_new
        this.$message({
          type: 'info',
          message: '已取消修改！'
        });
      });
    },
    changeIshot(index, row) {
      console.log(index, row);
      this.$confirm('是否修改' + row.name + '的人气状态吗' + '?', '修改实时生效！', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.axios.post('goods/setishot', {
          id: row.id,
          data: this.row[index].is_hot ? 1 : 0
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
        this.row[index].is_hot = !this.row[index].is_hot
        this.$message({
          type: 'info',
          message: '已取消修改！'
        });
      });
    },
    changeIsonsale(index, row) {
      console.log(index, row);
      this.$confirm('是否修改' + row.name + '的上架状态吗' + '?', '修改实时生效！', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.axios.post('goods/setisonsale', {
          id: row.id,
          data: this.row[index].is_on_sale ? 1 : 0
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
        this.row[index].is_on_sale = !this.row[index].is_on_sale
        this.$message({
          type: 'info',
          message: '已取消修改！'
        });
      });
    },
    changeIdentity(index, row){
      console.log(index, row);
      this.$confirm('是否修改' + row.name + '的身份信息状态吗' + '?', '修改实时生效！', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.axios.post('goods/setisIdentity', {
          id: row.id,
          data: this.row[index].Identity ? 1 : 0
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
        this.row[index].Identity = !this.row[index].Identity
        this.$message({
          type: 'info',
          message: '已取消修改！'
        });
      });
    },
    handlePageChange(val) {
      this.page = val;
      //保存到localStorage
      localStorage.setItem('Page', this.page)
      localStorage.setItem('FilterForm', JSON.stringify(this.filterForm));
      this.getList()
      // if (this.issearch == false) {
      //   this.getList()
      // } else {
      //   this.getcatelist(this.SecondCategoryId)
      // }
    },
    handleRowEdit(index, row) {
      // this.$router.push({
      //   name: 'goods_add',
      //   query: {
      //     id: row.id
      //   }
      // })GoodsUpdatePage
      this.$router.push({
        name: 'GoodsUpdatePage',
        query: {
          id: row.id
        }
      })
    },
    handleRowDelete(index, row) {
      this.$confirm('确定要删除?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.axios.post('goods/destory', {
          id: row.id
        }).then((response) => {
          console.log(response.data)
          if (response.data.errno === 0) {
            this.$message({
              type: 'success',
              message: '删除成功!'
            });
            this.getList();
          }
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '取消删除！'
        });
      });
    },
    ///////////////////////////////////////////////////////以下为全局方法
    onSubmitFilter() {
      this.page = 1
      this.getList()
    },
    getList() {
      // if (this.SecondClassifyId == '') {
      //
      // }
      this.filterForm.secondClassify = this.SecondClassifyId == '' ? 0 : this.SecondClassifyId
      // console.log(this.filterForm);
      // console.log(this.filterForm.isnew);
      // console.log(this.filterForm.ishot);
      // console.log(this.filterForm.issale);
      this.axios.post('goods/index', {
          page: this.page,
          name: this.filterForm.name,
          SecondClassifyId: this.filterForm.secondClassify,
          isnew: this.filterForm.isnew,
          ishot: this.filterForm.ishot,
          issale: this.filterForm.issale
      }).then((res) => {
        console.log(res);
        this.tableData = res.data.data.data
        this.row = []
        for (var i = 0; i < this.tableData.length; i++) {
          // array[i]
          let obj = {}
          obj.id = this.tableData[i].id
          obj.add_localtime = this.timestampToTime(this.tableData[i].add_time)
          obj.is_hot = this.tableData[i].is_hot == 1 ? true : false
          obj.is_new = this.tableData[i].is_new == 1 ? true : false
          obj.is_on_sale = this.tableData[i].is_on_sale == 1 ? true : false
          obj.Identity = this.tableData[i].Identity == 1 ? true : false
          obj.name_edit = false
          obj.cost_price_edit = false
          obj.retail_price_edit = false
          obj.freight_edit = false
          obj.goods_number_edit = false
          obj.short_order_edit = false
          this.row.push(obj)
        }
        // console.log(this.row);
        // this.row.is_hot = res.data.data.data
        this.page = res.data.data.currentPage
        this.total = res.data.data.count
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
  },
  components: {

  },
  mounted() {
    this.findGoodsClassifyFirst()
    this.getList();

  }
}
</script>

<style >
.bold_text {
  font-weight: bold;
  color: #ff5566
}
.table_box_name_edit {
  margin: 0px 8px;
}
.table_box_name {
  /* border: 1px solid black; */
  margin: 0px 8px;
  line-height: 18px;
  max-height: 36px;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;

}
.table_box {
  /* border: 1px solid black; */
  display: flex;
  justify-content: flex-start;
  align-items: center;
  margin: 3px 0px;
}
.table_box_img {
  width: 60px;
  height: 60px;
  /* margin-top: 3.5px; */
}
</style>
