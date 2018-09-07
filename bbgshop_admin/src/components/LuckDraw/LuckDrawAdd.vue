<template lang="html">
  <div class="content-page">
      <div class="content-nav" >
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>店铺运营</el-breadcrumb-item>
              <el-breadcrumb-item :to="{ path: '/dashboard/Luckdraw_page' }">抽奖管理</el-breadcrumb-item>
              <el-breadcrumb-item>发起抽奖</el-breadcrumb-item>
          </el-breadcrumb>
          <div class="operation-nav">
              <el-button type="primary" @click="goBackPage" icon="arrow-left">返回列表</el-button>
          </div>
      </div>
      <div class="content-main">
        <el-form label-width="180px">
          <el-form-item label="发起抽奖商品" >
            <el-input @focus="showLuckGoodsPopup" v-model="LuckGoods.name" placeholder="点击选择发起抽奖商品" >
            </el-input>
            <div v-if="this.id !== 0" class="itemtip">
              编辑时重新选择商品则视为重新发起选择商品的抽奖 ！
            </div>
          </el-form-item>
          <el-form-item label="商品原价">
            <el-input style="width:100px;" disabled v-model="(LuckGoods.retail_price / 1).toFixed(2)">
            </el-input>
            <div class="itemtip">
              原价不可更改
            </div>
          </el-form-item>
          <el-form-item label="最少开奖人数">
            <el-input type="number" style="width:125px;" v-model="Luck.LuckPeople" :min="1" > </el-input>
            <div class="itemtip"> 最少开奖人数, <span style="color:#ff6666;">若截止开奖人数没有达到最少开奖人数，截止时间和开奖时间则自动延后一天 (24小时) ，直到达到最少人数才开奖 </span> </div>
          </el-form-item>
          <el-form-item label="奖品数量">
             <el-input type="number" placeholder="" style="width:140px;" :min="1" v-model="Luck.LuckGoodsNum">
               <template slot="append">件</template>
            </el-input>
            <div class="itemtip"> 奖品数量,此数值为，
              <span style="color:#ff6f00;"> 抽奖抽出的人数，</span>
              <span style="color:#ff6666;"> 尽量不要超出四人，否则会使前台显示很诡异 </span> </div>
          </el-form-item>
          <el-form-item label="抽奖截止时间">
            <div class="block">
              <!-- <span class="demonstration">设置默认时间</span> -->
              <el-date-picker
                v-model="Luck.limit_time_unix"
                type="datetime"
                :placeholder="limit_time_unix_placeholder"
                default-time="12:00:00">
              </el-date-picker>
            </div>
            <div class="itemtip"> 抽奖截止时间, <span style="color:#ff6f00;">超过此时间即不能再参与抽奖</span> </div>
          </el-form-item>

          <el-form-item label="开奖时间">
            <div class="block">
              <!-- <span class="demonstration">设置默认时间</span> -->
              <el-date-picker
                v-model="Luck.open_time_unix"
                type="datetime"
                :placeholder="open_time_unix_placeholder"
                default-time="12:00:00">
              </el-date-picker>
            </div>
            <div class="itemtip"> 开奖时间,大概误差不会超过十分钟
              <span style="color:#ff6f00;">请务必保证截止时间与开奖时间间隔超过10分钟，
                <span style="color:#ff6666;">否则会产生不可避免的错误 ！！</span></span></div>
          </el-form-item>
          <!-- <el-button @click="buttom">取消</el-button> -->
          <el-form-item label="活动详情页">
            <template>
                  <div style="margin-top:-30px;">
                      <!-- 图片上传组件辅助-->
                      <el-upload
                              class="avatar-uploader"
                              action="http://upload.qiniup.com"
                              :data="uploadToken"
                              :headers="header"
                              :show-file-list="false"
                              :on-success="detailhandlesuccess"
                              :on-error="uploadError">
                      </el-upload>
                      <!--富文本编辑器组件-->
                      <quill-editor
                              v-model="Luck.LuckDetailEdit"
                              ref="myQuillEditor"
                              :options="editorOption"
                              @change="onEditorChange($event)"
                      >
                      </quill-editor>
                  </div>
              </template>
            <div class="itemtip"> 默认为选择的商品的详情页 <span style="color:#ff6f00">如要修改请修改</span></div>
          </el-form-item>
          <el-form-item>
              <el-button type="primary" @click="onSubmitInfo">确定保存</el-button>
              <el-button @click="goBackPage">取消</el-button>
          </el-form-item>
        </el-form>
      </div>
<!-- ////////////////////////////////////////////////////////指定商品弹出层 -->
      <van-popup class="GoodsPopover" v-model="selectGoodsPopover">
        <el-row class="GoodsPopoverTitle">
          <el-col :span="12" style="line-height:37px;font-weight:bold">添加抽奖商品</el-col>
          <el-col :span="12" style="text-align:right">
            <el-input style="width:200px;" v-model="LuckGoodsInput" @keyup.13.native="SelectLuckGoods()" placeholder="请输入商品名称"></el-input>
            <el-button type="primary" @click="SelectLuckGoods">搜索</el-button>
          </el-col>
        </el-row>
        <el-table :data="dangerGoodsData" border :default-sort = "{prop: 'date', order: 'descending'}" stripe style="width: 100%">
          <el-table-column prop="id" label="ID" align="center" width="100">
          </el-table-column>
          <el-table-column prop="name" label="商品名称">
          </el-table-column>
          <el-table-column prop="" align="center" width="100" label="商品价格">
            <template slot-scope="scope">
              {{(dangerGoodsData[scope.$index].retail_price / 1).toFixed(2) }}
            </template>
          </el-table-column>
          <el-table-column prop="action" align="center" label="操作" width="80">
            <template slot-scope="scope">
                <el-button size="small" :type="scope.row.btnType"
                   @click="handleSelectGoods(scope.$index, scope.row)">{{scope.row.btnText}}</el-button>
            </template>
          </el-table-column>
        </el-table>
          <div class="page-box">
            <el-pagination style="margin-right:10px;" @current-change="LuckGoodsPageChange" :current-page="goodspage" :page-size="5"
              layout="total, prev, pager, next, jumper" :total="goodstotal">
            </el-pagination>
          </div>
      </van-popup>
  </div>
</template>

<script>
// import E from 'wangeditor';
import api from '@/config/api';
const toolbarOptions = [
  ['bold', 'italic', 'underline', 'strike'], // toggled buttons
  [{'header': 1}, {'header': 2}], // custom button values
  [{'list': 'ordered'}, {'list': 'bullet'}],
  [{'script': 'sub'}, {'script': 'super'}], // superscript/subscript
  [{'align': 'center'}],
  ['image', 'video'],
  ['clean'] // remove formatting button
]
export default {
  data(){
    return {
      uploaddress: api.UploadAddress,
      id: 0,
      limit_time_unix_placeholder: '选择日期时间',
      open_time_unix_placeholder: '选择日期时间',
      uploadToken:{
        token: "",
      },
      uploaderHeader: {
        'X-Nideshop-Token': localStorage.getItem('token') || '',
      },
      header: {
        'X-Nideshop-Token': localStorage.getItem('token') || '',
      }, // 有的图片服务器要求请求头需要有token之类的参数，写在这里
      editorOption: {
        placeholder: '',
        theme: 'snow', // or 'bubble'
        modules: {
          toolbar: {
            container: toolbarOptions, // 工具栏
            handlers: {
              'image': function(value) {
                if (value) {
                  // 触发input框选择图片文件
                  document.querySelector('.avatar-uploader input').click()
                } else {
                  this.quill.format('image', false);
                }
              }
            }
          }
        }
      },
      Luck:{
        LuckPeople:'', //最少开奖人数
        LuckDetailEdit: '',
        create_time: '',
        // LimitTimeLocal: [], //限制时间传统格式
        // LimitTimeUnix: [], //限制时间 时间戳
        LuckGoodsNum: '',// 奖品数量
        open_time_unix: '',
        open_time_local: '', //开奖时间
        limit_time_unix: '',
        limit_time_local: '', //抽奖截止时间
      },
      goodspage:1,
      goodstotal:0,
      selectGoodsPopover:false,
      LuckGoodsInput:'',
      LuckGoods: {},
      dangerGoodsData: [],
      LuckGoodsList: [],
      allGoodsData: [],
    }
  },
  mounted(){
    this.id = this.$route.query.id || 0;
    this.gettoken()
    if (this.id !== 0) {
      this.getInfo()
    }
  },
  methods:{
    ///////////////////////////////////////////编辑抽奖，按id查找抽奖内容
    buttom() {
      console.log(this.LuckGoods);
    },
    getInfo() {
      this.axios.post('luckdraw/findluckinfoByid',{
        id: this.id
      }).then(res => {
        console.log(res);
        if (res.data.errno == 0) {
          this.Luck.LuckDetailEdit = res.data.data.luck_goods_detail
          this.Luck.LuckPeople = res.data.data.luck_people_num
          this.Luck.LuckGoodsNum = res.data.data.luck_goods_num
          this.LuckGoods.name = res.data.data.luck_goods_name
          this.LuckGoods.retail_price = res.data.data.luck_goods_price
          this.LuckGoods.id = res.data.data.luck_goods_id
          this.LuckGoods.luck_goods_pic = res.data.data.luck_goods_pic
          this.limit_time_unix_placeholder = this.timestampToTime(res.data.data.luck_limit_time)
          this.open_time_unix_placeholder = this.timestampToTime(res.data.data.luck_open_time)
          this.Luck.open_time_local = res.data.data.luck_open_time
          this.Luck.limit_time_local = res.data.data.luck_limit_time
          // this.Luck.LuckPeople = res.data.data.luck_people_num
          // console.log(res.data.data.luck_goods_detail);
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
    onSubmitInfo(){
      console.log(this.LuckGoodsList);
      console.log(this.Luck.limit_time_local);
      console.log(this.Luck.open_time_local);
      console.log(this.Luck.LuckDetailEdit);
      console.log(this.Luck.LuckGoodsNum);
      console.log(this.Luck.LuckPeople);
      console.log(this.LuckGoods.name);
      // console.log(this.Luck.open_time_unix);
      if (this.LuckGoodsList.length == 0) {
        if (this.LuckGoods.name == '') {
          this.$message.error('请选择抽奖商品 !')
          return false
        }else {
        }
      }
      if (this.Luck.open_time_unix && this.Luck.limit_time_unix) {
        this.Luck.open_time_local = new Date(this.Luck.open_time_unix).getTime()
        this.Luck.limit_time_local = new Date(this.Luck.limit_time_unix).getTime()
      }else {
        if (this.id == 0) {
          this.$message.error('请填写截止时间和开奖时间 !')
          return false
        }else {

        }
      }
      if (this.Luck.open_time_local < this.Luck.limit_time_local) {
        this.$message.error('截止时间不能大于开奖时间 !')
        return false
      }
      if (this.Luck.LuckPeople < 1 || this.Luck.LuckPeople > 1000) {
        this.$message.error('开奖人数在 1 ~ 999 人之间 !')
        return false
      }
      if (this.Luck.LuckGoodsNum == '' ) {
        this.$message.error('请输入奖品数量 !')
        return false
      }
      if (parseInt(this.Luck.LuckGoodsNum) > parseInt(this.Luck.LuckPeople) ) {
        this.$message.error('奖品数量不能大于开奖人数 !')
        return false
      }
      this.Luck.create_time = new Date().getTime()
      this.axios.post('luckdraw/luckstore',{
        luckId: this.id,
        Luck:this.Luck,
        goods:this.LuckGoods
      }).then((res) => {
        console.log(res);
        if (res.data.errno === 0) {
          this.$message({
            type: 'success',
            message: '添加成功!'
          });
          this.goBackPage()
        }


      })

    },
    onEditorChange(e) {
      this.Luck.LuckDetailEdit = e.html
      // console.log(this.Luck.LuckDetailEdit);
    },
    detailhandlesuccess(res, file) {
      // res为图片服务器返回的数据
      console.log(res, file);
      // 获取富文本组件实例
      let quill = this.$refs.myQuillEditor.quill
      // 如果上传成功
      if (res) {
        // 获取光标所在位置
        let length = quill.getSelection().index;
        // 插入图片  res.info为服务器返回的图片地址
        quill.insertEmbed(length, 'image', this.uploaddress + res.key)
        // 调整光标到最后
        quill.setSelection(length + 1)
      } else {
        this.$message.error('图片插入失败')
      }
    },
    // 富文本图片上传失败
    uploadError() {
      // loading动画消失
      this.$message.error('图片插入失败')
    },
    gettoken(){
      this.axios.post('upload/token').then((res) => {
        console.log(res);
        this.uploadToken.token = res.data.data.uploadToken
      })
    },
    LuckGoodsPageChange(val){
      this.goodspage = val;
      //保存到localStorage
      localStorage.setItem('goodsPage', this.goodspage)
      this.showLuckGoodsPopup()
    },
    handleSelectGoods(index,row){
      if ( row.btnType == 'danger') {
        this.delLuckGoods(row.id)
        let NoData = this.dangerGoodsData
        this.dangerGoodsData = []
        for (var i = 0; i < NoData.length; i++) {
          if (NoData[i].id === row.id) {
            NoData[i] = row
            NoData[i].btnType = "success"
            NoData[i].btnText = "选中"
          }
        }
        this.dangerGoodsData = NoData
      }else {
        let NoData = this.dangerGoodsData
        this.dangerGoodsData = []
        for (var i = 0; i < NoData.length; i++) {
          if (NoData[i].btnType == "danger") {
            NoData[i] = NoData[i]
            NoData[i].btnType = "success"
            NoData[i].btnText = "选中"
          }else if (NoData[i].id === row.id) {
            this.LuckGoodsList = []
            NoData[i] = row
            NoData[i].btnType = "danger"
            NoData[i].btnText = "已选中"
            this.LuckGoodsList.push(NoData[i])
          }
        }
        this.dangerGoodsData = NoData
        this.LuckGoods = this.LuckGoodsList[0]
        this.Luck.LuckDetailEdit = this.LuckGoodsList[0].goods_desc
        this.selectGoodsPopover = false
      }
    },
    SelectLuckGoods(){
      this.showLuckGoodsPopup()
    },
    showLuckGoodsPopup(){
      this.selectGoodsPopover = true
      this.axios.get('collage/collagegoods', {
        params: {
          page: this.goodspage,
          goodsname: this.LuckGoodsInput,
        }
      }).then((res) => {
        this.allGoodsData = res.data.data.data
        this.goodspage = res.data.data.currentPage
        this.goodstotal = res.data.data.count
        let NoGoodsData = []
        for (var i = 0; i < this.allGoodsData.length; i++) {
          let obj = {}
          obj = this.allGoodsData[i]
          obj.btnType = "success"
          obj.btnText = "选中"
          NoGoodsData.push(obj)
        }
        for (var i = 0; i < this.LuckGoodsList.length; i++) {
          for (var j = 0; j < NoGoodsData.length; j++) {
            if (this.LuckGoodsList[i].id === NoGoodsData[j].id) {
              console.log("123456789");
              NoGoodsData[j].btnType = "danger"
              NoGoodsData[j].btnText = "已选中"
            }
          }
        }
        this.dangerGoodsData = NoGoodsData
      })
    },
    //删除指定商品
    delLuckGoods(id){
        let dataa = []
        for (var i = 0; i < this.LuckGoodsList.length; i++) {
         if (this.LuckGoodsList[i].id === id) {
         }else {
           console.log(this.LuckGoodsList[i]);
           let objj = this.LuckGoodsList[i]
           dataa.push(objj)
         }
        }
        this.LuckGoodsList = dataa
        if (this.LuckGoodsList.length == 0) {
          this.LuckGoods = {}
          this.Luck.LuckDetailEdit = ''
        }
    },
    goBackPage() {
      this.$router.go(-1);
    },
  }
}
</script>

<style lang="css">
.itemtip {
  /* text-align: center; */
  margin-bottom: -22px;
  font-size: 12px;
  color: #8391a5
}
.page-box {
  margin-bottom: 15px;
}
.GoodsPopoverTitle {
  margin: 20px 20px 0 20px;
  padding-bottom: 10px;
}
.GoodsPopover {
  position: fixed;
  width: 600px;
  background: rgba(255, 255, 255, 0.9);
}
</style>
