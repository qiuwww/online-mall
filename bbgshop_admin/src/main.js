import Vue from 'vue'
import Axios from 'axios'
// 针对vue的axios封装吧
import VueAxios from 'vue-axios'

// import 'element-ui/lib/theme-default/index.css'
// 引入样式
// import 'vue-easytable/libs/themes-base/index.css'
// 导入 table 和 分页组件
// import {VTable,VPagination} from 'vue-easytable'

// 富文本编辑器的相关文件
import  VueQuillEditor from 'vue-quill-editor'
import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'
// import 'layui/css/layui.css'
// import 'layui/layui.js'
// import Vant from 'vant';
// import 'vant/lib/vant-css/index.css';

// import E from 'wangeditor'
// import echarts from 'echarts'

import App from './App'
import router from './router'

//引入echarts
// import echarts from 'echarts'

// Vue.prototype.$echarts = echarts


// import { vaptcha } from './config/v';

// <script src="https://cdn.vaptcha.com/v.js"></script>

// import 'https://cdn.vaptcha.com/v.js'
// 注册到全局
// Vue.component(VTable.name, VTable)
// Vue.component(VPagination.name, VPagination)
// 全局注入
Vue.use(VueQuillEditor) /* { default global options } */
// 添加到Vue中，
// This wrapper bind axios to Vue or this if you're using single file component.
Vue.use(VueAxios, Axios);
// Vue.use(Vant);
// Vue.use(Element);
// import api from '@/config/api';

// 直接在main中来处理token失效的问题，这个地方可以拿到router对象
// token失效就直接删除
router.beforeEach((to, from, next) => {
	let token = sessionStorage.getItem('token') || '';
    // 配置接口信息
		Axios.defaults.baseURL = 'http://127.0.0.1:8360/admin/'; //本地测试接口
		// Axios.defaults.baseURL = 'https://xxxxxxxxxxxxxxxxx.xxxxxxxxxxxxxxxxx.com/admin/';//易天数据接口
    Axios.defaults.headers.common['X-Nideshop-Token'] = token;
    // 如果token不存在切不是去login的就定向到login
		if (!token && to.name !== 'login') {
			console.log('重定向');
			next({
        path: '/login',
        // 机制，如果登录完成就重新定向到之前的页面，其实是一个跳转了
				query: { redirect: to.fullPath }
			})
		} else {
				next()
		}
});

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  components: { App },
  router,
  template: '<App/>'
}).$mount('#app')
