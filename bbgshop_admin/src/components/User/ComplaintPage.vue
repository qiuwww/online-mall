<template lang="html">
<div class="ComplaintPage">
  <div class="content-page">
		<div class="content-nav">
			<el-breadcrumb class="breadcrumb" separator="/">
				<el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
				<el-breadcrumb-item>用户管理</el-breadcrumb-item>
				<el-breadcrumb-item>用户反馈</el-breadcrumb-item>
			</el-breadcrumb>
		</div>
		<div class="content-main">
      <div class="filter-box">
				<el-form :inline="true" :model="filterForm" class="demo-form-inline">
					<el-form-item label="用户昵称">
						<el-input v-model="filterForm.name" placeholder="用户昵称"></el-input>
					</el-form-item>
					<el-form-item>
						<el-button type="primary" @click="onSubmitFilter">查询</el-button>
					</el-form-item>
				</el-form>
			</div>
      <div class="form-table-box">
        <el-table :data="tableData" style="width: 100%" :default-sort = "{prop: 'date', order: 'descending'}" border stripe header-align="center">
          <el-table-column prop="id" label="ID" width="90" sortable align="center" >
          </el-table-column>
          <!-- <el-table-column prop="username" label="会员名称">
          </el-table-column> -->
          <el-table-column prop="user_name" label="用户呢称" width="110" align="center">
          </el-table-column>
          <el-table-column prop="msg_type" label="反馈类型" sortable width="120" align="center" >
          </el-table-column>
          <!-- <el-table-column prop="gender" label="性别" width="70">
            <template scope="scope">
              {{ scope.row.gender == 0 ? '女' : '男' }}
            </template>
          </el-table-column> -->
          <el-table-column prop="msg_content" label="反馈内容">
          </el-table-column>
          <el-table-column prop="msg_time" label="反馈时间" sortable width="170" align="center">
          </el-table-column>
          <el-table-column prop="user_mobile" label="手机号" width="130" align="center">
          </el-table-column>
          <el-table-column label="操作" width="80" align="center">
            <template slot-scope="scope">
              <!--<el-button size="small" @click="handleRowEdit(scope.$index, scope.row)">编辑</el-button>-->
              <el-button size="small" type="danger" @click="handleRowDelete(scope.$index, scope.row)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
      <div class="page-box">
        <el-pagination @current-change="handlePageChange" :current-page="page" :page-size="10" layout="total, prev, pager, next, jumper" :total="total">
        </el-pagination>
      </div>
      <!-- <el-card class="box-card" v-for="item in FeedBackData" :key="item.msg_id">
        <div slot="header" class="clearfix">
          <span>{{item.user_id}}</span>
          <el-button style="float: right; padding: 3px 0" type="text">操作按钮</el-button>
        </div>
        <div class="text item">
          {{item.msg_content}}
        </div>
        <div class="text item">
          {{item.msg_content}}
        </div>
      </el-card> -->


			<!-- <div class="filter-box">
				<el-form :inline="true" :model="filterForm" class="demo-form-inline">
					<el-form-item label="会员名称">
						<el-input v-model="filterForm.name" placeholder="会员名称"></el-input>
					</el-form-item>
					<el-form-item>
						<el-button type="primary" @click="onSubmitFilter">查询</el-button>
					</el-form-item>
				</el-form>
			</div> -->
		</div>
	</div>
</div>
</template>

<script>
export default {
  name:'ComplaintPage',
  data(){
    return {
      page: 1,
			total: 0,
      filterForm: {
				name: ''
			},
      // FeedBackData:[],
      tableData: [],
    }
  },
  methods:{
    handleRowDelete(index, row) {

			this.$confirm('确定要删除?', '提示', {
				confirmButtonText: '确定',
				cancelButtonText: '取消',
				type: 'warning'
			}).then(() => {

				this.axios.post('user/delfeedback', { id: row.id }).then((response) => {
					console.log(response.data)
					if (response.data.errno === 0) {
						this.$message({
							type: 'success',
							message: '删除成功!'
						});
						this.getList();
					}
				})
			})
      .catch(() => { })
		},
    handlePageChange(val) {
			this.page = val;
			//保存到localStorage
			localStorage.setItem('userPage', this.page)
			// localStorage.setItem('userFilterForm', JSON.stringify(this.filterForm));
			this.getList()
		},
    getList() {
      this.axios.get('user/feedback',{
        params: {
					page: this.page,
					name: this.filterForm.name
				}
      }).then((res) => {
        console.log(res);
        this.tableData = res.data.data.data
        this.page = res.data.data.currentPage
        this.total = res.data.data.count
      })
		},
    onSubmitFilter() {
      this.page = 1
      this.getList()
    },
  },
  mounted(){
    this.getList()
    // this.axios.post('user/feedback').then((res) => {
    //   console.log(res);
    //   this.tableData = res.data.data
    // })
  },

}
</script>

<style lang="css">
</style>
