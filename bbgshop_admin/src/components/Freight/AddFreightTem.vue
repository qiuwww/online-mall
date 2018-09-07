<template lang="html">
  <div class="content-page">
      <div class="content-nav" >
          <el-breadcrumb class="breadcrumb" separator="/">
              <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>店铺运营</el-breadcrumb-item>
              <el-breadcrumb-item :to="{ path: '/dashboard/FreightTemPage' }">运费模板</el-breadcrumb-item>
              <el-breadcrumb-item>新建运费模板</el-breadcrumb-item>
          </el-breadcrumb>
          <div class="operation-nav">
              <el-button type="primary" @click="goBackPage" icon="arrow-left">返回列表</el-button>
          </div>
      </div>
      <div class="content-main">
        <el-form label-width="180px">
          <el-form-item label="模板名称" >
            <el-input style="width:317px;" v-model="Freight.temp_name" placeholder="输入运费模板名称" >
            </el-input>
          </el-form-item>
          <el-form-item label="计费方式" >
            <el-radio-group v-model="Freight.Billing_Method" @change="BillingMethodChanged">
              <el-radio :label="0">按件数</el-radio>
              <el-radio :label="1" disabled>按重量</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="配送区域" >
            <el-table :data="tableData" border style="width: 100%" >
              <el-table-column label="可配送区域" width="360%">
                <template slot-scope="scope">
                  <el-tooltip placement="left">
                    <div slot="content">
                      <el-button type="primary" size="small" @click="editAdressTemplate_count(scope.$index)">编辑</el-button>
                      <el-button type="danger" size="small" @click="delAdressTemplate(scope.$index)">删除</el-button>
                    </div>
                    <div class="">
                      {{tableData[scope.$index].temp_point_city_name}}
                    </div>
                  </el-tooltip>
                </template>
              </el-table-column>
              <el-table-column :label="tableTitleFirst" align="center">
                <template slot-scope="scope">
                  <el-input v-model="tableData[scope.$index].temp_first_weight" ></el-input>
                </template>
              </el-table-column>
              <el-table-column label="运费（元）" align="center">
                <template slot-scope="scope">
                  <el-input v-model="tableData[scope.$index].temp_first_freight" ></el-input>
                </template>
              </el-table-column>
              <el-table-column :label="tableTitlecontinue" align="center">
                <template slot-scope="scope">
                  <el-input v-model="tableData[scope.$index].temp_continue_weight" ></el-input>
                </template>
              </el-table-column>
              <el-table-column label="运费（元）" align="center">
                <template slot-scope="scope">
                  <el-input v-model="tableData[scope.$index].temp_continue_freight" ></el-input>
                </template>
              </el-table-column>
            </el-table>
            <div class="add_temp_count" @click='add_temp_count'>
              指定配送区域和运费
            </div>
          </el-form-item>
          <el-form-item >
            <el-button type="danger" @click="addAdressTemplate">保存运费模板</el-button>
          </el-form-item>
        </el-form>
      </div>
<!-- ////////////////////////////////////////////////////////指定地址弹出层 -->
      <van-popup class="AddressPopover" v-model="show_address_popup">
        <div style="text-align: center">
            <el-transfer
              style="text-align: left; display: inline-block"
              v-model="addressData_show"
              :titles="['可选省、市、区', '已选省、市、区']"
              :button-texts="['移除', '加入']"
              :props="{
                key: 'id',
                label: 'name'
              }"
              @change="handleChange"
              :data="addressData">
            </el-transfer>
          </div>
          <div class="address_btn_area">
            <el-button type="info" plain @click='abc'>取消</el-button>
            <el-button type="info" plain @click='canelAddAddress'>取消</el-button>
            <el-button type="danger" @click="sureAddAddress">确定</el-button>
          </div>
      </van-popup>
  </div>
</template>

<script>
export default {
  data() {
    return {
      id: 0,
      is_edit: false,
      // BillingMethod: 0,
      trueaddressData: [],//备份
      addressData_show: [], //已被选中的省的id
      addressData: [],
      dataindex: '-1',//当前操作的数据条的下标
      have_point_address_ids_list: [], //选中的地址的id,列表
      have_point_address_ids_str: [], //选中的地址的id,字符串
      have_point_address_name_str: '', //选中地址的名字的字符串
      Original_point_address_list: [],//原始信息  获取到的规则列表
      Original_point_address_ids_list: [],//原始信息 已命中的所有省的id
      // RecAddressData: [],
      tableData: [],
      row: [],
      tableTitleFirst: '',
      tableTitlecontinue: '',
      show_address_popup: false,
      Freight: {
        temp_name: '',
        Billing_Method: 0
      }
    }
  },
  mounted() {
    this.id = this.$route.query.id || 0;
    this.getAddressList()
    // this.tableTitle = this.pieceTitle
    this.BillingMethodChanged(0)
    if (this.id !== 0) {
      this.is_edit = true
      this.getInfo()
    }
    // this.gettoken()
  },
  methods: {
    abc() {
      console.log(this.addressData_show);

    },
    ////////////////////////////////删除运费条数
    delAdressTemplate(index){
      let have_point_address_JSON = JSON.parse(this.tableData[index].temp_point_city_JSONstr)
      this.addressData = this.addressData.concat(have_point_address_JSON)
      this.tableData.splice(index, 1)
    },
    ////////////////////////////////编辑运费条数
    editAdressTemplate_count(index) {
      this.dataindex = index
      // console.log(this.addressData_show);
      // this.addressData_show = []
      // this.addressData = []
      // console.log(this.addressData_show);
      console.log(this.tableData[index].temp_point_city_id);
      let have_point_address_JSON = JSON.parse(this.tableData[index].temp_point_city_JSONstr)
      // this.addressData = this.trueaddressData
      this.addressData = this.addressData.concat(have_point_address_JSON)
      // console.log(this.addressData);
      let have_point_address = this.tableData[index].temp_point_city_id.split(',')
      let have_point_address_rep = have_point_address.map(num=>Number(num))
      console.log(have_point_address_rep);
      // this.addressData_show = []
      this.addressData_show = have_point_address_rep
      this.show_address_popup = true
      // this.addressData_show = []
      console.log(this.addressData_show);
    },
    /////////////////////////////保存运费模板
    addAdressTemplate() {
      console.log(this.tableData);
      if (this.tableData.length <= 0) {
        this.$message.error('您没有添加运费模板 !')
        return false
      }
      if (this.Freight.temp_name == '') {
        this.$message.error('您没有输入运费模板名称 !')
        return false
      }
      for (var i = 0; i < this.tableData.length; i++) {
        if (this.tableData[i].temp_point_city_JSONstr == '' || Number(this.tableData[i].temp_continue_freight) < 0
        || Number(this.tableData[i].temp_continue_weight) < 0 || Number(this.tableData[i].temp_first_freight) < 0
        || Number(this.tableData[i].temp_first_weight) < 0 || this.tableData[i].temp_point_city_name == ''
        || this.tableData[i].temp_point_city_id == '') {
         this.$message.error('第'+ Number(i + 1) + '条信息不完整 !')
         return false
        }
      }
      this.axios.post('freight/updatefreghttemple',{
        id: this.id,
        info: this.Freight,
        temp: this.tableData
      }).then((res) => {
        console.log(res);
        if (res.status === 200) {
          this.$notify({
            title: '成功 ！',
            message: res.data.errmsg,
            type: 'success'
          });
          this.goBackPage()
        }
      })


    },
    // 、、、、、、、、、、、、、、、、、、、、、、、、、、、、、
    sureAddAddress() {
      this.show_address_popup = false
      this.addressData_show = []
      let temp_point_city_JSONstr = ''
      let befordelrow = []
      for (var i = 0; i < this.have_point_address_ids_list.length; i++) {
        for (var j = 0; j < this.addressData.length; j++) {
          if (this.have_point_address_ids_list[i] == this.addressData[j].id) {
            befordelrow.push(this.addressData[j])
            this.addressData.splice(j, 1)
          }
        }
      }
      temp_point_city_JSONstr = JSON.stringify(befordelrow)
      let obj = {}
      obj.temp_point_city_name = this.have_point_address_name_str
      // obj.point_address_ids_list = this.have_point_address_ids_list
      obj.temp_point_city_id = this.have_point_address_ids_str
      obj.temp_point_city_JSONstr = temp_point_city_JSONstr
      obj.temp_first_weight = 1
      obj.temp_first_freight = 0.00
      obj.temp_continue_weight = 1
      obj.temp_continue_freight = 0.00
      this.tableData.push(obj)
      if (this.dataindex !== '-1'){
        this.tableData.splice(this.dataindex, 1)
        //用户删除所有省市区，可配送地址为空 应当把那一行也删掉
        if (this.tableData[this.dataindex].temp_point_city_name == '') {
          this.tableData.splice(this.dataindex, 1)
        }
      }
      //编辑完成后回到之前状态
      this.dataindex = '-1'
    },
    canelAddAddress() {
      console.log(this.addressData_show);
      this.addressData_show = []
      this.show_address_popup = false
    },
    handleChange(value, direction, movedKeys) {
      this.have_point_address_ids_list = value
      this.have_point_address_ids_str = value.join(',')
      this.have_point_address_name_str = ''
      for (var i = 0; i < value.length; i++) {
        for (var j = 0; j < this.addressData.length; j++) {
          if (value[i] == this.addressData[j].id) {
            this.have_point_address_name_str = this.have_point_address_name_str + ',' + this.addressData[j].name
          }
        }
      }
    },
    ///////////计费规则改变事件
    add_temp_count() {
      this.show_address_popup = true
    },
    BillingMethodChanged(e){
      // if (e == 1) {
      //   this.tableTitleFirst = '首重（Kg）'
      //   this.tableTitlecontinue = '续重（Kg）'
      // }else {
      //   this.tableTitleFirst = '首件（个）'
      //   this.tableTitlecontinue = '续件（个）'
      // }
      this.tableTitleFirst = e == 1 ? '首重（Kg）' : '首件（件）'
      this.tableTitlecontinue = e == 1 ? '续重（Kg）' : '续件（件）'
    },
    //////////////////////////////////编辑是按id获取信息
    getInfo() {
      this.axios.post('freight/findfreightinfoById', {
        id: this.id
      }).then(res => {
        console.log(res);
        if (res.data.errno === 0) {
          this.Freight.temp_name = res.data.data.main_info.temp_name
          this.Freight.Billing_Method = res.data.data.main_info.temp_method
          this.Original_point_address_list = res.data.data.point_address_list
          this.reloadOriginalpointaddresslist() //重组原始数据
        }
      })
    },
    reloadOriginalpointaddresslist() {
      console.log(this.Original_point_address_list);
      this.tableData = this.Original_point_address_list

      for (var i = 0; i < this.Original_point_address_list.length; i++) {
        // console.log(this.Original_point_address_list[i].temp_point_city_id);
        let ids_list = this.Original_point_address_list[i].temp_point_city_id.split(',')
        // console.log(ids_list);
        //连接所有以命中的省id
        this.Original_point_address_ids_list = this.Original_point_address_ids_list.concat(ids_list)
      }
      this.Original_point_address_ids_list = this.Original_point_address_ids_list.map(num=>Number(num))
      console.log(this.Original_point_address_ids_list);
      for (var j = 0; j < this.Original_point_address_ids_list.length; j++) {
        for (var k = 0; k < this.addressData.length; k++) {
          if (this.Original_point_address_ids_list[j] == this.addressData[k].id) {
            this.addressData.splice(k, 1)
          }
        }
      }
    },
    getAddressList() {
      this.axios.post('freight/selectprovince',{
      }).then(res =>{
        console.log(res.data.data);
        this.addressData = res.data.data
        this.trueaddressData = res.data.data
      })
    },
    goBackPage() {
      this.$router.go(-1);
    },
  }
}
</script>

<style lang="css">
.address_btn_area {
  /* border: 1px solid black; */
  height: 52px;
  margin-top: 15px;
  display: flex;
  justify-content: flex-end;
  align-items: center;
}
.AddressPopover {
  padding: 20px 20px 10px 20px;
}
.add_temp_count {
  color: #20a0ff;
  font-size: 12px;
  text-decoration: underline;
  float: left;
}
</style>
