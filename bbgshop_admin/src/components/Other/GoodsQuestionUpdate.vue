<template lang="html">
  <div class="content-page">
      <div class="content-nav">
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>店铺管理</el-breadcrumb-item>
              <el-breadcrumb-item>商品页常见问题管理</el-breadcrumb-item>
          </el-breadcrumb>
          <div class="operation-nav">
            <!-- <router-link to="/dashboard/Luckdraw_add"> -->
              <el-button type="primary" icon="plus" @click="addquestion">添加问题</el-button>
            <!-- </router-link> -->
          </div>
      </div>
      <div class="content-page">
        <el-row :gutter="20">
          <el-col :span="6"  v-for="item in issueData" :key="item.id">
            <el-card class="box-card">
              <div slot="header" class="">
                <!-- <span><el-input v-model="item.question" placeholder="请输入问题"></el-input></span> -->
                <span>{{item.question}}</span>
                <!-- <el-button style="float: right; padding: 3px 0" type="text">操作按钮</el-button> -->
              </div>
              <div class="card_content" style="color:#555">{{item.answer}}</div>
              <el-button style="float: right;" type="info" size="small" @click="handleEdit(item)">编辑</el-button>
              <el-button style="float: right;margin-right:10px" :plain="true" type="danger" size="small" @click="handleDel(item)">删除</el-button>
            </el-card>

          </el-col>
        </el-row>
      </div>
      <!-- ////////////////////////////////////////////////////////添加问题弹层 -->
      <van-popup class="addSupplerPopover" @click-overlay="closequestionpopup" v-model="show_question_popup">
        <div class="addSupplerPopover_title">
          编辑商品页常见问题
          <!-- {{abc}} -->
        </div>
        <div class="addSupplerPopover_from">
          <el-form label-width="80px" :model="formLabelAlign">
            <el-form-item label="问题">
              <el-input v-model="formLabelAlign.question"></el-input>
            </el-form-item>
            <el-form-item label="回答">
              <el-input type='textarea' :rows="4" v-model="formLabelAlign.answer"></el-input>
            </el-form-item>
          </el-form>
        </div>
        <div class="addSupplerPopover_btn">
          <el-button type="text"  @click="closequestionpopup">取消</el-button>
          <el-button type="danger"  @click="addquestionSure">确定</el-button>
        </div>
      </van-popup>
    </div>
</template>

<script>
export default {
  data () {
    return {
      issueData: [],
      show_question_popup: false,
      formLabelAlign: {
        question: '',
        answer: '',
        id: 0,
        // sort_order: ''
      }

    }
  },
  mounted() {
    this.getissue()
  },
  methods: {
    addquestion() {
      this.show_question_popup = true
      this.formLabelAlign.question = ''
      this.formLabelAlign.answer = ''
    },
    handleDel(item){
      this.$confirm('此操作将永久删除此信息, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.axios.post('index/delissue',{
            id: item.id
          }).then(res => {
            console.log(res);
            if (res.data.errno == 0) {
              this.getissue()
              this.closequestionpopup()
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
    addquestionSure() {
      this.$confirm('此操作将永久修改此信息, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.axios.post('index/updateissue',{
            info: this.formLabelAlign
          }).then(res => {
            if (res.data.errno == 0) {
              this.getissue()
              this.closequestionpopup()
              this.$message({
                type: 'success',
                message: '修改成功 ！'
              });
            }
          })
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '取消修改 ！'
          });
        });
      // this.show_question_popup = true
    },
    closequestionpopup() {
      this.show_question_popup = false
      this.formLabelAlign.question = ''
      this.formLabelAlign.answer = ''
      this.formLabelAlign.id = 0
    },
    handleEdit(item){
      console.log(item);
      this.show_question_popup = true
      this.formLabelAlign.question = item.question
      this.formLabelAlign.answer = item.answer
      this.formLabelAlign.id = item.id
    },
    getissue(){
      this.axios.post('index/findissue').then((res) => {
        console.log(res);
        this.issueData = res.data.data
      })
    },
  },
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
.box-card {
  padding-bottom: 10px;
  margin-top: 20px;
}
.card_content {
  color: #555;
  text-indent: 0.75rem;
  margin-bottom: 20px;
}
</style>
