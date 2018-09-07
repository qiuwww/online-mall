<template>
<div class="content-page">
  <div class="content-nav">
    <el-breadcrumb class="breadcrumb" separator="/">
      <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>订单中心</el-breadcrumb-item>
      <!-- <el-breadcrumb-item>订单列表</el-breadcrumb-item> -->
      <el-breadcrumb-item>订单详情</el-breadcrumb-item>
    </el-breadcrumb>
    <div class="operation-nav">
      <el-button type="primary" @click="goBackPage" size="small" icon="arrow-left">返回列表</el-button>
    </div>
  </div>
  <div class="content_detail">

    <el-card class="box-card">
      <div slot="header">
        <span style="color:#333;font-size:16px;font-weight:bold">订单详情</span>
        <span style="float: right;color:#666;font-size:14px;">{{orderInfo.order_sn}}</span>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">下单时间</div>
        <div class="box_card_item_right">{{orderInfo.add_localtime}}</div>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">付款时间</div>
        <div class="box_card_item_right">{{orderInfo.pay_time == 0 ? ' - - ': orderInfo.pay_localtime}}</div>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">优惠券</div>
        <div class="box_card_item_right">{{orderInfo.coupon_id == '0' ? '未使用优惠券':orderInfo.coupon_id}}</div>
      </div>
      <div class="box_card_item" v-if="orderInfo.coupon_id !== '0'">
        <div class="box_card_item_left">优惠券减免</div>
        <div class="box_card_item_right"> - {{orderInfo.coupon_price}}</div>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">用户留言</div>
        <div class="box_card_item_right">{{orderInfo.postscript == '' ? '无' : orderInfo.postscript}}</div>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">订单金额</div>
        <div class="box_card_item_right"><span style="font-size:12px;">￥</span>
          <span style="font-size:16px;color:#ff4444;font-weight:bold">{{orderInfo.actual_price}}</span>
        </div>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">订单状态</div>
        <div class="box_card_item_right">
          <!-- <span style="font-size:12px;">￥</span> -->
          <span style="font-size:16px;color:#ff4444;font-weight:bold">{{orderInfo.order_status_text}}</span>
        </div>
      </div>
    </el-card>

    <el-card class="box-card" v-if="refundInfo.length !== 0">
      <div slot="header">
        <span style="color:#333;font-size:16px;font-weight:bold">退款详情</span>
        <span style="float: right;color:#666;font-size:14px;">{{refundInfo[0].refund_sn}}</span>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">退款创建时间</div>
        <div class="box_card_item_right">{{refundInfo[0].creat_localtime}}</div>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">退款成功时间</div>
        <div class="box_card_item_right">{{refundInfo[0].refund_localtime}}</div>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">退款金额</div>
        <div class="box_card_item_right"><span style="font-size:12px;">￥</span>
          <span style="font-size:16px;color:#ff4444;font-weight:bold">{{refundInfo[0].refund_price}}</span>
        </div>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">退款类型</div>
        <div class="box_card_item_right">{{refundInfo[0].reson_value}} {{refundInfo[0].way_value}}</div>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">退款理由</div>
        <div class="box_card_item_right">{{refundInfo[0].reson}}</div>
      </div>
      <div class="box_card_item_img">
        <div class="box_card_item_imgleft">图片凭证</div>
        <!-- <div class="box_card_item_imgright">{{refundInfo[0].refund_img}}</div> -->
        <div class="box_card_item_imgright">
          <img class="box_card_item_imgright_item" @click="seeimg(img)" v-for="img in refundInfo[0].refund_localimg" :src="img" alt="">
        </div>
      </div>
    </el-card>

    <el-card class="box-card">
      <div slot="header">
        <span style="color:#333;font-size:16px;font-weight:bold">商品详情</span>
      </div>
      <el-row style="height:220px;overflow:scroll">
        <el-col :span="8" v-for="goods in goodslist" :key="goods.id">
          <el-card :body-style="{ padding: '0px' }">
            <img style="height:100px;" :src="goods.list_pic_url" alt="">
            <div style="padding: 2px 5px;">
              <span class="one_row_overflow" style="font-size:12px;height:40px;line-height:20px;">{{goods.goods_name}}</span>
              <div class="el_row_area">
                <div class="el_row_area_sku">
                  {{goods.goods_specifition_name_value}} x{{goods.number}}
                </div>
                <div class="el_row_area_price">
                  <span style="font-size:12px;">￥</span>{{goods.retail_price}}
                </div>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </el-card>

    <el-card class="box-card">
      <div slot="header">
        <span style="color:#333;font-size:16px;font-weight:bold">收货详情</span>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">姓名</div>
        <div class="box_card_item_right">{{orderInfo.consignee}}</div>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">手机号</div>
        <div class="box_card_item_right">{{orderInfo.mobile}}</div>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">详细地址</div>
        <div class="box_card_item_right">{{orderInfo.full_region}} {{orderInfo.address}}</div>
      </div>
    </el-card>

    <el-card class="box-card">
      <div slot="header">
        <span style="color:#333;font-size:16px;font-weight:bold">用户详情</span>
        <span style="float: right;color:#666;font-size:14px;">{{userInfo.id}}</span>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">昵称/性别</div>
        <div class="box_card_item_right" style="font-weight:bold;font-size:16px">{{userInfo.nickname}}
          <span style="color:#ff4444;font-size:11px">{{userInfo.gender == 1 ?'男':'女'}}</span></div>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">绑定手机号</div>
        <div class="box_card_item_right">{{userInfo.mobile}}</div>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">注册时间</div>
        <div class="box_card_item_right">{{userInfo.register_localtime}}</div>
      </div>
      <div class="box_card_item">
        <div class="box_card_item_left">最后登录时间</div>
        <div class="box_card_item_right">{{userInfo.lasterlogin_localtime}}</div>
      </div>
    </el-card>

  </div>
  <el-dialog v-model="dialogVisible" size="tiny">
    <img width="100%" :src="dialogImageUrl" alt="">
  </el-dialog>
  <el-button style="float:right" type="danger" @click="delorder">删除订单</el-button>
</div>

</div>
</template>

<script>
export default {
  data() {
    return {
      orderId: 0,
      dialogVisible: false,
      dialogImageUrl: '',
      // address: '',
      goodslist: [],
      // ordertime: '',
      // order_status: 0,
      // ordertimetime: '',
      userInfo: {},
      refundInfo: [],
      orderInfo: {},
    }
  },
  methods: {
    delorder() {
      this.$confirm('此操作将永久删除该信息, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.axios.post('order/destory', {
          id: this.orderId
        }).then((resss) => {
          console.log(resss);
        })
        this.$message({
          type: 'success',
          message: '删除成功!'
        });
        this.goBackPage()
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
      // }
    },
    // timestampToTime(1403058804);
    // console.log(timestampToTime(1403058804));//2014-06-18 10:33:24
    goBackPage() {
      this.$router.go(-1);
    },
    getInfo() {
      this.axios.post('order/detail', {
        orderId: this.orderId
      }).then((res) => {
        console.log(res);
        this.userInfo = res.data.data.userInfo
        this.refundInfo = res.data.data.refundInfo
        if (res.data.data.refundInfo.length >= 1) {
          this.refundInfo[0].creat_localtime = this.timestampToTime(res.data.data.refundInfo[0].creat_time)
          this.refundInfo[0].refund_localtime = this.timestampToTime(res.data.data.refundInfo[0].refund_time)
          if (res.data.data.refundInfo[0].refund_img) {
            this.refundInfo[0].refund_localimg = (res.data.data.refundInfo[0].refund_img).split(',')

          }
        }
        this.orderInfo = res.data.data.orderInfo
        this.orderInfo.add_localtime = this.timestampToTime(res.data.data.orderInfo.add_time)
        this.orderInfo.pay_localtime = this.timestampToTime(res.data.data.orderInfo.pay_time)
        this.userInfo.register_localtime = this.timestampToTime(res.data.data.userInfo.register_time * 1000)
        this.userInfo.lasterlogin_localtime = this.timestampToTime(res.data.data.userInfo.last_login_time * 1000)
        this.goodslist = res.data.data.orderGoods
        // this.order_status = res.data.data.orderInfo.order_status_text
        // this.address = res.data.data.orderInfo.full_region +"  "+ res.data.data.orderInfo.address
      })
    },
    seeimg(url) {
      this.dialogVisible = true
      this.dialogImageUrl = url
    },
    timestampToTime(timestamp) {
      var date = new Date(timestamp * 1); //时间戳为10位需*1000，时间戳为13位的话不需乘1000
      var Y = date.getFullYear() + '/';
      var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '/';
      var D = (date.getDate() < 10 ? '0' + date.getDate() : date.getDate()) + '  ';
      var h = (date.getHours() < 10 ? '0' + date.getHours() : date.getHours()) + ':';
      var m = (date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes()) + ':';
      var s = (date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds());
      return Y + M + D + h + m + s;
    }

  },
  components: {},
  mounted() {
    // console.log(this.$route.query)
    this.orderId = this.$route.query.id || 0;
    console.log(this.orderId);
    this.getInfo();
  }
}
</script>

<style scoped>
.box_card_item_imgright_item {
  width: 58px;
  height: 58px;
  margin: 2px 5px;
}

.box_card_item_imgright {
  /* border: 1px solid black; */
  width: 80%;
  float: right;
  text-align: right;
}

.box_card_item_imgleft {
  /* border: 1px solid black; */
  width: 20%;
  float: left;
}

.box_card_item_img {
  /* border: 1px solid black; */
  height: 68px;
  line-height: 22px;
  font-size: 13px;
  color: #666;
  /* margin-bottom: 6px; */
  /* border-bottom: 1px solid #eee; */
}

.content_detail {
  /* border: 1px solid black; */
  display: flex;
  flex-wrap: wrap;
  /* height: 600px; */
  /* justify-content: center; */
  /* align-items: center; */
}

.box-card {
  width: 400px;
  /* height: 250px; */
  margin: 5px;
}

.el_row_area_price {
  position: absolute;
  /* border:1px solid black; */
  font-size: 18px;
  font-weight: bold;
  color: #ff4444;
  bottom: 0;
  right: 0;
}

.el_row_area_sku {
  position: absolute;
  /* border:1px solid black; */
  font-size: 12px;
  color: #757575;
  bottom: 2px;
  left: 0;
}

.el_row_area {
  /* border:1px solid black; */
  position: relative;
  height: 38px;
}

.box_card_item_right {
  /* border:1px solid black; */
  float: right;
  padding: 0 3px;
}

.box_card_item_left {
  /* border:1px solid black; */
  float: left;
  padding: 0 3px;
}

.box_card_item {
  /* border:1px solid black; */
  height: 22px;
  line-height: 22px;
  font-size: 13px;
  color: #666;
  margin-bottom: 6px;
  border-bottom: 1px solid #eee;
}

.el-card__body {
  padding: 10px 15px;
}

.el-card__header {
  padding: 10px 15px;
}

.image {
  width: 200px !important;
  height: 200px !important;
}

.textstyle {
  color: #48576a !important;
  font-size: 15px !important;
}

.one_row_overflow {
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}
</style>
