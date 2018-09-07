<template>
    <div class="left-box">
        <div class="logo">
            <img style="height:50px;" src="static/images/beibao_logo.png"/>
        </div>
        <el-menu class="sidebar" :unique-opened="true" :default-active="currentPagePath" @open="handleOpen"
                 :router="true" theme="dark" @close="handleClose">
            <el-menu-item index="/dashboard">
                <i class="fa fa-map-signs"></i>
                <span>主页</span>
            </el-menu-item>
            <el-menu-item index="/dashboard/reportfrom">
                <i class="fa fa-line-chart"></i>
                <span>数据中心</span>
            </el-menu-item>
            <el-menu-item index="/dashboard/order/all">
                <i class="fa fa-large fa-archive"></i>
                <span>订单中心</span>
            </el-menu-item>
            <el-submenu index="goods">
                <template slot="title">
                    <i class="fa fa-shopping-bag"></i>
                    <span>商品管理</span>
                </template>
                <el-menu-item index="/dashboard/goods">
                    <i class="fa fa-circle"></i>
                    <span>商品列表</span>
                </el-menu-item>
                <el-menu-item index="/dashboard/category">
                    <i class="fa fa-circle"></i>
                    <span>商品分类</span>
                </el-menu-item>
                <el-menu-item index="/dashboard/SupplierPage">
                    <i class="fa fa-circle"></i>
                    <span>供货商管理</span>
                </el-menu-item>
                <!-- <el-menu-item index="/dashboard/brand">
                    <i class="fa fa-circle"></i>
                    <span>品牌管理</span>
                </el-menu-item> -->
            </el-submenu>
            <el-submenu index="Distribution">
              <template slot="title">
                  <i class="fa fa-group"></i>
                  <span>分销管理</span>
              </template>
              <el-menu-item index="/dashboard/DistributionConfig">
                  <i class="fa fa-circle"></i>
                  <span>分销设置</span>
              </el-menu-item>
              <el-menu-item index="/dashboard/Distribution_apply">
                  <i class="fa fa-circle"></i>
                  <span>分销申请</span>
              </el-menu-item>
              <el-menu-item index="/dashboard/Distribution_user">
                  <i class="fa fa-circle"></i>
                  <span>分销用户</span>
              </el-menu-item>
              <el-menu-item index="/dashboard/Distribution_detail">
                  <i class="fa fa-circle"></i>
                  <span>分销明细</span>
              </el-menu-item>
              <el-menu-item index="/dashboard/Distribution_cash">
                  <i class="fa fa-circle"></i>
                  <span>佣金管理</span>
              </el-menu-item>
            </el-submenu>
            <!-- <el-menu-item index="/dashboard">
                <i class="fa fa-tachometer"></i>
                <span>后台主页</span>
            </el-menu-item> -->

            <el-submenu index="other">
                <template slot="title">
                    <i class="fa fa-product-hunt"></i>
                    <span>店铺管理</span>
                </template>
                <el-menu-item index="/dashboard/KeywordSetting">
                    <i class="fa fa-circle"></i>
                    <span>关键词设置</span>
                </el-menu-item>
                <el-menu-item index="/dashboard/loopindex">
                    <i class="fa fa-circle"></i>
                    <span>首页轮播</span>
                </el-menu-item>
                <el-menu-item index="/dashboard/FreightTemPage">
                    <i class="fa fa-circle"></i>
                    <span>运费模板</span>
                </el-menu-item>
                <el-menu-item index="/dashboard/CartRulesPage">
                    <i class="fa fa-circle"></i>
                    <span>金额结算规则</span>
                </el-menu-item>
                <el-menu-item index="/dashboard/GoodsQuestionUpdate">
                    <i class="fa fa-circle"></i>
                    <span>商品页常见问题管理</span>
                </el-menu-item>
            </el-submenu>
            <el-submenu index="operate">
                <template slot="title">
                    <i class="fa fa-large fa-truck"></i>
                    <span>店铺运营</span>
                </template>
                <el-menu-item index="/dashboard/CouponPage">
                    <i class="fa fa-circle"></i>
                    <span>优惠券管理</span>
                </el-menu-item>
                <el-menu-item index="/dashboard/collagepage">
                    <i class="fa fa-circle"></i>
                    <span>拼团管理</span>
                </el-menu-item>
                <el-menu-item index="/dashboard/bargain/bargainPage">
                    <i class="fa fa-circle"></i>
                    <span>砍价管理</span>
                </el-menu-item>
                <el-menu-item index="/dashboard/Luckdraw_page">
                    <i class="fa fa-circle"></i>
                    <span>抽奖管理</span>
                </el-menu-item>
            </el-submenu>
            <el-submenu index="user">
                <template slot="title">
                    <i class="fa fa-large fa-user-circle"></i>
                    <span>用户管理</span>
                </template>
                <el-menu-item index="/dashboard/user">
                    <i class="fa fa-circle"></i>
                    <span>用户列表</span>
                </el-menu-item>
                <el-menu-item index="/dashboard/user/complaint">
                    <i class="fa fa-circle"></i>
                    <span>用户反馈</span>
                </el-menu-item>
            </el-submenu>
            <el-submenu index="setting">
                <template slot="title">
                    <i class="fa fa-large fa-file-text-o"></i>
                    <span>文章管理</span>
                </template>
                <el-menu-item index="/dashboard/NoviceGuide">
                    <i class="fa fa-circle"></i>
                    <span>新手指南</span>
                </el-menu-item>
                <el-menu-item index="/dashboard/AftersaleGuide">
                    <i class="fa fa-circle"></i>
                    <span>售后指南</span>
                </el-menu-item>
            </el-submenu>
        </el-menu>
    </div>
</template>

<script>
import api from '@/config/api';
// import { Menu,Submenu,MenuItem,MenuItemGroup } from 'element-ui'
// Vue.use(Menu)
    export default {
        data() {
            return {
              CorporateName: '',
              currentPagePath: '/dashboard'
            }
        },
        // components:{
        //   Menu,Submenu,MenuItem,MenuItemGroup
        // },
        methods: {
            handleOpen(key, keyPath) {
                console.log(key, keyPath);
            },
            handleClose(key, keyPath) {
                console.log(key, keyPath);
            },
            hasOwn() {
            }
        },
        mounted() {
          this.CorporateName = api.CorporateName
          console.log(this.$route.path);
        }
    }

</script>
<style>
    .left-box {
        width: 200px;
        display: flex;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 5;
        height: 100%;
        float: left;
        flex-direction: column;
        background: #324157;
    }

    .left-box .sidebar {
        width: 200px;
        flex: 1;
        border-radius: 0;
        background: #324157;
    }

    .left-box .fa {
        margin-right: 10px;
        font-size: 18px;
    }

    .left-box .el-submenu .el-menu-item .fa {
        margin-right: 10px;
        font-size: 10px;
    }

    .left-box .logo {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 120px;
        box-shadow: 0 1px 1px rgba(0, 0, 0, .5);
    }

    .left-box .logo img {
        /* border:1px solid black; */
        height: 60px;
    }
</style>
