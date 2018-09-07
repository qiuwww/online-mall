const qiniu = require('qiniu')
const sha1 = require('sha1')

// 七牛提供的公钥
const accessKey = think.config('qiniu.accessKey')
// 七牛提供的私钥
const secretKey = think.config('qiniu.secretKey')
// 存储空间名
const bucketName = think.config('qiniu.bucketName')
module.exports.upload = (req, res) => {
  // 文件名
  const fileName = `${sha1(req.query.fileName)}.${req.query.fileName.split('.').pop()}`

  const mac = new qiniu.auth.digest.Mac(accessKey, secretKey)
  const putPolicy = new qiniu.rs.PutPolicy({
    scope: `${bucketName}:${fileName}`,
    expires: 60 * 60 * 1,
    returnBody: '{"key":"$(key)","hash":"$(etag)","fsize":$(fsize),"bucket":"$(bucket)","name":"$(x:name)"}'
  })

  // 上传凭证
  const uploadToken = putPolicy.uploadToken(mac)

  res.send({
    code: '1',
    desc: 'ok',
    result: {
      bucketName,
      fileName,
      uploadToken
    }
  })
}
