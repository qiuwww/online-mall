<template>
<div class="content-page" ref="element">
  <div class="content-nav">
    <el-breadcrumb class="breadcrumb" separator="/">
      <el-breadcrumb-item :to="{ name: 'dashboard' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item :to="{ name: 'goods' }">商品管理</el-breadcrumb-item>
      <el-breadcrumb-item>{{infoForm.id == 0 ? '添加商品' : '编辑商品'}}</el-breadcrumb-item>
    </el-breadcrumb>
    <div class="operation-nav">
      <el-button type="primary" @click="goBackPage" icon="arrow-left">返回列表</el-button>
    </div>
  </div>
  <div class="content-main">
    <div class="form-table-box">
      <el-form ref="infoForm" :model="infoForm" label-width="180px">
        <el-form-item label="所属分类">
          <el-select @change="FirstClassifyChange" v-model="FirstClassifyId" @clear="FirstClassifyClear" clearable placeholder="请选择一级分类">
            <el-option v-for="item in FirstClassifyList" :key="item.id" :label="item.name" :value="item.id">
            </el-option>
          </el-select>
          <el-select @change="SecondClassifyChange" v-model="SecondClassifyId" clearable placeholder="请选择二级分类">
            <el-option v-for="item in SecondClassifyList" :key="item.id" :label="item.name" :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="商品名称">
          <el-input type="textarea" v-model="infoForm.name"></el-input>
        </el-form-item>
        <el-form-item label="商品简介">
          <el-input type="textarea" v-model="infoForm.brief" :rows="3"></el-input>
        </el-form-item>
        <el-form-item label="商品主图">
          <el-upload action="http://upload.qiniup.com"
          :data="uploadToken"
          list-type="picture-card"
          :limit='1'
          :on-success="MainImgSuccess"
          :on-preview="handlePictureCardPreviewMain"
          :headers="uploaderHeader"
          :file-list="GoodsMainImg">
            <i class="el-icon-plus"></i>
          </el-upload>
          <el-dialog :visible.sync="dialogVisibleMain">
              <img width="100%" :src="PictureCardPreviewMain" alt="">
            </el-dialog>
          <div class="form-tips">注：请上传一张 ！ 上传多张以新上传的图片为准</div>
        </el-form-item>
        <el-form-item label="商品主页轮播图">
          <el-upload
          action="http://upload.qiniup.com"
          list-type="picture-card"
          :multiple="true"
          :data="uploadToken"
          :headers="uploaderHeader"
          :on-preview="handlePictureCardPreviewLoop"
          :on-remove="loophandleRemove"
          :on-success="loophandlesuccess"
          :file-list="LoopImgList">
          <i class="el-icon-plus"></i>
          </el-upload>
          <el-dialog :visible.sync="dialogVisibleLoop">
            <img width="100%" :src="PictureCardPreviewLoop" alt="">
          </el-dialog>
          <div class="form-tips">注：商品详情页的轮播图</div>
        </el-form-item>
        <el-form-item label="商品规格">
          <template v-for="(item, keyindex) in SpecificationsKey.keylist" >
            <div class="SpecificationsKey_area">
              <el-input class="SpecificationsKey_area_key_input"
              v-model="SpecificationsKey.keylist[keyindex].value"
              :placeholder="'规格名' + keyindex" @keyup.native="updateTableTitleData()">
              <template slot="prepend">
                规格名
              </template>
              <template slot="append">
                <span style='color:#ff4444;font-weight:bold' v-if="keyindex > 0" @click="delSpecKey(keyindex)">删除规格</span>
                <span style='color:#673ab7;font-weight:bold' v-if="keyindex == 0" @click="addSpecKey(keyindex)">新增规格</span>
              </template>
            </el-input>
            <template v-for="(item, valueindex) in SpecificationsKey.keylist[keyindex].valuelist">
              <div class="SpecificationsValue_area">
                <el-input
                v-model="SpecificationsKey.keylist[keyindex].valuelist[valueindex].value"
                :placeholder="'规格值' + keyindex + '_' + valueindex" @keyup.native="updateTableData()"
                >
                <template slot="prepend">
                  规格值
                </template>
                <template slot="append">
                  <span style='color:#ff4444;font-weight:bold' v-if="valueindex > 0" @click="delSpecValue(keyindex,valueindex)">删除值</span>
                  <span style='color:#03a9f4;font-weight:bold' v-if="valueindex == 0" @click="addSpecValue(keyindex)">新增值</span>
                </template>
              </el-input>
              </div>
            </template>
            </div>
          </template>
        </el-form-item>
        <el-form-item label="">
          <div class="form-tips">
            请务必注意 ！<span style="color:#ff6666;"> 修改规格实质是删除重建 ！ 所以会导致用户正在操作的商品发生不可预知的错误 ！</span>
          </div>
        </el-form-item>
        <el-form-item label="规格明细">
          <el-table :data="tableData" border style="width: 100%">
            <el-table-column :label="title_1" v-if="title_1" align='center'>
              <template slot-scope="scope">
                {{tableData[scope.$index].value_1}}
              </template>
            </el-table-column>
            <el-table-column :label="title_2" v-if="title_2" align='center'>
              <template slot-scope="scope">
                {{tableData[scope.$index].value_2}}
              </template>
            </el-table-column>
            <el-table-column :label="title_3" v-if="title_3" align='center'>
              <template slot-scope="scope">
                {{tableData[scope.$index].value_3}}
              </template>
            </el-table-column>
            <el-table-column label="价格" align='center'>
              <template slot-scope="scope">
                    <el-input size="small" type="number"
                    @change="InputPrice(scope.$index, scope.row)"
                    v-model="tableData[scope.$index].price"
                        placeholder="请输入价格" >
                    </el-input>
              </template>
            </el-table-column>
            <el-table-column label="库存" align='center'>
              <template slot-scope="scope">
                  <el-input size="small" type="number"
                  @change="InputStock(scope.$index, scope.row)"
                  v-model="tableData[scope.$index].stock"
                        placeholder="请输入库存">
                  </el-input>
              </template>
            </el-table-column>
          </el-table>
        </el-form-item>
        <el-form-item label="批量设置">
          <el-row>
            <el-col :span="6">
              <el-input type="number" @change="SyncSetAllPrice()" v-model="sync_price" placeholder="批量设置价格">
              </el-input>
            </el-col>
            <el-col :span="6" style="margin-left:20px;">
              <el-input type="number" @change="SyncSetAllStock()" v-model="sync_stock" placeholder="批量设置库存">
              </el-input>
            </el-col>
          </el-row>
          <div class="form-tips">
            批量设置所有规格的价格和库存，请输入整数 ！ <span style="color:#ff6666;">修改规格后请重新设置 ！</span>
          </div>
        </el-form-item>
        <el-form-item label="商品详情">
          <template>
            <div style="margin-top:-25px;">
                    <!-- 图片上传组件辅助-->
              <el-upload
                class="avatar-uploader"
                action="http://upload.qiniup.com"
                :multiple="true"
                :data="uploadToken"
                :headers="uploaderHeader"
                :show-file-list="false"
                :on-success="detailhandlesuccess"
                :on-error="uploadError"
                :before-upload="beforeUpload">
              </el-upload>
                  <!--富文本编辑器组件-->
              <el-row v-loading="quillUpdateImg">
                  <quill-editor
                      v-model="infoForm.desc"
                      ref="myQuillEditor"
                      :options="editorOption"
                      @change="onEditorChange($event)"
                  >
                  </quill-editor>
              </el-row>
            </div>
          </template>
        </el-form-item>
        <el-form-item label="价格">
          <el-input type="number" :min="1" v-model="infoForm.price" @change="changePrices()" placeholder="设置价格"></el-input>
          <div class="form-tips">
            此价格为显示在商品列表中的价格，<span style="color:#ff6666;">默认为规格种类的价格最小值</span>
          </div>
        </el-form-item>
        <el-form-item label="划线价">
          <el-input type="number" :min="1" v-model="infoForm.extraPrice" placeholder="设置划线价"></el-input>
          <div class="form-tips">
            此价格为显示在商品页中的<span style="color:#ff6f00;">真实价格旁边被划掉的价格,例如
                  <span style="color:#757575;text-decoration:line-through;">￥988</span></span> ，
            <span style="color:#ff6666;">默认为价格值的 1.22 倍</span>
          </div>
        </el-form-item>
        <el-form-item label="成本价">
          <el-input type="number" :min="1" v-model="infoForm.cost_price" placeholder="设置成本价"></el-input>
          <div class="form-tips">
            此价格为该商品的<span style="color:#ff6f00;">成本价格，不参与前台计算，仅存储</span> ，
            <span style="color:#ff6666;">默认为 0 </span>
          </div>
        </el-form-item>
        <el-form-item label="库存">
          <el-input type="number" :min="0" v-model="infoForm.num" placeholder="设置库存"></el-input>
          <div class="form-tips">
            此库存为显示在商品列表中的库存，<span style="color:#ff6666;">默认为规格种类的库存累计值</span>
          </div>
        </el-form-item>
        <el-form-item label="运费">
          <el-radio-group v-model="infoForm.freight_type" @change='fright_model_changed'>
            <el-radio :label="0">统一运费</el-radio>
            <el-radio :label="1">运费模板</el-radio>
          </el-radio-group>
          <div class="" v-if="infoForm.freight_type == 0" style="margin-top:5px;">
            <el-input type="number" :min="0" v-model="infoForm.freight_price" placeholder="设置统一运费"></el-input>
            <div class="form-tips">
              用户下单时会<span style="color:#ff6666;"> 加上此数值 </span>
            </div>
          </div>
          <div class="" style="margin-top:5px;" v-if="infoForm.freight_type == 1">
            <el-select v-model="infoForm.freight_template" placeholder="请选择运费模板" @change='fright_model_select_changed'>
              <el-option
                v-for="item in fright_templete"
                :key="item.id"
                :label="item.temp_name"
                :value="item.id">
              </el-option>
            </el-select>
            <div class="form-tips">
              用户下单时会<span style="color:#ff6666;"> 按此模板计算运费 </span>
            </div>
          </div>
        </el-form-item>
        <el-form-item label="供货商">
          <!-- <el-input type="number" :min="0" v-model="infoForm.num" placeholder="设置积分"></el-input> -->
          <el-select v-model="infoForm.supplier_id" placeholder="请选择供货商" @change='supplier_select_changed'>
            <el-option
              v-for="item in supplier_list"
              :key="item.id"
              :label="item.name"
              :value="item.id">
            </el-option>
          </el-select>
          <div class="form-tips">
            此商品的<span style="color:#ff6666;"> 供货商 </span>
          </div>
        </el-form-item>
        <!-- <el-form-item label="积分">
          <el-input type="number" :min="0" v-model="infoForm.num" placeholder="设置积分"></el-input>
          <div class="form-tips">
            用户购买后可获得的积分，<span style="color:#ff6666;">默认为规格种类的库存累计值</span>
          </div>
        </el-form-item> -->
        <el-form-item label="是否需要身份信息">
          <el-switch on-text="" off-text="" v-model="infoForm.Identity"></el-switch>
          <div class="form-tips">
            <span style="color:#ff6666;"> 需要身份信息的商品在下单时需要用户填写身份证信息 </span>
          </div>
        </el-form-item>
        <el-form-item label="上架">
          <el-switch on-text="" off-text="" v-model="infoForm.sale"></el-switch>
        </el-form-item>
        <el-form-item label="新品">
          <el-switch on-text="" off-text="" v-model="infoForm.new"></el-switch>
        </el-form-item>
        <el-form-item label="人气">
          <el-switch on-text="" off-text="" v-model="infoForm.hot"></el-switch>
        </el-form-item>
        <el-form-item label="排序">
          <el-input type="number" :min="0" v-model="infoForm.short_order" placeholder="设置权重"></el-input>
          <div class="form-tips">
            请注意：<span style="color:#ff6666;"> 数值越大则会显示在最前面 </span>
          </div>
        </el-form-item>

        <el-form-item>
          <!-- <el-button @click="showSku">规格</el-button> -->
          <el-button type="primary" @click="onSubmitInfo">确定保存</el-button>
          <el-button @click="goBackPage">取消</el-button>
        </el-form-item>
      </el-form>

    </div>
  </div>
</div>
</template>

<script>
import { Toast } from 'vant'
import api from '@/config/api';
//以下为富文本配置
const toolbarOptions = [
  ['bold', 'italic', 'underline', 'strike'], // toggled buttons
  [{'header': 1}, {'header': 2}], // custom button values
  [{'list': 'ordered'}, {'list': 'bullet'}],
  [{'script': 'sub'}, {'script': 'super'}], // superscript/subscript
  [{ 'align': 'center' }],
  ['image'],
  ['clean'] // remove formatting button
]
export default {
  data() {
    return {
      uploaddress: api.UploadAddress,
      goodsId: 0,
      supplier_list: [],//供货商列表
      // fright_model: 0,//运费的默认选项
      fright_model_select: '',//运费模板下拉列表的绑定值
      fright_templete: [],//运费模板列表
      // select_freight_tem_id: '',//用户选中的运费模板的 下拉类表项
      sync_price: '',//批量设置的价格
      sync_stock: '',//批量设置的库存
      del_value: '',//用户删除的value值 ，用来更新表格数据
      is_classify_change: 0, //用来判断分类改变过几次
      FirstClassifyList: [],
      FirstClassifyId: '',
      SecondClassifyList: [],
      SecondClassifyId: '',
      uploaderHeader: {
        'X-Nideshop-Token': localStorage.getItem('token') || '',
      }, // 有的图片服务器要求请求头需要有token之类的参数，写在这里
      uploadToken: {
        token: ''
      },
      dialogVisibleMain: false, //主图 查看
      PictureCardPreviewMain: '', //主图 查看的链接
      dialogVisibleLoop: false,//循环图 查看
      PictureCardPreviewLoop: '',//循环图查看到呃链接
      GoodsMainImg: [],
      unresoldLoopImg: [],
      LoopImgList: [],
      infoForm: {
        id: 0,
        name: '',
        brief: '',
        desc: '',
        num: 0,
        hot: 0,
        new: 0,
        sale: 0,
        main_img: '',
        loop_img: [],
        price: 0.00,
        extraPrice: 0.00,
        is_sale: 0,
        is_hot: 0,
        is_new: 0,
        freight_price: 0.00,
        freight_template: '',
        cost_price: 0.00,
        freight_type: 0,
        short_order: 0,
        supplier_id: '',//供货商id
        supplier_name: '',//供货商名称
        Identity: 0,//是否需要身份信息
      },
      quillUpdateImg: false, // 根据图片上传状态来确定是否显示loading动画，刚开始是false,不显示
      //富文本配置
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
      skuInfo: {},
      tableData: [],
      tabletitleData: [],
      SpecificationsKey: {
        keylist: [{
          value: '',
          valuelist: [{
            value: ''
          }]
        }]
      },
      title_1: '',
      title_2: '',
      title_3: '',
      unDeacartesRideList: [],//未经过笛卡尔乘积的数组 后台重组数据
      DescartesRideList: [],//进过笛卡尔乘积之后的数组 用来判断信息是否完整
      tableOldData: '',
      tableOldTitleData: [], //初始title的值

    }
  },
  mounted() {
    this.goodsId = this.$route.query.id || 0;
    this.infoForm.id = this.goodsId
    // console.log(this.goodsId); //goodsId意义不大，主要是infoForm.id
    if (this.goodsId == 0) {
      this.is_classify_change = 2
    } else {
      this.getGoodsInfo()
    }
    this.gettoken();
    this.getsupplier();
    this.findGoodsClassifyFirst()
  },
  methods: {
    getsupplier() {
      this.axios.post('goodsUpdate/getsupplier').then(res => {
        console.log(res);
        this.supplier_list = res.data.data
        // this.fright_templete = res.data.data
      })
    },
    //供货商下拉列表项改变
    supplier_select_changed(e){
      for (var i = 0; i < this.supplier_list.length; i++) {
        if (this.supplier_list[i].id == e) {
          this.infoForm.supplier_name = this.supplier_list[i].name
          this.infoForm.supplier_id = this.supplier_list[i].id
        }
      }
      console.log(this.infoForm);
    },
    //运费模板项改变
    fright_model_select_changed(e) {
      // this.infoForm.freight_template = e
      console.log(this.infoForm.freight_template);
    },
    //运费设置更改
    fright_model_changed(e) {
      // this.infoForm.freight = 0.00
      if (e == 1) {
        this.axios.post('goodsUpdate/getfrighttempletelist').then(res => {
          console.log(res);
          this.fright_templete = res.data.data
        })
      }else {
        // this.fright_templete = []
      }
      // console.log(this.infoForm.freight);
      // console.log(this.infoForm.freight_type);
    },
    //提交表单
    onSubmitInfo() {
      this.infoForm.is_sale = this.infoForm.sale ? 1 : 0
      this.infoForm.is_hot = this.infoForm.hot ? 1 : 0
      this.infoForm.is_new = this.infoForm.new ? 1 : 0
      console.log(this.infoForm);
      console.log(this.tableData);
      console.log(this.FirstClassifyId);
      console.log(this.SecondClassifyId);
      if(this.FirstClassifyId == '' || this.SecondClassifyId == ''){
        this.$message.error("请选择分类 ！")
        return false
      }
      if (this.infoForm.freight_type == 0 && Number(this.infoForm.freight_price) < 0) {
        this.$message.error("运费设置有误 ！")
        return false
      }
      if (this.infoForm.freight_type == 1 &&( this.infoForm.freight_template == '' || Number(this.infoForm.freight_template == 0))) {
        this.$message.error("运费设置有误 ！")
        return false
      }
      if (this.infoForm.supplier_id == '' || parseInt(this.infoForm.supplier_id) == 0 || this.infoForm.supplier_name == '') {
        this.$message.error("请选择供货商 ！")
        return false
      }
      if (Number(this.infoForm.short_order) < 0) {
        this.$message.error("排序不能小于 0 ！")
        return false
      }
      if(this.infoForm.name == '' || this.infoForm.brief == '' || this.infoForm.desc == ''
      || this.infoForm.num < 0 || this.infoForm.main_img == '' || this.infoForm.loop_img.length == 0 ){
        this.$message.error("信息不完整 ！")
        return false
      }
      if (this.tableData == '' || this.tableData.length == 0) {
        this.$message.error("商品至少要有一种规格 ！")
        return false
      }
      for (var i = 0; i < this.tableData.length; i++) {
          if (this.tableData[i].price == '' || this.tableData[i].stock == '' || this.tableData[i].value_1 == '' ) {
            this.$message.error("规格1，价格，库存信息不完整 ！")
            return false
          }
          if (this.tableData[i].value_2 && (this.tableData[i].value_2 == '' || typeof(this.tableData[i].value_2) == 'undefined')) {
            this.$message.error("规格2信息不完整 ！")
            return false
          }
          if (this.tableData[i].value_3 && (this.tableData[i].value_3 == '' || typeof(this.tableData[i].value_3) == 'undefined')) {
            this.$message.error("规格3信息不完整 ！")
            return false
          }
      }
      const loading = this.$loading({
        lock: true,
        text: 'Loading...',
        spinner: 'el-icon-loading',
        background: 'rgba(0, 0, 0, 0.7)'
      });
      for (var p = 0; p < this.tabletitleData.length; p++) {
        if (this.tabletitleData[p] == '') {
          this.tabletitleData.splice(p, 1)
        }
      }
      //避免一些诡异的情况 再次核实title值有没有空值  有就去掉
      console.log("all_ok");
        this.axios.post('goodsUpdate/goodsstore',{
          info: this.infoForm,
          classifyid: this.SecondClassifyId
        }).then(resgoods => {
          console.log(resgoods);
          if (resgoods.data.errno === 200 || resgoods.data.errno === 400 ) {
            this.$notify({
              title: '成功',
              message: resgoods.data.errmsg,
              type: 'success',
              duration: 2000
            });
            let after_id = resgoods.data.data
            this.axios.post('goodsUpdate/specifystore',{
              id: after_id,
              oldtitle: this.tableOldTitleData,
              title: this.tabletitleData,
              value: this.tableData,
              unDeacartesList: this.unDeacartesRideList
            }).then(resspec => {
              console.log(resspec);
              if (resspec.data.errno === 200 || resspec.data.errno === 400){
                loading.close();
                this.$notify({
                  title: '成功',
                  message: resspec.data.errmsg,
                  type: 'success',
                  duration: 2000
                });
                Toast('写入成功 ！ 已返回 ！ ')
                setTimeout(() => {
                  this.goBackPage()
                },417)
              }else {
                loading.close();
                this.$notify.error({
                  title: '错误',
                  message: '写入失败 ！ 异常 ！！！'
                });
              }
            })
          }else {
            loading.close();
            this.$notify.error({
              title: '错误',
              message: '写入失败 ！ 异常 ！！！'
            });
          }
        })
    },
    ////////////////////////////////////////////以下为表格更新操作
    SyncSetAllPrice() {
      for (var i = 0; i < this.tableData.length; i++) {
        this.tableData[i].price = this.sync_price
      }
      this.infoForm.price = this.sync_price
      this.changePrices()
    },
    SyncSetAllStock() {
      for (var i = 0; i < this.tableData.length; i++) {
        this.tableData[i].stock = this.sync_stock
      }
      this.infoForm.num = this.sync_stock * this.tableData.length
    },
    changePrices() {
      this.infoForm.extraPrice = (parseInt(this.infoForm.price) * 1.22).toFixed(2)
      // this.infoForm.cost_price = (parseInt(this.infoForm.price) * 0.88).toFixed(2)
    },
    InputPrice(index,row) {
      var minprice = this.tableData[0].price
      for (var i = 0; i < this.tableData.length; i++) {
        if ((this.tableData[i].price - minprice) < 0) {
          minprice = this.tableData[i].price
        }
      }
      this.infoForm.price = minprice
      this.changePrices()
      this.updateTableData()
    },
    InputStock(index,row) {
      // var minstock = this.tableData[0].stock
      let num = 0
      for (var i = 0; i < this.tableData.length; i++) {
        num = Number(this.tableData[i].stock) + Number(num)
        // if ((this.tableData[i].stock - minstock) < 0) {
        //   minstock = this.tableData[i].stock
        // }
      }
      // this.infoForm.num = minstock
      this.infoForm.num = num
      this.updateTableData()
      // console.log(this.tableData);
    },
    ////////////////////////////////////////////以下为界面的规格事件
    //更新表格
    updateTableData() {
      console.log('更新表格');
        let list = []
        console.log(this.SpecificationsKey.keylist);
        for (var i = 0; i < this.SpecificationsKey.keylist.length; i++) {
          let column = []
          for (var j = 0; j < this.SpecificationsKey.keylist[i].valuelist.length; j++) {
            column.push(this.SpecificationsKey.keylist[i].valuelist[j].value)
          }
          list.push(column)
        }
        console.log(list);
        this.unDeacartesRideList = list
        this.DescartesRide(list)
      // }
    },
    //笛卡尔循环
    DescartesRide(list) {
      console.log('笛卡尔循环');
      // console.log(list);
      // console.log(this.tableData);
      function Cartesian(a, b) {
        var ret = [];
        // console.log(a+" "+b);
        for (var i = 0; i < a.length; i++) {
          for (var j = 0; j < b.length; j++) {
            ret.push(array(a[i], b[j]));
          }
        }
        return ret;
      }
      function array(a, b) {
        var ret = [];
        if (!(a instanceof Array)) {
          ret = Array.call(null, a);
        } else {
          ret = Array.apply(null, a);
        }
        ret.push(b);
        return ret;
      }
      function multiCartesian(data) {
        var len = data.length;
        if (len == 0) {
          return [];
        } else if (len == 1) {
          // console.log('一条数据');
          // console.log(data);
          let reload = []
          for (var p = 0; p < data[0].length; p++) {
            let obj = []
            obj.push(data[0][p])
            reload[p] = obj
          }
          return reload;
        } else {
          var ret = data[0];
          for (var i = 1; i < len; i++) {
            ret = Cartesian(ret, data[i]);
          }
          return ret;
        }
      }
      let arr = multiCartesian(list);
      console.log(arr);
      this.DescartesRideList = arr
      this.tableOldData = this.tableData
      this.tableData = []
      ///////////////////*********************判断之前有没有值，增加规格值或删除规格值，有就回填，没有就新建
      console.log(this.tabletitleData);
      let tableSameData = [] //与之前相比相同的值 this.tableOldData 数组中的值
      let tableSameRow = [] //与之前相比相同的下标 this.tableOldData 数组的下标
      // 循环查找与之前相同的规格值和规格下标
      for (var ik = 0; ik < this.tableOldData.length; ik++) { //循环老数据
          for (var il = 0; il < this.DescartesRideList.length; il++) { //循环新的经过了笛卡尔循环的新数据
              if ((this.tableOldData[ik].value_1 == this.DescartesRideList[il][0])
              && (this.tableOldData[ik].value_2 == this.DescartesRideList[il][1])
              && (this.tableOldData[ik].value_3 == this.DescartesRideList[il][2])) {
                tableSameData.push(this.tableOldData[ik])  //循环匹配到的相同的数据,此数组下标为自然增长值
                tableSameRow.push([ik])  //循环匹配到的相同的数据的老主句的下标,此数组下标为自然增长值
              }
          }
        }
      console.log(tableSameData);
      console.log(tableSameRow);
      ///////////////////新建tableData，经过笛卡尔循环的重组的tabledata 此时全价格和库存为空
      for (var m = 0; m < this.DescartesRideList.length; m++) { //循环新数据，新建tabledata
          let obj = {}
          let price = ''
          let stock = ''
          obj.price = ''
          obj.stock = ''
          obj.value_1 = arr[m][0]
          obj.value_2 = arr[m][1]
          obj.value_3 = arr[m][2]
          this.tableData.push(obj)
      }
      ///////////////////以上tableData的价格和库存都为空
      ///////////////////以下for循环是为了让数据相同就回填 ！！！很重要，相同的数据回填！！
      for (var im = 0; im < tableSameRow.length; im++) {  // 数据回填 ！！！
        // if (this.tableData[im].price && this.tableData[im].stock) {
          this.tableData[im].price = tableSameData[im].price
          this.tableData[im].stock = tableSameData[im].stock
        // }
      }
      console.log(this.tableData);
      console.log(this.tableOldData);
    },
    //设置之前的表格头，用来和后台对比
    setTableOldTitleData() {
      this.tableOldTitleData = []
      for (var ih = 0; ih < this.SpecificationsKey.keylist.length; ih++) {
        this.tableOldTitleData.push(this.SpecificationsKey.keylist[ih].value)
      }
      for (var ph = 0; ph < this.tableOldTitleData.length; ph++) {
        if (this.tableOldTitleData[ph] == '') {
          this.tableOldTitleData.splice(ph, 1)
        }
      }//避免一些诡异的情况 核实title值有没有空值  有就去掉
      // this.tableOldTitleData = this.tabletitleData
    },
    //更新表格头
    updateTableTitleData() {
      // console.log(this.SpecificationsKey.keylist.length);
      this.tabletitleData = []
      for (var i = 0; i < this.SpecificationsKey.keylist.length; i++) {
        this.tabletitleData.push(this.SpecificationsKey.keylist[i].value)
      }
      this.title_1 = this.tabletitleData[0]
      this.title_2 = this.tabletitleData[1]
      this.title_3 = this.tabletitleData[2]
      for (var p = 0; p < this.tabletitleData.length; p++) {
        if (this.tabletitleData[p] == '') {
          this.tabletitleData.splice(p, 1)
        }
      }//避免一些诡异的情况 核实title值有没有空值  有就去掉
      // this.tableOldTitleData = this.tabletitleData
    },
    //无意义，只是用来测试
    showSku () {
      console.log(this.infoForm);
      // this.tableData[0].price = 0
      // this.updateTableTitleData()
      // console.log(this.infoForm);
      // console.log(this.SpecificationsKey);
      // console.log(this.tabletitleData);
      // console.log(this.tableData);
    },
    //增加规格名
    addSpecKey(e) {
      console.log('增加规格名');
      if (this.SpecificationsKey.keylist.length >= 3) {
        this.$message.error('请勿增加三条以上的规格名 ！ ')
        return false
      }
      this.SpecificationsKey.keylist.push({
          value: '',
          valuelist: [{
            value: ''
          }]
      });
      // console.log(this.SpecificationsKey);
    },
    //增加规格值
    addSpecValue(e) {
      console.log('增加规格值');
      this.SpecificationsKey.keylist[e].valuelist.push({
          value: '',
      });
    },
    //删除规格名
    delSpecKey(e) {
      this.SpecificationsKey.keylist.splice(e, 1)
      this.updateTableTitleData()
      this.updateTableData('key', [0])

    },
    //删除规格值
    delSpecValue(e,a) {
      console.log(e,a);
      console.log('删除规格值');
      // this.del_value = this.SpecificationsKey.keylist[e].valuelist[a].value
      // console.log(this.del_value);
      // let point = []
      // point[0] = e
      // point[1] = a
      this.SpecificationsKey.keylist[e].valuelist.splice(a, 1)
      this.updateTableData()

    },
    ////////////////////////////////////////////以下为SKU事件
    //重组sku数据
    reloadSkuInfo() {
      console.log(this.skuInfo);
      for (let f = 0;f < this.skuInfo.title.length;f++) {
        this.addSpecKey()
        for (let g = 1;g < this.skuInfo.value[f].length;g++) {
          // console.log(f,g);
          this.addSpecValue(f)
        }
      }
      for (var i = 0; i < this.skuInfo.title.length; i++) {
        this.SpecificationsKey.keylist[i].value = this.skuInfo.title[i].name
        for (var h = 0; h < this.skuInfo.value[i].length; h++) {
          // console.log(i,h);
          this.SpecificationsKey.keylist[i].valuelist[h].value = this.skuInfo.value[i][h].value
        }
      }
      this.setTableOldTitleData()
      this.updateTableTitleData()
      this.tableData = this.skuInfo.true_product_list
      if (this.SpecificationsKey.keylist[1].value == '') {
          this.SpecificationsKey.keylist.splice(1, 1)
          console.log('删除空规格名');
        }else if (this.SpecificationsKey.keylist[2].value == '') {
          this.SpecificationsKey.keylist.splice(2, 1)
          console.log('删除空规格名');
      }
      //重组之后的规格会多出一个空值 虽然不影响但最好还是删掉
    },
    //获取sku数据
    getgoodsSku() {
      // console.log(this.GoodsId);
      this.axios.post('goods/getgoodsskucands',{
        id: this.goodsId
      }).then(res => {
        console.log(res);
        if (res.data.errno == 0) {
          this.skuInfo = res.data.data
          this.reloadSkuInfo()
          // console.log(this.tableData);
        }else {
          this.$message.error("异常 ！ 请退出 ！")
        }
      })
    },
    ///////////////////////////////////////////以下为富文本上传事件
    onEditorChange(e) {
      this.infoForm.desc = e.html
      console.log(this.infoForm.desc);
    },
    beforeUpload() {
      // 显示loading动画
      this.quillUpdateImg = true
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
        this.$message.error('图片插入失败 ！')
      }
      // loading动画消失
      this.quillUpdateImg = false
    },
    // 富文本图片上传失败
    uploadError() {
      // loading动画消失
      this.quillUpdateImg = false
      this.$message.error('图片上传失败 ！')
    },
    //////////////////////////////////////////以下为图片上传事件
    //循环图上传成功事件
    loophandlesuccess(res, file) {
      // console.log(res);
      var imageUrl = this.uploaddress + res.key
      let fileUrl = {}
      let list = {}
      list.fileUrl = imageUrl
      this.infoForm.loop_img.push(list)
      // console.log(this.infoForm.loop_img);
    },
    //循环图删除事件
    loophandleRemove(file, fileList) {
      // console.log(file);
      // console.log(fileList);
      // console.log(this.infoForm.loop_img);
      // if (this.LoopImgLength == 0){
        this.infoForm.loop_img = []
        for (var i = 0; i < fileList.length; i++) {
          let list = {}
          let fileUrl = {}
          if (fileList[i].response) { //上传成功会有两种情况 上传之后再删除再上传 只有url 直接上传是有response
            list.fileUrl = this.uploaddress + fileList[i].response.key
          }else{
            list.fileUrl = fileList[i].url
          }
          this.infoForm.loop_img.push(list)
        }
        // console.log(this.infoForm.loop_img);
    },
    //循环图查看事件
    handlePictureCardPreviewLoop(file) {
      this.PictureCardPreviewLoop = file.url;
      this.dialogVisibleLoop = true;
    },
    //主图上传成功事件
    MainImgSuccess(file,filelist) {
      console.log(file);
      console.log(filelist);
      this.GoodsMainImg = []
      let obj = {}
      let url = {}
      obj.url = this.uploaddress + filelist.response.key
      this.GoodsMainImg.push(obj)
      this.infoForm.main_img = obj.url
      //这样可以保证主图只上传一张 !!!!
    },
    //查看主图
    handlePictureCardPreviewMain() {
      this.dialogVisibleMain = true
      this.PictureCardPreviewMain = this.infoForm.main_img
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
    },
    //获取一级分类列表
    findGoodsClassifyFirst() {
      this.axios.post('goodsUpdate/findGoodsClassifyFirst', {}).then(res => {
        console.log(res.data.data);
        this.FirstClassifyList = res.data.data
      })
    },
    //获取上传token
    gettoken() {
      this.axios.post('upload/token').then((res) => {
        console.log('上传的token：' + res.data.data.uploadToken);
        this.uploadToken.token = res.data.data.uploadToken
      })
    },
    //获取商品数据
    getGoodsInfo() {
      this.axios.post('goodsUpdate/findGoodsInfo', {
        id: this.goodsId
      }).then(res => {
        console.log(res);
        this.infoForm.name = res.data.data.goodsInfo.name
        this.infoForm.brief = res.data.data.goodsInfo.goods_brief
        this.infoForm.price = res.data.data.goodsInfo.retail_price
        this.infoForm.extraPrice = res.data.data.goodsInfo.extra_price
        this.infoForm.cost_price = res.data.data.goodsInfo.cost_price
        this.infoForm.freight_price = res.data.data.goodsInfo.freight_price
        this.infoForm.freight_type = res.data.data.goodsInfo.freight_type
        this.infoForm.freight_template = res.data.data.goodsInfo.freight_template
        this.infoForm.short_order = res.data.data.goodsInfo.short_order
        this.infoForm.num = res.data.data.goodsInfo.goods_number
        this.infoForm.is_sale = res.data.data.goodsInfo.is_on_sale
        this.infoForm.is_hot = res.data.data.goodsInfo.is_hot
        this.infoForm.is_new = res.data.data.goodsInfo.is_new
        this.infoForm.sale = res.data.data.goodsInfo.is_on_sale == 1 ? true : false
        this.infoForm.hot = res.data.data.goodsInfo.is_hot == 1 ? true : false
        this.infoForm.new = res.data.data.goodsInfo.is_new == 1 ? true : false
        this.infoForm.Identity = res.data.data.goodsInfo.Identity == 1 ? true : false
        this.infoForm.main_img = res.data.data.goodsInfo.list_pic_url
        this.unresoldLoopImg = res.data.data.goodsInfo.loop_img
        this.FirstClassifyId = res.data.data.firstClassify.id
        this.SecondClassifyId = res.data.data.secondClassify.id
        this.infoForm.desc = res.data.data.goodsInfo.goods_desc
        // this.supplier_list = res.data.data.supplier_list
        this.infoForm.supplier_id = res.data.data.goodsInfo.supplier_id,//供货商id
        this.infoForm.supplier_name = res.data.data.goodsInfo.supplier_name,//供货商名称
        // console.log(this.infoForm.loop_img);
        this.img_reload()
        this.getgoodsSku()
      })
    },
    //图片路径重组
    img_reload() {
      let obj = {}
      let url = {}
      obj.url = this.infoForm.main_img
      this.GoodsMainImg.push(obj)
      for (var i = 0; i < this.unresoldLoopImg.length; i++) {
        // console.log(i);
        let obj2 = {}
        let obj3 = {}
        obj2.url = this.unresoldLoopImg[i].img_url
        this.LoopImgList.push(obj2)
        obj3.fileUrl = this.unresoldLoopImg[i].img_url
        this.infoForm.loop_img.push(obj3)
      }
    },
    /////////////////////////////////////////以下为全局方法 、、、、、、、、、、、、、、
    goBackPage() {
      this.$router.go(-1);
    },

  }
}
    /*
      有问题请联系微信 m13101221 备注 bbgshop，哼 不加备注我会以为你是发小广告的
    */
</script>

<style lang="css">
.form-tips {
  font-size: 10px;
  color: #757575;
}
.SpecificationsValue_area {
  /* border: 1px solid black; */
  /* width: 300px; */
  margin: 5px 0;
}
.SpecificationsKey_area_key_input {
  /* border: 1px solid black; */
  /* width: 300px; */
}
.SpecificationsKey_area {
  /* border: 1px solid black; */
  width: 320px;
  margin-right: 15px;
  float: left;
}
</style>
