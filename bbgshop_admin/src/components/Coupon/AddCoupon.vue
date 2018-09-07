<template lang="html">
  <div class="content-page">
      <div class="content-nav" >
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item >店铺运营</el-breadcrumb-item>
              <el-breadcrumb-item :to="{ path: '/dashboard/CouponPage' }">优惠券管理</el-breadcrumb-item>
              <el-breadcrumb-item>添加优惠券</el-breadcrumb-item>
          </el-breadcrumb>
          <div class="operation-nav">
              <el-button type="primary" @click="goBackPage" icon="arrow-left">返回列表</el-button>
          </div>
      </div>

      <div class="content-main">
<!-- ////////////////////////////////////////////////////////////////////////////////////////优惠券基础信息开始 -->

        <el-form :model="ruleForm" ref="ruleForm" label-width="180px">
          <div class="tiptitle">
            优惠券基础信息
          </div>
          <el-form-item label="优惠券名称" >
            <el-input style="width:280px;" placeholder="请输入优惠券名称" v-model="ruleForm.name" ></el-input>
          </el-form-item>
          <el-form-item label="发放数量" >
            <el-input type="number" :min="1" style="width:100px;" v-model="ruleForm.number"></el-input>
            <span style="font-size:16px;color:#8391a5">张</span>
          </el-form-item>
          <el-form-item label="优惠券形式" style="margin-bottom:15px;" >
            <el-radio-group v-model="cupfromradio" @change="cupfromradiochanged">
              <el-radio :label="1">指定金额</el-radio>
              <el-radio :label="2">折扣</el-radio>
            </el-radio-group>
            <div class="cupfromarea" v-show="cupfromradio == 1">
              面值：<el-input type="number" :min="0" style="width:100px;" v-model="ruleForm.value"></el-input>
              <span class="cupfromareatip">元</span>
            </div>
            <div  class="cupfromarea" v-show="cupfromradio == 2">
              折扣：<el-input type="number" :min="1" :max="10" style="width:100px;" v-model="ruleForm.value"></el-input>
              <span class="cupfromareatip">折</span>
            </div>
          </el-form-item>
          <el-form-item label="使用门槛"  >
            <el-radio-group  v-model="cuplimtradio">
              <el-radio :label="4">无限制</el-radio>
              <el-radio :label="5">限制</el-radio>
            </el-radio-group>
            <div class="cupfromarea" v-show="cuplimtradio == 5">
              满 <el-input type="number" :min="1" style="width:100px;" v-model="ruleForm.limit_price"></el-input> 元可用
              <!-- <span class="cupfromareatip">元</span> -->
            </div>
          </el-form-item>
<!-- ////////////////////////////////////////////////////////////////////////////////////////优惠券基础信息结束 -->
<!-- ////////////////////////////////////////////////////////////////////////////////////////优惠券基本规则开始 -->
          <div class="tiptitle" style="padding-top:10px;padding-bottom:10px;">
            优惠券基本规则
            </div>
            <el-form-item label="每人限领" style="margin-top:12px;" >
              <el-input disabled type="number" :min="1" style="width:100px;" v-model="ruleForm.user_number" ></el-input>
              <span style="font-size:16px;color:#8391a5">张</span>
            </el-form-item>
            <el-form-item label="有效期"  style="margin-top:-10px;">
              <el-radio-group class="cupable" v-model="cupableradio">
                <el-radio :disabled="is_edit" :label="6" style="color:#757575">固定日期</el-radio>
                <br>
                <div class="dateblock" v-show="cupableradio == 6">
                    <el-date-picker
                      :disabled="is_edit"
                      v-model="ruleForm.datelimit"
                      type="datetimerange"
                      align="left"
                      :placeholder="datepickerPlaceholder"
                      :default-time="['00:00:00', '00:00:00']">
                    </el-date-picker>
                  </div>
                <br />
                <el-radio :disabled="is_edit" :label="7" class="radioselect" >领到券<span style="color:#ff6f00">立即开始 <span v-if="cupableradio !== 7"> N </span>
                  <span v-show="cupableradio == 7">
                    <el-input type="number" :min="1" style="width: 18%;" v-model="ruleForm.datestart"></el-input>
                  </span> 天内有效</span>
                </el-radio>
                <br />
                <el-radio :disabled="is_edit" :label="8">领到券<span style="color:#ff6666">次日开始 <span v-show="cupableradio !== 8"> N </span>
                  <span v-show="cupableradio == 8">
                    <el-input type="number" :min="1" style="width: 18%;" v-model="ruleForm.datestart"></el-input>
                  </span> 天内有效</span>
                </el-radio>
              </el-radio-group>
            </el-form-item>
<!-- ////////////////////////////////////////////////////////指定商品 -->
          <el-form-item label="指定商品" style="margin-top:12px;" >
            <el-radio-group  v-model="cuppointradio">
              <el-radio :disabled="is_edit" :label="9">全部商品</el-radio>
              <el-radio :disabled="is_edit":label="10">指定商品</el-radio>
              <el-button style="margin-left:20px" @click="showPointGoodsPopup"
              v-show="cuppointradio == 10" type="primary" size="small" icon="plus">添加商品</el-button>
            </el-radio-group>
            <div class="pointGoodsArea" v-show="cuppointradio == 10">
              <div class="pointGoodsTitle">
                <div class="pointGoodsTitle_left"> 商品名称 </div>
                <div class="pointGoodsTitle_right"> 操作 </div>
              </div>
              <div class="pointGoodsTip" v-if="pointGoodsList.length == 0">
                您没有选择指定商品
              </div>
              <div class="" v-if="pointGoodsList.length > 0" v-for="item in pointGoodsList">
                <div class="pointGoodsTitle_left listItemName"> {{item.name}} </div>
                <div class="pointGoodsTitle_right listItemAction ">
                  <el-button type="danger" size="mini" plain @click="delPointGoods(item.id)">删除</el-button>
                </div>
              </div>
            </div>
          </el-form-item>
<!-- ////////////////////////////////////////////////////////指定商品弹出层 -->
          <van-popup class="GoodsPopover" v-model="selectGoodsPopover">
            <el-row class="GoodsPopoverTitle">
              <el-col :span="12" style="line-height:37px;font-weight:bold">添加指定商品</el-col>
              <el-col :span="12" style="text-align:right">
                <el-input v-model="PointGoodsInput" @keyup.13.native="SelectPointGoods()" style="width: 70%;" placeholder="请输入商品名称"></el-input>
                <el-button type="primary" @click="SelectPointGoods">搜索</el-button>
              </el-col>
            </el-row>
            <el-table :data="dangerGoodsData" border :default-sort = "{prop: 'date', order: 'descending'}" stripe style="width: 100%">
              <el-table-column prop="id" label="ID" align="center" width="100">
              </el-table-column>
              <el-table-column prop="name" label="商品名称">
              </el-table-column>
              <el-table-column prop="action" align="center" label="操作" width="120">
                <template slot-scope="scope">
                  <el-button size="small" :type="scope.row.btnType"
                  @click="handleSelectGoods(scope.$index, scope.row)">{{scope.row.btnText}}</el-button>
                </template>
              </el-table-column>
            </el-table>
            <div class="page-box">
                <el-pagination style="margin-right:10px;" @current-change="PointGoodsPageChange" :current-page="goodspage" :page-size="5"
                layout="total, prev, pager, next, jumper" :total="goodstotal">
                </el-pagination>
            </div>
          </van-popup>
<!-- ////////////////////////////////////////////////////////指定商品结束 -->
<!-- ////////////////////////////////////////////////////////指定用户 -->
          <el-form-item label="指定用户" style="margin-top:12px;" >
            <el-radio-group  v-model="cupuserradio">
              <el-radio :disabled="is_edit" :label="11">不指定</el-radio>
              <el-radio :disabled="is_edit" :label="12">指定用户</el-radio>
              <el-button style="margin-left:20px"  @click="showPointUserPopup"
              v-show="cupuserradio == 12" type="primary" size="small" icon="plus">添加用户</el-button>
            </el-radio-group>
            <div class="pointGoodsArea" v-show="cupuserradio == 12">
              <div class="pointGoodsTitle">
                <div class="pointGoodsTitle_left"> 用户名称 </div>
                <div class="pointGoodsTitle_right"> 操作 </div>
              </div>
              <div class="pointGoodsTip" v-if="pointUserList.length == 0">
                您没有添加指定用户
              </div>
              <div class="" v-if="pointUserList.length > 0" v-for="item in pointUserList">
                <div class="pointGoodsTitle_left listItemName"> {{item.name}} </div>
                <div class="pointGoodsTitle_right listItemAction ">
                  <el-button type="danger" size="mini" plain @click="delPointUser(item.id)">删除</el-button>
                </div>
              </div>
            </div>
          </el-form-item>
<!-- ////////////////////////////////////////////////////////指定用户弹出层 -->
          <van-popup class="GoodsPopover" v-model="selectUserPopover">
            <el-row class="GoodsPopoverTitle">
              <el-col :span="12" style="line-height:37px;font-weight:bold">添加指定用户</el-col>
              <el-col :span="12" style="text-align:right">
                <el-input v-model="PointUserInput" @keyup.13.native="SelectPointUser()"  style="width: 70%;" placeholder="请输入用户名称"></el-input>
                <el-button type="primary" @click="SelectPointUser">搜索</el-button>
              </el-col>
            </el-row>
            <el-table :data="dangerUserData" border :default-sort = "{prop: 'date', order: 'descending'}" stripe style="width: 100%">
              <el-table-column prop="id" label="ID" align="center" width="100">
              </el-table-column>
              <el-table-column prop="name" label="用户名称">
              </el-table-column>
              <el-table-column prop="action" align="center" label="操作" width="120">
                <template slot-scope="scope">
                  <el-button size="small" :type="scope.row.btnType"
                  @click="handleSelectUser(scope.$index, scope.row)">{{scope.row.btnText}}</el-button>
                </template>
              </el-table-column>
            </el-table>
            <div class="page-box">
                <el-pagination style="margin-right:10px;" @current-change="PointUserPageChange" :current-page="userpage" :page-size="5"
                layout="total, prev, pager, next, jumper" :total="usertotal">
                </el-pagination>
            </div>
          </van-popup>
<!-- ///////////////////////////////////////////////////////////////////////指定用户结束 -->
<!-- ///////////////////////////////////////////////////////////////////////指定用户可使用商品优惠券开始 -->
          <!-- <el-form-item label="指定用户和商品">
          </el-form-item> -->
          <!-- 同时指定商品和用户即为指定用户可使用的优惠券 -->
<!-- ////////////////////////////////////////////////////////////////////////////////////////指定用户可使用商品优惠券结束 -->
          <el-form-item label="使用说明">
            <el-input type="textarea" style="width:45%;"  :rows="2" placeholder="请输入使用说明" v-model="ruleForm.Instructions">
            </el-input>
          </el-form-item>

          <!-- <el-form-item label="用户领取">
            <el-radio-group style="margin-top:12px;" v-model="cupusergetradio">
              <el-radio  :label="13">实时到账
                <span style="color:rgb(117, 117, 117);font-size:12px;">(不需要用户领取，直接发放到每个用户)</span>
              </el-radio><br>
              <el-radio style="margin-top:12px;margin-bottom:5px;" :label="14">需要主动领取
                <span style="color:rgb(117, 117, 117);font-size:12px;">(不领取就不能使用)</span>
              </el-radio>
            </el-radio-group>
            <div class="tipa" v-show="cupusergetradio == 13">
              实时到账每人限领与发放数量已取消
            </div>
            <div class="tipa" v-show="cupusergetradio == 14">
              核对每人限领与发放数量，发完则不能领取
            </div>
          </el-form-item> -->
<!-- ////////////////////////////////////////////////////////////////////////////////////////优惠券基本规则结束 -->

          <el-form-item>
            <el-button type="primary" @click="submitForm('ruleForm')">立即创建</el-button>
            <el-button @click="resetForm('ruleForm')">重置</el-button>
          </el-form-item>
        </el-form>

    </div>
  </div>
</template>

<script>
import { Toast } from 'vant';
export default {
  data() {
    return {
      goodspage: 1,
      goodstotal: 0,
      userpage: 1,
      usertotal: 0,
      cupfromradio: 1,//优惠券形式默认单选按钮
      cuplimtradio: 4,//使用门槛默认单选按钮
      cupableradio: 6,//有效期默认单选按钮
      cuppointradio: 9,//指定商品默认单选按钮
      cupuserradio: 11,//指定用户默认单选按钮
      // cupusergetradio: 13,//是否需要用户主动领取默认值
      selectGoodsPopover: false,//选择商品的弹出层
      selectUserPopover:false,//选择用户的弹出层
      PointUserInput: "", //添加指定用户的输入框内容
      PointGoodsInput: "",//添加指定商品的输入框内容
      allGoodsData:[], //数据库取出的五条数据
      allUserData:[], //数据库取出的五条数据
      dangerGoodsData:[],//修改按钮之后的五条数据
      dangerUserData:[],//修改按钮之后的五条数据
      ruleForm: {
          name: '', //名称
          number: '', //数量
          // discount: '', //打折
          value: '', //面值和折扣
          limit_price: '', //使用门槛价格
          user_number: 1, //每人限领
          datelimit: '', //时间限制
          datestart: '',//时间开始
          Instructions: '',//优惠券使用说明
        },
        pointGoodsList: [],//指定商品可使用优惠券列表
        pointUserList: [],//指定用户可使用优惠券列表
        id: 0,
        is_edit: false,
        datepickerPlaceholder: '点击选择 开始日期 - 结束日期',
        typechangeTime: 0,//优惠券形式改变过几次

      };
  },
  mounted(){
    this.id = this.$route.query.id || 0;
    if (this.id !== 0) {
      this.is_edit = true
      this.getInfo()
    }
  },
  updated(){
  },
  methods: {
    ////////////////////////////////////////////////编辑时按id查找信息
    getInfo(){
      this.axios.post('coupon/findcouponinfoById',{
        id: this.id
      }).then(res => {
        console.log(res);
        this.datepickerPlaceholder = this.timestampToTime(res.data.data.validity_create)
        + ' 创建，有效期 ' + (res.data.data.validity_limit_day / 86400000) + ' 天 '
        this.ruleForm.name = res.data.data.coupon_name
        this.ruleForm.number = res.data.data.coupon_number
        this.ruleForm.value = res.data.data.coupon_value
        this.cupfromradio = res.data.data.coupon_type == 0 ? 1 : 2
        this.typechangeTime = this.cupfromradio == 1 ? 3 : 2
        this.ruleForm.limit_price = res.data.data.coupon_limit_value
        this.cuplimtradio = res.data.data.coupon_limit == 0 ? 4 : 5
        this.ruleForm.Instructions = res.data.data.Instructions
        console.log(this.cupfromradio);
        console.log(this.cuplimtradio);
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
    cupfromradiochanged() {
      this.typechangeTime = Number(this.typechangeTime) + 1
      if (this.typechangeTime > 3) {
        this.ruleForm.value = ''
      }
    },
    ////////////////////////////////////////////////以下为添加用户
    // ....................................................
    //删除指定用户
    delPointUser(id){
      let dataa = []
      for (var i = 0; i < this.pointUserList.length; i++) {
       if (this.pointUserList[i].id === id) {
       }else {
         console.log(this.pointUserList[i]);
         let objj = this.pointUserList[i]
         dataa.push(objj)
       }
      }
      this.pointUserList = dataa
      // this.pointGoodsList.splice( this.pointGoodsList.indexOf( id ), 1 );
      console.log(this.pointUserList);
    },
    //添加指定用户弹出层列表内选定按钮
    handleSelectUser(index,row){
      if ( row.btnType == 'danger') {
        this.delPointUser(row.id)
        let NoData = this.dangerUserData
        this.dangerUserData = []
        for (var i = 0; i < NoData.length; i++) {
          if (NoData[i].id === row.id) {
            NoData[i].id = row.id
            NoData[i].name = row.name
            NoData[i].btnType = "success"
            NoData[i].btnText = "选中"
          }
        }
        this.dangerUserData = NoData
      }else {
        let NoData = this.dangerUserData
        this.dangerUserData = []
        for (var i = 0; i < NoData.length; i++) {
          if (NoData[i].id === row.id) {
            NoData[i].id = row.id
            NoData[i].name = row.name
            NoData[i].btnType = "danger"
            NoData[i].btnText = "已选中"
          }
        }
        this.dangerUserData = NoData
        let data =[] //已添加商品；列表
        for (var i = 0; i < this.pointUserList.length; i++) {
          if (this.pointUserList[i].id === row.id) {
          }else {
            let obj = {}
            obj = this.pointUserList[i]
            data.push(obj)
          }
        }
        this.pointUserList = data
          let obj = {}
          obj.id = row.id
          obj.name = row.name
          obj.btnType = row.btnType
          obj.btnText = row.btnText
          this.pointUserList.push(obj)
        console.log(this.pointUserList);
      }

    },
    //添加指定用户弹出层翻页按钮
    PointUserPageChange(val){
      this.userpage = val;
      //保存到localStorage
      localStorage.setItem('UserPage', this.userpage)
      this.showPointUserPopup()
    },
    //添加指定用户弹出层搜索按钮
    SelectPointUser(){
      this.showPointUserPopup()
    },
    //打开弹层获取数据
    showPointUserPopup(){
      this.selectUserPopover = true
      this.axios.get('coupon/pointuser', {
        params: {
          page: this.userpage,
          username: this.PointUserInput,
        }
      }).then((res) => {
        console.log(res);
        this.allUserData = res.data.data.data
        this.userpage = res.data.data.currentPage
        this.usertotal = res.data.data.count
        let NoGoodsData = []
        for (var i = 0; i < this.allUserData.length; i++) {
          let obj = {}
          obj.id = this.allUserData[i].id
          obj.name = this.allUserData[i].nickname
          obj.btnType = "success"
          obj.btnText = "选中"
          NoGoodsData.push(obj)
        }
        for (var i = 0; i < this.pointUserList.length; i++) {
          for (var j = 0; j < NoGoodsData.length; j++) {
            if (this.pointUserList[i].id === NoGoodsData[j].id) {
              console.log("123456789");
              NoGoodsData[j].btnType = "danger"
              NoGoodsData[j].btnText = "已选中"
            }
          }
        }
        this.dangerUserData = NoGoodsData
        console.log(this.dangerUserData);
      })
    },
    ///////////////////////////////////////////////////添加指定用户结束
    ///////////////////////////////////////////////////以下为添加指定商品
    // ........................................................
    //添加指定商品弹出层列表内翻页按钮
    PointGoodsPageChange(val){
      this.goodspage = val;
      //保存到localStorage
      localStorage.setItem('goodsPage', this.goodspage)
      this.showPointGoodsPopup()
    },
    //添加指定商品弹出层列表内选定按钮
    handleSelectGoods(index,row){
      if ( row.btnType == 'danger') {
        this.delPointGoods(row.id)
        let NoData = this.dangerGoodsData
        this.dangerGoodsData = []
        for (var i = 0; i < NoData.length; i++) {
          if (NoData[i].id === row.id) {
            NoData[i].id = row.id
            NoData[i].name = row.name
            NoData[i].btnType = "success"
            NoData[i].btnText = "选中"
          }
        }
        this.dangerGoodsData = NoData
      }else {
        let NoData = this.dangerGoodsData
        this.dangerGoodsData = []
        for (var i = 0; i < NoData.length; i++) {
          if (NoData[i].id === row.id) {
            NoData[i].id = row.id
            NoData[i].name = row.name
            NoData[i].btnType = "danger"
            NoData[i].btnText = "已选中"
          }
        }
        this.dangerGoodsData = NoData
        let data =[] //已添加商品；列表
        for (var i = 0; i < this.pointGoodsList.length; i++) {
          if (this.pointGoodsList[i].id === row.id) {
          }else {
            let obj = {}
            obj = this.pointGoodsList[i]
            data.push(obj)
          }
        }
        this.pointGoodsList = data
          let obj = {}
          obj.id = row.id
          obj.name = row.name
          obj.btnType = row.btnType
          obj.btnText = row.btnText
          this.pointGoodsList.push(obj)
        console.log(this.pointGoodsList);
      }

    },
    //添加指定商品弹出层搜索按钮
    SelectPointGoods(){
        this.showPointGoodsPopup()
    },
    //打开指定商品弹出层
    showPointGoodsPopup(){
      this.selectGoodsPopover = true
      this.axios.get('coupon/pointgoods', {
        params: {
          page: this.goodspage,
          goodsname: this.PointGoodsInput,
        }
      }).then((res) => {
        console.log(res);
        this.allGoodsData = res.data.data.data
        this.goodspage = res.data.data.currentPage
        this.goodstotal = res.data.data.count
        let NoGoodsData = []
        for (var i = 0; i < this.allGoodsData.length; i++) {
          let obj = {}
          obj.id = this.allGoodsData[i].id
          obj.name = this.allGoodsData[i].name
          obj.btnType = "success"
          obj.btnText = "选中"
          NoGoodsData.push(obj)
        }
        for (var i = 0; i < this.pointGoodsList.length; i++) {
          for (var j = 0; j < NoGoodsData.length; j++) {
            if (this.pointGoodsList[i].id === NoGoodsData[j].id) {
              console.log("123456789");
              NoGoodsData[j].btnType = "danger"
              NoGoodsData[j].btnText = "已选中"
            }
          }
        }
        this.dangerGoodsData = NoGoodsData
        console.log(this.dangerGoodsData);
      })
    },
    //删除指定商品
    delPointGoods(id){
        let dataa = []
        for (var i = 0; i < this.pointGoodsList.length; i++) {
         if (this.pointGoodsList[i].id === id) {
         }else {
           console.log(this.pointGoodsList[i]);
           let objj = this.pointGoodsList[i]
           dataa.push(objj)
         }
        }
        this.pointGoodsList = dataa
        // this.pointGoodsList.splice( this.pointGoodsList.indexOf( id ), 1 );
        console.log(this.pointGoodsList);
    },
    ///////////////////////////////////////////////////添加指定商品结束
    ////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////
    goBackPage() {
      this.$router.go(-1);
    },
    submitForm(formName) {
      console.log(this.cupfromradio);
      console.log(this.cuplimtradio);
      if (this.id !== 0) {
        if (this.ruleForm.name == '' || this.ruleForm.number == ''
        || this.ruleForm.value == '' || this.ruleForm.limit_price == '') {
          this.$message.error("数据不完整！")
          return false
        }
        let updatedinfo = {}
        updatedinfo.name = this.ruleForm.name
        updatedinfo.number = this.ruleForm.number
        updatedinfo.value = this.ruleForm.value
        updatedinfo.limit_price = this.ruleForm.limit_price
        updatedinfo.Instructions = this.ruleForm.Instructions
        updatedinfo.type = this.cupfromradio == 1 ? 0 : 1
        updatedinfo.limit_type = this.cuplimtradio == 4 ? 0 : 1
        console.log(updatedinfo.type);
        console.log(updatedinfo.limit_type);
        console.log(updatedinfo);
        this.axios.post('coupon/couponupdate',{
          id: this.id,
          coupon: updatedinfo
        }).then(res => {
          console.log(res)
          if (res.status === 200) {
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
        //总体判断信息是否完整
        // let isComp = true
        //   if (this.cupusergetradio == 13) { //优惠券实时到账
        //     if (this.ruleForm.name == '' || this.ruleForm.Instructions == ''|| this.ruleForm.value == '') { isComp = false }
        //   }else if(this.cupusergetradio == 14){
          if (this.ruleForm.name == '' || this.ruleForm.number == ''|| this.ruleForm.user_number == ''
            || this.ruleForm.Instructions == ''|| this.ruleForm.value == '') {
              // isComp = false }
              this.$message.error("数据不完整！")
              return false
          }
        //   if (isComp == false) {
        //
        // }
        //优惠券使用门槛判断
        let isLimit = true
          if ( this.cuplimtradio == 5) {
            if ( this.ruleForm.limit_price == '') { }else{ isLimit = false }
          }else{ isLimit = false }

          if (isLimit == true) {
            this.$message.error("请输入使用门槛金额！")
            return false
          }
        //优惠券有效期判断
        let datelimit = true
          if ( this.cupableradio == 6) {
            if (this.ruleForm.datelimit == '') { datelimit = false }
          }else if( this.cupableradio == 7 || this.cupableradio == 8){
            if (this.ruleForm.datestart == '') { datelimit = false }
          }
          if (this.cupableradio == 7 || this.cupableradio == 8) {
              if (this.ruleForm.datestart == '0') {
                datelimit = false
              }
          }
          if (datelimit == false) {
            this.$message.error("优惠券有效期未设置或设置为0！")
            return false
          }

        //判断指定商品
        let pointgoods = true
          if ( this.cuppointradio == 10) {
            if ( this.pointGoodsList.length == 0) {
              pointgoods = false }
          }
          if (pointgoods == false) {
            this.$message.error("选择指定商品不能为空！")
            return false
          }
        //判断指定用户
        let pointuser = true
          if ( this.cupuserradio == 12) {
            if ( this.pointUserList.length == 0) {
              pointuser = false }
          }
          if (pointuser == false) {
            this.$message.error("选择指定用户不能为空！")
            return false
          }

        //数据整合-------------------------------------------------------------------------------------------
        let CupTime = {} //优惠券时间
          // let AbleStartTime = '' //优惠券起始时间
          // let AbleEndTime = '' //优惠券终止时间
          // let CupCreatTime = '' //优惠券创建时间
          // let CupUserGetTime = '' //用户领取优惠券时间
          if (this.cupableradio == 6) {
              CupTime.start = new Date(this.ruleForm.datelimit[0]).getTime()
              CupTime.end = new Date(this.ruleForm.datelimit[1]).getTime()
              CupTime.limit_day = CupTime.end - CupTime.start
              CupTime.create = new Date().getTime()
              console.log(CupTime);
            }else if(this.cupableradio == 7){
              //当日有效
              // CupTime.start = new Date().getTime()
              CupTime.start = ''
              CupTime.limit_day = this.ruleForm.datestart * 86400000
              // CupTime.end = CupTime.start + (this.ruleForm.datestart * 86400000)
              CupTime.end = ''
              CupTime.create = new Date().getTime()
              console.log(CupTime);
            }else if (this.cupableradio == 8) {
              //次日有效
              // let Y = new Date().getFullYear()
              // let M = new Date().getMonth() + 1
              // let D = new Date().getDate() + 1 //次日
              // let nextDay = Y+'/'+M+'/'+D+' '+'00:00:00'
              // CupTime.start = new Date(nextDay).getTime()
              CupTime.start = ''
              CupTime.limit_day = this.ruleForm.datestart * 86400000
              // CupTime.end = CupTime.start + (this.ruleForm.datestart * 86400000)
              CupTime.end = ''
              CupTime.create = new Date().getTime()
              console.log(CupTime);
          }

        let CupState = {} //状态
          //优惠券形式
          if ( this.cupfromradio == 1) {
              CupState.CupFrom = 0
            }else if ( this.cupfromradio == 2) {
              CupState.CupFrom = 1
          }
          if (this.cuplimtradio == 4) {
              CupState.CupLimit = 0
            }else if (this.cuplimtradio == 5) {
              CupState.CupLimit = 1
          }
          if (this.cupableradio == 6) {
              CupState.CupTime = 0
            }else if ( this.cupableradio == 7){
              CupState.CupTime = 1
            }else if ( this.cupableradio == 8){
              CupState.CupTime = 2
          }
          CupState.CupAble = 1
          // if (this.cupusergetradio == 13) {
          //     CupState.CupAble = 0
          //   }else if (this.cupusergetradio == 14) {
          //     CupState.CupAble = 1
          // }
        if (this.cuppointradio == 9) {
          this.pointGoodsList = []
        }
        if (this.cupuserradio == 11) {
          this.pointUserList = []
        }
        // if (this.cupusergetradio == 13) {
        //   this.ruleForm.number = '99999999'
        //   this.ruleForm.user_number = '1'
        // }
        //存入数据库
        this.axios.post('coupon/storemainCup',{
          ruleForm:this.ruleForm,
          CupTime:CupTime,
          CupState:CupState,
          GoodsList:this.pointGoodsList,
          UserList:this.pointUserList
            // AbleEndTime:
          }).then((res) => {
            console.log(res);
            if (res.status === 200) {
              this.$message({
                type: 'success',
                message: '更新成功!'
              });
              this.goBackPage()
            }else {
              this.$message.error("异常 ！")
            }
          })

        console.log(this.pointGoodsList);
        console.log(this.pointUserList);
        // console.log(this.ruleForm);
        // console.log(this.);
        // console.log(this.datepicker);
      //   this.$refs[formName].validate((valid) => {
      //     if (valid) {
      //       alert('submit!');
      //     } else {
      //       console.log('error submit!!');
      //       return false;
      //     }
      //   });
      // },
      // resetForm(formName) {
      //   this.$refs[formName].resetFields();

        }
    }
  }
}
</script>
<!-- } -->
<!-- </script> -->

<style lang="css" scoped>
.tipa {
  color: #888;
  font-size: 12px;
  line-height: 30px;
}
.page-box {
  margin-bottom: 15px;
}
/* .AnselectGoodsList {
  float: left;
  width: 80px;
  height: 60px;
  line-height: 60px;
  text-align: center;
}
.GoodsPopoverBottom {
  margin: 7px 10px 10px 10px;
  height: 60px;
  overflow: auto;
} */
.GoodsPopoverTitle {
  margin: 20px 20px 0 20px;
  padding-bottom: 10px;
  /* border-bottom: 1px solid #ddd; */
}
.GoodsPopover {
  position: fixed;
  /* border: 1px solid black; */
  width: 600px;
  /* height: 450px; */
  /* left: calc(50vw - 250px + 200px);
  top: calc(50vh - 150px); */
  background: rgba(255, 255, 255, 0.9);
}
/* .GoodsPopoverArea {
  position: fixed;
  background: rgba(0, 0, 0, 0.1);
  left: 0;
  top: 0;
  z-index: 999;
  width: 100vw;
  height: 100vh;
} */
.listItemAction {
  border-bottom: 1px solid #eee;
}
.listItemName {
  /* border: 1px solid black; */
  border-bottom: 1px solid #eee;
  color: #333;
  overflow : hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  /* margin-top: 4px; */
}
.pointGoodsTip {
  /* border: 1px solid black; */
  text-align: center;
  font-size: 12px;
  color: #8391a5
}
.pointGoodsTitle_right {
  /* border: 1px solid black; */
  float: left;
  height: 30px;
  width: 70px;
  text-align: center;
  line-height: 30px;
  /* padding-left: 10px; */
}
.pointGoodsTitle_left {
  /* border: 1px solid black; */
  float: left;
  height: 30px;
  width: 198px;
  line-height: 30px;
  padding-left: 10px;
}
.pointGoodsTitle {
  background: #f8f8f8;
  color: #333;
  font-size: 15px;
  width: 278px;
  height: 30px;
  /* border: 1px solid black */
}
.pointGoodsArea {
  width: 278px;
  margin-top: 5px;
  height: auto;
  /* border: 1px solid black */
}
.radioselect {
  margin: 20px 0px;
}
.cupable {
  /* border: 1px solid black; */
  margin-top: 10px;
}
.dateblock {
  margin-top: 15px;
  margin-bottom: 0px;
  /* margin: 15px 0; */
}
.cupfromareatip {
  font-size:16px;
  color:#8391a5
}
.cupfromarea {
  font-size:16px;
  color:#333
}
.el-radio {
  color: #333
}
.tiptitle {
  /* border: 1px solid black; */
  border-bottom: 1px solid #8391a5;
  /* display: inline-block; */
  font-weight: bold;
  margin-top: -5px;
  padding-left: 2px;
  padding-bottom: 5px;
  margin-bottom: 10px;
  color: #333;
  font-size: 16px;
}
</style>
