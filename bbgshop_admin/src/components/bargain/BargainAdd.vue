<template lang="html">
  <div class="content-page">
      <div class="content-nav" >
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>店铺运营</el-breadcrumb-item>
              <el-breadcrumb-item :to="{ path: '/dashboard/bargain/bargainPage' }">砍价管理</el-breadcrumb-item>
              <el-breadcrumb-item>发起砍价</el-breadcrumb-item>
          </el-breadcrumb>
          <div class="operation-nav">
              <el-button type="primary" @click="goBackPage" icon="arrow-left">返回列表</el-button>
          </div>
      </div>
      <div class="content-main">
        <el-form label-width="180px">
          <el-form-item label="发起砍价商品" >
            <el-input :disabled="is_edit" @focus="showBargainGoodsPopup" v-model="BargainGoods.name" placeholder="点击选择砍价商品" >
            </el-input>
          </el-form-item>
          <el-form-item label="商品原价">
            <el-input style="width:100px;" disabled v-model="(BargainGoods.retail_price / 1).toFixed(2)">
            </el-input>
            <div class="itemtip">
              原价不可更改
            </div>
          </el-form-item>
          <el-form-item label="底价">
            <el-input type="number" style="width:125px;" :min="0" :max="BargainGoods.retail_price" v-model="Bargain.BargainMinPrice"> </el-input>
            <div class="itemtip"> 允许商品的最低价，最低为0，最高为商品原价 </div>
          </el-form-item>
          <el-form-item label="最多发起次数">
            <el-input type="number" style="width:125px;" :min="1" :max="BargainGoods.goods_number" v-model="Bargain.BargainInitNumber"> </el-input>
            <!-- <div class="itemtip"> 最低为1，最大值为商品总库存 {{BargainGoods.goods_number}}</div> -->
            <div class="itemtip">如果用户发起，则数值减一</div>
          </el-form-item>
          <el-form-item label="砍价人数">
            <el-input type="number" style="width:125px;" v-model="Bargain.BargainPeople"  @change="float()" :min="1" > </el-input>
            <div class="itemtip"> 实际人数在此基础浮动 </div>
          </el-form-item>
          <el-form-item label="砍价人数与金额浮动范围">
            <template>
              <el-table :data="FloatingData" border style="width: 80%">
                <el-table-column type="index" label="次数" width="100" align="center" >
                </el-table-column>
                <el-table-column prop="Floating" label="砍价浮动值" align="center" >
                </el-table-column>
                <el-table-column prop="Listing" label="剩余浮动值" align="center" >
                </el-table-column>
                <el-table-column prop="chance" label="概率浮动值" align="center" >
                </el-table-column>
              </el-table>
            </template>
            <div class="itemtip"> 砍到底价大概需要 <span style="color:#ff4444;font-weight:bold;font-size:22px;"> {{FloatingData.length}} </span>个人，
              <span style="color:#e91e63">不完全准确，与用户算法相同，存在误差</span>
            </div>

            <!-- <el-input type="number" style="width:125px;" :min="1" v-model="Bargain.BargainPeople"> </el-input> -->
            <!-- <div class="itemtip"> 最低为1，暂无上限 </div> -->
          </el-form-item>
          <!-- <el-form-item label="单用户可砍价次数">
            <el-input type="number" style="width:125px;" :min="1" v-model="Bargain.BargainPeopleTime"> </el-input>
            <div class="itemtip"> 单个用户可砍价的次数 <span style="color:rgb(255, 150, 0)">谨慎填写</span></div>
          </el-form-item> -->
          <el-form-item label="允许发起时间">
            <template>
              <div class="block">
                <!-- <span class="demonstration">默认</span> -->
                <el-date-picker
                  :disabled="is_edit"
                  v-model="Bargain.LimitTimeLocal"
                  type="datetimerange"
                  :placeholder="dateplaceholder">
                </el-date-picker>
              </div>
            </template>
          </el-form-item>
          <el-form-item label="用户砍价持续时间">
             <el-input :disabled="is_edit" type="number" placeholder="" style="width:140px;" :min="0" v-model="Bargain.BargainUserDuration">
               <template slot="append">小时</template>
            </el-input>
          </el-form-item>
          <!-- <el-form-item label="砍价范围">
            <el-input type="number" placeholder="最小值" style="width:100px;" :min="0" v-model="Bargain.BargainRandomMin"> </el-input> ~
            <el-input type="number" placeholder="最大值" style="width:100px;" :min="1" v-model="Bargain.BargainRandomMax"> </el-input>
            <div class="itemtip"> 用户点击砍价后随机砍价的范围 <span style="color:rgb(255, 150, 0)">很重要，勿乱填</span></div>
          </el-form-item> -->
          <!-- <el-form-item label="活动规则">
            <el-input type="textarea" :autosize="{ minRows: 2, maxRows: 4}" placeholder="请输入活动规则" v-model="Bargain.RulesActivity">
            </el-input>
          </el-form-item> -->
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
                              v-model="Bargain.BargainDetailEdit"
                              ref="myQuillEditor"
                              :options="editorOption"
                              @change="onEditorChange($event)"
                      >
                      </quill-editor>
                  </div>
              </template>
            <div class="itemtip"> 默认为选择的商品的详情页 <span style="color:rgb(255, 150, 0)">如要修改请修改</span></div>
          </el-form-item>
          <!-- <el-form-item label="商品主图" >
            <el-upload
              action="http://upload.qiniup.com"
              list-type="picture-card"
              :data="uploadToken"
              :headers="uploaderHeader"
              :on-success="BargainImgSuccess"
              :before-upload="beforeBargainImg"
              :file-list = "BargainImgList">
              <i class="el-icon-plus"></i>
            </el-upload>
          </el-form-item> -->
          <el-form-item>
              <el-button type="primary" @click="onSubmitInfo">确定保存</el-button>
              <el-button @click="goBackPage">取消</el-button>
          </el-form-item>
        </el-form>
      </div>
      <!-- <div class="operation-nav">
        <router-link to="/dashboard/addcoupon">
          <el-button type="primary" icon="plus">添加商品</el-button>
        </router-link>
      </div> -->
    <!-- </div> -->
<!-- ////////////////////////////////////////////////////////指定商品弹出层 -->
      <van-popup class="GoodsPopover" v-model="selectGoodsPopover">
        <el-row class="GoodsPopoverTitle">
          <el-col :span="12" style="line-height:37px;font-weight:bold">添加砍价商品</el-col>
          <el-col :span="12" style="text-align:right">
            <el-input style="width:200px;" v-model="BargainGoodsInput" @keyup.13.native="SelectBargainGoods()" placeholder="请输入商品名称"></el-input>
            <el-button type="primary" @click="SelectBargainGoods">搜索</el-button>
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
            <el-pagination style="margin-right:10px;" @current-change="BargainGoodsPageChange" :current-page="goodspage" :page-size="5"
              layout="total, prev, pager, next, jumper" :total="goodstotal">
            </el-pagination>
          </div>
      </van-popup>
  </div>
</template>

<script>
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
      dateplaceholder: '请选择时间范围 ',
      FloatingData: [],
      uploadToken:{
        token: "",
      },
      uploaderHeader: {
        'X-Nideshop-Token': localStorage.getItem('token') || '',
      },
      // quillUpdateImg: false, // 根据图片上传状态来确定是否显示loading动画，刚开始是false,不显示
      //        serverUrl: '',  // 这里写你要上传的图片服务器地址
      //        header: {token: sessionStorage.token},  // 有的图片服务器要求请求头需要有token之类的参数，写在这里
      //        detailContent: '', // 富文本内容
      //        editorOption: {},  // 富文本编辑器配置
      // 这里写你要上传的图片服务器地址
      header: {
        'X-Nideshop-Token': localStorage.getItem('token') || '',
      }, // 有的图片服务器要求请求头需要有token之类的参数，写在这里
      // detailContent: '', // 富文本内容
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

      // BargainImgList: [],
      Bargain:{
        BargainMinPrice: '', //商品低价 可购买的价格
        BargainPeople:'', //可参与砍价的人数
        BargainInitNumber: '',//库存
        // BargainRandomMin: '', //砍价随机范围最小值
        // BargainRandomMax: '', //砍价随机范围最大值
        BargainPeopleTime: 1, //单用户可砍价的次数
        RulesActivity: '',//活动规则
        BargainDetailEdit: '',
        create_time: '',
        LimitTimeLocal: [], //限制时间传统格式
        LimitTimeUnix: [], //限制时间 时间戳
        BargainUserDuration: '',//用户可持续砍价的时间
        BargainUserDurationUnix: '',//用户可持续砍价的时间 时间戳
      },
      goodspage:1,
      goodstotal:0,
      selectGoodsPopover:false,
      BargainGoodsInput:'',
      BargainGoods: {},
      dangerGoodsData: [],
      BargainGoodsList: [],
      allGoodsData: [],
      id: 0,
      is_edit: false,//编辑状态
      // row: [],
    }
  },
  mounted(){
    this.id = this.$route.query.id || 0;
    if (this.id !== 0) {
      this.is_edit = true
      this.getInfo()
    }
    console.log();
    this.gettoken()
  },
  methods:{
    /////////////////////////////////////////////编辑时按id获取信息
    getInfo() {
      this.axios.post('bargain/findbargaininfoById',{
        id: this.id
      }).then(res => {
        console.log(res);
        // this.Bargain.
        this.BargainGoods.name = res.data.data.goods_name
        this.BargainGoods.retail_price = res.data.data.retail_price
        this.dateplaceholder = this.timestampToTime(res.data.data.start_time) + '   --   ' + this.timestampToTime(res.data.data.end_time)
        this.Bargain.BargainMinPrice = res.data.data.lowest_price
        this.Bargain.BargainPeople = res.data.data.least_cut_num
        this.Bargain.BargainInitNumber = res.data.data.most_init_num
        this.Bargain.BargainDetailEdit = res.data.data.activity_detail
        this.Bargain.BargainUserDuration = res.data.data.user_duration_time / 3600000
        this.float()
      })
    },
    float(){
      // console.log(num);
      console.log(this.Bargain.BargainPeople);
      this.FloatingData = []
      let rend = (parseInt(100*Math.random()) / 1000).toFixed(3);
      console.log(0.08 + Number(rend));
      let reddd = (0.08 + Number(rend)).toFixed(3)
      let cutprice = (this.BargainGoods.retail_price * (0.08 + Number(rend))).toFixed(2)
      let lsieprice = ((this.BargainGoods.retail_price - cutprice) / 1).toFixed(2)
      console.log(cutprice);
      let obj = {}
      obj.Floating = cutprice
      obj.Listing = lsieprice
      obj.chance = reddd
      this.FloatingData[0] = obj
      console.log(this.FloatingData);
      if (this.Bargain.BargainPeople > 1 && this.BargainGoods.retail_price >= 0 && this.Bargain.BargainMinPrice >= 0) {
        for (var i = 0; i >= 0; i++) {
          console.log(i);
          let re12nd = (parseInt(100*Math.random()) / 1000).toFixed(3);
          console.log(this.FloatingData);
          let red12ddd = ((( i + 1) / this.Bargain.BargainPeople) * (0.08 + rend * 10)).toFixed(3)
          let cut12price = (Number(this.FloatingData[i].Listing) * ((( i + 1) / this.Bargain.BargainPeople) * (0.08 + rend * 10))).toFixed(2)
          let list12ing = (this.FloatingData[i].Listing - cut12price).toFixed(2)
          let objj = {}
          objj.Floating = cut12price
          objj.Listing = list12ing
          objj.chance = red12ddd
          this.FloatingData.push(objj)
          if(Number(list12ing) <= this.Bargain.BargainMinPrice) {
            this.FloatingData[i + 1].Listing = "砍价已完成"
               break;
           }
        }
      }
      // this.FloatingData.push(obj)

      // this.FloatingData[0].Floating = cutprice
      // let rend = (parseInt(100*Math.random()) / 1000).toFixed(3);
      // cutprice = (barinfo.have_cut_lest * ((barinfo.have_cut_num / barinfo.least_cut_num) * (0.08 + rend * 10))).toFixed(2)

    },
    onSubmitInfo(){
      if (this.id !== 0) {
        if (this.Bargain.BargainMinPrice == '') {
          this.$message.error('请输入商品低价！')
          return false
        }
        if (this.Bargain.BargainInitNumber == '') {
          this.$message.error('请输入最多发起次数！')
          return false
        }
        if (this.Bargain.BargainPeople == '') {
          this.$message.error('请输入可参与砍价的人数！')
          return false
        }
        if (this.Bargain.BargainDetailEdit == '') {
          this.$message.error('请输入活动详情页 ！')
          return false
        }
        this.axios.post('bargain/bargainupdate',{
          bargain:this.Bargain,
          id: this.id
        }).then((res) => {
          console.log(res);
          if (res.data.errno === 0) {
            this.$message({
              type: 'success',
              message: '更新成功!'
            });
            this.goBackPage()
          }else {
            this.$message.error("异常 ！")
          }
        })
      }else {
        console.log(this.BargainGoodsList);
        console.log(this.Bargain);
        // if (parseInt(this.Bargain.BargainRandomMin) >= parseInt(this.Bargain.BargainRandomMax)) {
        //   this.$message.error('砍价随机最大值应大于最小值！')
        //   return false
        // }
        if (this.BargainGoodsList.length == 0) {
          this.$message.error('请选择砍价商品！')
          return false
        }
        if (this.Bargain.BargainMinPrice == '') {
          this.$message.error('请输入商品低价！')
          return false
        }
        if (this.Bargain.BargainInitNumber == '') {
          this.$message.error('请输入最多发起次数！')
          return false
        }
        if (this.Bargain.BargainPeople == '') {
          this.$message.error('请输入可参与砍价的人数！')
          return false
        }
        if (this.Bargain.LimitTimeLocal.length == 0) {
          this.$message.error('请输入允许发起的时间！')
          return false
        }else{
          this.Bargain.LimitTimeUnix[0] = new Date(this.Bargain.LimitTimeLocal[0]).getTime()
          this.Bargain.LimitTimeUnix[1] = new Date(this.Bargain.LimitTimeLocal[1]).getTime()
        }
        if (this.Bargain.BargainUserDuration == '') {
          this.$message.error('请输入用户可持续砍价的时间！')
          return false
        }else{
          this.Bargain.BargainUserDurationUnix = this.Bargain.BargainUserDuration * 3600000
        }
        if (this.Bargain.BargainPeopleTime == '') {
          this.$message.error('请输入用户可砍价的次数！')
          return false
        }
        // if (this.Bargain.RulesActivity == '') {
        //   this.$message.error('请输入活动规则！')
        //   return false
        // }
        this.Bargain.create_time = new Date().getTime()
        this.axios.post('bargain/bargainstore',{
          bargain:this.Bargain,
          goods:this.BargainGoods
        }).then((res) => {
          console.log(res);
          if (res.data.errno === 0) {
            this.$message({
              type: 'success',
              message: '添加成功!'
            });
            this.goBackPage()
          }else {
            this.$message.error("异常 ！")
          }
        })
      }
    },
    onEditorChange(e) {
      this.Bargain.BargainDetailEdit = e.html
      console.log(this.Bargain.BargainDetailEdit);
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
    // beforeBargainImg(){
      // this.BargainImgList = []
      // console.log("123");
    // },
    // BargainImgSuccess(res){
    //
    //   console.log(res);
    //   let obj = {}
    //   obj.fileUrl = this.uploaddress+ res.key
    //   this.BargainImgList[0] = obj
    // },
    gettoken(){
      // console.log("12163546498764131");
      this.axios.post('upload/token').then((res) => {
        console.log(res);
        this.uploadToken.token = res.data.data.uploadToken
      })
    },
    BargainGoodsPageChange(val){
      this.goodspage = val;
      //保存到localStorage
      localStorage.setItem('goodsPage', this.goodspage)
      this.showBargainGoodsPopup()
    },
    handleSelectGoods(index,row){
      if ( row.btnType == 'danger') {
        this.delBargainGoods(row.id)
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
            this.BargainGoodsList = []
            NoData[i] = row
            NoData[i].btnType = "danger"
            NoData[i].btnText = "已选中"
            this.BargainGoodsList.push(NoData[i])
          }
        }
        this.dangerGoodsData = NoData
        // console.log(this.dangerGoodsData);
        // console.log(this.BargainGoodsList);
        // if (this.BargainGoodsList.length == 0) {
        //   this.BargainGoodsName = ""
        // }else {
          this.BargainGoods = this.BargainGoodsList[0]
          this.Bargain.BargainDetailEdit = this.BargainGoodsList[0].goods_desc
          this.selectGoodsPopover = false
        // }

      }
    },
    SelectBargainGoods(){
      this.showBargainGoodsPopup()
    },
    showBargainGoodsPopup(){
      this.selectGoodsPopover = true
      this.axios.get('bargain/bargaingoods', {
        params: {
          page: this.goodspage,
          goodsname: this.BargainGoodsInput,
        }
      }).then((res) => {
        // console.log(res);
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
        for (var i = 0; i < this.BargainGoodsList.length; i++) {
          for (var j = 0; j < NoGoodsData.length; j++) {
            if (this.BargainGoodsList[i].id === NoGoodsData[j].id) {
              console.log("123456789");
              NoGoodsData[j].btnType = "danger"
              NoGoodsData[j].btnText = "已选中"
            }
          }
        }
        this.dangerGoodsData = NoGoodsData
        // console.log(this.dangerGoodsData);
        // console.log(this.BargainGoodsList);
      })
    },
    //删除指定商品
    delBargainGoods(id){
        let dataa = []
        for (var i = 0; i < this.BargainGoodsList.length; i++) {
         if (this.BargainGoodsList[i].id === id) {
         }else {
           console.log(this.BargainGoodsList[i]);
           let objj = this.BargainGoodsList[i]
           dataa.push(objj)
         }
        }
        this.BargainGoodsList = dataa
        // this.pointGoodsList.splice( this.pointGoodsList.indexOf( id ), 1 );
        // console.log(this.BargainGoodsList);
        if (this.BargainGoodsList.length == 0) {
          this.BargainGoods = {}
          this.Bargain.BargainDetailEdit = ''
        }
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
