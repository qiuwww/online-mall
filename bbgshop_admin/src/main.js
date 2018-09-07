import Vue from 'vue'
import Axios from 'axios'
import VueAxios from 'vue-axios'

// import 'element-ui/lib/theme-default/index.css'
// 引入样式
// import 'vue-easytable/libs/themes-base/index.css'
// 导入 table 和 分页组件
// import {VTable,VPagination} from 'vue-easytable'
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
Vue.use(VueQuillEditor)
Vue.use(VueAxios, Axios);
// Vue.use(Vant);
// Vue.use(Element);
// import api from '@/config/api';

router.beforeEach((to, from, next) => {
	let token = sessionStorage.getItem('token') || '';
    // 配置接口信息
		Axios.defaults.baseURL = 'http://127.0.0.1:8360/admin/'; //本地测试接口
		// Axios.defaults.baseURL = 'https://xxxxxxxxxxxxxxxxx.xxxxxxxxxxxxxxxxx.com/admin/';//易天数据接口
    Axios.defaults.headers.common['X-Nideshop-Token'] = token;

		if (!token && to.name !== 'login') {
			console.log('重定向');
			next({
				path: '/login',
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
