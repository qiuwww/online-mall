<template lang="html">
  <div class="content-page">
      <div class="content-nav">
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>店铺管理</el-breadcrumb-item>
              <el-breadcrumb-item>关键词设置</el-breadcrumb-item>
          </el-breadcrumb>
          <div class="operation-nav">
            <el-button type="primary" icon="plus" @click="addkeybtn">添加关键词</el-button>
          </div>
      </div>
      <div class="content-page">
        <el-card class="border_card" v-for="item in info_list" :key="item.id">
          <!-- <el-tooltip class="item" effect="dark" placement="top">
            <div slot="content">

            </div>
            <div class="one_row_overflow"> -->
            <div :class="item.is_hot == 1 ? 'border':''">
              {{item.keyword}}
            </div>
            <div class="action_btn_area">
              <el-button size="mini" @click="handleRowDelete(item)">删除</el-button>
              <el-button size="mini" type='primary' @click="handleEdit(item)">编辑</el-button>
            </div>
            <!-- </div>
          </el-tooltip> -->
        </el-card>
      </div>
      <!-- ////////////////////////////////////////////////////////添加关键词弹层 -->
      <van-popup class="addkeyPopover" @click-overlay="closekeypopup" v-model="show_key_popup">
        <div class="addkeyPopover_title">
          添加关键词
          <!-- {{abc}} -->
        </div>
        <div class="addkeyPopover_from">
          <el-form label-width="120px" :model="formLabelAlign">
            <el-form-item label="关键词">
              <el-input v-model="formLabelAlign.keywords"></el-input>
            </el-form-item>
            <el-form-item label="热门">
              <el-switch v-model="row.is_hot" ></el-switch>
              <!-- <el-input v-model="formLabelAlign.hot"></el-input> -->
            </el-form-item>
          </el-form>
        </div>
        <div class="addkeyPopover_btn">
          <el-button type="text"  @click="closekeypopup">取消</el-button>
          <el-button type="danger"  @click="addkeySure">确定</el-button>
        </div>
      </van-popup>
    </div>
</template>
<script>
export default {
  data () {
    return {
      info_list: [],
      show_key_popup: false,
      row: {
        is_hot: 0
      },
      formLabelAlign: {
        keywords: '',
        id: '',
        is_hot: 0,
      }
    }
  },
  mounted() {
    this.findInfo()
  },
  methods: {
    handleEdit(row) {
      console.log(row);
      this.show_key_popup = true
      this.formLabelAlign.keywords = row.keyword
      this.formLabelAlign.id = row.id
      this.row.is_hot = row.is_hot == 1 ? true : false
    },
    addkeybtn() {
      this.show_key_popup = true
    },
    addkeySure() {
      if (this.formLabelAlign.keywords == '') {
        this.$message.error('请输入关键词 !')
        return false
      }
      this.formLabelAlign.is_hot = this.row.is_hot ? 1 : 0
      console.log(this.formLabelAlign);
      console.log(this.row);
      this.axios.post('keywords/updatekeywords',{
        info: this.formLabelAlign
      }).then(res => {
        console.log(res);
        if (res.data.errno === 0) {
          this.$message({
            type: 'success',
            message: '更新成功 ！'
          })
          this.closekeypopup()
          this.findInfo()
        }else {
          this.$message.error('异常 !')
        }
      })
    },
    handleRowDelete(row) {
      this.$confirm('此操作将永久删除此信息, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.axios.post('keywords/delkeywords',{
            id: row.id
          }).then(res => {
            console.log(res);
            if (res.data.errno === 0) {
              this.findInfo()
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
    closekeypopup() {
      this.show_key_popup = false
      this.formLabelAlign.keywords = ''
      this.formLabelAlign.id = ''
      this.formLabelAlign.is_hot = ''
    },
    findInfo() {
      this.axios.post('keywords/findkeywords').then(res => {
        console.log(res);
        this.info_list = res.data.data
      })
    }

  },
}
</script>

<style lang="css">
.border {
  border: 1px solid #ff5566;
  padding: 2px 8px;
  border-radius: 3px;
  font-weight: bold;
  color: #ff5566;
}
.addkeyPopover_btn {
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
.addkeyPopover_from {
  /* border:1px solid black; */
  width: 80%;
  margin: 50px auto;
}
.addkeyPopover_title {
  margin: 10px 20px;
  /* border:1px solid black; */
  text-align: center;
  font-size: 20px;
  padding: 10px 0px;
  border-bottom: 1px solid #eee;

}
.addkeyPopover {
  width: 500px;
  /* height: 300px; */
  border-radius: 5px;
}
.action_btn_area {
  text-align: right;
  /* border:1px solid black; */
  width: 100%;
  margin-top: 15px;
  margin-bottom: -13px;
}
.border_card {
  float: left;
  margin: 5px 10px 5px 10px;
  /* width: 200px; */
}
</style>
