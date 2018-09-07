<template>
<div class="login">
  <div class="logo_box">
    <img class="logo_box_img" src="static/images/indexlogo.png" />
    <div class="bottom_border"></div>
  </div>
  <div class="login-bigbox">
    <div class="login-picbox">
      <div class="login-message">
      </div>
      <div class="cloud cloud-b">
        <div class="line-a"></div>
        <div class="line-b"></div>
        <div class="line-c"></div>
        <div class="line-d"></div>
        <div class="line-e"></div>
      </div>
      <div class="boat">
        <div class="wrap">

          <div class="main">
            <div class="boat-top-layer">
              <div class="top">
                <div class="pole"></div>
                <div class="help"><span></span></div>
              </div>
              <div class="bottom"></div>
            </div>
            <div class="boat-mid-layer">
              <div class="top"></div>
              <div class="bottom"></div>
            </div>
            <div class="boat-bot-layer">
              <div class="top"></div>
              <div class="bottom"></div>
            </div>
          </div>
        </div>
        <div class="water">
          <div class="drops clearfix drops-1">
            <span class="drop drop-a"></span>
            <span class="drop drop-b"></span>
            <span class="drop drop-c"></span>
            <span class="drop drop-d"></span>
            <span class="drop drop-e"></span>
            <span class="drop drop-f"></span>
            <span class="drop drop-g"></span>
            <span class="drop drop-h"></span>
          </div>
          <div class="drops clearfix drops-2">
            <span class="drop drop-a"></span>
            <span class="drop drop-b"></span>
            <span class="drop drop-c"></span>
            <span class="drop drop-d"></span>
            <span class="drop drop-e"></span>
            <span class="drop drop-f"></span>
            <span class="drop drop-g"></span>
            <span class="drop drop-h"></span>
          </div>
        </div>

      </div>

    </div>
     <div class="login_item_box">
    <!--  <div class="logo">

      </div> -->
      <div class="box_body">
        <p class="tips" >欢迎使用<span style="color:#ff4444;padding:0 5px;font-size:20px;"> Github版贝堡商城 </span>后台管理</p>

        <el-form ref="form" :model="form" :rules="rules" label-position="top">
          <el-form-item label="" prop="username">
            <el-input v-model="form.username" placeholder="用户名"></el-input>
          </el-form-item>
          <el-form-item label="" prop="password">
            <el-input type="password" v-model="form.password" @keyup.13.native="show()" placeholder="密码"></el-input>
          </el-form-item>

          <el-form-item label="" prop="">
            <!-- 点击式按钮建议宽度不低于200px,高度介于36px与46px  -->
            <!-- 嵌入式仅需设置宽度，高度根据宽度自适应，最小宽度为200px -->
            <div id="vaptcha_container">
              <!--vaptcha_container是用来引入Vaptcha的容器，下面代码为预加载动画，仅供参考-->
              <div class="vaptcha-init-main">
                <div class="vaptcha-init-loading">
                  <img src="https://cdn.vaptcha.com/vaptcha-loading.gif" />
                  <span class="vaptcha-text">Vaptcha启动中...</span>
                </div>
              </div>
            </div>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="startLogin" :loading="loading" style="width: 100%;">
              {{ loading ? '登录中...' : '登录' }}
            </el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>
    <div class="text_tips">
      注：来来来 睁大眼睛看清楚了，github版本没有人机验证的逻辑 关键代码在LoginPage.vue第216行代码
    </div>
  </div>
  <div class="footertop">
    <ul >
      <li class="border_right"><a href="http://www.bbgshop.com/" target="_Blank">贝堡科技</a></li>
      <li class="border_right"><a href="http://www.bbgshop.com/Goods" target="_Blank">产品介绍</a></li>
      <li class="border_right"><a href="http://www.bbgshop.com/Parnter" target="_Blank">合作伙伴</a></li>
      <li class="border_right"><a href="http://www.bbgshop.com/About" target="_Blank">关于我们</a></li>
      <li><a href="http://www.bbgshop.com/Contact" target="_Blank">联系我们</a></li>
    </ul>
  <div class="footerbottom">
    Copyright © 2018 bbgshop.com All rights reserved.
  </div>
  <div class="footerbottom">
    贝堡网络科技提供技术支持
  </div>
  <div class="footerbottompc">
    Copyright © 2018 bbgshop.com All rights reserved.  贝堡网络科技提供技术支持
  </div>
</div>

  <!-- </div> -->
</div>
<!-- <link href="../../static.loadingStyle/loading.css" rel="stylesheet"> -->
</template>
<!-- <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script> -->
<!-- <script type="text/javascript" src="https://cdn.vaptcha.com/v.js"></script> -->
<script>
import api from '@/config/api';
export default {
  data() {
    return {
      // vaptcha:false,
      form: {
        challenge: '',
        username: 'admin',
        password: 'bbgshop',
        token: '',
      },
      rules: {
        username: [{
          required: true,
          message: '请输入用户名',
          trigger: 'blur'
        }, ],
        password: [{
            required: true,
            message: '请输入密码',
            trigger: 'blur'
          },
          {
            min: 6,
            message: '密码不得低于6个字符',
            trigger: 'blur'
          },
        ],
      },
      loading: false,
      CorporateName: '',

    }
  },
  components: {},
  mounted() {
    var that = this
    // console.log(api.CorporateName);
    this.CorporateName = api.CorporateName
    // console.log(that.vaptcha);
    this.axios.get('auth/getVaptcha').then((res) => {
      console.log(res);
      // console.log(that.vaptcha);
      let resjson = JSON.parse(res.data.data)
      console.log(resjson);
      if (resjson) {
        var options = {
          vid: resjson.vid, //站点id ,string,必选,
          challenge: resjson.challenge, //验证流水号 ,string,必选,
          container: "#vaptcha_container", //验证码容器,element,必选,
          type: "float", //验证码类型,string,默认float,可选择float,popup,embed,
          https: false, //是否是https , boolean,默认true,(false:http),
          color: "#57ABFF", //点击式按钮的背景颜色,string
          outage: '/',
          success: function(token, challenge) { //当验证成功时执行回调,function,参数token为string,必选,
            //提交表单时将token，challenge一并提交，作为验证通过的凭证，服务端进行二次验证  宕机模式无challenge
            if (token) {
              that.form.token = token
            }
          },
          fail: function() { //验证失败时执行回调
            //todo:执行人机验证失败后的事情
            this.$message.error('人机验证失败！');
          }
        }
        //vaptcha对象
        var vaptcha_obj;
        window.vaptcha(options, function(obj) {
          vaptcha_obj = obj;
          //执行初始化
          vaptcha_obj.init();
          // });
        }, 'json')
      }

    })
  },
  methods: {
    show() {
      this.startLogin()
    },
    startLogin() {
      if (!this.form.token) {
        this.$message.error('请进行人机验证！');
        // alert('请进行人机验证');
        // return false;
      }
      this.$refs['form'].validate((valid) => {
        if (!valid) {
          return false;
        }
        this.loading = true;
        this.axios.post('auth/login', {
          username: this.form.username,
          password: this.form.password
        }).then((res) => {
          console.log(res.data)
          this.loading = false;
          if (res.data.errno === 0 || true) {
            localStorage.setItem('token', res.data.data.token);
            sessionStorage.setItem('token', res.data.data.token);
            localStorage.setItem('userInfo', JSON.stringify(res.data.data.userInfo));
            this.$router.push({
              name: 'dashboard'
            });
          } else {
            this.$message.error('用户名或密码错误！');
          }

        }).catch((err) => {
          console.log(err)
          this.loading = false;
        })

      });
    }
  }
}
</script>
<style>
@import '../../static/ship';
.login {
  background-image: linear-gradient(-225deg, #FFE6FA 0%, #E3FDF5 100%);
  font-family: Lato, Helvetica, sans-serif, '微软雅黑';
  height: 100vh;
  width: 100vw;
  color: #656565;
}
@media only screen and (max-width: 767px) {
  .logo_box {
    padding-top: 8vh;
    text-align: center;
  }
  .vaptcha-init-main {
    width: calc(100vw - 32px) !important;;
  }
  .vaptcha-init-loading {
    width:calc(100vw - 32px) !important;
  }
  #vaptcha_container{
    width:calc(100vw - 32px);
  }
  .login-picbox {
    display: none;
  }
  .bottom_border {
    height: 2px;
    background-image: linear-gradient(to right, #eea2a2 0%, #bbc1bf 19%, #57c6e1 42%, #b49fda 79%, #7ac5d8 100%);
  }
  .login-bigbox {
    margin-top: 8vh;
    text-align: center;
    padding: 8px;
  }
  .box_body .tips{
    height: 36px;
    line-height: 36px;
    font-size: 18px;
    font-weight:bold;
    margin-bottom: 3vh;
  }
  .login_item_box {
    padding: 8px;
    border-radius: 8px;
    background: rgba(255, 255, 255, 0.5);
  }
  .footertop {
    /* border:1px solid black; */
    position: fixed;
    width: 100vw;
    bottom: 0;
  }
  .footertop ul{
    /* border:1px solid black; */
    height: 14px;
    display: flex;
    justify-content: center;
    align-items: center;
    line-height: 14px;
  }
  .footertop ul li{
    /* border:1px solid black; */
    padding: 0px 5px;
    float:left;
    font-size: 10px;
  }
  .footerbottompc {
    display: none;
  }
  .border_right {
    /* border-right: 1px solid #757575; */
  }
  .footertop ul li a{
    text-decoration: none;
    color: #656565 !important;
  }
  .footerbottom {
    width: 100%;
    font-size: 8px;
    margin: 2px;
    text-align: center;
  }
  .text_tips {
    font-size: 12px;
    text-align: center;
    margin: 4vh auto;
  }
}
@media only screen and (min-width: 768px) {
  .login-picbox {
    /* display: none; */
  }
  .logo_box {
    padding-top: 12vh;
    /* margin-left: 25vw; */
    /* text-align: center; */
  }
  .vaptcha-init-main {
    width:400px !important;;
  }
  .vaptcha-init-loading {
    width:400px !important;
  }
  #vaptcha_container{
    width:400px;
  }
  .logo_box_img{
    margin-left: 8vw;
  }
  .bottom_border {
    height: 2px;
    background-image: linear-gradient(to right, #eea2a2 0%, #bbc1bf 19%, #57c6e1 42%, #b49fda 79%, #7ac5d8 100%);
  }
  .login-bigbox {
    /* border: 1px solid black; */
    /* display: inline-block; */
    position: relative;
    margin-top: 8vh;
    text-align: center;
    padding: 8px;
    height: 500px;
  }
  .box_body .tips{
    height: 36px;
    line-height: 36px;
    font-size: 18px;
    font-weight:bold;
    margin-bottom: 3vh;
    margin-top: 1vh;
  }
  .login-picbox {
    /* border: 1px solid black; */
    /* position: absolute; */
    /* width: calc(100% - 440px - 10%); */
    /* height: calc(100% - 16px); */
    /* width: 500px; */
    /* height: 500px; */
    /* float: left; */
  }
  .login_item_box {
    /* float: right; */
    position: absolute;
    right: 10%;
    top: 40px;
    padding: 15px;
    width: 400px;
    border-radius: 8px;
    background: rgba(255, 255, 255, 0.5);
  }
  .footertop {
    /* border:1px solid black; */
    position: fixed;
    width: 100vw;
    bottom: 0;
  }
  .footertop ul{
    /* border:1px solid black; */
    height: 14px;
    display: flex;
    justify-content: center;
    align-items: center;
    line-height: 14px;
  }
  .footertop ul li{
    /* border:1px solid black; */
    padding: 0px 5px;
    float:left;
    font-size: 10px;
  }
  .border_right {
    /* border-right: 1px solid #757575; */
  }
  .footertop ul li a{
    text-decoration: none;
    color: #656565 !important;
  }
  .footerbottom {
    display: none;
  }
  .footerbottompc {
    display: block;
    width: 100%;
    font-size: 8px;
    margin: 2px;
    text-align: center;
  }
  .text_tips {
    position: absolute;
    width: 400px;
    bottom: 40px;
    right: 10%;
    font-size: 12px;
    text-align: center;
    /* width: 100vw; */
  }
}
.vaptcha-init-main {
  display: table;
  border-radius: 2px;
  width: 320px;
  height: 100%;
  background-color: #EEEEEE;
}

.vaptcha-init-loading {
  display: table-cell;
  vertical-align: middle;
  text-align: center
}

.vaptcha-init-loading>a {
  display: inline-block;
  width: 18px;
  height: 18px;
  border: none;
}

.vaptcha-init-loading>a img {
  vertical-align: middle
}

.vaptcha-init-loading .vaptcha-text {
  font-family: sans-serif;
  font-size: 12px;
  color: #CCCCCC;
  vertical-align: middle
}


</style>
