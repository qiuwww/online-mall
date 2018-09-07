<template>
<div class="right-box">
  <div class="navbar">
    <div class="menu">
      <div class="menu-item">
        <i class="fa fa-user" @click="resetpwd"></i>
      </div>
      <div class="menu-item">
        <i class="fa fa-sign-out" @click="logout"></i>
      </div>
    </div>
  </div>
  <!-- //修改密码的弹层 -->
  <van-popup v-model="resetpwd_popup">
    <div class="resetpwd_popup_area">
      <div class="popup_area_title">
        修改登录密码
      </div>
      <div class="popup_area_befor">
        <el-form :inline="true" :model="filterForm" class="demo-form-inline">
            <el-form-item label="原密码">
                <el-input :disabled="is_true" style="width:250px" v-model="filterForm.befor_pwd" placeholder="请输入原密码"></el-input>
            </el-form-item>
            <el-form-item label="原特征码">
                <el-input :disabled="is_true" style="width:250px" v-model="filterForm.befor_code" placeholder="请输入原特征码"></el-input>
            </el-form-item>
            <!-- <el-form-item style="text-align:right"> -->
            <div class="checkbtn" v-if="!is_true">
              <el-button style="margin-right:6px" size='small' type="primary" @click="checkpwdcode">验证</el-button>
            </div>
            <!-- </el-form-item> -->
        </el-form>
        <transition name="el-fade-in-linear">

        <el-form v-if="is_true" style="border-top:1px solid #eee" :inline="true" :model="filterFormAfter" class="demo-form-inline">
            <el-form-item label="新密码" style="margin-top:22px">
                <el-input style="width:250px" v-model="filterFormAfter.after_pwd" placeholder="请输入新密码"></el-input>
            </el-form-item>
            <el-form-item label="新特征码">
                <el-input style="width:250px" v-model="filterFormAfter.after_code" placeholder="请输入新特征码"></el-input>
            </el-form-item>
            <div class="checkbtn" v-if="is_true">
              <el-button style="margin-right:6px" size='small' type="primary" @click="surereset">确定</el-button>
            </div>
        </el-form>
      </transition>

      </div>
    </div>
  </van-popup>
</div>
</template>

<script>
export default {
  data() {
    return {
      resetpwd_popup: false,
      filterForm: {
        befor_pwd: '',
        befor_code: '',
      },
      filterFormAfter: {
        after_pwd: '',
        after_code: '',
      },
      is_true: false
    }
  },
  methods: {
    resetpwd() {
      this.resetpwd_popup = true
      this.is_true = false
      this.filterForm.befor_pwd = ''
      this.filterForm.befor_code = ''
      this.filterFormAfter.after_pwd = ''
      this.filterFormAfter.after_code = ''
    },
    surereset() {
      if (this.filterFormAfter.after_pwd == '' || this.filterFormAfter.after_code == '') {
        this.$message.error('输入修改信息 ！')
        return false
      }
      if (this.filterFormAfter.after_pwd.length < 6 ) {
        this.$message.error('密码最少为 6 位 ！')
        return false
      }
      this.axios.post('auth/changepwd',{
        info: this.filterFormAfter
      }).then(res => {
        console.log(res);
        if (res && res.data.errno !== 0) {
          this.$message.error(res.data.errmsg)
        }else {
          this.$notify({
          title: '修改成功 ！',
          message: '密码修改成功 ！',
          type: 'success'
        });
        this.resetpwd_popup = false
        this.is_true = true
        this.filterForm.befor_pwd = ''
        this.filterForm.befor_code = ''
        this.filterFormAfter.after_pwd = ''
        this.filterFormAfter.after_code = ''
        }
      })
    },
    checkpwdcode() {
      if (this.filterForm.befor_pwd == '' || this.filterForm.befor_code == '') {
        this.$message.error('输入核对信息 ！')
        return false
      }
      this.axios.post('auth/checkpwd',{
        info: this.filterForm
      }).then(res => {
        console.log(res);
        if (res && res.data.errno !== 0) {
          this.$message.error(res.data.errmsg)
        }else {
          this.is_true = true
        }
      })
    },
    logout() {
      this.$confirm('是否要退出?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        localStorage.clear();
        sessionStorage.clear();
        this.$router.replace({
          name: 'login'
        });
      });
    }
  }
}
</script>
<style scoped>
.checkbtn {
  width: 100%;
  margin-top: -10px;
  margin-bottom: 12px;
  /* margin-right: 100px; */
  text-align: right;
}
.popup_area_befor {
  /* border: 1px solid black; */
  margin: 0 3%;
  margin-top: 25px;
  text-align: center;

}
.popup_area_title {
  margin: 3%;
  padding: 2%;
  padding-bottom: 3%;
  /* border: 1px solid black; */
  font-size: 19px;
  text-align: center;
  border-bottom: 1px solid #eee;
}
.resetpwd_popup_area {
  width: 400px;
  /* height: 300px; */
}

.right-box {
  background: #324157;
  height: 60px;
  display: block;
  position: fixed;
  top: 0;
  left: 200px;
  z-index: 5;
  float: left;
  width: calc(100% - 200px);
  overflow: hidden;
}

.navbar {
  height: 60px;
  background: #324157;
  display: flex;
  width: 100%;
  justify-content: center;
  flex-direction: row;
}

.navbar .menu {
  flex: 1;
  margin-top: 15px;
  height: 40px;
  display: flex;
  justify-content: flex-end;
}

.navbar .menu-item {
  margin: 0 15px;
  height: 30px;
  line-height: 30px;
  text-align: center;
  font-size: 20px;
  color: #fff;
}
</style>
