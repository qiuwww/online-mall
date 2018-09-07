import Vue from 'vue'
import Router from 'vue-router'
Vue.use(Router)

export default new Router({
    scrollBehavior: () => ({y: 0}),
    routes: [
      {
          path: '/login',
          name: 'login',
          // component: require('@/components/LoginPage')
          component:resolve => require(['@/components/LoginPage'],resolve)

      },
      {
          path: '*',
          redirect: '/dashboard'
      },
        {
            path: '/',
            name: 'dashboard',
            redirect: '/dashboard'
        },
        {
            path: '/dashboard',
            name: 'dashboard',
            component:resolve => require(['@/components/DashboardPage'],resolve),
            children: [

              {
                  path: 'AftersaleGuide',
                  name: 'AftersaleGuide',
                  component:resolve => require(['@/components/Guide/AftersaleGuide'],resolve),

              },
              {
                  path: 'NoviceGuide',
                  name: 'NoviceGuide',
                  component:resolve => require(['@/components/Guide/NoviceGuide'],resolve),

              },
              {
                  path: 'KeywordSetting',
                  name: 'KeywordSetting',
                  component:resolve => require(['@/components/Keywords/KeywordSetting'],resolve),

              },
              {
                  path: 'GoodsUpdatePage',
                  name: 'GoodsUpdatePage',
                  component:resolve => require(['@/components/Goods/GoodsUpdatePage'],resolve),

              },
              {
                  path: 'GoodsQuestionUpdate',
                  name: 'GoodsQuestionUpdate',
                  component:resolve => require(['@/components/Other/GoodsQuestionUpdate'],resolve),

              },
              {
                  path: 'DistributionConfig',
                  name: 'DistributionConfig',
                  component:resolve => require(['@/components/Distribution/DistributionConfig'],resolve),

              },
              {
                  path: 'reportfrom',
                  name: 'reportfrom',
                  component:resolve => require(['@/components/ReportFrom/ReportFrom'],resolve),

              },
              {
                  path: 'Luckdraw_page',
                  name: 'Luckdraw_page',
                  component:resolve => require(['@/components/LuckDraw/LuckDrawPage'],resolve),
              },
              {
                  path: 'Luckdraw_add',
                  name: 'Luckdraw_add',
                  component:resolve => require(['@/components/LuckDraw/LuckDrawAdd'],resolve),
              },
              {
                  path: 'Distribution_user',
                  name: 'Distribution_user',
                  component:resolve => require(['@/components/Distribution/DistributionUser'],resolve),

              },
              {
                  path: 'Distribution_apply',
                  name: 'Distribution_apply',
                  component:resolve => require(['@/components/Distribution/DistributionApply'],resolve),

              },
              {
                  path: 'Distribution_cash',
                  name: 'Distribution_cash',
                  component:resolve => require(['@/components/Distribution/DistributionCash'],resolve),

              },
              {
                  path: 'Distribution_detail',
                  name: 'Distribution_detail',
                  // component: require('@/components/WelcomePage')
                  component:resolve => require(['@/components/Distribution/DistributionDetail'],resolve),

              },
                {
                    path: '/',
                    name: 'welcome',
                    // component: require('@/components/WelcomePage')
                    component:resolve => require(['@/components/WelcomePage'],resolve),

                },
                {
                    path: 'SupplierPage',
                    name: 'SupplierPage',
                    // component: require('@/components/Other/LoopIndexPage')
                    component:resolve => require(['@/components/Supplier/SupplierPage'],resolve),
                },
                {
                    path: 'CategoryUpdatePage',
                    name: 'CategoryUpdatePage',
                    // component: require('@/components/Other/LoopIndexPage')
                    component:resolve => require(['@/components/Category/CategoryUpdatePage'],resolve),
                },
                {
                    path: 'CartRulesAdd',
                    name: 'CartRulesAdd',
                    // component: require('@/components/Other/LoopIndexPage')
                    component:resolve => require(['@/components/CartRules/CartRulesAdd'],resolve),
                },
                {
                    path: 'CartRulesPage',
                    name: 'CartRulesPage',
                    // component: require('@/components/Other/LoopIndexPage')
                    component:resolve => require(['@/components/CartRules/CartRulesPage'],resolve),
                },
                {
                    path: 'FreightTemPage',
                    name: 'FreightTemPage',
                    // component: require('@/components/Other/LoopIndexPage')
                    component:resolve => require(['@/components/Freight/FreightTemPage'],resolve),
                },
                {
                    path: 'AddFreightTem',
                    name: 'AddFreightTem',
                    // component: require('@/components/Other/LoopIndexPage')
                    component:resolve => require(['@/components/Freight/AddFreightTem'],resolve),
                },
                {
                    path: 'loopindex',
                    name: 'loopindex',
                    // component: require('@/components/Other/LoopIndexPage')
                    component:resolve => require(['@/components/Other/LoopIndexPage'],resolve),
                },
                {
                    path: 'CouponPage',
                    name: 'CouponPage',
                    component:resolve => require(['@/components/Coupon/CouponPage'],resolve),
                    // component: require('@/components/Other/BarIndexPage')
                },
                {
                    path: 'addcoupon',
                    name: 'addcoupon',
                    component:resolve => require(['@/components/Coupon/AddCoupon'],resolve),
                    // component: require('@/components/Other/BarIndexPage')
                },
                {
                    path: 'goods',
                    name: 'goods',
                    component:resolve => require(['@/components/Goods/GoodsPage'],resolve),
                    // component: require('@/components/Goods/GoodsPage')
                },
                // {
                //     path: 'goods/add',
                //     name: 'goods_add',
                //     component:resolve => require(['@/components/Goods/GoodsAddPage'],resolve),
                //     // component: require('@/components/Goods/GoodsAddPage')
                // },
                {
                    path: 'category',
                    name: 'category',
                    component:resolve => require(['@/components/Category/CategoryPage'],resolve),
                    // component: require('@/components/Category/CategoryPage')
                },
                // {
                //     path: 'category/add',
                //     name: 'category_add',
                //     component:resolve => require(['@/components/Category/CategoryAddPage'],resolve),
                //     // component: require('@/components/Category/CategoryAddPage')
                // },
                {
                    path: 'brand',
                    name: 'brand',
                    component:resolve => require(['@/components/Brand/BrandPage'],resolve),
                    // component: require('@/components/Brand/BrandPage')
                },
                {
                    path: 'brand/add',
                    name: 'brand_add',
                    component:resolve => require(['@/components/Brand/BrandAddPage'],resolve),
                    // component: require('@/components/Brand/BrandAddPage')
                },
                // {
                //     path: 'order',
                //     name: 'order',
                //     component:resolve => require(['@/components/Order/OrderPage'],resolve),
                //     // component: require('@/components/Order/OrderPage')
                // },
                // {
                //     path: 'pendpayorder',
                //     name: 'pendpayorder',
                //     component:resolve => require(['@/components/Order/PendPayOrder'],resolve),
                //     // component: require('@/components/Order/OrderPage')
                // },
                // {
                //     path: 'pendoutorder',
                //     name: 'pendoutorder',
                //     component:resolve => require(['@/components/Order/PendOutOrder'],resolve),
                //     // component: require('@/components/Order/OrderPage')
                // },
                // {
                //     path: 'alreadyoutorder',
                //     name: 'alreadyoutorder',
                //     component:resolve => require(['@/components/Order/AlreadyOutOrder'],resolve),
                //     // component: require('@/components/Order/OrderPage')
                // },
                {
                    path: 'collagepage',
                    name: 'collagepage',
                    component:resolve => require(['@/components/Collage/CollagePage'],resolve),
                    // component: require('@/components/Order/OrderPage')
                },
                {
                    path: 'collage/add',
                    name: 'collage_add',
                    component:resolve => require(['@/components/Collage/CollageAdd'],resolve),
                    // component: require('@/components/Order/OrderPage')
                },
                {
                    path: 'order/all',
                    name: 'order_all',
                    component:resolve => require(['@/components/Order/AllOrderPage'],resolve),
                    // component: require('@/components/Order/OrderPage')
                },
                // {
                //     path: 'refundorder',
                //     name: 'refundorder',
                //     component:resolve => require(['@/components/Order/RefundOrder'],resolve),
                //     // component: require('@/components/Order/OrderPage')
                // },
                {
                    path: 'order/detail',
                    name: 'order_detail',
                    component:resolve => require(['@/components/Order/OrderDetailPage'],resolve),
                    // component: require('@/components/Order/OrderDetailPage')
                },
                {
                    path: 'operate/topic',
                    name: 'topic',
                    component:resolve => require(['@/components/Topic/TopicPage'],resolve),
                    // component: require('@/components/Topic/TopicPage')
                },
              {
                path: 'operate/topic/add',
                name: 'topic_add',
                component:resolve => require(['@/components/Topic/TopicAddPage'],resolve),
                // component: require('@/components/Topic/TopicAddPage')
              },
              {
                path: 'user',
                name: 'user',
                component:resolve => require(['@/components/User/UserPage'],resolve),
                // component: require('@/components/User/UserPage')
              },
              {
                path: 'user/complaint',
                name: 'user_complaint',
                component:resolve => require(['@/components/User/ComplaintPage'],resolve),
                // component: require('@/components/User/ComplaintPage')
              },
              {
                path: 'bargain/bargainPage',
                name: 'bargain_Page',
                component:resolve => require(['@/components/bargain/BargainPage'],resolve),
                // component: require('@/components/User/ComplaintPage')
              },
              {
                path: 'bargain/bargainAdd',
                name: 'bargain_Add',
                component:resolve => require(['@/components/bargain/BargainAdd'],resolve),
                // component: require('@/components/User/ComplaintPage')
              },
            ]
        }

    ]
})
