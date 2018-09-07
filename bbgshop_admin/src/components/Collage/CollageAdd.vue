<template lang="html">
  <div class="content-page">
      <div class="content-nav" >
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>店铺运营</el-breadcrumb-item>
              <el-breadcrumb-item :to="{ path: '/dashboard/collagepage' }">拼团管理</el-breadcrumb-item>
              <el-breadcrumb-item>发起拼团</el-breadcrumb-item>
          </el-breadcrumb>
          <div class="operation-nav">
              <el-button type="primary" @click="goBackPage" icon="arrow-left">返回列表</el-button>
          </div>
      </div>
      <div class="content-main">
        <el-form label-width="180px">
          <el-form-item label="发起拼团商品" >
            <el-input :disabled="is_edit" @focus="showCollageGoodsPopup" v-model="CollageGoods.name" placeholder="点击选择拼团商品" >
            </el-input>
          </el-form-item>
          <el-form-item label="商品原价">
            <el-input style="width:100px;" disabled v-model="(CollageGoods.retail_price / 1).toFixed(2)">
            </el-input>
            <div class="itemtip">
              原价不可更改
            </div>
          </el-form-item>
          <el-form-item label="拼团价">
            <el-input type="number" style="width:125px;" :min="0" :max="CollageGoods.retail_price" v-model="Collage.CollageMinPrice"> </el-input>
            <div class="itemtip"> 允许商品的拼团价格，最低为0.01，最高为商品原价 </div>
          </el-form-item>
          <el-form-item label="最多发起次数">
            <el-input type="number" style="width:125px;" :min="1" :max="CollageGoods.goods_number" v-model="Collage.CollageInitNumber"> </el-input>
            <div class="itemtip">如果用户发起，则数值减一</div>
          </el-form-item>

          <el-form-item label="拼团人数">
            <el-input type="number" style="width:125px;" v-model="Collage.CollagePeople" :min="1" > </el-input>
            <div class="itemtip"> 达到此数值即拼团成功 </div>
          </el-form-item>
          <!-- <el-form-item label="是否开启虚拟成团">
            <el-switch
              v-model="Collage.Virtual"
              on-color="#13ce66"
              off-color="#ff4949">
            </el-switch>
            <div class="itemtip"> 系统帮助用户添加拼团成员 </div>
          </el-form-item> -->
          <el-form-item label="用户拼团持续时间">
             <el-input :disabled="is_edit" type="number" placeholder="" style="width:140px;" :min="0" v-model="Collage.CollageUserDuration">
               <template slot="append">小时</template>
            </el-input>
          </el-form-item>
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
                              v-model="Collage.CollageDetailEdit"
                              ref="myQuillEditor"
                              :options="editorOption"
                              @change="onEditorChange($event)"
                      >
                      </quill-editor>
                  </div>
              </template>
            <div class="itemtip"> 默认为选择的商品的详情页 <span style="color:rgb(255, 150, 0)">如要修改请修改</span></div>
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
          <el-col :span="12" style="line-height:37px;font-weight:bold">添加拼团商品</el-col>
          <el-col :span="12" style="text-align:right">
            <el-input style="width:200px;" v-model="CollageGoodsInput" @keyup.13.native="SelectCollageGoods()" placeholder="请输入商品名称"></el-input>
            <el-button type="primary" @click="SelectCollageGoods">搜索</el-button>
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
            <el-pagination style="margin-right:10px;" @current-change="CollageGoodsPageChange" :current-page="goodspage" :page-size="5"
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
      is_edit: false,
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
      Collage:{
        CollageMinPrice: '', //商品低价 可购买的价格
        CollagePeople:'', //可参与拼团的人数
        CollageDetailEdit: '',
        Virtual: true,
        VirtualLocal: 1,
        create_time: '',
        CollageInitNumber: '',
        // LimitTimeLocal: [], //限制时间传统格式
        // LimitTimeUnix: [], //限制时间 时间戳
        CollageUserDuration: '',//用户可持续拼团的时间
        CollageUserDurationUnix: '',//用户可持续拼团的时间 时间戳
      },
      goodspage:1,
      goodstotal:0,
      selectGoodsPopover:false,
      CollageGoodsInput:'',
      CollageGoods: {},
      dangerGoodsData: [],
      CollageGoodsList: [],
      allGoodsData: [],
    }
  },
  mounted(){
    this.id = this.$route.query.id || 0;
    if (this.id !== 0) {
      this.is_edit = true
      this.getInfo()
    }
    this.gettoken()
  },
  methods:{
    //////////////////////////////////编辑是按id获取信息
    getInfo() {
      this.axios.post('collage/findcollageinfoById',{
        id: this.id
      }).then(res => {
        console.log(res);
        this.CollageGoods.name = res.data.data.goods_name
        this.CollageGoods.retail_price = res.data.data.retail_price
        this.Collage.CollageMinPrice = res.data.data.collage_price
        // this.Collage.CollagePeople = res.data.data.least_coll_num
        this.Collage.CollageDetailEdit = res.data.data.activity_detail
        this.Collage.CollageInitNumber = res.data.data.most_init_num
        this.Collage.CollagePeople = res.data.data.least_coll_num
        this.Collage.CollageUserDuration = (res.data.data.user_duration_time / 3600000)
        // this.Collage.CollageMinPrice = res.data.data.collage_price
        // this.Collage.CollageMinPrice = res.data.data.collage_price
      })
    },
    onSubmitInfo(){
      console.log(this.CollageGoods);
      if (this.id !== 0) { //更新
        if (this.Collage.CollageMinPrice == '') {
          this.$message.error('请输入拼团价 ！')
          return false
        }
        if (this.Collage.CollageInitNumber == '') {
          this.$message.error('请输入最多发起次数 ！')
          return false
        }
        if (this.Collage.CollagePeople == '') {
          this.$message.error('请输入拼团人数 ！')
          return false
        }
        if (this.Collage.CollageDetailEdit == '') {
          this.$message.error('请输入活动详情页 ！')
          return false
        }
        this.axios.post('collage/collageupdate',{
          collage:this.Collage,
          id: this.id,
          // goods:this.CollageGoods
        }).then((res) => {
          console.log(res);
          if (res.data.errno === 0) {
            this.$message({
              type: 'success',
              message: '更新成功!'
            });
            this.goBackPage()
          }else {
            this.$message.error("异常 ！ 请退出 ！")
          }

        })
      }else { //创建
        if (this.CollageGoodsList.length == 0) {
          this.$message.error('请选择拼团商品！')
          return false
        }
        if (this.Collage.CollageMinPrice == '') {
          this.$message.error('请输入拼团价！')
          return false
        }
        if (this.Collage.CollageInitNumber == '') {
          this.$message.error('请输入最多发起次数！')
          return false
        }
        if (this.Collage.CollagePeople == '') {
          this.$message.error('请输入拼团人数！')
          return false
        }
        if (this.Collage.CollageUserDuration == '') {
          this.$message.error('请输入用户可持续拼团的时间！')
          return false
        }else{
          this.Collage.CollageUserDurationUnix = this.Collage.CollageUserDuration * 3600000
        }
        this.Collage.create_time = new Date().getTime()
        this.Collage.retail_price = this.CollageGoods.retail_price
        this.Collage.main_img = this.CollageGoods.list_pic_url
        this.Collage.VirtualLocal = this.Collage.Virtual == true ? 1 : 0
        console.log(this.CollageGoodsList);
        console.log(this.Collage);
        this.axios.post('collage/collagestore',{
          collage:this.Collage,
          goods:this.CollageGoods
        }).then((res) => {
          console.log(res);
          this.$message({
            type: 'success',
            message: '添加成功!'
          });
          this.goBackPage()

        })
       }
    },
    onEditorChange(e) {
      this.Collage.CollageDetailEdit = e.html
      console.log(this.Collage.CollageDetailEdit);
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
    CollageGoodsPageChange(val){
      this.goodspage = val;
      //保存到localStorage
      localStorage.setItem('goodsPage', this.goodspage)
      this.showCollageGoodsPopup()
    },
    handleSelectGoods(index,row){
      if ( row.btnType == 'danger') {
        this.delCollageGoods(row.id)
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
            this.CollageGoodsList = []
            NoData[i] = row
            NoData[i].btnType = "danger"
            NoData[i].btnText = "已选中"
            this.CollageGoodsList.push(NoData[i])
          }
        }
        this.dangerGoodsData = NoData
        this.CollageGoods = this.CollageGoodsList[0]
        this.Collage.CollageDetailEdit = this.CollageGoodsList[0].goods_desc
        this.selectGoodsPopover = false
      }
    },
    SelectCollageGoods(){
      this.showCollageGoodsPopup()
    },
    showCollageGoodsPopup(){
      this.selectGoodsPopover = true
      this.axios.get('collage/collagegoods', {
        params: {
          page: this.goodspage,
          goodsname: this.CollageGoodsInput,
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
        for (var i = 0; i < this.CollageGoodsList.length; i++) {
          for (var j = 0; j < NoGoodsData.length; j++) {
            if (this.CollageGoodsList[i].id === NoGoodsData[j].id) {
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
    delCollageGoods(id){
        let dataa = []
        for (var i = 0; i < this.CollageGoodsList.length; i++) {
         if (this.CollageGoodsList[i].id === id) {
         }else {
           console.log(this.CollageGoodsList[i]);
           let objj = this.CollageGoodsList[i]
           dataa.push(objj)
         }
        }
        this.CollageGoodsList = dataa
        if (this.CollageGoodsList.length == 0) {
          this.CollageGoods = {}
          this.Collage.CollageDetailEdit = ''
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
