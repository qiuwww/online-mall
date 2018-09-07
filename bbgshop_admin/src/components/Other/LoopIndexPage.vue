<template lang="html">
  <div class="content-page">
      <div class="content-nav">
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>店铺管理</el-breadcrumb-item>
              <el-breadcrumb-item>首页轮播图管理</el-breadcrumb-item>
          </el-breadcrumb>
      </div>
      <div class="content-page">
        <el-card class="box-card card_item" v-for="(item,index) in LoopList" :key="item.id">
          <!-- {{item}} -->
          <div class="" @click="setsimple(index)">

          <el-upload
            class="card_item_uploader"
            action="http://upload.qiniup.com"
            :data="uploadToken"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
            :before-upload="beforeAvatarUpload">
            <!-- <el-dialog :visible.sync="dialogVisible">
              <img width="100%" :src="dialogImageUrl" alt="">
            </el-dialog> -->
            <img v-if="item.url" :src="item.url" class="card_item_image">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
            <div class="card_item_title">
              <div class="card_item_title_left">
                标题：
              </div>
              <el-input class="card_item_title_right"
              placeholder="标题不展示在前台"
              v-model="item.content"></el-input>
            </div>
            <div class="card_item_route">
              <div class="card_item_title_left">
                链接：
              </div>
              <el-input class="card_item_title_right"
              placeholder="用户点击跳转的前台路由"
              v-model="item.name" @focus="selectLink(index)"></el-input>
            </div>
            <el-button size='small' @click="delimagecard(index)" :plain="true" class="card_item_delete_btn" type="primary">删除此项</el-button>
            <el-button size='small' class="card_item_upload_btn"
            type="danger" @click='sureupload(index)'>确定上传</el-button>
           <!-- {{item.link}} -->
         </div>

        </el-card>
        <el-card class="box-card card_add" >
          <img @click="addloopimage" class="add_icon" src="../../../static/images/add.png"></img>
        </el-card>
            <!-- <el-card class="box-card">
              <div slot="header" class="clearfix">
                <el-row >
                  <el-col :span="12" style="line-height:38px;color:#48576a;">首页轮播图</el-col>
                  <el-col :span="12" style="text-align:right;" >  <el-button @click="clear" type="danger">清除所有</el-button></el-col>
                </el-row>
              </div>
              <div class="image_all_area">
                <el-upload
                  action="http://upload.qiniup.com"
                  list-type="picture-card"
                  :data="uploadToken"
                  :on-preview="handlePictureCardPreview1"
                  :on-remove="handleRemove"
                  :on-success="handlesuccess"
                  :file-list="LoopList"
                  >
                  <i class="el-icon-plus"></i>
                </el-upload>
                <el-dialog :visible.sync="dialogVisible">
                  <img width="100%" :src="dialogImageUrl" alt="">
                </el-dialog>
            </div>
              <el-row>
                <el-col :span="24" style="text-align:right;" >
                <el-button @click="upload" type="primary">确定上传</el-button></el-col>
              </el-row>
            </el-card> -->
      </div>
      <van-popup class="selectpopup" v-model="showSelectPopup">
        <div class="selectpopup_top">
          <div class="selectpopup_left">
            <el-menu
                default-active="1"
                class="select_el_menu"
                @select='elmenuselect'>
                <el-menu-item index="1">
                  <i class="el-icon-setting"></i>
                  <span slot="title">商品</span>
                </el-menu-item>
                <el-menu-item index="2">
                  <i class="el-icon-menu"></i>
                  <span slot="title">分类</span>
                </el-menu-item>
                <el-menu-item index="3">
                  <i class="el-icon-document"></i>
                  <span slot="title">页面</span>
                </el-menu-item>
              </el-menu>
          </div>
          <div class="selectpopup_right" v-if="selectMenuIndex == 1">
            <el-row class="selectpopup_right_elrow">
              <el-col :span="12" class="selectpopup_right_elrow_text">循环图跳转到商品</el-col>
              <el-col :span="12" style="text-align:right;padding-right:20px">
                <el-input style="width:200px;" v-model="goodsRouteInput" @keyup.13.native="SelectgoodsRoute()" placeholder="请输入商品名称"></el-input>
                <el-button type="primary" @click="SelectgoodsRoute">搜索</el-button>
              </el-col>
            </el-row>
            <el-table class="selectpopup_right_table"
            :data="dangerGoodsData" border
            :default-sort = "{prop: 'date', order: 'descending'}" stripe style="width: 100%">
              <el-table-column prop="" label="商品名称">
                <template slot-scope="scope">
                  <div class="show_one_row">
                    {{dangerGoodsData[scope.$index].name}}
                  </div>
                </template>
              </el-table-column>
              <el-table-column prop="action" align="center" label="操作" width="80">
                <template slot-scope="scope">
                    <el-button size="small" :type="scope.row.btnType"
                       @click="handleSelectGoods(scope.$index, scope.row)">{{scope.row.btnText}}</el-button>
                </template>
              </el-table-column>
            </el-table>
              <div class="selectpopup_right_table_page">
                <el-pagination style="margin-right:10px;"
                @current-change="goodsRoutePageChange"
                :current-page="goodspage" :page-size="7"
                  layout="total, prev, pager, next, jumper" :total="goodstotal">
                </el-pagination>
              </div>
          </div>
          <div class="selectpopup_right" v-if="selectMenuIndex == 2">
            <el-row class="selectpopup_right_elrow">
              <el-col :span="24" class="selectpopup_right_elrow_text">循环图跳转到分类</el-col>
            </el-row>

            <div class="selectpopup_right_bottom">
              <el-row class="selectpopup_right_bottom_top_col">
                <el-col :span="7" class="selectpopup_right_bottom_top_col_text">
                  仅跳转到一级分类
                </el-col>
                <el-col :span="17" class="selectpopup_right_bottom_top_col_text">
                  跳转到二级分类
                </el-col>
              </el-row>
              <el-row >
                <el-col :span="6" class="selectpopup_right_bottom_col">
                  <el-radio-group v-model="FirstClassifyRadio"
                  @change="one_radio_change" class="selectpopup_right_bottom_radio_area" >
                    <el-radio class="selectpopup_right_bottom_radio_item" style="float:left"
                    v-for="item in FirstClassifyList" :label="item.id" :key="item.id">{{item.name}}</el-radio>
                  </el-radio-group>
                </el-col>
                <el-col :span="18" class="selectpopup_right_bottom_second_col">
                  <el-radio-group v-model="FirstSecondClassifyRadio"
                  @change="FirstClassifyChange" class="selectpopup_right_bottom_radio_area" >
                    <el-radio class="selectpopup_right_bottom_radio_item" style="float:left"
                    v-for="item in FirstClassifyList" :label="item.id" :key="item.id">{{item.name}}</el-radio>
                  </el-radio-group>
                  <el-radio-group v-model="SecondSecondClassifyRadio"
                  @change="SecondClassifyChange" class="selectpopup_right_bottom_radio_area_second" >
                    <el-radio class="selectpopup_right_bottom_radio_item_second" style="float:left"
                    v-for="item in SecondClassifyList" :label="item.id" :key="item.id">{{item.name}}</el-radio>
                  </el-radio-group>
                </el-col>
              </el-row>
            </div>
          </div>
          <div class="selectpopup_right" v-if="selectMenuIndex == 3">
            <el-row class="selectpopup_right_elrow">
              <el-col :span="24" class="selectpopup_right_elrow_text">循环图跳转到页面</el-col>
            </el-row>
            <div class="selectpopup_right_bottom">
              <el-radio-group v-model="jumpPageRadio"
              @change="jumpPageRadioChange" class="selectpopup_right_bottom_radio_area_page" >
                <el-radio class="selectpopup_right_bottom_radio_item_page" style="float:left"
                v-for="item in jumpPageRadioList" :label="item.id" :key="item.id">{{item.name}}</el-radio>
              </el-radio-group>
            </div>
          </div>
        </div>
        <div class="selectpopup_bottom_left">
          <el-row class="">
            <el-col :span="20" class="selectpopup_bottom_left_route">{{goodsRoute_route}}</el-col>
            <el-col :span="4" style="text-align:right;padding-right:20px">
              <el-button type="primary" @click="sureRouteJump">确定</el-button>
            </el-col>
          </el-row>
        </div>

      </van-popup>
    </div>
</template>

<script>
import api from '@/config/api';
export default {
  data() {
     return {
       uploaddress: api.UploadAddress,
       jumpPageRadio: '',
       jumpPageRadioList: [{
         id: 0,
         name: '砍价页面',
         path: '/pages/Resagin_bargain/Resagin_bargain'
       },{
         id: 1,
         name: '新手指南',
         path: '/pages/ucenter/NoviceGuide/NoviceGuide'
       },{
         id: 2,
         name: '售后指南',
         path: '/pages/ucenter/AftersaleGuide/AftersaleGuide'
       }],
       FirstClassifyRadio: '',
       FirstSecondClassifyRadio: '',
       SecondSecondClassifyRadio: '',
       FirstClassifyList: [],
       SecondClassifyList: [],
       FirstClassifyId: '',
       SecondClassifyId: '',
       goodspage:1,
       goodstotal:0,
       // selectGoodsPopover:false,
       goodsRouteInput:'',
       goodsRoute: {},
       dangerGoodsData: [],
       goodsRouteList: [],
       allGoodsData: [],
       goodsRoute_route: 'No route',

       imageUrl: '',
       uploadToken:{
         token: "",
       },
       showSelectPopup: false,
       dialogImageUrl: '',
       LoopList: [],
       dialogVisible: false,
       selectMenuIndex: 1,
       uploaderHeader: {
         'X-Nideshop-Token': localStorage.getItem('token') || '',
         // 'Access-Control-Allow-Origin:*',
       },
     };
   },
   mounted(){
     this.getLoop()
     this.gettoken()
   },
   methods: {
     //跳转到页面的单选框改变事件
     jumpPageRadioChange(e) {
       console.log(e);
       for (var i = 0; i < this.jumpPageRadioList.length; i++) {
         if (e == this.jumpPageRadioList[i].id) {
           this.goodsRoute.name = this.jumpPageRadioList[i].name + ' (指定页面) '
           this.goodsRoute_route = this.jumpPageRadioList[i].path
         }
       }
     },
     //以下为循环图跳转到分类
     // //二级分类的二级分改变事件
     // second_second_radio_change(e) {
     //   console.log(e);
     // },
     // //二级分类的一级分类改变事件
     // second_one_radio_change(e) {
     //   console.log(e);
     // },
     //一级分类改变事件
     one_radio_change(e) {
       console.log(e);
       for (var i = 0; i < this.FirstClassifyList.length; i++) {
         if (e == this.FirstClassifyList[i].id) {
           this.goodsRoute.name = this.FirstClassifyList[i].name + ' (一级分类) '
         }
       }
       // console.log(this.goodsRoute);
       this.goodsRoute_route = '/pages/category/category?id=' + e
       // this.FirstSecondClassifyRadio = ''
       // this.SecondSecondClassifyRadio = ''
     },
     ///////////////////////////////////////////以下为分类改变事件
     //清空一级分类事件
     FirstClassifyClear() {
       setTimeout(() => {
         console.log("触发清空一级分类事件");
         this.SecondClassifyList = []
         this.FirstClassifyId = ''
         this.SecondClassifyId = ''
       },500)
       //注：延迟是因为清空一级分类也会导致一级分类改变从而搜索二级分类，所以要在搜索二级分类之后清空二级分类
     },
     //一级分类改变触发
     FirstClassifyChange(e) {
       // console.log(e);
       console.log('触发一级分类改变');
       this.FirstClassifyId = e
       this.is_classify_change = parseInt(this.is_classify_change) + 1
       //注: 因为页面刚展示也会触发一级分类改变事件，所以要判断一级分类改变过几次，若没有以下判断会导致刚进入时二级分类为空
       if (this.is_classify_change > 1) {
         this.SecondClassifyId = ''
       }
       this.axios.post('goodsUpdate/findGoodsClassifySecondById', {
         id: e
       }).then(res => {
         console.log(res);
         this.SecondClassifyList = res.data.data
       })
     },
     //二级分类改变事件
     SecondClassifyChange(e) {
       // console.log(e);
       console.log('触发二级分类改变');
       this.SecondClassifyId = e
       for (var i = 0; i < this.SecondClassifyList.length; i++) {
         if (e == this.SecondClassifyList[i].id) {
           this.goodsRoute.name = this.SecondClassifyList[i].name + ' (二级分类) '
         }
       }
       this.goodsRoute_route = '/pages/category/category?id=' + e
       this.FirstClassifyRadio = ''

     },
     //获取一级分类列表
     findGoodsClassifyFirst() {
       this.axios.post('goodsUpdate/findGoodsClassifyFirst', {}).then(res => {
         console.log(res.data.data);
         this.FirstClassifyList = res.data.data
       })
     },

     //确定路径
     sureRouteJump() {
       console.log(this.goodsRoute);
       console.log(this.LoopList[this.simple]);
       // if (this.selectMenuIndex == 1) {
         if (this.goodsRoute_route == 'No route' || this.goodsRoute_route == '/') {
           this.LoopList[this.simple].link = '/'
           this.LoopList[this.simple].name = '无跳转'
         }else {
           this.LoopList[this.simple].link = this.goodsRoute_route
           this.LoopList[this.simple].name = this.goodsRoute.name
         }
         this.showSelectPopup = false
         this.goodsRoute = {}
       // }

     },
     // 以下为商品事件
     goodsRoutePageChange(val){
       this.goodspage = val;
       //保存到localStorage
       localStorage.setItem('goodsPage', this.goodspage)
       this.showgoodsRoutePopup()
     },
     handleSelectGoods(index,row){
       if ( row.btnType == 'danger') {
         this.delgoodsRoute(row.id)
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
             this.goodsRouteList = []
             NoData[i] = row
             NoData[i].btnType = "danger"
             NoData[i].btnText = "已选中"
             this.goodsRouteList.push(NoData[i])
           }
         }
         this.dangerGoodsData = NoData
         this.goodsRoute = this.goodsRouteList[0]
         // if (true) {
           this.goodsRoute_route = '/pages/goods/goods?id=' + this.goodsRouteList[0].id
         // }
       }
     },
     SelectgoodsRoute(){
       this.showgoodsRoutePopup()
     },
     showgoodsRoutePopup(){
       // this.selectGoodsPopover = true
       this.axios.get('index/goodsroute', {
         params: {
           page: this.goodspage,
           goodsname: this.goodsRouteInput,
         }
       }).then((res) => {
         console.log(res);
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
         for (var i = 0; i < this.goodsRouteList.length; i++) {
           for (var j = 0; j < NoGoodsData.length; j++) {
             if (this.goodsRouteList[i].id === NoGoodsData[j].id) {
               console.log("123456789");
               NoGoodsData[j].btnType = "danger"
               NoGoodsData[j].btnText = "已选中"
             }
           }
         }
         this.dangerGoodsData = NoGoodsData
         // console.log(this.dangerGoodsData);
         // console.log(this.goodsRouteList);
       })
     },
     //删除指定商品
     delgoodsRoute(id){
         let dataa = []
         for (var i = 0; i < this.goodsRouteList.length; i++) {
          if (this.goodsRouteList[i].id === id) {
          }else {
            console.log(this.goodsRouteList[i]);
            let objj = this.goodsRouteList[i]
            dataa.push(objj)
          }
         }
         this.goodsRouteList = dataa
         // this.pointGoodsList.splice( this.pointGoodsList.indexOf( id ), 1 );
         // console.log(this.goodsRouteList);
         if (this.goodsRouteList.length == 0) {
           this.goodsRoute = {}
           this.goodsRoute_route = 'No route'
           // this.Bargain.BargainDetailEdit = ''
         }
     },



     elmenuselect(index,indexPath){
       console.log(index,indexPath);
       this.selectMenuIndex = index
       this.jumpPageRadio = ''
       if (index == 1) {
         this.showgoodsRoutePopup()
       }else if (index == 2) {
         this.findGoodsClassifyFirst()
       }
     },
     // handleOpen(key, keyPath) {
     //    console.log(key, keyPath);
     //  },
     //  handleClose(key, keyPath) {
     //    console.log(key, keyPath);
     //  },
     selectLink(index) {
       this.showSelectPopup = true
       // console.log(index);
       this.setsimple(index)
       this.goodsRoute_route = this.LoopList[index].link
       this.showgoodsRoutePopup()
     },
     //确定上传
     sureupload(index) {
       this.setsimple(index)
       // console.log(this.LoopList);
       // console.log(this.LoopList[index]);
       if (this.LoopList[index].url == '') {
         this.$message.error('请选择轮播图 !')
         return false
       }
       const loading = this.$loading({
         lock: true,
         text: 'Loading...',
         spinner: 'el-icon-loading',
         background: 'rgba(0, 0, 0, 0.7)'
       });
       setTimeout(() => {
         // console.log(this.LoopList[this.simple]);
         this.axios.post('index/updateloopimageByIdorNot',{
           info: this.LoopList[index]
         }).then(res => {
           console.log(res);
           if (res.status == 200) {
             this.$notify({
               title: '提示',
               type: 'success',
               message: res.data.errmsg,
               duration: 2000
             });
             this.getLoop()
           }
           loading.close();
         })
       },300)
     },
     //设置index
     setsimple(e) {
       this.simple = e
       console.log(this.simple);
     },
     //获取上传token
     gettoken() {
       this.axios.post('upload/token').then((res) => {
         // console.log('上传的token：' + res.data.data.uploadToken);
         this.uploadToken.token = res.data.data.uploadToken
       })
     },
     //删除图片项
     delimagecard(e) {
       console.log(e);
       // if (this.LoopList[e].content == '' || this.LoopList[e].link == '') {
       //
       // }
       this.$confirm('您即将删除 ' + this.LoopList[e].content + '，操作立即生效, 是否继续 ?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          // console.log(this.LoopListRes[e]);
          // console.log(this.LoopList[e]);
          this.axios.post('index/delloopimageById',{
            id: this.LoopList[e].id
          }).then(res => {
            console.log(res);
            if (res.data.errno == 0) {
              this.getLoop()
              this.$message({
                type: 'success',
                message: '删除成功!'
              });
            }
          })
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '取消删除 !'
          });
        });
     },
     //添加图片项
     addloopimage() {
       let obj = {}
       obj.url = ''
       obj.link = ''
       obj.content = ''
       obj.id = ''
       this.LoopList.push(obj)
       console.log(this.LoopList);
     },
     //图片上传成功后数据重组
     handleAvatarSuccess(res, file) {
       console.log(res, file);
       let index = this.simple
       this.LoopList[index].url = this.uploaddress + file.response.key;
       this.LoopList[index].link = this.LoopList[index].link
       this.LoopList[index].content = this.LoopList[index].content
       this.LoopList[index].id = this.LoopList[index].id
       this.LoopList[index].name = this.LoopList[index].name
       console.log(this.LoopList[index]);
       // console.log(res, file, index);
        // this.imageUrl = this.uploaddress + file.response.key;
      },
      beforeAvatarUpload(file) {
        // console.log(file);
        // const isJPG = file.type === 'image/jpeg';
        // const isLt2M = file.size / 1024 / 1024 < 2;
        //
        // if (!isJPG) {
        //   this.$message.error('上传头像图片只能是 JPG 格式!');
        // }
        // if (!isLt2M) {
        //   this.$message.error('上传头像图片大小不能超过 2MB!');
        // }
        // return isJPG && isLt2M;
      },
     getLoop(){
       this.axios.post('index/findindexloop').then((res) => {
         console.log(res.data.data);
         this.LoopList = []
         var loop = res.data.data
         for (var i = 0; i < loop.length; i++) {
           // array[i]
           // console.log(loop);
           let obj = {}
           obj.url = loop[i].image_url
           obj.link = loop[i].link
           obj.content = loop[i].content
           obj.id = loop[i].id
           obj.name = loop[i].name
           this.LoopList.push(obj)
         }
         this.gettoken()
       })
     },

     // handleExceed1(files, fileList) {
     //   this.$message.warning(`当前限制选择 3 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`);
     // },
   }
}
</script>

<style lang="css" scoped>
.selectpopup_right_bottom_top_col_text {
  text-align: center;
  font-size: 16px;
  color: #757575;
  /* font-weight: bold; */
}
.selectpopup_right_bottom_top_col {
  /* border:1px solid black; */
  height: 30px;
  line-height: 30px;
}
.selectpopup_right_bottom_radio_area_page {
  /* border: 1px solid black; */
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.selectpopup_right_bottom_second_col {
  display: flex;
  justify-content: center;
  align-items: center;
  /* border:1px solid black; */
  /* width:  */
  height: 360px;
  margin-top: -15px;
  width: 480px;
}


.selectpopup_right_bottom_col {
  display: flex;
  justify-content: center;
  align-items: center;
  border-right: 2px solid #fff;
  /* border:1px solid black; */
  /* width:  */
  height: 360px;
  margin-top: -15px;
  width: 200px;
}
.selectpopup_right_bottom_radio_item {
  /* border:1px solid black; */
  margin: 6px 10px;
  /* float: left; */

}
.selectpopup_right_bottom_radio_item_second {
  /* border:1px solid black; */
  margin: 4px 10px;
  float: left;
}
.selectpopup_right_bottom_radio_area_second {
  /* border:1px solid black; */
  width: 150px;
  height: 200px;
  overflow-y: auto;
  text-align: center;
}
.selectpopup_right_bottom_radio_area {
  /* border:1px solid black; */
  width: 102px;
  text-align: center;
  /* margin-left: 20px; */
  /* margin-top: 10px; */
}
.selectpopup_right_bottom {
  /* border:1px solid black; */
  background: #eee;
  width: 680px;
  height: 375px;
  /* display: flex; */
  /* justify-content: center; */
  /* align-items: center; */

}
.show_one_row {
  overflow : hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
}
.selectpopup_bottom_left_route {
  text-align: center;
  font-size: 22px;
  color: #ff4456;
}
.selectpopup_bottom_left {
  border-top:1px solid #eee;
  height: 67px;
  line-height: 67px;

}
.selectpopup_right_table_page {
  /* border: 1px solid black; */
  height:35px;
  line-height: 35px;
  text-align: right;
}
.selectpopup_right_table {
  /* border:1px solid black; */
  height: 341px;
}
.selectpopup_right_elrow {
  /* border:1px solid black; */
  border-bottom: 1px solid #eee;
  height: 55px;
  line-height: 55px;
}
.selectpopup_right_elrow_text {
  padding-left: 15px;
  color: #757575;
  font-size: 16px;

}
.selectpopup_right {
  width: 680px;
  height: 100%;
  /* border:1px solid black; */
  float: left;

}
.select_el_menu {
  width: 120px;
  height: 100%;
}
.selectpopup_left {
  width: 120px;
  /* border: 1px solid black; */
  height: 100%;
  float: left;
}
.selectpopup_top {
  width: 800px;
  height: 430px;
}
.selectpopup {
  width: 800px;
  height: 500px;
}
.avatar-uploader-icon {
  position: absolute;
  top: 4px;
  left: 6px;
  font-size: 28px;
  color: #8c939d;
  width: 150px;
  height: 120px;
  line-height: 120px;
  text-align: center;
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
}
.avatar-uploader-icon:hover {
  border-color: #20a0ff;
}
.add_icon {
  width: 50px;
  height: 50px;
}
.card_add {
  /* border:1px solid black; */
  float: left;
  height: 130px;
  width: 130px;
  margin: 10px;
  display: flex;
  justify-content: center;
  align-items: center;
}


.card_item_delete_btn {
  position: absolute;
  top: 95px;
  right: 82px;
}
.card_item_upload_btn {
  position: absolute;
  top: 95px;
  right: 5px;
}
.card_item_title_right {
  float: right;
  width: 190px;
  font-size: 12px;
}
.card_item_title_left {
  float: left;
  height: 36px;
  line-height: 36px;
  font-size: 13px;

}
.card_item_route {
  position: absolute;
  /* border:1px solid black; */
  left: 165px;
  right: 5px;
  height: 36px;
  top: 50px;
}
.card_item_title {
  position: absolute;
  /* border:1px solid black; */
  left: 165px;
  right: 5px;
  height: 36px;
  top: 8px;
}
.card_item_uploader {
  position: absolute;
  top: 0px;
  left: 0px;
  /* border: 1px dashed #d9d9d9; */
  /* border-radius: 6px; */
  /* cursor: pointer; */
  /* position: relative; */
  /* overflow: hidden; */
}
.el-card__body {
  padding: 0px;
  width: 400px;
  height: 130px;
  position: absolute;
}
.card_item_image {
  width: 150px;
  height: 120px;
  position: absolute;
  top: 5px;
  left: 10px;
  /* gl */
}
.card_item {
  width: 400px;
  height: 130px;
  margin: 10px;
  float: left;
  position: relative;
}
/* .image_all_area {
  border: 1px solid black;
} */
/* .el-upload-list--picture-card .el-upload-list__item {
  width: 100% !important;
  height: 100% !important;
} */
</style>
