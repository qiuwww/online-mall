const Application = require('thinkjs');
// 生产环境入口文件
const instance = new Application({
  ROOT_PATH: __dirname,
  proxy: true, // use proxy
  env: 'production'
});

instance.run();
