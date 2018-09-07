<template lang="html">
  <div class="content-page">
      <div class="content-nav">
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>文章管理</el-breadcrumb-item>
              <el-breadcrumb-item>售后指南设置</el-breadcrumb-item>
          </el-breadcrumb>
          <div class="operation-nav">
            <!-- <router-link to="/dashboard/Luckdraw_add"> -->
              <!-- <el-button type="primary" icon="plus" @click="addquestion">添加</el-button> -->
            <!-- </router-link> -->
          </div>
      </div>
      <div class="content-page">
        <el-form label-width="150px">
          <el-form-item label="售后指南">
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
          <el-form-item label="">
            <el-button type="danger" @click="DisRulesUpdate">确定保存</el-button>
          </el-form-item>
        </el-form>
      </div>

    </div>
</template>

<script>
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
  data () {
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
        id: ''
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
  mounted() {
    this.findInfo()
    this.gettoken()
  },
  methods: {
    DisRulesUpdate() {
      console.log(this.formLabelAlign);
      if (!this.formLabelAlign.rules_value || this.formLabelAlign.rules_value == '') {
        this.$message.error("请填写售后指南 ！")
        return false
      }
      this.$confirm('此操作将修改此信息，立即生效！, 是否继续?', '提示', {
         confirmButtonText: '确定',
         cancelButtonText: '取消',
         type: 'warning'
       }).then(() => {
         this.axios.post('guide/setafterguide',{
           info: this.formLabelAlign
         }).then(res => {
           console.log(res);
           if (res.data.errno == 0) {
             this.findInfo()
             this.$message({
               type: 'success',
               message: '更新成功 ！'
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
    findInfo() {
      this.axios.post('guide/findafterguideinfo').then(res => {
        console.log(res);
        this.formLabelAlign.rules_value = res.data.data.rules_text
        this.formLabelAlign.id = res.data.data.id ? res.data.data.id : ''
      })
    },
    /////////////////////富文本操作事件
    ///////////////////////////////////////////以下为富文本上传事件
    onEditorChange(e) {
      this.formLabelAlign.rules_value = e.html
      console.log(this.formLabelAlign.rules_value);
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

  },
}
</script>

<style lang="css">

</style>
