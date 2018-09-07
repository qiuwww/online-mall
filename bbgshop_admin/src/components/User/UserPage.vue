<template>
	<div class="content-page">
		<div class="content-nav">
			<el-breadcrumb class="breadcrumb" separator="/">
				<el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
				<el-breadcrumb-item>商品管理</el-breadcrumb-item>
				<el-breadcrumb-item>会员列表</el-breadcrumb-item>
			</el-breadcrumb>
			<div class="operation-nav">
				<router-link to="/dashboard/user/add">
					<!--<el-button type="primary" icon="plus">添加会员</el-button>-->
				</router-link>
			</div>
		</div>
		<div class="content-main">
			<div class="filter-box" style="float:left;">
				<el-form :inline="true" :model="filterForm" class="demo-form-inline">
					<el-form-item label="用户名称">
						<el-input v-model="filterForm.name" placeholder="用户名称"></el-input>
					</el-form-item>
					<el-form-item>
						<el-button type="primary" @click="onSubmitFilter">查询</el-button>
					</el-form-item>
				</el-form>
			</div>
			<div class="filter-box" style="float:right;" v-if="CorporateName == 'dw'">
				<el-button type="primary" @click="user_level_config">会员等级设置</el-button>
	    </div>
			<div class="form-table-box">
				<el-table :data="tableData" :default-sort = "{prop: 'date', order: 'descending'}" style="width: 100%" border stripe>
					<el-table-column prop="id" label="ID" width="90" sortable align="center">
					</el-table-column>
					<el-table-column prop="nickname" label="呢称" align="center">
					</el-table-column>
					<!-- <el-table-column prop="weixin_openid" label="OpenId"  align="center">
					</el-table-column> -->
					<!-- <el-table-column prop="gender" label="性别" sortable width="90" align="center">
						<template slot-scope="scope">
							{{ scope.row.gender == 0 ? '女' : '男' }}
						</template>
					</el-table-column> -->
					<el-table-column label="手机号" sortable align="center">
						<template slot-scope="scope">
							<el-tooltip placement="right">
								<div slot="content">
								  {{tableData[scope.$index].mobile_country_e}} - {{tableData[scope.$index].mobile_country}}  +{{tableData[scope.$index].mobile_code}}
								</div>
								<div>{{tableData[scope.$index].mobile}}</div>
							</el-tooltip>
						</template>
					</el-table-column>
					</el-table-column>
					<el-table-column prop="register_localtime" label="注册时间" sortable width="180" align="center">
					</el-table-column>
					<el-table-column prop="last_login_localtime" label="最后登录时间" sortable width="180" align="center">
					</el-table-column>
					<!-- <el-table-column prop="integral" label="积分" width="130" sortable align="center">
					</el-table-column> -->
					<el-table-column label="等级" width="130" sortable align="center" v-if="CorporateName == 'dw'">
						<template slot-scope="scope">
							<el-tooltip placement="right">
							  <div slot="content">
									<el-button size="small" type="primary" @click="handlePointLevel(scope.$index, scope.row)">指定用户等级</el-button>
							  </div>
							  <div>L{{tableData[scope.$index].user_level}}</div>
							</el-tooltip>
						</template>
					</el-table-column>
					<el-table-column label="固定等级" width="120" sortable align="center" v-if="CorporateName == 'dw'">
						<template slot-scope="scope">
							<!-- <el-tooltip placement="right">
							  <div slot="content">
									固定用户等级是为了让某些指定用户的等级不随等级列表的改变而改变，选中固定等级立即生效，取消固定等级在第二天凌晨生效
							  </div> -->
								<el-switch v-model="inforow[scope.$index].isfockers" @change="changeLevelFockers(scope.$index, scope.row)"></el-switch>
							<!-- </el-tooltip> -->
						</template>
					</el-table-column>
					<el-table-column prop="user_all_price" label="总消费" width="130" sortable align="center">
					</el-table-column>
					<el-table-column prop="user_discount" label="折扣" width="130" sortable align="center" v-if="CorporateName == 'dw'">
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
		</div>
		<van-popup class="selectpopup" v-model="showSelectPopup">
			<div class="selectpopup_top">
				<div class="selectpopup_right">
					<div class="selectpopup_right_top">
						会员等级设置
						<!-- <span class="small">(主动充值)</span> -->
					</div>
					<div class="selectpopup_right_middle">
						<el-radio-group v-model="level_rule" size="medium" @change="level_rule_change">
				      <el-radio-button :label="0">使用金额充值</el-radio-button>
				      <el-radio-button :label="1">使用累计消费</el-radio-button>
				      <el-radio-button :label="2">同时使用，满足其一即可</el-radio-button>
				    </el-radio-group>
					</div>
					<el-table class="selectpopup_right_table"
					:data="levelData" border style="width: 100%">
						<el-table-column label="等级名" align="center">
							<template slot-scope="scope">
								<div class="" v-if="!row[scope.$index].btntype">
									{{levelData[scope.$index].name}}
								</div>
								<el-input class="" v-if="row[scope.$index].btntype" v-model="levelData[scope.$index].name">
								</el-input>
							</template>
						</el-table-column>
						<el-table-column label="等级值" align="center">
							<template slot-scope="scope">
									{{scope.$index}}
							</template>
						</el-table-column>
						<el-table-column label="充值金额" align="center" v-if="level_rule == 0 || level_rule == 2">
							<template slot-scope="scope">
								<div class="" v-if="!row[scope.$index].btntype">
									{{levelData[scope.$index].recharge_monery}}
								</div>
								<el-input class="" v-if="row[scope.$index].btntype" v-model="levelData[scope.$index].recharge_monery">
								</el-input>
							</template>
						</el-table-column>
						<el-table-column label="消费金额" align="center"  v-if="level_rule == 1 || level_rule == 2">
							<template slot-scope="scope">
								<div class="" v-if="!row[scope.$index].btntype">
									{{levelData[scope.$index].consumption_monery}}
								</div>
								<el-input class="" v-if="row[scope.$index].btntype" v-model="levelData[scope.$index].consumption_monery">
								</el-input>
							</template>
						</el-table-column>
						<el-table-column label="折扣" align="center">
							<template slot-scope="scope">
								<div class="" v-if="!row[scope.$index].btntype">
									{{levelData[scope.$index].discount_scale}}
								</div>
								<el-input class="" v-if="row[scope.$index].btntype" v-model="levelData[scope.$index].discount_scale">
								</el-input>
							</template>
						</el-table-column>
						<el-table-column prop="action" align="center" label="操作" width="150">
							<template slot-scope="scope">
									<el-button size="small" v-if="!row[scope.$index].btntype"
									@click="handleEditGoods(scope.$index, scope.row)">编辑</el-button>
									<el-button size="small" v-if="row[scope.$index].btntype"
									@click="handleCanelGoods(scope.$index, scope.row)">取消</el-button>
									<el-button size="small" type="primary" v-if="row[scope.$index].btntype"
									@click="handleSureGoods(scope.$index, scope.row)">完成</el-button>
									<el-button size="small" type="danger" v-if="!row[scope.$index].btntype"
									@click="handleDelGoods(scope.$index, scope.row)">删除</el-button>

							</template>
						</el-table-column>
					</el-table>
					<el-button size="small" type="primary" style="float:right;margin-top:5px;margin-right:20px;"
					@click="handleAddLevelGoods">添加等级</el-button>
				</div>
			</div>
			<div class="selectpopup_bottom_left">

			</div>
		</van-popup>
		<!-- ////////////////////////////////////////////////////////指定用户等级 -->
		<van-popup class="PointUserLevelPopover" @click-overlay="closepointuserlevelpopup" v-model="show_pointuserlevel_popup">
			<div class="PointUserLevelPopover_title">
				指定用户等级
			</div>
			<div class="PointUserLevelPopover_user_info">
				<div class="PointUserLevelPopover_user_info_left">选中用户</div>
				<div class="PointUserLevelPopover_user_info_right">{{select_user_info.nickname}}</div>
			</div>
			<div class="PointUserLevelPopover_user_info">
				<div class="PointUserLevelPopover_user_info_left">用户当前等级</div>
				<div class="PointUserLevelPopover_user_info_right">LV {{select_user_info.user_level}}</div>
			</div>
			<div class="PointUserLevelPopover_user_info point">
				<div class="PointUserLevelPopover_user_info_left border">
					指定用户的等级
				</div>
				<div class="PointUserLevelPopover_user_info_right border">
					<el-radio-group v-model="level_select" @change="level_select_change">
				    <el-radio v-for="item in levelData" :label="item.id" :key="item.id">{{item.name}}</el-radio>
				  </el-radio-group>
				</div>

			</div>
			<div class="PointUserLevelPopover_user_info">
				<div class="PointUserLevelPopover_user_info_left">用户即将生效的折扣</div>
				<div class="PointUserLevelPopover_user_info_right">{{select_user_level.discount_scale}}</div>
			</div>
			<div class="tips">
				注: 指定了用户等级的用户的等级不会随等级列表的改变而改变，类似于永久指定了用户的等级，
				而用户的折扣将<span style="color:#ff6666;font-weight:bold" > 永远为设置时的折扣 </span>
				 ！直到您取消该用户的固定等级或重新设置固定等级对应的折扣 ！
			</div>
			<div class="tips">
				再注: 设置指定用户的等级操作为<span style="color:#ff6f00;font-weight:bold"> 立即生效 </span>，
				这意味着您需要谨慎操作 ！而取消固定等级将在<span style="color:#ff6f00;font-weight:bold"> 次日凌晨生效 </span>，
				并且当前用户的等级将开始按照等级列表逻辑<span style="color:#ff6666;font-weight:bold"> 重新分配等级 </span> ！
			</div>
			<div class="tips">
				再再注: 指定用户等级不会影响用户的累计消费和累计充值 ！但累计消费和累计充值的数值将会影响用户
				<span style="color:#ff6666;font-weight:bold"> 重新分配等级 </span> ！
			</div>
			<div class="PointUserLevelPopover_btn">
				<el-button type="text"  @click="closepointuserlevelpopup">取消</el-button>
				<el-button type="danger"  @click="pointuserlevelSure">确定</el-button>
			</div>
		</van-popup>
	</div>
</template>

<script>
import { Toast } from 'vant'
import api from '@/config/api';
export default {
	data() {
		return {
			level_select: '',//指定用户等级默认选项
			// levelData: [],//等级列表
			page: 1,
			total: 0,
			level_rule: '',
			// radio_recharge: 0,
			// radio_consumption: 0,
			// radio_consumption_and_recharge: 1,
			show_pointuserlevel_popup: false,
			showSelectPopup: false,
			// selectMenuIndex: 1,
			filterForm: {
				name: ''
			},
			levelData: [],
			tableData: [],
			row: [],
			inforow: [],
			level_index: 0,
			select_user_info: {},
			select_user_level: {},
			rule_changed: 0,
			CorporateName: '',
		}
	},
	methods: {
		//修改固定等级
		changeLevelFockers(index,row){
			this.$confirm('是否修改' + row.nickname + '的固定等级吗' + '?', '修改将在第二天凌晨生效！', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.axios.post('user/setisfockers', {
          id: row.id,
          data: this.inforow[index].isfockers ? 1 : 0
        }).then((response) => {
          console.log(response.data)
          if (response.data.errno === 0) {
            this.$message({
              type: 'success',
              message: '修改成功!'
            });
						this.getList()
          }
        })
      }).catch(() => {
        this.inforow[index].isfockers = !this.inforow[index].isfockers
        this.$message({
          type: 'info',
          message: '已取消修改！'
        });
      });
		},
		//储存指定用户的等级
		pointuserlevelSure() {
			this.axios.post("user/setPointLevel",{
				dis: this.select_user_level.discount_scale,
				level: this.level_index,
				userid: this.select_user_info.id,
				levelname: this.levelData[this.level_index].name
			}).then(res => {
				console.log(res);
				if (res.data.errno == 0) {
					this.$message({
						type: 'success',
						message: '修改成功 !'
					});
					this.getList()
					this.closepointuserlevelpopup()
				}
			})
		},
		//修改指定用户等级select
		level_select_change(e){
			console.log(e);
			console.log(this.levelData);
			for (var i = 0; i < this.levelData.length; i++) {
				// if (e !== 0) {
					if (e !== 0 && (e == this.levelData[i].id)) {
						this.select_user_level = this.levelData[i]
						this.level_index = i
					}
				// }

			}
		},
		// //确定指定用户等级弹层
		// pointuserlevelSure(){
		//
		// },
		//取消指定用户等级弹层
		closepointuserlevelpopup() {
			this.show_pointuserlevel_popup = false
		},
		//显示指定用户等级的弹层
		handlePointLevel(index,row){
			this.select_user_info = row
			this.axios.post('user/getuserlevel').then(res => {
				console.log(res);
				if (res.data.errno === 0) {
					this.levelData = res.data.data.data
					// console.log(this.levelData[this.select_user_info.user_level - 1]);
					this.level_select = this.select_user_info.user_level - 1 >= 0 ? this.levelData[this.select_user_info.user_level - 1].id : ''
					this.select_user_level = this.select_user_info.user_level - 1 >= 0 ? this.levelData[this.select_user_info.user_level - 1] : 0
					// for (var i = 0; i < this.levelData.length; i++) {
					// 	// level_select
					// 	if (this.levelData.id == this.select_user_info.user_level) {
					//
					// 	}
					// }
					// this.level_rule = res.data.data.rules[0].type
					// console.log(res.data.data.rules[0].type);
					// console.log(this.level_rule);
					// for (var i = 0; i < res.data.data.data.length; i++) {
					// 	// let btntype = false
					// 	let obj = {}
					// 	obj.btntype = false
					// 	this.row.push(obj)
					// }
				}
			})
			this.show_pointuserlevel_popup = true
		},
		level_rule_change(e){
			// console.log(e);
			this.axios.post('user/setlevelrules',{
				e: e
			}).then(res => {
				console.log(res);
				if (res.data.errno === 0) {
					if (this.rule_changed > 0) {
						Toast('修改已生效 ！')
					}
					this.user_level_config();
					this.rule_changed = this.rule_changed + 1
				}
			})
			this.level_rule = e
		},
		//////////////////////////////////////////用户等级设置
		/////////////取消等级
		handleCanelGoods(index,row){
			console.log(index);
			if (row.id) {
				this.row[index].btntype = false
			}else {
				// console.log('13216548978');
				this.levelData.splice(index, 1)
				this.row.splice(index, 1)
				// this.user_level_config();
			}
		},
		////////////删除等级
		handleDelGoods(index,row) {
			if (row.id) {
				console.log('原有');
				// this.$confirm('此操作将删除该信息, 是否继续?', '提示', {
        //   confirmButtonText: '确定',
        //   cancelButtonText: '取消',
        //   type: 'warning'
        // }).then(() => {
					this.axios.post('user/dellevelinfo',{
						id: row.id
					}).then(res => {
						console.log(res);
						if (res.data.errno === 0) {
							this.$message({
								type: 'success',
								message: '删除成功 !'
							});
							this.levelData.splice(index, 1)
							this.row.splice(index, 1)
							this.user_level_config();
						}
					// })

        // }).catch(() => {
        //   this.$message({
        //     type: 'info',
        //     message: '取消删除 !'
        //   });
        });
			}else {
				console.log('新增');
				this.levelData.splice(index, 1)
				this.row.splice(index, 1)
			}
		},
		////////////添加等级
		handleAddLevelGoods() {
				let obj = {}
				obj.name = ''
				obj.level = 0
				obj.recharge_monery = 0
				obj.consumption_monery = 0
				obj.discount_scale = 0
				this.levelData.push(obj)
				let objj = {}
				objj.btntype = true
				this.row.push(objj)
				console.log(this.row);
		},
		//开启编辑
		handleEditGoods(index,row){
			this.row[index].btntype = true
		},
		handleSureGoods(index,row){
			if (this.level_rule == 0 && (row.name == '' || Number(row.recharge_monery) == 0 ||  Number(row.discount_scale) == 0)) {
				this.$message({
	         type: 'info',
	         message: '信息不完整 !'
	       });
				 Toast('信息不完整 !')
				 return false
			}
			if (this.level_rule == 1 && (row.name == '' || Number(row.consumption_monery) == 0 || Number(row.discount_scale) == 0)) {
				this.$message({
	         type: 'info',
	         message: '信息不完整 !'
	       });
				 Toast('信息不完整 !')
				 return false
			}
			if (this.level_rule == 2 && (row.name == '' || Number(row.recharge_monery) == 0 || Number(row.consumption_monery) == 0 || Number(row.discount_scale) == 0)) {
				this.$message({
	         type: 'info',
	         message: '信息不完整 !'
	       });
				 Toast('信息不完整 !')
				 return false
			}
			if (Number(row.recharge_monery) < 0 || Number(row.consumption_monery) < 0 || Number(row.discount_scale) < 0 || Number(row.discount_scale) > 10) {
				this.$message({
	         type: 'info',
	         message: '金额比例不正确 !'
	       });
				 Toast('金额比例不正确 !')
				 return false
			}
			this.axios.post('user/adduserlevel',{
				info: this.levelData[index]
			}).then(res => {
				console.log(res);
				if (res.data.errno === 0) {
					this.$message({
						type: 'success',
						message: '添加成功 !'
					});
					let id = res.data.data
					this.levelData[index].id = id
					this.user_level_config();
				}
			})
			this.row[index].btntype = false

		},
		user_level_config() {
			this.axios.post('user/getuserlevel').then(res => {
				console.log(res);
				if (res.data.errno === 0) {
					this.levelData = res.data.data.data
					this.level_rule = res.data.data.rules[0].type
					// console.log(res.data.data.rules[0].type);
					// console.log(this.level_rule);
					for (var i = 0; i < res.data.data.data.length; i++) {
						// let btntype = false
						let obj = {}
						obj.btntype = false
						this.row.push(obj)
					}
				}
			})
			this.showSelectPopup = true
		},
		handlePageChange(val) {
			this.page = val;
			//保存到localStorage
			localStorage.setItem('userPage', this.page)
			localStorage.setItem('userFilterForm', JSON.stringify(this.filterForm));
			this.getList()
		},
		handleRowEdit(index, row) {
			this.$router.push({ name: 'user_add', query: { id: row.id } })
		},
		handleRowDelete(index, row) {

			this.$confirm('确定要删除?', '提示', {
				confirmButtonText: '确定',
				cancelButtonText: '取消',
				type: 'warning'
			}).then(() => {

				this.axios.post('user/destory', { id: row.id }).then((response) => {
					console.log(response.data)
					if (response.data.errno === 0) {
						this.$message({
							type: 'success',
							message: '删除成功!'
						});

						this.getList();
					}
				})


			});
		},
		onSubmitFilter() {
			this.page = 1
			this.getList()
		},
		getList() {
			this.axios.get('user', {
				params: {
					page: this.page,
					name: this.filterForm.name
				}
			}).then((response) => {
				console.log(response);
        this.tableData = response.data.data.data
				this.inforow = []
				for (var i = 0; i < this.tableData.length; i++) {
					this.tableData[i].register_localtime = this.timestampToTime(this.tableData[i].register_time)
					this.tableData[i].last_login_localtime = this.timestampToTime(this.tableData[i].last_login_time)
					let obj = {}
					obj.isfockers = this.tableData[i].user_level_is_fockers == 0 ? false : true
					this.inforow.push(obj)
				}
        this.page = response.data.data.currentPage
        this.total = response.data.data.count
			})
		},
		timestampToTime(timestamp) {
        var date = new Date(timestamp * 1000);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
				var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + '  ';
				var h = (date.getHours() < 10 ? '0'+date.getHours() : date.getHours()) + ':';
				var m = (date.getMinutes() < 10 ? '0'+date.getMinutes() : date.getMinutes()) + ':';
        var s = (date.getSeconds() < 10 ? '0'+date.getSeconds() : date.getSeconds());
        return Y+M+D+h+m+s;
    }
	},
	components: {

	},
	mounted() {
		this.CorporateName = api.CorporateName
		this.getList();
	}
}

</script>

<style scoped>
.tips {
	text-align: left;
	font-size: 0.75rem;
	width: 90%;
	margin: 10px auto;
	text-indent: 1.25rem;
	letter-spacing: 0.2px;
	/* color: #757575 */
}
.PointUserLevelPopover_user_info_left.border {
	height: 120px;
}
.PointUserLevelPopover_user_info_right.border {
	/* border: 1px solid black; */
	height: 120px;
	width: 100px;
	/* margin-left: 10px; */
	/* display: flex; */
	/* justify-content: center; */
	/* align-items: center; */
	overflow-y: auto;
}
.PointUserLevelPopover_user_info.point {
	margin-bottom: 12px;
	/* border: 1px solid black; */
	height: 120px;
}
.PointUserLevelPopover_user_info_left {
	float: left;
}
.PointUserLevelPopover_user_info_right {
	float: right;
	color: #ff5566;
	font-weight: bold;
}
.PointUserLevelPopover_user_info {
	width: 90%;
	margin: 0 auto;
	height: 32px;
	/* border: 1px solid black; */
	color: #757575;
	font-size: 14px;

}
.PointUserLevelPopover_btn {
  /* text-align: right; */
  /* border:1px solid black; */
  height: 50px;
  width: 90%;
  margin: 20px auto;
  margin-bottom: 10px;
  display: flex;
  justify-content: flex-end;
  align-items: center;
}
.PointUserLevelPopover_from {
  /* border:1px solid black; */
  width: 80%;
  margin: 50px auto;
}
.PointUserLevelPopover_title {
  margin: 10px 20px;
  /* border:1px solid black; */
  text-align: center;
  font-size: 20px;
  padding: 10px 0px;
  border-bottom: 1px solid #eee;

}
.PointUserLevelPopover {
  width: 800px;
  /* height: 300px; */
  border-radius: 5px;
}

.selectpopup_right_middle {
	/* border:1px solid black; */
	text-align: right;
	padding-right: 10px;
	height: 40px;
	line-height: 40px;
	font-size: 14px;
	color: #666;
	margin-bottom: 3px;
	margin-top: 3px;
}
.selectpopup_right_table {
	/* border: 1px solid black; */
	max-height: 395px;
	overflow-y: auto;
}
.selectpopup_right_top .small {
	color: #757575;
	font-size: 14px;
}
.selectpopup_right_top {
	/* border:1px solid black; */
	height: 32px;
	text-align: center;
	line-height: 32px;
	margin: 0px 15px;
	font-size: 20px;
	border-bottom: 1px solid #f4f4f4;
	padding: 10px 0px;
	padding-top: 18px;
}
.selectpopup_right {
	background: #eee;
	/* border:1px solid black; */
	width: 100%;
	height: 100%;
}
.selectpopup_top {
	/* border:1px solid black; */
	width: 100%;
	height: 90%;
}
.selectpopup {
	width: 800px;
	height: 600px;
}
</style>
