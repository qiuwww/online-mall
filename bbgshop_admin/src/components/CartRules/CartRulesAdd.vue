<template lang="html">
  <div class="content-page">
      <div class="content-nav" >
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>店铺运营</el-breadcrumb-item>
              <el-breadcrumb-item :to="{ path: '/dashboard/CartRulesPage' }">金额结算规则</el-breadcrumb-item>
              <el-breadcrumb-item>新建规则</el-breadcrumb-item>
          </el-breadcrumb>
          <div class="operation-nav">
              <el-button type="primary" @click="goBackPage" icon="arrow-left">返回列表</el-button>
          </div>
      </div>
      <div class="content-main">
        <el-form label-width="180px">
          <el-form-item label="规则名称" >
            <el-input style="width:317px;" v-model="Rules.rules_name" placeholder="输入规则名称" >
            </el-input>
          </el-form-item>
          <el-form-item label="规则适用对象" >
            <el-radio-group v-model="Rules.suit_model">
              <el-radio :label="0">全店商品</el-radio>
              <el-radio :label="1" disabled>部分分类</el-radio>
            </el-radio-group>
            <div class="" v-if="Rules.suit_model == 0">
              <div class="form-tips">
                规则适用于全店所有商品
              </div>
            </div>
            <div class="" v-if="Rules.suit_model == 1">
              <div class="form-tips">
                规则只适用于部分分类
              </div>
            </div>
          </el-form-item>
          <el-form-item label="规则类型" >
            <el-radio-group v-model="Rules.type_model" @change="type_model_change">
              <el-radio :label="0">减运费</el-radio>
              <el-radio :label="1">减价格</el-radio>
              <el-radio :label="2">打折扣</el-radio>
            </el-radio-group>
            <div class="" v-if="Rules.type_model == 0">
              <!-- <el-input type="number" :min="0" style="width:150px;margin-top:5px;" v-model="Rules.minus_price" placeholder="请输入折扣"></el-input> -->
              <div class="form-tips">
                达到规则限制的最低金额后，<span style="color:#ff6666;"> 在订单价格的基础上，<span style="color:#ff6f00;"> 减去订单运费</span> </span>
              </div>
            </div>
            <div class="" v-if="Rules.type_model == 1">
              <el-input type="number" :min="1" style="width:150px;margin-top:5px;margin-bottom:5px;" v-model="Rules.minus_price" placeholder="请输入减去的价格"></el-input>
              <div class="form-tips">
                达到规则限制的最低金额后，<span style="color:#ff6666;"> 在订单价格的基础上，<span style="color:#ff6f00;"> 减去此数值 </span> </span>
              </div>
            </div>
            <div class="" v-if="Rules.type_model == 2">
              <el-input type="number" :min="2" style="width:150px;margin-top:5px;margin-bottom:5px;" v-model="Rules.discount_price" placeholder="请输入折扣"></el-input>
              <div class="form-tips">
                达到规则限制的最低金额后，<span style="color:#ff6666;"> 在订单价格的基础上，<span style="color:#ff6f00;"> 乘以此数值 </span> </span>
              </div>
            </div>

          </el-form-item>
          <el-form-item label="规则限制金额" >
            <el-radio-group v-model="Rules.limit_model" @change="limit_model_change">
              <el-radio :label="0">无限制</el-radio>
              <el-radio :label="1">限制金额</el-radio>
            </el-radio-group>
            <div class="" v-if="Rules.limit_model == 1">
              <el-input type="number" :min="0" style="width:150px;margin-top:5px;margin-bottom:5px;" v-model="Rules.limit_price" placeholder="请输入限制金额"></el-input>
              <div class="form-tips">
                限制应用此规则的最低金额，<span style="color:#ff6666;"> 达到此金额才会应用此规则 </span>
              </div>
            </div>
            <div class="" v-if="Rules.limit_model == 0">
              <div class="form-tips">
                不限制应用此规则的最低金额，<span style="color:#ff6666;"> 所有购买操作都会应用此规则 </span>
              </div>
            </div>
          </el-form-item>
          <el-form-item>
              <el-button type="primary" @click="onSubmitInfo">确定保存</el-button>
              <el-button @click="goBackPage">取消</el-button>
          </el-form-item>
        </el-form>
      </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      id: 0,
      // rules_type_model: 0,//规则类型 满减或折扣
      // rules_suit_model: 0,//规则适用对象 全店或部分商品
      // rules_limit_model: 0,//适用规则的最低限制
      is_edit: false,
      reload_time: 0,//单选框改变次数
      Rules: {
        rules_name: '',
        type_model: 0,//规则类型 满减或折扣或减运费
        suit_model: 0,//规则适用对象 全店或部分商品
        limit_model: 0,//适用规则的最低限制
        minus_price: 0,//减去的价格
        discount_price: 0,//折扣
        limit_price: 0,//限制金额
        suit_catelog: '',//指定的分类
      },
    }
  },
  mounted() {
    this.id = this.$route.query.id || 0;
    if (this.id !== 0) {
      this.is_edit = true
      this.getInfo()
    }
  },
  methods: {
    // 、、、、、、、、、、、、、、、、、、、、、、、
    onSubmitInfo() {
      console.log(this.Rules);
      if (this.Rules.rules_name == '') {
        this.$message.error("请输入规则名称 !")
        return false
      }
      if (this.Rules.type_model == 1 && this.Rules.minus_price == '') {
        this.$message.error("请输入规则类型的减免价格 !")
        return false
      }
      if (this.Rules.type_model == 2 && this.Rules.discount_price == '') {
        this.$message.error("请输入规则类型的折扣比例 !")
        return false
      }
      if (this.Rules.type_model == 2 && (Number(this.Rules.discount_price) >= 10)) {
        this.$message.error("折扣比例不能大于10 !")
        return false
      }
      if (this.Rules.limit_model == 1 && this.Rules.limit_price == '') {
        this.$message.error("请输入规则限制金额 !")
        return false
      }
      if (this.Rules.limit_model == 1 && (Number(this.Rules.limit_price) <= Number(this.Rules.minus_price))) {
        this.$message.error("规则限制金额不能大于减免金额 !")
        return false
      }
      this.axios.post('cartRules/updaterules',{
        id: this.id,
        rules: this.Rules
      }).then(res => {
        console.log(res);
        if (res.status == 200) {
            this.$notify({
            title: '成功',
            message: res.data.errmsg,
            type: 'success'
          });
          this.goBackPage()
        }
      })
    },
    ////////////////////////////////////单选框更改事件
    type_model_change(e){
      this.reload_time = Number(this.reload_time) + 1
      if (Number(this.reload_time) > 3) {
        this.Rules.minus_price = ''
        this.Rules.discount_price = ''
      }
    },
    limit_model_change(){
      this.reload_time = Number(this.reload_time) + 1
      if (Number(this.reload_time) > 3) {
        this.Rules.limit_price = ''
      }
    },
    //////////////////////////////////
    getInfo() {
      this.axios.post('cartRules/findrulesinfoById', {
        id: this.id
      }).then(res => {
        console.log(res);
        this.Rules.rules_name = res.data.data.rules_name
        this.Rules.type_model = res.data.data.rules_type
        this.Rules.suit_model = res.data.data.rules_suit
        this.Rules.limit_model = res.data.data.rules_limit
        this.Rules.minus_price = res.data.data.rules_minus_price
        this.Rules.discount_price = res.data.data.rules_discount_price
        this.Rules.limit_price = res.data.data.rules_limit_price
        this.Rules.suit_catelog = res.data.data.rules_suit_catelog
        // console.log(res.data.data.rules_limit_price);
        // console.log(this.Rules.limit_price);
        // console.log(this.Rules);
      })
    },
    goBackPage() {
      this.$router.go(-1);
    },
  }
}
</script>

<style lang="css">
.form-tips {
  color: #757575;
  font-size: 12px;
}
</style>
