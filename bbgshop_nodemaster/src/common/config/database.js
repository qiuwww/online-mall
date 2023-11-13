const mysql = require('think-model-mysql');
// 数据库配置
module.exports = {
  handle: mysql,
  database: 'online_mall',
  prefix: 'bbgshop_',
  encoding: 'utf8mb4',
  host: '127.0.0.1',
  port: '3306',
  user: 'root',
  password: '',
  dateStrings: true
};
