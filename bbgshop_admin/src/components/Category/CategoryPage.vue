<template>
	<div class="content-page">
		<div class="content-nav">
			<el-breadcrumb class="breadcrumb" separator="/">
				<el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
				<el-breadcrumb-item>商品管理</el-breadcrumb-item>
				<el-breadcrumb-item>商品分类</el-breadcrumb-item>
			</el-breadcrumb>
			<div class="operation-nav">
				<router-link to="/dashboard/CategoryUpdatePage">
					<el-button type="primary" icon="plus">添加分类</el-button>
				</router-link>
			</div>
		</div>
		<div class="content-main">
			<div class="form-table-box">
				<el-tree
				  :data="treeData"
				  :props="defaultProps"
					node-key="id"
				  accordion
					:render-content="renderContent">
				</el-tree>
				<div class="tips">
					来来来 看这里 拿小本本记下来, 请务必注意,
					<span style="color:#ff6666;font-weight:bold">顶级分类下务必至少要有一个启用的对应的二级分类 ！</span>
					否则会导致很严重的后果 ！
				</div>
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
        filterForm: {
          name: ''
        },
				defaultProps: {
					children: 'children',
					label: 'label',
				},
				treeData: [],
        tableData: []
      }
    },
    methods: {
			renderContent(h, { node, data, store }) {
        return (
          <span>
            <span>
							<span style="font-size:14px;">{node.label}</span>
							<span style="font-size:10px;color:#757575;padding-left:15px;">Order_{data.sort_order}</span>
              <span style="font-size:10px;color:#757575;padding-left:15px;">{data.is_show == 0 ? '未启用' : '已启用'}</span>
            </span>
            <span style="float: right; margin-right: 20px">
              <el-button size="small" on-click={ () => this.handleRowEdit(store, data) }>编辑</el-button>
              <el-button size="small" type="danger" on-click={ () => this.handleRowDelete(store, data) }>删除</el-button>
            </span>
          </span>);
      },
      handlePageChange(val) {
        this.page = val;
        //保存到localStorage
        localStorage.setItem('brandPage', this.page)
        localStorage.setItem('brandFilterForm', JSON.stringify(this.filterForm));
        this.getList()
      },
      handleRowEdit(store, data) {
        this.$router.push({ name: 'CategoryUpdatePage', query: { id: data.id } })
      },
      handleRowDelete(store, data) {
        this.$confirm('确定要删除?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.axios.post('category/destory', { id: data.id }).then((response) => {
            console.log(response.data)
            if (response.data.errno === 0) {
              this.$message({
                type: 'success',
                message: '删除成功 !'
              });
							store.remove(data);
              // this.getList();
            }
          })
        }).catch(() => {
					this.$message({
						type: 'info',
						message: '取消删除 !'
					});
				});
      },
      onSubmitFilter() {
        this.page = 1
        this.getList()
      },
      getList() {
        this.axios.get('category', {
          params: {
            page: this.page,
            name: this.filterForm.name
          }
        }).then((response) => {
					console.log(response);
          this.tableData = response.data.data
					this.datareload()
        })
      },
			datareload() {
				for (var i = 0; i < this.tableData.length; i++) {
					if (this.tableData[i].parent_id == 0) {
						// console.log(this.tableData[i].name);
						let obj = {}
						let children = []
						obj.label = this.tableData[i].name
						obj.id = this.tableData[i].id
						obj.sort_order = this.tableData[i].sort_order
						obj.is_show = this.tableData[i].is_show
						for (var j = 0; j < this.tableData.length; j++) {
							let childer = []
							if (this.tableData[j].parent_id !== 0 && this.tableData[j].parent_id == this.tableData[i].id) {
								let list = {}
								list.label = this.tableData[j].name
								list.id = this.tableData[j].id
								list.sort_order = this.tableData[j].sort_order
								list.is_show = this.tableData[j].is_show
								children.push(list)
							}
						}
						obj.children = children
						this.treeData.push(obj)
					}
				}
				console.log(this.treeData);
			},
    },
    components: {

    },
    mounted() {

      this.getList();
    }
  }

</script>

<style scoped>
.tips {
	text-align: center;
	padding-top: 20px;
	color: #757575;
	font-size: 16px;
}
.sub-category .el-table__expanded-cell{
	padding: 0;
}
</style>
