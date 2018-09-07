<template lang="html">
  <div class="content-page">
      <div class="content-nav" >
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>分销管理</el-breadcrumb-item>
              <el-breadcrumb-item>分销设置</el-breadcrumb-item>
          </el-breadcrumb>
          <!-- <div class="operation-nav">
              <el-button type="primary" size="small" @click="Refresh">刷新</el-button>
          </div> -->
      </div>
      <div class="content-main">
        <el-form label-width="150px">
          <el-form-item label="规则文本">
            <!-- <el-input type="textarea" :rows="8" placeholder="请输入内容" v-model="formLabelAlign.rules_value"></el-input> -->
            <template>
              <div style="margin-top:-25px;">
                      <!-- 图片上传组件辅助-->
                <el-upload
                  class="avatar-uploader"
                  action="http://upload.qiniup.com"
                  :multiple="true"
                  :data="uploadToken"
                  :headers="uploaderHeader"
                  :show-file-list="false"
                  :on-success="detailhandlesuccess"
                  :on-error="uploadError"
                  :before-upload="beforeUpload">
                </el-upload>
                    <!--富文本编辑器组件-->
                <el-row v-loading="quillUpdateImg">
                    <quill-editor
                        v-model="formLabelAlign.rules_value"
                        ref="myQuillEditor"
                        :options="editorOption"
                        @change="onEditorChange($event)"
                    >
                    </quill-editor>
                </el-row>
              </div>
            </template>
          </el-form-item>
          <el-form-item label="当前自身佣金返还率">
            <el-input :min="0" :max="100" style="width:125px;" type="number" v-model="formLabelAlign.localownrate" placeholder="">
              <template slot="append">%</template>
            </el-input>
            <div class="form-tips">
              <span style="color:#ff6f00;">分销员自身购买商品</span> ，
              <span style="color:#ff6666;">获得的返还率</span>
            </div>
          </el-form-item>
          <el-form-item label="当前一次佣金返还率">
            <el-input :min="0" :max="100" style="width:125px;" type="number" v-model="formLabelAlign.localrate" placeholder="">
              <template slot="append">%</template>
            </el-input>
            <!-- <div class="form-tips">
              <span style="color:#ff6f00;">真实价格旁边被划掉的价格,例如
                    <span style="color:#757575;text-decoration:line-through;">￥988</span></span> ，
              <span style="color:#ff6666;">默认为价格值的 1.22 倍</span>
            </div> -->
          </el-form-item>
          <el-form-item label="当前二次佣金返还率">
            <el-input :min="0" :max="100" style="width:125px;" type="number" v-model="formLabelAlign.localsecondrate" placeholder="">
              <template slot="append">%</template>
            </el-input>
            <div class="form-tips">
              请注意：<span style="color:#ff6f00;">此数值不会和一级分销的返还率相加，而是独立存在的</span> ，
              <span style="color:#ff6666;"> 也就是说，如果用户为二次分销，返还的佣金将是订单金额直接乘以此数值，不会与一次分销返还率产生交集 ！</span>
            </div>
          </el-form-item>
          <el-form-item label="当前最低提现金额">
            <el-input :min="0" style="width:125px;" type="number" v-model="formLabelAlign.localprice" placeholder="">
              <template slot="prepend">￥</template>
            </el-input>
          </el-form-item>
          <!-- <el-form-item label="活动区域">
            <el-input v-model="formLabelAlign.region"></el-input>
          </el-form-item>
          <el-form-item label="活动形式">
            <el-input v-model="formLabelAlign.type"></el-input>
          </el-form-item> -->
          <el-form-item label="">
            <el-button type="danger" @click="DisRulesUpdate">确定保存</el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>
</template>

<script>
import { Toast } from 'vant'
import api from '@/config/api';
//以下为富文本配置
const toolbarOptions = [
  ['bold', 'italic', 'underline', 'strike'], // toggled buttons
  [{'header': 1}, {'header': 2}], // custom button values
  [{'list': 'ordered'}, {'list': 'bullet'}],
  [{'script': 'sub'}, {'script': 'super'}], // superscript/subscript
  [{ 'align': 'center' }],
  ['image'],
  ['clean'] // remove formatting button
]
export default {
  data() {
     return {
       uploaddress: api.UploadAddress,
       uploaderHeader: {
         'X-Nideshop-Token': localStorage.getItem('token') || '',
       }, // 有的图片服务器要求请求头需要有token之类的参数，写在这里
       uploadToken: {
         token: ''
       },
       quillUpdateImg: false,
       formLabelAlign: {
         rules_value: '',
         localrate: 0.00,
         localsecondrate: 0.00,
         localprice: 0.00,
         localownrate: 1.00,
       },
       quillUpdateImg: false, // 根据图片上传状态来确定是否显示loading动画，刚开始是false,不显示
       //富文本配置
       editorOption: {
         placeholder: '',
         theme: 'snow', // or 'bubble'
         modules: {
           toolbar: {
             container: toolbarOptions, // 工具栏
             handlers: {
               'image': function(value) {
                 if (value) {
                   // 触发input框选择图片文件
                   document.querySelector('.avatar-uploader input').click()
                 } else {
                   this.quill.format('image', false);
                 }
               }
             }
           }
         }
       },
     };
   },
   mounted(){
     this.getDisconfig()
     this.gettoken()
   },
   methods: {
     DisRulesUpdate() {
       console.log(this.formLabelAlign);
       if (this.formLabelAlign.rules_value == '') {
         this.$message.error("请填写分销规则 ！")
         return false
       }
       if (Number(this.formLabelAlign.localownrate) < 0 || Number(this.formLabelAlign.localownrate) >= 100) {
         this.$message.error("自身佣金返还率设置有误 ！")
         return false
       }
       if (Number(this.formLabelAlign.localrate) < 0 || Number(this.formLabelAlign.localrate) >= 100) {
         this.$message.error("一级佣金返还率设置有误 ！")
         return false
       }
       if (Number(this.formLabelAlign.localsecondrate) < 0 || Number(this.formLabelAlign.localsecondrate) >= 100) {
         this.$message.error("二级佣金返还率设置有误 ！")
         return false
       }

       if (Number(this.formLabelAlign.localprice) < 0 ) {
         this.$message.error("最低返现金额不能小于0 ！")
         return false
       }
       this.formLabelAlign.localrate = (this.formLabelAlign.localrate / 1).toFixed(2)
       this.$confirm('此操作将修改此信息，立即生效！, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.axios.post('distribution/updateconfig',{
            info: this.formLabelAlign
          }).then((res) => {
            console.log(res);
            if (res.data.errno == 0) {
              this.getDisconfig()
              this.$message({
                type: 'success',
                message: '修改成功 ！'
              });
            }
          })

        }).catch(() => {
          this.$message({
            type: 'info',
            message: '取消修改 ！'
          });
        });
     },
     /////////////////////富文本操作事件
     ///////////////////////////////////////////以下为富文本上传事件
     onEditorChange(e) {
       this.formLabelAlign.rules_value = e.html
       // console.log(this.formLabelAlign.rules_value);
     },
     beforeUpload() {
       // 显示loading动画
       this.quillUpdateImg = true
     },
     detailhandlesuccess(res, file) {
       // res为图片服务器返回的数据
       console.log(res, file);
       // 获取富文本组件实例
       let quill = this.$refs.myQuillEditor.quill
       // 如果上传成功
       if (res) {
         // 获取光标所在位置
         let length = quill.getSelection().index;
         // 插入图片  res.info为服务器返回的图片地址
         quill.insertEmbed(length, 'image', this.uploaddress + res.key)
         // 调整光标到最后
         quill.setSelection(length + 1)
       } else {
         this.$message.error('图片插入失败 ！')
       }
       // loading动画消失
       this.quillUpdateImg = false
     },
     // 富文本图片上传失败
     uploadError() {
       // loading动画消失
       this.quillUpdateImg = false
       this.$message.error('图片上传失败 ！')
     },

     //获取上传token
     gettoken() {
       this.axios.post('upload/token').then((res) => {
         console.log('上传的token：' + res.data.data.uploadToken);
         this.uploadToken.token = res.data.data.uploadToken
       })
     },
     getDisconfig() {
       this.axios.post('distribution/getdisconfig').then(res => {
         console.log(res);
         this.formLabelAlign.rules_value = res.data.data[0].rules_text
         this.formLabelAlign.localrate = Number(res.data.data[0].rate * 1).toFixed(2)
         this.formLabelAlign.localprice = res.data.data[0].price
         this.formLabelAlign.localsecondrate = Number(res.data.data[0].secondrate * 1).toFixed(2)
         this.formLabelAlign.localownrate = Number(res.data.data[0].ownrate * 1).toFixed(2)
       })
     }
   }
 }
  </script>

<style lang="css" scoped>
.form-tips {
  font-size: 10px;
  color: #757575;
}
</style>
