const Base = require('./base.js');
const fs = require('fs');
const qiniu = require('qiniu')


module.exports = class extends Base {
  async tokenAction() {
    // 文件名
    // 七牛提供的公钥
    var accessKey = think.config('qiniu.accessKey')
    // 七牛提供的私钥
    var secretKey = think.config('qiniu.secretKey')
    // 存储空间名
    var bucketName = think.config('qiniu.bucketName')
    var mac = new qiniu.auth.digest.Mac(accessKey, secretKey);

    var options = {
        "scope": bucketName
      };
      var putPolicy = new qiniu.rs.PutPolicy(options);
      var uploadToken=putPolicy.uploadToken(mac);
      console.log(uploadToken);
        return this.success({
            uploadToken:uploadToken
        })
    }

};
