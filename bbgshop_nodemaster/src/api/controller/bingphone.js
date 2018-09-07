const Base = require('./base.js');
/**
 * 云通信基础能力业务短信发送、查询详情以及消费消息示例，供参考。
 * Created on 2017-07-31
 */

const SMSClient = require('@alicloud/sms-sdk')

// ACCESS_KEY_ID/ACCESS_KEY_SECRET 根据实际申请的账号信息进行替换 think.config('vaptcha.vid')
const accessKeyId = think.config('SMSClient.accessKeyId')
const SignatureName = think.config('SMSClient.SignatureName')
const TemplateDomesticCode = think.config('SMSClient.TemplateDomesticCode') //国内短信
const TemplateAbroadCode = think.config('SMSClient.TemplateAbroadCode') ? think.config('SMSClient.TemplateAbroadCode') : '' //国际短信
const secretAccessKey = think.config('SMSClient.secretAccessKey')

//在云通信页面开通相应业务消息后，就能在页面上获得对应的queueName,不用填最后面一段
const queueName = think.config('SMSClient.queueName')

//初始化sms_client
let smsClient = new SMSClient({accessKeyId, secretAccessKey})

// smsClient.sendBatchSMS({
//     PhoneNumberJson: JSON.stringify(['18040580000', '15088650000']),
//     SignNameJson: JSON.stringify(['短信迁移测试签名','短信迁移测试签名']),
//     TemplateCode: 'SMS_71175823',
//     TemplateParamJson: JSON.stringify([{code: "1234", product: "ytx1"}, {code: "5678", product: "ytx2"}]),
// }).then(function (res) {
//     let {Code}=res
//     if (Code === 'OK') {
//        //处理返回参数
//        console.log(res)
//     }
// }, function (err) {
//     console.log('err', err)
// })


// //短信回执报告
// smsClient.receiveMsg(0, queueName).then(function (res) {
//     //消息体需要base64解码
//     let {code, body}=res
//     if (code === 200) {
//         //处理消息体,messagebody
//         console.log(body)
//     }
// }, function (err) {
//     console.log(err)
// })

// //短信上行报告
// smsClient.receiveMsg(1, queueName).then(function (res) {
//     //消息体需要base64解码
//     let {code, body}=res
//     if (code === 200) {
//         //处理消息体,messagebody
//         console.log(body)
//     }
// }, function (err) {
//     console.log(err)
// })


// //查询短信发送详情
// smsClient.queryDetail({
//     PhoneNumber: '1500000000',
//     SendDate: '20170731',
//     PageSize: '10',
//     CurrentPage: "1"
// }).then(function (res) {
//     let {Code, SmsSendDetailDTOs}=res
//     if (Code === 'OK') {
//         //处理发送详情内容
//         console.log(SmsSendDetailDTOs)
//     }
// }, function (err) {
//     //处理错误
//     console.log(err)
// })


module.exports = class extends Base {
  async getcountrycodeAction() {
    const data = await this.model('country_code_ali').select()
    return this.success(data)
  }
  async findAction() {
    const userId = this.post("userId")
    const result = await this.model('user').where({ id: userId}).find();
    const selectedcountry = await this.model('country_code_ali').where({ phone_code: result.mobile_code}).find();
    return this.success({
      Result:result,
      selectedcountry:selectedcountry
    })
  }
  async textAction() {
    const Phone = this.post('Phone');
    const selectedcountry = this.post('selectedcountry')
    if (parseInt(selectedcountry.phone_code) == 86) {
      console.log('国内短信');
        return this.success({
          Phone:Phone,
          type: 0,
        })
      }else {
        console.log('国际短信');
        return this.success({
          Phone:Phone,
          type: 1,
        })
      }
  }
  //发送国际验证码
  async sedAbroadsodeAction() {
    const Phone = this.post('phone');
    const selectedcountry = this.post('selectedcountry')
    console.log(selectedcountry);
    let phone_add_code = '00' + selectedcountry.phone_code + Phone
    console.log(phone_add_code);
    var Num="7";
      for(var i=0;i<5;i++)
      { Num+=Math.floor(Math.random()*10); }
      console.log(Num);
      let message = await smsClient.sendSMS({
          PhoneNumbers: phone_add_code,
          SignName: SignatureName,
          TemplateCode: TemplateAbroadCode,
          TemplateParam: '{"code": '+Num+'}'
        }).then(function (res) {
            console.log(res);
            if (res) {
                let abc = '短信发送成功 ！'
                return abc
            }
        }, function (err) {
            console.log(err)
            return err.data.Message
        })
        console.log(message);
        return this.success({
          Phone:Phone,
          num:Num,
          message: message,
        });

  }

  //发送国内验证码
  async sedDomesticsodeAction() {
    const Phone = this.post('phone');
    var Num="7";
      for(var i=0;i<5;i++)
      {
      Num+=Math.floor(Math.random()*10);
      }
      console.log(Num);
      let message = await smsClient.sendSMS({
          PhoneNumbers: Phone,
          SignName: SignatureName,
          TemplateCode: TemplateDomesticCode,
          TemplateParam: '{"code": '+Num+'}'
        }).then(function (res) {
            console.log(res);
            if (res) {
                let abc = '短信发送成功 ！'
                return abc
            }
        }, function (err) {
            console.log(err)
            return err.data.Message
        })
        console.log(message);
        return this.success({
          Phone:Phone,
          num:Num,
          message: message,
        });

  }

  // 验证验证码
  async checksodeAction() {
    const Phone = this.post("phone")
    const Code = this.post("code")

    // const findresult = await this.model('user').where({ id: think.userId}).update({ mobile: bing});
    // const result = await this.model('user').where({ id: think.userId }).update({ phone: bing});
    return this.success({Phone,Code})
  }



  async bingAction() {
    const bing = this.post("bingphone")
    const userid = this.post("userid")
    const selectedcountry = this.post("selectedcountry")
    console.log(bing,userid);
    console.log(selectedcountry);
    const findresult = await this.model('user').where({ id: userid}).update({
      mobile: bing,
      mobile_country: selectedcountry.country_name_chinese,
      mobile_country_code: selectedcountry.country_code,
      mobile_code: selectedcountry.phone_code,
      mobile_country_e: selectedcountry.country_name_english,
    });
    // const result = await this.model('user').where({ id: think.userId }).update({ phone: bing});
    return this.success({
      Findresult:findresult,
      // Result:result,
      bingphone:bing,
      // abc:"123"
    })
  }

};
