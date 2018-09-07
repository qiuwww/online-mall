<template>
    <div class="content-page">
        <div class="content-nav">
            <el-breadcrumb class="breadcrumb" separator="/">
                <el-breadcrumb-item :to="{ name: 'dashboard' }">首页</el-breadcrumb-item>
                <el-breadcrumb-item>商品管理</el-breadcrumb-item>
                <el-breadcrumb-item>{{infoForm.id ? '编辑分类' : '添加分类'}}</el-breadcrumb-item>
            </el-breadcrumb>
            <div class="operation-nav">
                <el-button type="primary" @click="goBackPage" icon="arrow-left">返回列表</el-button>
            </div>
        </div>
        <div class="content-main">
            <div class="form-table-box">
                <el-form ref="infoForm" :model="infoForm" label-width="180px">
                    <el-form-item label="上级分类">
                        <el-select :disabled="!infoForm.FirstClassifyId && is_edit" v-model="infoForm.FirstClassifyId" placeholder="请选择上级分类">
                            <el-option v-for="item in firstClassify" :key="item.id" :label="item.name" :value="item.id"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="分类名称">
                        <el-input v-model="infoForm.name" placeholder="请输入分类名称"></el-input>
                    </el-form-item>
                    <el-form-item label="简短介绍">
                        <el-input type="textarea" :rows="2" v-model="infoForm.front_name" placeholder="请输入简短介绍"></el-input>
                    </el-form-item>
                    <el-form-item label="显示首页Bar" v-if="infoForm.FirstClassifyId == 0">
                      <el-switch v-model="infoForm.show_index" ></el-switch>
                    </el-form-item>
                    <el-form-item label="首页Bar图标" v-if="infoForm.show_index">
                      <el-upload
                        class="index_bar_uploader"
                        action="http://upload.qiniup.com"
                        :show-file-list="false"
                        :data="uploadToken"
                        :on-success="handleIndexBarSuccess">
                        <img v-if="infoForm.index_bar_imageUrl" :src="infoForm.index_bar_imageUrl" class="index_bar">
                        <i v-else class="el-icon-plus index_bar_uploader_icon"></i>
                      </el-upload>
                    </el-form-item>
                    <!-- <el-form-item label="图标跳转分类" v-if="infoForm.show_index">
                      <el-select v-model="infoForm.Bar_jump_link_id" placeholder="请选择跳转分类">
                          <el-option v-for="item in firstClassify" :key="item.id" :label="item.name" :value="item.id"></el-option>
                      </el-select>
                    </el-form-item> -->
                    <el-form-item label="图标排序" v-if="infoForm.show_index">
                      <el-input style="width:117px;" type="number" :min="0" v-model="infoForm.bar_sort_order" placeholder="设置权重"></el-input>
                    </el-form-item>
                    <el-form-item label="分类图片(首页)" v-if="!infoForm.FirstClassifyId">
                      <el-upload
                        class="index_catrgory_normal_uploader"
                        action="http://upload.qiniup.com"
                        :show-file-list="false"
                        :data="uploadToken"
                        :on-success="handleIndexCateGoryImgSuccess">
                        <img v-if="infoForm.index_catrgory_normal_imageUrl" :src="infoForm.index_catrgory_normal_imageUrl" class="index_catrgory_normal">
                        <i v-else class="el-icon-plus index_catrgory_normal_uploader_icon"></i>
                      </el-upload>
                    </el-form-item>
                    <el-form-item label="分类图片(分类页)">
                      <el-upload
                        class="catrgory_normal_uploader"
                        action="http://upload.qiniup.com"
                        :show-file-list="false"
                        :data="uploadToken"
                        :on-success="handleCateGoryImgSuccess">
                        <img v-if="infoForm.catrgory_normal_imageUrl" :src="infoForm.catrgory_normal_imageUrl" class="catrgory_normal">
                        <i v-else class="el-icon-plus catrgory_normal_uploader_icon"></i>
                      </el-upload>
                    </el-form-item>

                    <el-form-item label="排序">
                        <el-input style="width:117px;" type="number" :min="0" v-model="infoForm.sort_order" placeholder="设置权重"></el-input>
                    </el-form-item>
                    <el-form-item label="启用">
                        <el-switch v-model="infoForm.is_show"></el-switch>
                    </el-form-item>
                    <el-form-item label="">
                        <el-button type="danger" @click="updateBtn">确定保存</el-button>
                        <el-button type="primary" @click="goBackPage">取消</el-button>
                    </el-form-item>
                </el-form>
            </div>
        </div>

    </div>
</template>

<script>
import api from '@/config/api';
  export default {
    data() {
      return {
        uploaddress: api.UploadAddress,
        level: 'L1',
        is_edit: true,
        uploadToken:{
          token: "",
        },
        firstClassify: [
          { id: 0,
            name: '顶级分类' }
        ],
        infoForm: {
          id: 0,
          FirstClassifyId: 0,
          name: '',
          front_name: '',
          sort_order: 0,
          is_show: false,
          show_index: false,
          index_bar_imageUrl: '',//首页bar小图标
          bar_sort_order: 0,//小图标排序
          // Bar_jump_link_id: '',//小图标跳转分类id
          catrgory_normal_imageUrl: '',//显示在分类页右上角的图片
          index_catrgory_normal_imageUrl: '',//显示在首页 每个大分类之前的图片
        }
      }
    },
    created(){
    },
    methods: {
      ////////////////////////////////最终更新
      updateBtn() {
        if (this.infoForm.name == '' || this.infoForm.front_name == '' || this.infoForm.catrgory_normal_imageUrl == '') {
          this.$message.error("分类信息不完整 ！")
          return false
        }
        if (this.infoForm.show_index && (this.infoForm.index_bar_imageUrl == '')) {
          this.$message.error("bar图标信息不完整 ！")
          return false
        }
        if ((!this.infoForm.FirstClassifyId) && (this.infoForm.index_catrgory_normal_imageUrl == '')) {
          this.$message.error("首页分类图片不完整 ！")
          return false
        }
        this.axios.post('categoryUpdate/categorystore',{
          info: this.infoForm
        }).then(res => {
          // console.log(res);
          if (res.status == 200) {
            this.$message({
              message: '添加成功 !',
              type: 'success'
            });
            this.goBackPage()
          }
        })
      },
      /////////////////////////首页bar小图片上传=事件
      handleIndexBarSuccess(res,file) {
        console.log(res,file);
        this.infoForm.index_bar_imageUrl = 'http://resource.bbgshop.com/'+ res.key
      },
      handleCateGoryImgSuccess(res,file) {
        console.log(res,file);
        this.infoForm.catrgory_normal_imageUrl = 'http://resource.bbgshop.com/'+ res.key
      },
      handleIndexCateGoryImgSuccess(res,file) {
        console.log(res,file);
        this.infoForm.index_catrgory_normal_imageUrl = 'http://resource.bbgshop.com/'+ res.key
      },
      // abc() {
      //   console.log(this.infoForm);
      // },
      gettoken(){
        this.axios.post('upload/token').then((res) => {
          // console.log(res);
          this.uploadToken.token = res.data.data.uploadToken
        })
      },
      getInfo() {
        this.axios.post('categoryUpdate/findclassifybyid',{
          id: this.infoForm.FirstClassifyId
        }).then(res => {
          console.log(res);
          this.level = res.data.data.level
          this.infoForm.front_name = res.data.data.front_name
          this.infoForm.name = res.data.data.name
          this.infoForm.sort_order = res.data.data.sort_order
          this.infoForm.is_show = res.data.data.is_show == 0 ? false : true
          this.infoForm.id = this.infoForm.FirstClassifyId
          this.infoForm.FirstClassifyId = res.data.data.parent_id == 0 ? 0 : res.data.data.parent_id
          this.infoForm.show_index = res.data.data.show_index == 0 ? false : true
          // this.infoForm.index_bar_imageUrl = res.data.data.icon_url
          this.infoForm.catrgory_normal_imageUrl = res.data.data.wap_banner_url
          this.infoForm.index_catrgory_normal_imageUrl = res.data.data.banner_url
        })
      },
      ////////////////////////查找一级分类
      findGoodsClassifyFirst() {
        this.axios.post('categoryUpdate/findGoodsClassifyFirst').then(res => {
          // console.log(res);s
          this.firstClassify = this.firstClassify.concat(res.data.data)
          this.infoForm.FirstClassifyId = parseInt(this.$route.query.id || 0);
          this.is_edit = this.$route.query.id ? true : false
          if (this.infoForm.FirstClassifyId !== 0) {
            this.getInfo();
            this.getcannel()
          }
        })
      },
      ///////////////////////查找小图标
      getcannel() {
        // console.log(this.infoForm.id);
        // console.log(this.infoForm.FirstClassifyId);
        this.axios.post('categoryUpdate/findindexbaricon',{
          id: this.infoForm.FirstClassifyId
        }).then(res => {
          // console.log(res);
          this.infoForm.index_bar_imageUrl = res.data.data.icon_url
          this.infoForm.Bar_jump_link_id = res.data.data.category_id
          this.infoForm.bar_sort_order = res.data.data.sort_order
        })
      },
      /////////////////////返回上一家
      goBackPage() {
        this.$router.go(-1);
      },
    },
    components: {},
    mounted() {
      this.findGoodsClassifyFirst();
      this.gettoken();

    }
  }

</script>

<style >
.index_catrgory_normal_uploader {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  width: 300px;
  height: 125px;
  text-align: center;
  line-height: 125px;
  color: #d9d9d9;
  font-size: 18px;
}
.index_catrgory_normal {
  width: 300px;
  height: 125px;
}
.catrgory_normal_uploader {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  width: 200px;
  height: 125px;
  text-align: center;
  line-height: 125px;
  color: #d9d9d9;
  font-size: 18px;
}
.catrgory_normal {
  width: 200px;
  height: 125px;
}
.index_bar_uploader {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  width: 80px;
  height: 80px;
  text-align: center;
  line-height: 80px;
  color: #d9d9d9;
  font-size: 18px;
}
.index_bar {
  width: 80px;
  height: 80px;
}
</style>
