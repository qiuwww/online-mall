<template>
    <div class="content-page">
        <div class="content-nav">
            <el-breadcrumb class="breadcrumb" separator="/">
                <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
                <el-breadcrumb-item>订单中心</el-breadcrumb-item>
            </el-breadcrumb>
            <div class="operation-nav">
                <el-button type="warning" size="small" @click="ExportExecle">订单导出</el-button>
                <el-button type="primary" size="small" @click="Refresh">刷新</el-button>
            </div>
            <!-- <div class="operation-nav">
                <router-link to="/dashboard/order/add">
                    <el-button type="primary" icon="plus">添加订单</el-button>
                </router-link>
            </div> -->
        </div>
        <div class="content-main">
          <div class="content_filler">
            <div class="content_filler_left">
              <el-form :inline="true" :model="filterForm" class="demo-form-inline">
                  <el-form-item label="订单号">
                      <el-input v-model="filterForm.order_sn" @change='snchange' placeholder="请输入订单号"></el-input>
                  </el-form-item>
                  <el-form-item label="收货人">
                      <el-input v-model="filterForm.consignee" placeholder="请输入收货人"></el-input>
                  </el-form-item>
                  <!-- <el-form-item label="用户">
                      <el-input v-model="filterForm.user" placeholder="请输入用户名"></el-input>
                  </el-form-item> -->
                  <el-form-item label="下单时间">
                    <div class="block">
                      <el-date-picker
                        v-model="limit_day"
                        type="datetimerange"
                        :picker-options="pickerOptions"
                        placeholder="选择时间范围"
                        align="right"
                        @change='pickerchange'
                        >
                      </el-date-picker>
                    </div>
                  </el-form-item>
                  <el-form-item>
                      <el-button type="primary" @click="onSubmitFilter">查询</el-button>
                  </el-form-item>
              </el-form>
            </div>
            <div class="content_filler_right" >
              <el-select style="width:150px;margin-right:10px" v-model="ordertype" clearable placeholder="请选择订单状态" @change="changeorder_type">
                <el-option
                  v-for="item in typelist"
                  :key="item.id"
                  :label="item.value"
                  :value="item.code">
                </el-option>
              </el-select>
              <el-select style="width:150px;margin-right:10px" v-model="orderstate" clearable placeholder="请选择订单类型" @change="changeorder_state">
                <el-option
                  v-for="item in statelist"
                  :key="item.id"
                  :label="item.value"
                  :value="item.code">
                </el-option>
              </el-select>
              <!-- <el-select style="width:150px;" v-model="filterForm.supplier_id" clearable placeholder="请选择供货商" @change="changeorder_supplier">
                <el-option
                  v-for="item in supplierlist"
                  :key="item.id"
                  :label="item.name"
                  :value="item.id">
                </el-option>
              </el-select> -->
              <el-button type="primary" @click="ClierFilter">清空查询</el-button>
            </div>
          </div>
          <div class="form-table-box">
                <el-table :data="tableData" style="width: 100%" border stripe>
                    <el-table-column prop="order_sn"  width="200" align="center" label="订单号" >
                      <template slot-scope="scope">
                        <el-tooltip class="item" effect="dark" placement="left">
                          <div slot="content">
                          <div class="tooltip_item">
                             <div class="tooltip_item_left">订单号</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].order_sn}}</div>
                          </div>
                          <div class="tooltip_item" v-if="tableData[scope.$index].order_status == '400'">
                             <div class="tooltip_item_left">退款订单号</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].refund.refund_sn}}</div>
                          </div>
                          </div>
                          <div class="one_row_overflow">
                            {{tableData[scope.$index].order_sn}}
                          </div>
                        </el-tooltip>
                      </template>
                    </el-table-column>
                    <el-table-column align="center" label="用户">
                      <template slot-scope="scope">
                        <el-tooltip class="item" effect="dark" placement="left">
                          <div slot="content">
                          <div class="tooltip_item">
                             <div class="tooltip_item_left">用户昵称</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].user.nickname}}</div>
                          </div>
                          <div class="tooltip_item">
                             <div class="tooltip_item_left">手机号</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].user.mobile}}</div>
                          </div>
                          <div class="tooltip_item">
                             <div class="tooltip_item_left">地区</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].user.mobile_country_e}} - {{tableData[scope.$index].user.mobile_country}}   +{{tableData[scope.$index].user.mobile_code}}</div>
                          </div>
                          <div class="tooltip_item">
                             <div class="tooltip_item_left">注册时间</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].register_localtime}}</div>
                          </div>
                          </div>
                          <div class="one_row_overflow">
                            {{tableData[scope.$index].user.nickname}}
                          </div>
                        </el-tooltip>
                      </template>
                    </el-table-column>
                    <el-table-column align="center" label="收货人">
                      <template slot-scope="scope">
                        <el-tooltip class="item" effect="dark" placement="left">
                          <div slot="content">
                          <div class="tooltip_item">
                             <div class="tooltip_item_left">收货人</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].consignee}}</div>
                          </div>
                          <div class="tooltip_item">
                             <div class="tooltip_item_left">收货地址</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].full_region}}</div>
                          </div>
                          <div class="tooltip_item">
                             <div class="tooltip_item_left">手机号</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].mobile}}</div>
                          </div>
                          </div>
                        <div class="one_row_overflow">
                          {{tableData[scope.$index].consignee}}
                        </div>
                      </el-tooltip>
                      </template>
                    </el-table-column>
                    <el-table-column align="center" width="140"  label="订单金额(元)">
                      <template slot-scope="scope">
                        <el-tooltip class="item" effect="dark" placement="left">
                          <div slot="content">
                          <div class="tooltip_item">
                             <div class="tooltip_item_left">付款金额</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].actual_localprice}}</div>
                          </div>
                          <div class="tooltip_item" v-if="tableData[scope.$index].refund.state">
                             <div class="tooltip_item_left">申请退款金额</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].refund.refund_price}}</div>
                          </div>
                          <div class="tooltip_item" v-if="tableData[scope.$index].refund_time !== '0'">
                             <div class="tooltip_item_left">已退款金额</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].refund.refund_price}}</div>
                          </div>
                          </div>
                          <div class="one_row_overflow">
                            {{tableData[scope.$index].actual_localprice}}
                          </div>
                        </el-tooltip>
                      </template>
                    </el-table-column>
                    <el-table-column align="center" width="160" label="订单状态">
                      <template slot-scope="scope">
                        <el-tooltip class="item" effect="dark" placement="left">
                          <div slot="content">
                            <div slot="content">
                            <div class="tooltip_item">
                               <div class="tooltip_item_left">下单时间</div>
                               <div class="tooltip_item_right">{{tableData[scope.$index].add_localtime}}</div>
                            </div>
                            <div class="tooltip_item">
                               <div class="tooltip_item_left">付款时间</div>
                               <div class="tooltip_item_right">{{tableData[scope.$index].pay_localtime}}</div>
                            </div>
                            </div>
                          <div class="tooltip_item">
                             <div class="tooltip_item_left">发货时间</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].logistics_localtime}}</div>
                          </div>
                          <div class="tooltip_item">
                             <div class="tooltip_item_left">发起退款时间</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].create_refund_localtime}}</div>
                          </div>
                          <!-- <div class="tooltip_item">
                             <div class="tooltip_item_left">退款处理时间</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].refund_handle_localtime}}</div>
                          </div> -->
                          <div class="tooltip_item">
                             <div class="tooltip_item_left">退款成功时间</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].refund_localtime}}</div>
                          </div>
                          <div class="tooltip_item" v-if="tableData[scope.$index].refund_is_success == 1">
                             <div class="tooltip_item_left">确认时间</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].refund_localtime}}</div>
                          </div>
                          <div class="tooltip_item" v-if="tableData[scope.$index].refund_is_success !== 1">
                             <div class="tooltip_item_left">确认时间</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].confirLogic_localtime}}</div>
                          </div>
                          </div>
                          <div class="one_row_overflow">
                            {{tableData[scope.$index].order_status_text}}

                            <!-- {{tableData[scope.$index].refund.state == 1017 && tableData[scope.$index].refund.abled == 0 ? '退款终止' : tableData[scope.$index].order_status_text}} -->
                            <span class="one_row_overflow_refundsuccess">{{tableData[scope.$index].refund_is_success === 1 ? " 退款成功 " : "  "}}</span>
                            <span class="one_row_overflow_refundno">{{tableData[scope.$index].refund.state == 1017 && tableData[scope.$index].refund.abled == 0 ? '拒绝退款' : ''}}</span>
                            <span class="one_row_overflow_refundbile">{{tableData[scope.$index].create_refund_localtime !== ' - - ' &&
                              tableData[scope.$index].refund.abled == 1 && tableData[scope.$index].refund_is_success === 0 ? '退款撤回' : ''}}</span>
                            <span class="one_row_overflow_refundget">{{ tableData[scope.$index].refund.state == 1001 && tableData[scope.$index].create_refund_localtime !== ' - - ' &&
                              tableData[scope.$index].refund.abled == 0 && tableData[scope.$index].refund_is_success === 0 ? '申请退款' : ''}}</span>
                            <span class="one_row_overflow_refundno">{{ tableData[scope.$index].order_status == 201 && tableData[scope.$index].pay_id == 2 &&
                              tableData[scope.$index].collage_is_success == 0 && tableData[scope.$index].refund_is_success == 0
                              && tableData[scope.$index].collage_isouttime == 0 ? '拼团中' : ''}}</span>
                              <span class="one_row_overflow_refundno">{{ tableData[scope.$index].order_status == 201 && tableData[scope.$index].pay_id == 2 &&
                                tableData[scope.$index].collage_is_success == 0 && tableData[scope.$index].refund_is_success == 0
                                && tableData[scope.$index].collage_isouttime == 1 ? '拼团失败' : ''}}</span>
                              <!-- v-if="scope.row.order_status == 201 && scope.row.pay_id == 2 && scope.row.collage_is_success == 0
                              && scope.row.collage_isouttime == 1 && scope.row.refund_is_success == 0" -->
                              <span class="one_row_overflow_refundno">{{ tableData[scope.$index].order_status == 0 && tableData[scope.$index].pay_id == 2 &&
                                tableData[scope.$index].collage_is_success == 0 && tableData[scope.$index].refund_is_success == 0 ? '发起拼团' : ''}}</span>
                            <span class="one_row_overflow_refundcollage">{{ tableData[scope.$index].order_status == 201 && tableData[scope.$index].pay_id == 2 &&
                              tableData[scope.$index].collage_is_success == 1 && tableData[scope.$index].refund_is_success == 0 ? '拼团成功' : ''}}</span>
                          </div>
                        </el-tooltip>
                      </template>
                    </el-table-column>
                    <el-table-column align="center" width="170" label="订单类型">
                      <template slot-scope="scope">
                        <div class="one_row_overflow">
                          {{tableData[scope.$index].pay_name == ''? "普通订单":tableData[scope.$index].pay_name}}
                          <span v-if="tableData[scope.$index].order_status == 400">
                            <span class="one_row_overflow_refund">
                              {{tableData[scope.$index].refund.type == 0 ? '未发货' : '已发货'}}
                            </span>
                          </span>
                        </div>
                      </template>
                    </el-table-column>
                    <el-table-column align="center" label="留言">
                      <template slot-scope="scope">
                        <el-tooltip class="item" effect="dark" placement="left">
                          <div slot="content">
                          <div class="tooltip_item">
                             <div class="tooltip_item_left">买家留言</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].postscript == '' ? '无' : tableData[scope.$index].postscript}}</div>
                          </div>
                          <div class="tooltip_item" >
                             <div class="tooltip_item_left">卖家留言</div>
                             <div class="tooltip_item_right">{{tableData[scope.$index].admin_message == '' ? '无' : tableData[scope.$index].admin_message}}</div>
                          </div>
                          </div>
                          <div class="one_row_overflow">
                            {{tableData[scope.$index].postscript == '' ? '无' : tableData[scope.$index].postscript}}
                          </div>
                        </el-tooltip>
                      </template>
                    </el-table-column>
                    <el-table-column label="操作" width="280" align="center" >
                        <template slot-scope="scope">
                            <el-button size="small" @click="Message(scope.$index, scope.row)" v-if="scope.row.order_status == 0">留言</el-button>
                            <el-button size="small" @click="ChageAddress(scope.$index, scope.row)" v-if="scope.row.order_status == 0">改地址</el-button>
                            <el-button size="small" @click="ChagePrice(scope.$index, scope.row)" v-if="scope.row.order_status == 0">改价格</el-button>
                            <el-button size="small" v-if="scope.row.pay_id == 0 && scope.row.order_status == 201 "
                            type="info" @click="Sendout(scope.$index, scope.row)">发货</el-button>
                            <!-- <el-button size="small" v-if="scope.row.pay_id == 0 && scope.row.order_status == 201 && scope.row.refund.abled == 1" -->
                            <!-- type="info" @click="Sendout(scope.$index, scope.row)">发货</el-button> -->
                            <!-- <el-button size="small" v-if="scope.row.pay_id == 0 && scope.row.order_status == 201 && scope.row.refund.state == 1017" -->
                            <!-- type="info" @click="Sendout(scope.$index, scope.row)">发货</el-button> -->
                            <el-button size="small" v-if="scope.row.pay_id == 2 && scope.row.collage_is_success == 1 && scope.row.order_status == 201"
                            type="info" @click="Sendout(scope.$index, scope.row)">发货</el-button>
                            <el-button size="small" v-if="scope.row.pay_id == 3 && scope.row.order_status == 201"
                            type="info" @click="Sendout(scope.$index, scope.row)">发货</el-button>
                            <el-button size="small" v-if="scope.row.order_status == 300 || scope.row.order_status == 301"
                            type="success" @click="Sendlogic(scope.$index, scope.row)">物流</el-button>
                            <el-button size="small" v-if="scope.row.order_status == 400 && scope.row.refund.type == 1 && scope.row.refund.abled == 0 && scope.row.refund.state == 1001"
                            type="success" @click="Sendlogic(scope.$index, scope.row)">物流</el-button>
                            <el-button disabled size="small" v-if="scope.row.refund.state == 503"
                            type="info">退款已成功</el-button>
                            <el-button v-if="scope.row.refund.state == 1001 && scope.row.refund.abled == 0"
                            size="small" type="danger" @click="refund(scope.$index, scope.row)">退款</el-button>
                            <el-button size="small" @click="handleRowEdit(scope.$index, scope.row)">查看</el-button>

                            <el-button size="small" @click="refundSure(scope.$index, scope.row)"
                            v-if="scope.row.order_status == 201 && scope.row.pay_id == 2 && scope.row.collage_is_success == 0
                            && scope.row.collage_isouttime == 1 && scope.row.refund_is_success == 0" type="info">退款(拼团超时)</el-button>

                            <el-button size="small" disabled v-if="scope.row.pay_id == 2 && scope.row.collage_is_success == 0
                            && scope.row.collage_isouttime == 1 && scope.row.refund_is_success == 1" type="info">拼团超时</el-button>
                            <!-- <el-button size="small" type="danger" @click="handleRowDelete(scope.$index, scope.row)">删除</el-button> -->
                        </template>
                    </el-table-column>
                </el-table>
            </div>
            <div class="page-box">
                <el-pagination @current-change="handlePageChange" :current-page="page" :page-size="10" layout="total, prev, pager, next, jumper" :total="total">
                </el-pagination>
            </div>
        </div>
        <!-- 修改订单价格弹层 -->
        <van-popup v-model="chage_price_popup">
          <div class="ChagePrice_area">
            <div class="ChagePrice_area_title">
              订单列表 <span style="font-size:11px;font-weight:normal;color:#757575;"> (修改订单价格)</span>
            </div>
            <div class="ChageAddress_area">
                <div class="BuyPeople_Info">
                  <span style="float:left">
                  <span style="font-size:12px;color:#757575;">买家：</span>
                  <span style="font-weight:bold">{{user_info.nickname}}</span>
                </span>
                <span style="float:right">
                  <span style="font-size:12px;color:#757575;font-weight:bold">{{order_info.local_time}}</span>
                  <!-- <span style="font-weight:bold">{{user_info.nickname}}</span> -->
                </span>
              </div>
              <div style="font-size:12px;color:#757575;width:95%;margin:auto;margin-top:15px;">订单编号：{{order_info.order_sn}}</div>
              <div class="change_price_area">
                <div class="change_price_goods" v-for="item in goodslist" :key="item.id">
                  <img class="change_price_goods_img"  :src="item.list_pic_url" alt="">
                  <div class="change_price_goods_name">{{item.goods_name}}</div>
                  <div class="change_price_goods_price"> ￥ <span class="big">{{item.retail_price}}</span></div>
                  <div class="change_price_goods_sku">{{item.goods_specifition_name_value}} x{{item.number}}
                  </div>
                </div>
              </div>
              <div class="change_price">
                <div class="change_price_left">
                  订单总金额
                </div>
                <div class="change_price_right">
                  ￥ <span class="big">{{order_info.actual_price}}</span>
                </div>
              </div>
              <div class="change_input_area">
                <div class="change_input_area_left">
                  修改订单价格
                </div>
                <!-- <div class="change_input_area_right"> -->
                <el-input class="change_input_area_right" v-model="changed_price_input" @change="change_price_input" placeholder="请输入修改价格"></el-input>
                <!-- </div> -->
              </div>
              <div class="change_input_area_btnarea">
                <el-button type="primary" plain @click='closechangeprice'>取消</el-button>
                <el-button type="danger" :disabled='price_reg' @click="sure_change_price">确认修改</el-button>
              </div>
            </div>
          </div>
        </van-popup>
        <!-- // 修改收货地址弹层 -->
        <van-popup v-model="chage_address_popup">
          <div class="ChagePrice_area">
            <div class="ChagePrice_area_title">
              订单列表 <span style="font-size:11px;font-weight:normal;color:#757575;"> (修改收货地址)</span>
            </div>
            <div class="ChageAddress_area">
                <div class="BuyPeople_Info">
                  <span style="float:left">
                  <span style="font-size:12px;color:#757575;">买家：</span>
                  <span style="font-weight:bold">{{user_info.nickname}}</span>
                </span>
                <span style="float:right">
                  <span style="font-size:12px;color:#757575;font-weight:bold">{{order_info.local_time}}</span>
                  <!-- <span style="font-weight:bold">{{user_info.nickname}}</span> -->
                </span>
              </div>
              <div style="font-size:12px;color:#757575;width:95%;margin:auto;margin-top:15px;">订单编号：{{order_info.order_sn}}</div>
              <div style="font-size:12px;color:#757575;width:95%;margin:auto;margin-top:15px;">收货地址：</div>
              <div class="ChageAddress_area_item">
                  <div class="ChageAddress_area_item_getname">
                    <!-- <span style="font-size:12px;color:#757575;">收货人:</span> -->
                    {{order_info.consignee}}
                  </div>
                  <div class="ChageAddress_area_item_getaddress">
                    {{order_info.full_region}} {{order_info.address}}
                  </div>
                  <div class="ChageAddress_area_item_getphone">
                    {{order_info.mobile}}
                  </div>
                  <!-- <div> -->
                    <el-button @click="open_chage_address" class="ChageAddress_area_item_chage_btn"
                    size="mini" type="danger" v-if="!enable_chage_address">修改</el-button>
                    <el-button @click="close_chage_address" class="ChageAddress_area_item_chage_btn"
                    size="mini" type="danger" v-if="enable_chage_address">取消</el-button>
                  <!-- </div> -->
              </div>
              <transition name="el-fade-in-linear">

                <div v-if="enable_chage_address" class="ChageAddress_chage_item">
                    <div style="font-size:16px;color:#333;width:95%;margin:5px auto;margin-bottom:25px;font-weight:bold">
                      修改收货地址
                    </div>
                  <el-form label-width="120px" :model="inputAddress">
                    <el-form-item label="收货人姓名：">
                      <el-input v-model="inputAddress.name"></el-input>
                    </el-form-item>
                    <el-form-item label="收货手机号：">
                      <el-input v-model="inputAddress.phone"></el-input>
                    </el-form-item>
                    <el-form-item label="收货人地址：">
                      <el-select class="ChageAddress_chage_item_select" v-model="firstRegionvalue" placeholder="选择省" @change="firstRegionChage">
                        <el-option
                          v-for="item in firstRegion"
                          :key="item.id"
                          :label="item.name"
                          :value="item.id">
                        </el-option>
                      </el-select>
                      <el-select class="ChageAddress_chage_item_select" v-model="secondRegionvalue" placeholder="选择市" @change="secondRegionChage">
                        <el-option
                          v-for="item in secondRegion"
                          :key="item.id"
                          :label="item.name"
                          :value="item.id">
                        </el-option>
                      </el-select>
                      <el-select class="ChageAddress_chage_item_select" v-model="thirdRegionvalue" placeholder="选择县" @change="thirdRegionChage">
                        <el-option
                          v-for="item in thirdRegion"
                          :key="item.id"
                          :label="item.name"
                          :value="item.id">
                        </el-option>
                      </el-select>
                    </el-form-item>
                    <el-form-item label="详细地址：">
                      <el-input type="textarea" v-model="inputAddress.address" :autosize="{ minRows: 2, maxRows: 4}"></el-input>
                    </el-form-item>
                  </el-form>
                  <div style="margin-bottom:15px;text-align:right">
                    <el-button type="text" @click="canelForm" style="margin-right:15px;">取消</el-button>
                    <el-button type="primary" @click="submitForm">确定</el-button>

                  </div>

                </div>
              </transition>
            </div>
          </div>
        </van-popup>
        <!-- //留言的弹层 -->
        <van-popup v-model="seeorder_popup">
          <div class="see_area">
            <div class="ChagePrice_area_title">
              订单列表 <span style="font-size:11px;font-weight:normal;color:#757575;"> (修改留言)</span>
            </div>
            <div style="font-size:12px;color:#757575;width:95%;margin:auto;margin-top:15px;margin-left:25px;">订单编号：{{order_info.order_sn}}</div>
            <div class="see_area_area">
              <el-form label-width="120px" :model="message">
                <el-form-item label="买家留言：">
                  <el-input type="textarea" autosize v-model="message.buy_mes" :placeholder="message.buy_mes_plase"></el-input>
                </el-form-item>
                <el-form-item label="卖家留言：">
                  <el-input type="textarea" v-model="message.admin_mes" :placeholder="message.admin_mes_plase"></el-input>
                </el-form-item>
              </el-form>
            </div>
            <div style="margin-bottom:15px;margin-right:20px;text-align:right">
              <el-button type="text" @click="canelmessage" style="margin-right:15px;">取消</el-button>
              <el-button type="primary" @click="submitmessage">确定</el-button>

            </div>
          </div>
        </van-popup>
        <!-- //发货的弹层 -->
        <van-popup v-model="sendout_logistics_popup">
          <div class="sendout_area">
            <div class="sendout_title">
                发货订单
            </div>
            <div class="sendout_area_area">
              <div class="sendout_area_item" v-for="item in goodslist">
                <img class="sendout_area_item_img" :src="item.list_pic_url"></img>
                <div class="sendout_area_item_name">
                  {{item.goods_name}}
                </div>
                <div class="sendout_area_item_sku">
                  {{item.goods_specifition_name_value}} x{{item.number}}
                </div>
                <div class="sendout_area_item_price">
                  <span style="font-size:12px;">￥</span>{{item.retail_price}}
                </div>
              </div>
            </div>
            <div class="sendout_area_length">
              共<span style="font-size:18px;color:#ff4444;padding:0 5px;">{{goodslist.length}}</span>件商品
            </div>
            <div class="sendout_area_send_logic">
              <div class="sendout_area_send_logic_value">
                填写物流单号:
              </div>
              <div class="sendout_area_send_logic_area">
                <el-form label-width="100px" :model="locgic_form">
                  <el-form-item label="物流公司">
                    <!-- <el-input v-model="locgic_form.compy"></el-input> -->
                    <el-select style="width:230px;" v-model="locgic_form.compy" clearable placeholder="请选择物流公司">
                      <el-option
                        v-for="item in logic_comy_list"
                        :key="item.id"
                        :label="item.name"
                        :value="item.id">
                      </el-option>
                    </el-select>
                  </el-form-item>
                  <el-form-item label="物流单号">
                    <el-input style="width:230px;" v-model="locgic_form.compycode"></el-input>
                  </el-form-item>
                </el-form>

              </div>
            </div>
          </div>
          <div style="margin-bottom:15px;margin-right:20px;text-align:right">
            <el-button type="text" @click="canelsendout" style="margin-right:15px;">取消</el-button>
            <el-button type="primary" @click="submitsendout">确定</el-button>

          </div>
        </van-popup>
        <!-- //退款弹出层 -->
        <van-popup class="RefundPopover" v-model="seeRefundPopover">
          <div class="RefundTitle">
                  退款订单
          </div>
          <div class="RefundArea">
            <div class="RefundArea_item">
              <div class="RefundArea_item_left">买家：<span style="color:#333;font-size:16px;font-weight:bold;height:">{{userInfo.nickname}}</span></div>
              <div class="RefundArea_item_right">{{refundInfo.creat_localtime}}</div>
            </div>
            <div class="RefundArea_item">
              <div class="RefundArea_item_right">{{refundInfo.refund_sn}}</div>
            </div>
            <div class="RefundArea_item">
              <div class="RefundArea_item_right">{{mainInfo.consignee}}</div>
            </div>
            <div class="RefundArea_item">
              <div class="RefundArea_item_right">{{mainInfo.full_region}}{{mainInfo.address}}</div>
            </div>
            <div class="RefundArea_item">
              <div class="RefundArea_item_right">{{refundInfo.reson_value}}</div>
            </div>
            <div class="RefundArea_item">
              <div class="RefundArea_item_right">{{refundInfo.way_value}}</div>
                </div>
              <div class="RefundArea_reson_item">
                <div class="RefundArea_reson_item_left">退款理由：</div>
                <div class="RefundArea_reson_item_right">{{refundInfo.reson}}</div>
              </div>
                 <!-- {{refund_img}} -->
              <div class="RefundArea_reson_item">
                <div class="RefundArea_reson_item_left">图片凭证：</div>
                <div class="RefundArea_reson_item_imgright">
                  <div class="RefundArea_reson_item_imgrightext" v-if="refundInfo.refund_img == '' || refundInfo.type == 0">
                    未上传图片
                  </div>
                    <!-- <div class="RefundArea_reson_item_imgrightext" v-if="refundtype == 2">
                      未发货前退款，没有图片
                    </div> -->
                  <img class="RefundArea_reson_item_img" @click="imgclick(img)" v-if="refundInfo.refund_img !== ''" v-for="img in refund_img"
                  :src="img"></img>
                </div>
              </div>
              <div class="hr">

              </div>
             <div class="RefundArea_item">
              <div class="RefundArea_item_right">总金额 ￥
                <span style="font-size:20px;font-weight:bold;color:#F56C6C">{{mainInfo.actual_price}}</span>
                </div>
              </div>
              <div class="RefundArea_item">
                <div class="RefundArea_item_right">退款金额 ￥
                  <span style="font-size:20px;font-weight:bold;color:#F56C6C">{{refundInfo.refund_price}}</span>
                </div>
              </div>
            </div>
            <div class="Refund_btn">
              <el-button size="small" type="info" :plain="true" @click="closerefund">取消</el-button>
              <el-button size="small" type="info"  @click="canelrefund">拒绝</el-button>
              <el-button size="small" type="danger" @click="refundSurebtn">确认退款</el-button>
            </div>
        </van-popup>
        <el-dialog :visible.sync="dialogVisible">
          <img width="100%" :src="dialogImageUrl" alt="">
        </el-dialog>
        <!-- //物流的弹层 -->
        <van-popup v-model="seelogic_popup">
          <div class="see_area">
            <div class="ChagePrice_area_title">
              订单列表 <span style="font-size:11px;font-weight:normal;color:#757575;"> (物流信息)</span>
            </div>
            <div style="font-size:12px;color:#757575;width:95%;margin:auto;margin-top:15px;margin-left:25px;">订单编号：{{order_info.order_sn}}</div>
            <div style="font-size:12px;color:#757575;width:95%;margin:auto;margin-top:15px;margin-left:25px;">运单编号：{{logic_info.logistic_code}}</div>
            <div style="font-size:12px;color:#757575;width:95%;margin:auto;margin-top:15px;margin-left:25px;">物流公司：{{logic_info.shipper_name}}</div>
            <div class="logic_area_one">
              <div style="font-size:12px;color:#757575;margin-bottom:7px;">最新物流信息：</div>
              <div class="logic_area_one_content">
                {{logic_info.traces && logic_info.traces.length > 0 ? logic_info.traces[0].content : '暂无物流消息'}}
                <!-- {{logic_info.traces[0].datetime}} -->
              </div>
              <div class="logic_area_one_datetime">
                <span style="font-size:11px;">更新于</span> {{logic_info.traces && logic_info.traces.length > 0 ? logic_info.traces[0].datetime : ' --:--:--'}}
              </div>
              <div class="logic_area_one_finish">
                {{logic_info.is_finish === 0 ? " 物流未完成 " : " 物流已完成 "}}

              </div>
              <!-- <el-form label-width="120px" :model="message">
                <el-form-item label="买家留言：">
                  <el-input type="textarea" autosize v-model="message.buy_mes" :placeholder="message.buy_mes_plase"></el-input>
                </el-form-item>
                <el-form-item label="卖家留言：">
                  <el-input type="textarea" v-model="message.admin_mes" :placeholder="message.admin_mes_plase"></el-input>
                </el-form-item>
              </el-form> -->
            </div>
            <!-- <div style="margin-bottom:15px;margin-right:20px;text-align:right"> -->
              <!-- <el-button type="text" @click="canelmessage" style="margin-right:15px;">取消</el-button> -->
              <!-- <el-button type="primary" @click="submitmessage">确定</el-button> -->

            <!-- </div> -->
          </div>
        </van-popup>
        <!-- //导出表格的弹层 -->
        <van-popup v-model="export_execle_popup">
          <div class="export_area">
            <div class="ChagePrice_area_title">
              订单列表 <span style="font-size:11px;font-weight:normal;color:#757575;"> (导出Execle表格)</span>
            </div>
          </div>
          <div class="ChagePrice_area_filler">
            <el-form label-width="100px" :model="export_from">
              <el-form-item label="" style="margin:10px 15px 10px 0px;float:right">
                <el-select style="width:150px;" @change="export_supplier_change" v-model="export_from.supplier_id" clearable placeholder="请选择供货商">
                  <el-option
                    v-for="item in supplierlist"
                    :key="item.id"
                    :label="item.name"
                    :value="item.id">
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="" style="margin:10px 0px 10px 0px;float:left">
                <div class="block">
                  <el-date-picker
                    v-model="Export_limit_day"
                    type="datetimerange"
                    placeholder="选择创建订单的时间范围"
                    align="right"
                    @change='Export_pickerchange'
                    >
                  </el-date-picker>
                </div>
              </el-form-item>
              <!-- <el-form-item label="物流单号">
                <el-input style="width:230px;" v-model="locgic_form.compycode"></el-input>
              </el-form-item> -->
            </el-form>
          </div>
          <div class="export_select_supplier_area">
            <el-table :data="export_order_goods" border style="width: 100%">
              <el-table-column align="center" label="创建时间" width="170">
                <template slot-scope="scope">
                    <div class="one_row_overflow">
                      {{export_order_goods[scope.$index].add_time}}
                    </div>
                </template>
              </el-table-column>
              <el-table-column align="center" width="190" label="订单编号" >
                <template slot-scope="scope">
                    <div class="one_row_overflow">
                      {{export_order_goods[scope.$index].order_sn}}
                    </div>
                </template>
              </el-table-column>
              <el-table-column align="center" label="商品名称" >
                <template slot-scope="scope">
                    <div class="one_row_overflow" style="-webkit-line-clamp: 2;">
                      {{export_order_goods[scope.$index].goods_name}}
                    </div>
                </template>
              </el-table-column>
              <el-table-column align="center" width="120" prop="supplier_name" label="供货商" >
              </el-table-column>
              <el-table-column label="数量" width="70" align="center">
                <template slot-scope="scope">
                    <div class="one_row_overflow">
                      {{export_order_goods[scope.$index].goods_num}}
                    </div>
                </template>
              </el-table-column>
              <el-table-column label="订单状态" width="120" align="center">
                <template slot-scope="scope">
                  <el-tooltip class="item" effect="dark" placement="left">
                    <div slot="content">
                    <div class="tooltip_item">
                       <div class="tooltip_item_left">物流公司</div>
                       <div class="tooltip_item_right">{{export_order_goods[scope.$index].express_shipper_name}}</div>
                    </div>
                    <div class="tooltip_item">
                       <div class="tooltip_item_left">运单编号</div>
                       <div class="tooltip_item_right">{{export_order_goods[scope.$index].express_logistic_code}}</div>
                    </div>
                    </div>
                  <div class="one_row_overflow">
                    {{export_order_goods[scope.$index].order_status}}
                  </div>
                </el-tooltip>
                </template>
              </el-table-column>
              <el-table-column align="center" label="属性" width="70" >
                <template slot-scope="scope">
                  <el-tooltip class="item" effect="dark" placement="left">
                    <div slot="content">
                    <div class="tooltip_item">
                       <div class="tooltip_item_left">商品属性</div>
                       <div class="tooltip_item_right">{{export_order_goods[scope.$index].is_Identity}}</div>
                    </div>
                    <div class="tooltip_item">
                       <div class="tooltip_item_left">身份信息</div>
                       <div class="tooltip_item_right">{{export_order_goods[scope.$index].Identity_Input}}</div>
                    </div>
                    </div>
                  <div class="one_row_overflow">
                    {{export_order_goods[scope.$index].is_Identity}}
                  </div>
                </el-tooltip>
                </template>
              </el-table-column>
              <el-table-column align="center" label="备注" width="70" >
                <template slot-scope="scope">
                  <el-tooltip class="item" effect="dark" placement="left">
                    <div slot="content">
                    <div class="tooltip_item">
                       <div class="tooltip_item_left">买家备注</div>
                       <div class="tooltip_item_right">{{export_order_goods[scope.$index].user_message}}</div>
                    </div>
                    <div class="tooltip_item">
                       <div class="tooltip_item_left">买家备注</div>
                       <div class="tooltip_item_right">{{export_order_goods[scope.$index].admin_message}}</div>
                    </div>
                    </div>
                  <div class="one_row_overflow">
                    {{export_order_goods[scope.$index].user_message}}
                  </div>
                </el-tooltip>
                </template>
              </el-table-column>
              <el-table-column align="center" label="收货人" width="140" >
                <template slot-scope="scope">
                  <el-tooltip class="item" effect="dark" placement="left">
                    <div slot="content">
                    <div class="tooltip_item">
                       <div class="tooltip_item_left">收货人</div>
                       <div class="tooltip_item_right">{{export_order_goods[scope.$index].consignee}}</div>
                    </div>
                    <div class="tooltip_item">
                       <div class="tooltip_item_left">收货地址</div>
                       <div class="tooltip_item_right">{{export_order_goods[scope.$index].full_region}}</div>
                    </div>
                    <div class="tooltip_item">
                       <div class="tooltip_item_left">地区</div>
                       <div class="tooltip_item_right">{{export_order_goods[scope.$index].user_country}}</div>
                    </div>
                    <div class="tooltip_item">
                       <div class="tooltip_item_left">手机号</div>
                       <div class="tooltip_item_right">{{export_order_goods[scope.$index].mobile}}</div>
                    </div>
                    </div>
                  <div class="one_row_overflow">
                    {{export_order_goods[scope.$index].consignee}}
                  </div>
                </el-tooltip>
                </template>
              </el-table-column>
              <!-- <el-table-column prop="address" label="地址"> -->
              <!-- </el-table-column> -->
            </el-table>
            <div class="page-box">
              <el-pagination @current-change="handlePageChange_goods" :current-page="export_page"
              :page-size="10" layout="total, prev, pager, next, jumper" :total="export_total">
              </el-pagination>
            </div>
            <div class="page-box">
              <el-button style="margin:10px 20px;" type="primary" :disabled="export_abled_button" @click="ExportExecleAction">导出到Excele表格</el-button>
            </div>
          </div>
        </van-popup>

    </div>
</template>

<script>
import { Toast } from 'vant'
import FileSaver from 'file-saver'
import XLSX from 'xlsx'
// import { Loading } from 'vant';
  export default {
    data() {
      return {
        export_from: {
          supplier_id: ''
        },
        // order_supplier: '',//供货商的值
        supplierlist: [],//供货商列表
        export_execle_popup: false,//导出表格的弹层
        price_reg: true,//确认按钮状态
        changed_price_input: '',//修改的价格
        page: 1,
        total: 0,
        // looptime: '00:00',
        // time: 120000,
        // timeloop: '',
        pickerOptions: {
          shortcuts: [{
            text: '最近一周',
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
              picker.$emit('pick', [start, end]);
            }
          }, {
            text: '最近一个月',
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
              picker.$emit('pick', [start, end]);
            }
          }, {
            text: '最近三个月',
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
              picker.$emit('pick', [start, end]);
            }
          }]
        },
        limit_day: [],
        limit_day_unix: [0,0],
        refundtype: 0,
        chage_price_popup: false,
        dialogVisible: false,
        seeRefundPopover: false,
        seelogic_popup: false,
        dialogImageUrl: '',
        mainInfo: {},
        userInfo: {},
        refundInfo: {},
        refund_img: [],
        sendout_logistics_popup: false,
        chage_address_popup: false,
        order_info: {},
        user_info: {},
        logic_info: {},
        seeorder_popup: false,
        message: {
          buy_mes:'',
          admin_mes:'',
          buy_mes_plase: "买家没有留言",
          admin_mes_plase: "卖家没有留言"
        },
        enable_chage_address: false,
        firstRegion:[],
        secondRegion: [],
        thirdRegion: [],
        RegionCode: {
          first:0,
          second:0,
          third:0,
        },
        firstRegionvalue: '',
        secondRegionvalue: '',
        thirdRegionvalue: '',
        inputAddress: {
          name:'',
          phone: '',
          address: '',
        },
        filterForm: {
          consignee: '',
          order_sn: '',
          supplier_id: '',
          // user: '',
        },
        logic_comy: '',
        logic_comy_list: [],
        locgic_form: {
          compy: '',
          compycode: ''
        },
        goodslist: [],
        tableData: [],
        ordertype: '',
        orderstate: '',
        statelist: [
          {
            id:1,
            value:"普通订单",
            code: 0
          },{
            id:2,
            value:"拼团订单",
            code: 2
          },{
            id:3,
            value:"砍价订单",
            code: 1
          },{
            id:4,
            value:"抽奖订单",
            code: 3
          }
        ],
        typelist: [
          {
            id:1,
            value:"待付款",
            code: 0
          },{
            id:2,
            value:"待发货",
            code: 201
          },{
            id:3,
            value:"待收货",
            code: 300
          },{
            id:4,
            value:"已完成",
            code: 301
          },{
            id:5,
            value:"处理中",
            code: 400
          },
        ],
        export_order_goods: [],
        export_page: 1,
        export_total: 0,
        loading_notify: '',
        export_abled_button: false,
        Export_limit_day: [],//订单导出时限制时间的绑定
        Export_limit_day_unix: [0,0],//订单导出时限制时间的绑定
      }
    },
    methods: {
      //导出弹窗 修改限制时间
      Export_pickerchange(){
        console.log(this.Export_limit_day);
        if (this.Export_limit_day.length !== 0) {
          this.Export_limit_day_unix[0] = new Date(this.Export_limit_day[0]).getTime()
          this.Export_limit_day_unix[1] = new Date(this.Export_limit_day[1]).getTime()
        }
        console.log(this.Export_limit_day_unix);
        this.ExportExecle()

      },
      //导出到表格
      ExportExecleAction(){
        this.$confirm('是否确认导出为Excel表格 ?', '提示', {
         confirmButtonText: '确定',
         cancelButtonText: '取消',
         type: 'warning'
       }).then(() => {
         this.axios.post('order/EXPORT_TO_EXLECE',{
           supplier: this.export_from.supplier_id,
           limit_time_start: this.Export_limit_day_unix[0],
           limit_time_end: this.Export_limit_day_unix[1],
         }).then(res => {
           console.log(res);
           let info = res.data.data
           if (res.data.errno == 0) {
             this.export_abled_button = true
             this.loading_notify = this.$notify({
               title: '成功',
               message: '表格数据重组成功 ！ 正在导出 ！',
               type: 'success',
               duration: 0
             });
             setTimeout(() => {
               function formatJson(filterVal, jsonData) {
           　　　　return jsonData.map(v => filterVal.map(j => v[j]))
               }
               require.ensure([], () => { //require的路径因个人项目结构不同可能需要单独调整，请自行修改路径
     　　　　　　const { export_json_to_excel } = require('../../vendor/Export2Excel');
     　　　　　　const tHeader = ['创建时间','订单编号','订单状态','运单编号','物流公司','商品名称','供货商','数量','收货人','收货地址','用户地区','手机号',
     '买家备注','卖家备注','商品类型','身份信息'];
     　　　　　　const filterVal = ['add_time', 'order_sn','order_status', 'express_logistic_code', 'express_shipper_name', 'goods_name', 'supplier_name', 'goods_num',
      'consignee', 'full_region', 'user_country', 'mobile', 'user_message', 'admin_message', 'is_Identity','Identity_Input'];
     　　　　　　const list = info;
     　　　　　　const data = formatJson(filterVal, list);
     　　　　　　export_json_to_excel(tHeader, data, '供货商订单表');
     　　　　})
               this.loading_notify.close()
               this.export_abled_button = false
               this.export_execle_popup = false
             },1000)
           }
         })
       }).catch(() => {
         this.$message({
           type: 'info',
           message: '取消导出 ！'
         });
       });
      },
      //修改筛选条件
      export_supplier_change(e){
        console.log(e);
        this.ExportExecle()
      },
      handlePageChange_goods(val) {
        this.export_page = val;
        //保存到localStorage
        localStorage.setItem('page', this.export_page)
        localStorage.setItem('export_from', JSON.stringify(this.export_from));
        this.ExportExecle()
      },
      //以下为导出execle表格、、、、、、、、、、、、、、、、、、
      ExportExecle() {
        this.export_execle_popup = true
        this.axios.get('order/getallordergoods',{
          params: {
            page: this.export_page,
            supplier: this.export_from.supplier_id,
            limit_time_start: this.Export_limit_day_unix[0],
            limit_time_end: this.Export_limit_day_unix[1],
          }
        }).then(res => {
          console.log(res);
          this.export_order_goods = res.data.data.data
          // for (var i = 0; i < this.export_order_goods.length; i++) {
          //   this.export_order_goods[i].add_localtime = this.timestampToTime(this.export_order_goods.order_info[i].add_time)
          //
  				// }
          this.export_page = res.data.data.currentPage
          this.export_total = res.data.data.count
        })
        console.log(this.tableData);
      },
      //以下为修改价格//////////////////////////////////////\]
      sure_change_price() {
        if (Number(this.changed_price_input) > Number(this.order_info.actual_price)) {
            this.$confirm('输入价格大于订单总价，是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
              const loading = this.$loading({
              lock: true,
              text: 'Loading',
              spinner: 'el-icon-loading',
              background: 'rgba(255, 255, 255, 0.7)'
            });
              this.axios.post('order/changeorderprice',{
                id: this.order_info.id,
                price: this.changed_price_input
              }).then(res => {
                console.log(res);
                if (res.data.errno === 0) {
                  Toast('修改成功 !')
                  this.$notify({
                    title: '成功',
                    message: '修改成功 ！',
                    type: 'success'
                  });
                  this.getList()
                  this.closechangeprice()
                  loading.close()
                }else{
                  Toast('修改失败 !')
                  this.$notify.error({
                     title: '错误',
                     message: '修改失败 ！'
                   });
                  loading.close()
                }
              })
            }).catch(() => {
              this.$message({
                type: 'info',
                message: '取消修改 !'
              });
            });
          }else {
            this.$confirm('您即将修改订单价格，是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            const loading = this.$loading({
            lock: true,
            text: 'Loading',
            spinner: 'el-icon-loading',
            background: 'rgba(255, 255, 255, 0.7)'
          });
            this.axios.post('order/changeorderprice',{
              id: this.order_info.id,
              price: this.changed_price_input
            }).then(res => {
              console.log(res);
              if (res.data.errno === 0) {
                Toast('修改成功 !')
                this.$notify({
                  title: '成功',
                  message: '修改成功 ！',
                  type: 'success'
                });
                this.getList()
                this.closechangeprice()
                loading.close()
              }else{
                Toast('修改失败 !')
                this.$notify.error({
                   title: '错误',
                   message: '修改失败 ！'
                 });
                loading.close()
              }
            })
          }).catch(() => {
            this.$message({
              type: 'info',
              message: '取消修改 !'
            });
          });
        }
      },
      closechangeprice() {
        this.price_reg = true
        this.chage_price_popup = false
        this.changed_price_input = ''
      },
      change_price_input(e) {
        console.log(e);
        let reg = /^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/
        // reg.test('bc');
        if (reg.test(e)) {
          // console.log('匹配');
          this.price_reg = false
        }else {
          // console.log('不匹配');
          this.price_reg = true
        }

      },
      ChagePrice(index,row) {
        console.log(index,row);
        this.axios.post('order/findpendpaygoodslist', {
          orderid: row.id
        }).then((res) => {
          console.log(res);
          this.order_info = res.data.data.goodsPrice
          // let obj = {}
          this.order_info.local_time = this.timestampToTime(res.data.data.goodsPrice.add_time)
          this.goodslist = res.data.data.goodslist
          this.user_info = res.data.data.user
          // console.log(this.user_info);
          // console.log(this.order_info);
        })
        // this.chage_address_popup = true
        this.chage_price_popup = true
      },
      ///以下为查看物流///////////////////////////////////
      Sendlogic(index,row) {
        const loading = this.$loading({
            lock: true,
            text: 'Loading',
            spinner: 'el-icon-loading',
            background: 'rgba(0, 0, 0, 0.7)'
          });
          console.log(row);
          this.axios.post('order/express',{
            orderId: row.id
          }).then(res => {
            console.log(res);
            if (res.data.errno === 0) {
              loading.close();
              this.seelogic_popup = true
              this.order_info = row
              this.logic_info = res.data.data
            }else {
              // Toast("异常 !")
            }
          })
      },
      // 以下为筛选///////////////////////////////////////////////////////////
      ClierFilter() {
        this.filterForm.order_sn = ''
        this.filterForm.consignee = ''
        this.ordertype = ''
        this.orderstate = ''
        this.limit_day_unix[0] = 0
        this.limit_day_unix[1] = 0
        this.getList()

      },
      looprefresh() {
        // this.timeloop = setInterval(() => {
        //   this.time = this.time - 1000
        //   if (this.time == 0) {
        //     this.time = 120000
        //     this.getList();
        //   }else {
        //     this.looptime = this.timestampToDate(this.time)
        //   }
        // }, 1000);
      },
      snchange() {
        // this.onSubmitFilter()
      },
      pickerchange() {
        // console.log("123");
        this.onSubmitFilter()
      },
      changeorder_state(e) {
        this.orderstate = e
        console.log(e);
        this.getList()
      },
      // changeorder_state
      // 以下为退款///////////////////////////////////////////////////////////
      imgclick(url){
        // console.log(url);
        this.dialogImageUrl = url;
        this.dialogVisible = true;
      },
      refund(index,row){
        // this.getList()
        // console.log(this.rowinfo);
        this.seeRefundPopover = true
        this.mainInfo = row
        this.userInfo = row.user
        this.refundInfo = row.refund
        this.refund_img = []
        console.log(row);
        if (row.refund.type == 0) {

        }else {
          let refund_img = row.refund.refund_img
            if (refund_img.indexOf(",") != -1 ) {
              this.refund_img = refund_img.split(",")
            }else {
              this.refund_img.push(refund_img)
          }
        }

      },
      closerefund() {
        this.seeRefundPopover = false
      },
      refundSurebtn(){
        console.log("确认退款");
        this.$confirm('同意请求即按照退款规则将支付款按原路退到买家帐号上！', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            const loading = this.$loading({
            lock: true,
            text: 'Loading',
            spinner: 'el-icon-loading',
            background: 'rgba(255, 255, 255, 0.7)'
          });
            this.axios.post("pay/prerefund",{
              orderId:this.mainInfo.id
            }).then((res) => {
              console.log(res);
              let refund_time = Number(res.data.timeStamp * 1000)
              if (res.status === 200 && res.data.errno === 0) {
                this.axios.post('order/refundSuccess',{
                  orderId:this.mainInfo.id,
                  time: refund_time
                }).then((res) => {
                  console.log(res);
                  this.$message({
                    type: 'success',
                    message: '退款成功!'
                  });
                  this.getList()
                  loading.close()
                  this.seeRefundPopover = false
                })
              }

            })
          }).catch(() => {
          });
      },
      canelrefund(){
        console.log("拒绝退款");
        this.$confirm('此操作将拒绝   '+this.mainInfo.user.nickname+'   的退款操作此操作不可逆（但可以重复提交申请）, 是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.axios.post('order/canelrefund',{
              orderid: this.mainInfo.id,
            }).then((res) => {
              console.log(res);
              if (res.data.errno == 0) {
                this.$message({
                  type: 'success',
                  message: '操作成功!'
                });
                this.getList()
                this.seeRefundPopover = false
              }
            })

          }).catch(() => {
          });

      },
      //以下为发货  ////////////////////////////////////////////////////////////////////////
      submitsendout(){
        console.log(this.order_info);
        console.log(this.goodslist);
        console.log(this.locgic_form);
        if (this.locgic_form.compycode == '' || this.locgic_form.compy == '') {
          this.$message.error("物流信息不完整！")
          return false
        }
        // let rex = '^[0-9]*$/g'
        let code = this.locgic_form.compycode
        let rex = /^[0-9]*$/g
        if (!rex.test(code)) {
          // console.log("213654789");
          this.$message.error("物流单号不正确！")
          return false
        }
        this.$confirm('此操作将永久此订单状态(谨慎操作！), 是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.axios.post('order/setlogiccompy',{
              orderinfo: this.order_info,
              goodslist: this.goodslist,
              locgic: this.locgic_form,
            }).then((res) => {
              console.log(res);
              if (res.data.errno === 0 ) {
                this.canelsendout()
                Toast('已发货！')
                this.$message({
                  type: 'success',
                  message: '成功发货！'
                });
                this.Refresh()
              }else {
                Toast('未知错误！')
              }
            })
          }).catch(() => {
            this.$message({
              type: 'info',
              message: '已取消！'
            });
          });

      },
      canelsendout(){
        this.sendout_logistics_popup = false
        this.locgic_form.compy = ''
        this.locgic_form.compycode = ''
      },
      Sendout(index, row) {
        console.log(index, row);
        this.axios.post('order/findpendpaygoodslist',{
          orderid:row.id
        }).then((res) => {
          console.log(res);
          this.goodslist = res.data.data.goodslist
          this.order_info = res.data.data.goodsPrice
          this.logic_comy_list = res.data.data.logiclist
        })
        this.sendout_logistics_popup = true
      },

      //以下为修改收货地址  ////////////////////////////////////////////////////////////////////////
      submitForm(){
        console.log(this.inputAddress);
        console.log(this.RegionCode);
        if (this.inputAddress.phone.length > 11) {
          this.$message.error("手机号错误！")
          return false
        }
        if (this.RegionCode.first == 0 || this.RegionCode.second == 0 ||this.RegionCode.third == 0 ||
        this.inputAddress.name == '' || this.inputAddress.phone == '' || this.inputAddress.address == '') {
          this.$message.error("信息不完整！")
          return false
        }
        this.$confirm('此操作将永久修改该信息(此操作不可逆，但可以多次修改), 是否继续?', '警告！', {
           confirmButtonText: '确定',
           cancelButtonText: '取消',
           type: 'warning'
         }).then(() => {
           this.axios.post('order/setpendpayaddress',{
             address:this.inputAddress,
             regioncode:this.RegionCode,
             orderid:this.order_info.id
           }).then((res) => {
             console.log(res);
             if (res.data.errno === 0) {
               // this.ChageAddress()
               this.enable_chage_address = false
               this.inputAddress.name = ''
               this.inputAddress.phone = ''
               this.inputAddress.address = ''
               this.chage_address_popup = false
               this.Refresh()
               Toast("修改成功!")
             }
           })
           this.$message({
             type: 'success',
             message: '修改成功!'
           });
         }).catch(() => {
           this.$message({
             type: 'info',
             message: '取消修改!'
           });
         });
      },
      canelForm(){
        this.enable_chage_address = false
        this.inputAddress.name = ''
        this.inputAddress.phone = ''
        this.inputAddress.address = ''
        this.chage_address_popup = false

      },
      firstRegionChage(e){
        console.log(e);
          this.secondRegionvalue = ''
          this.thirdRegionvalue = ''
          this.axios.post('order/findTypeRegion',{
            type: 2,
            id: e
          }).then((res) => {
            console.log(res);
            this.secondRegion = res.data.data.list
          })
          this.RegionCode.first = e
      },
      secondRegionChage(e){
        console.log(e);
          this.thirdRegionvalue = ''
          this.axios.post('order/findTypeRegion',{
            type: 3,
            id: e
          }).then((res) => {
            console.log(res);
            this.thirdRegion = res.data.data.list
          })
          this.RegionCode.second = e
      },
      thirdRegionChage(e){
        this.RegionCode.third = e
      },
      ChageAddress(index, row) {
        this.axios.post('order/findpendpaygoodslist', {
          orderid: row.id
        }).then((res) => {
          console.log(res);
          this.order_info = res.data.data.goodsPrice
          // let obj = {}
          this.order_info.local_time = this.timestampToTime(res.data.data.goodsPrice.add_time)

          this.user_info = res.data.data.user
          console.log(this.user_info);
          console.log(this.order_info);
        })
        this.chage_address_popup = true
      },
      open_chage_address() {
        this.axios.post('order/findTypeRegion',{
          type: 1
        }).then((res) => {
          console.log(res);
          this.firstRegion = res.data.data.list
        })
        this.inputAddress.name = this.order_info.consignee
        this.inputAddress.phone = this.order_info.mobile
        this.inputAddress.address = this.order_info.address
        this.enable_chage_address = true

      },
      close_chage_address() {
        this.inputAddress.name = ''
        this.inputAddress.phone = ''
        this.inputAddress.address = ''
        this.enable_chage_address = false
      },
      //以下为留言  ////////////////////////////////////////////////////////////////////////
      submitmessage(){
        this.$confirm('此操作将永久修改此信息, 是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.axios.post('order/setpendpaymessage',{
              message: this.message,
              orderid: this.order_info.id
            }).then((res) => {
              console.log(res);
              if (res.data.errno === 0) {
                this.canelmessage()
                this.Refresh()
                Toast("修改成功!")
              }else{
                this.$message.error("修改失败!")
              }
            })
          }).catch(() => {
            this.$message({
              type: 'info',
              message: '取消修改!'
            });
          });
      },
      canelmessage(){
        this.seeorder_popup = false

      },
      Message(index,row){
        console.log(index,row);
        this.seeorder_popup = true
        this.order_info = row
        this.message.buy_mes = this.order_info.postscript
        this.message.admin_mes = this.order_info.admin_message

      },

      Refresh() {
        this.getList()
        this.time = 120000
      },
      refundSure(index,row){
        console.log("确认退款");
        this.$confirm('同意请求即按照退款规则将支付款按原路退到买家帐号上！', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            const loading = this.$loading({
            lock: true,
            text: 'Loading',
            spinner: 'el-icon-loading',
            background: 'rgba(255, 255, 255, 0.7)'
          });
            this.axios.post("pay/prerefund",{
              orderId: row.id
            }).then((res) => {
              console.log(res);
              let refund_time = Number(res.data.timeStamp * 1000)
              if (res.status === 200 && res.data.errno === 0) {
                this.axios.post('order/refundSuccess',{
                  orderId: row.id,
                  time: refund_time
                }).then((res) => {
                  console.log(res);
                })
                this.$message({
                  type: 'success',
                  message: '退款成功!'
                });
                this.getList()
                this.onSubmitSelect()
                loading.close()
                // this.seeRefundPopover = false
              }else {
                this.$message.error('退款失败');
                Toast('此处失败可能是因为您的商户中基本账户余额不足，请充值后重新发起 ！')
                this.getList()
                this.onSubmitSelect()
                loading.close()
              }
            })
          }).catch(() => {
          });
      },
      onSubmitSelect (){
        this.filterForm.order_sn = ''
        this.filterForm.consignee = ""
        this.ordertype = ''
        this.getList()
      },
      changeorder_type(e){
        console.log(e);
        this.ordertype = e
        this.getList()
      },
      handlePageChange(val) {
        this.page = val;
        //保存到localStorage
        localStorage.setItem('orderPage', this.page)
        localStorage.setItem('orderFilterForm', JSON.stringify(this.filterForm));
        this.getList()
      },
      handleRowEdit(index, row) {
        console.log(row);
        this.$router.push({ name: 'order_detail', query: { id: row.id } })
      },
      onSubmitFilter() {
        this.page = 1
        console.log(this.limit_day);
        if (this.limit_day.length == 0) {
          this.limit_day_unix = [0,0]
        }else {
          this.limit_day_unix[0] = new Date(this.limit_day[0]).getTime()
          this.limit_day_unix[1] = new Date(this.limit_day[1]).getTime()
        }
        console.log(this.limit_day_unix);
        this.getList()
      },
      getList() {
        this.axios.get('order/all', {
          params: {
            page: this.page,
            orderSn: this.filterForm.order_sn,
            consignee: this.filterForm.consignee,
            status:this.ordertype,
            type:this.orderstate,
            supplier_id: this.filterForm.supplier_id,
            limit_day_start: this.limit_day_unix[0],
            limit_day_end: this.limit_day_unix[1],
            // user: this.filterForm.user
          }
        }).then((response) => {
          console.log(response);
          this.$message({
            message: '已刷新！',
            type: 'success'
          });
          this.tableData = response.data.data.data
          for (var i = 0; i < this.tableData.length; i++) {
            this.tableData[i].pay_localtime = this.tableData[i].pay_time == '0' ? ' - - ' : this.timestampToTime(this.tableData[i].pay_time)
            this.tableData[i].add_localtime = this.timestampToTime(this.tableData[i].add_time)
  					this.tableData[i].actual_localprice = (this.tableData[i].actual_price/1).toFixed(2)
            this.tableData[i].refund = this.tableData[i].refund
            this.tableData[i].refund.creat_localtime = this.timestampToTime(this.tableData[i].refund.creat_time)
            this.tableData[i].logistics_localtime = this.tableData[i].logistics_time == '0' ? ' - - ' : this.timestampToTime(this.tableData[i].logistics_time)
            this.tableData[i].refund_localtime = this.tableData[i].refund_time == '0' ? ' - - ' : this.timestampToTime(this.tableData[i].refund_time)
            this.tableData[i].confirLogic_localtime = this.tableData[i].confirLogic_time == '0' ? ' - - ' : this.timestampToTime(this.tableData[i].confirLogic_time)
            this.tableData[i].register_localtime = this.tableData[i].user.register_time == '0' ? ' - - ' : this.timestampToTime(this.tableData[i].user.register_time * 1000)

            if (this.tableData[i].refund.creat_time) {
              this.tableData[i].create_refund_localtime = this.tableData[i].refund.creat_time == '0' ? ' - - ' : this.timestampToTime(this.tableData[i].refund.creat_time)
              // this.tableData[i].refund_handle_localtime = this.tableData[i].refund.handel_time == '0' ? ' - - ' : this.timestampToTime(this.tableData[i].refund.handel_time)

            }else {
              // this.tableData[i].refund_handle_localtime = ' - - '
              this.tableData[i].create_refund_localtime = ' - - '
            }
  				}
          console.log(this.refund_img);
          this.page = response.data.data.currentPage
          this.total = response.data.data.count
        })
      },
      getsupplierlist(){
        this.axios.post('supplier/findallsupplierlistnocurrect').then(res => {
          console.log(res);
          this.supplierlist = res.data.data
        })
      },
      timestampToTime(timestamp) {
          var date = new Date(timestamp * 1);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
          var Y = date.getFullYear() + '/';
          var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '/';
          var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + '  ';
          var h = (date.getHours() < 10 ? '0'+date.getHours() : date.getHours()) + ':';
          var m = (date.getMinutes() < 10 ? '0'+date.getMinutes() : date.getMinutes()) + ':';
          var s = (date.getSeconds() < 10 ? '0'+date.getSeconds() : date.getSeconds());
          return Y+M+D+h+m+s;
      },
      timestampToDate(timestamp){
        var M = parseInt((timestamp % 3600000) / 60000);
        var S = ((timestamp % 60000) / 1000).toFixed(0);
        var localM = M < 10 ? '0' + M : M;
        var localS = S < 10 ? '0' + S : S;
        return localM + ":" + localS
      },
    },
    components: {

    },
    mounted() {
      let code = this.$route.query.state || '';
      this.changeorder_type(code)
      this.getList();
      this.getsupplierlist()
      this.looprefresh()

    }
  }

</script>

<style >
/* 以下为导出表格 */
.ChagePrice_area_filler {
  /* border:1px solid black; */
  display: flex;
  justify-content: flex-end;
  align-items: center;
}
.export_select_supplier_area {
  /* border: 1px solid black; */
}
.export_area {
  width: 80vw;
}
/* 以下为修改价格 */
.change_input_area_btnarea {
  height: 50px;
  /* border: 1px solid black; */
  display: flex;
  /* justify-content: flex-end; */
  align-items: center;

}
.change_input_area_right {
  /* height: 26px; */
  /* line-height: 26px; */
  float: right;
  width: 150px;
  margin-right: 5px;
}
.change_input_area_left {
  /* height: 26px; */
  /* line-height: 26px; */
  float: left;
  margin-left: 5px;
  font-size: 13px;
  color: #757575;
}
.change_input_area {
  border-bottom: 1px solid #eee;
  /* border:1px solid black; */
  height: 40px;
  line-height: 40px;
  margin-bottom: 12px;

}
.change_price_right {
  /* border:1px solid black; */
  height: 26px;
  line-height: 26px;
  float: right;
  margin-right: 5px;

}
.change_price_left {
  /* border:1px solid black; */
  height: 26px;
  line-height: 26px;
  float: left;
  margin-left: 5px;

}
.change_price {
  /* border: 1px solid black; */
  border-bottom: 1px solid #eee;
  height: 26px;
  line-height: 26px;
  font-size: 13px;
  color: #757575;
  margin-bottom: 12px;

}
.change_price_goods_sku {
  position: absolute;
  /* border:1px solid black; */
  bottom: 4px;
  left: 135px;
  color: #757575;
  font-size: 10px;
}
.change_price_goods_price .big,.change_price_right .big {
  color: #ff5566;
  font-weight: bold;
  font-size: 24px;
}
.change_price_goods_price {
  position: absolute;
  /* border:1px solid black; */
  bottom: 4px;
  right: 6px;
  height: 24px;
  font-size: 10px;
  color: #757575;

}
.change_price_goods_name {
  position: absolute;
  /* border:1px solid black; */
  line-height: 20px;
  max-height: 46px;
  font-size: 15px;
  top: 4px;
  right: 6px;
  left: 135px;
  overflow : hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}
.change_price_goods_img {
  /* border:1px solid black; */
  position: absolute;
  width: 120px;
  height: 82px;
  top: 4px;
  left: 6px;
}
.change_price_goods {
  /* border: 1px solid black; */
  border-top: 1px solid #eee;
  height: 90px;
  position: relative;
}
.change_price_area {
  border: 1px solid #eee;
  margin-top: 15px;
  margin-bottom: 15px;
  max-height: 112px;
  overflow-y: auto;
}
/* 、、、、、、、、、、、、、、、、、 */
.one_row_overflow_refundcollage {
  color: #ff5722;
  font-weight: bold;
}
.one_row_overflow_refundsuccess {
  color: #4caf50;
  font-weight: bold;
}
.one_row_overflow_refundbile {
  color: #2196f3;
  font-weight: bold;
}
.content_filler {
  position: relative;
  /* border:1px solid black; */
  height: 120px;
  width: 100%;
  margin: auto;
  /* margin-bottom: 20px; */
}
.content_filler_left {
  position: absolute;
  /* border:1px solid black; */
  width: 65%;
}
.content_filler_right {
  position: absolute;
  right: 0px;
}
.tooltip_item {
  /* display: inline-block; */
  display: block;
  height: 18px;
  line-height: 18px;
}
.tooltip_item_left {
  float: left;
  margin-right: 15px;
}
.tooltip_item_right {
  float: right;
}
.van-modal {
  z-index: 1999 !important;
}
.van-popup {
  z-index: 2001 !important;
}
.el-select-dropdown {
  z-index: 2050 !important;
}
/* //以下为物流 //////////////////////////////////////////////////////////////////////// */
.logic_area_one_finish {
  text-align: right;
  margin: 20px 0;
  color: #ff4444;
  font-weight: bolder;
}
.logic_area_one_datetime {
  /* border:1px solid black; */
  text-align: right;
  font-size: 14px;
  color: #757575;
}
.logic_area_one_content {
  /* border:1px solid black; */
  padding: 8px 0px;
  color: #f44444;
  font-weight: bold;
  text-indent: 2em;
}
.logic_area_one {
  margin: 15px 25px;
  /* margin-top: 15px; */
  /* border:1px solid black; */
}
/* //以下为退款 //////////////////////////////////////////////////////////////////////// */

.RefundArea_reson_item_imgrightext {
  line-height: 20px;
}
.hr {
  border-top:1px solid #ddd;
  margin-bottom: 20px;
}
.RefundArea_reson_item_img {
  width: 85px;
  height: 85px;
  margin: 0 5px;
}
.RefundArea_reson_item_imgright {
  text-align: right;
  width: 100%;
  font-size: 12px;
  color: #757575;
  /* line-height: 18px; */
  /* float: right; */
}
.RefundArea_reson_item_left {
  /* position: absolute; */
  /* position: absolute; */
  /* border:1px solid black; */
  width: 100px;
  font-size: 14px;
  color: #757575;
  float: left;
  font-weight: bold;
}
.RefundArea_reson_item_right {
  /* border:1px solid black; */
  /* position: absolute; */
  /* text-align: right; */
  width: 100%;
  font-size: 12px;
  color: #757575;
  line-height: 18px;
  /* float: right; */
}
.RefundArea_reson_item {
  /* border:1px solid black; */
  /* position: relative; */
  display: block;
  padding: 4px 1px;
  border-top:1px solid #ddd;
  min-height: 26px;
  /* position: relative; */
  /* height: auto; */
}
.Refund_btn {
  /* border:1px solid black; */
  /* margin:  */
  text-align: right;
  width: 95%;
  height: 32px;
  line-height: 28px;
  margin: 0 auto;
  margin-bottom: 10px;
}
.RefundArea_item_left {
  float: left;
  /* border: 1px solid black; */
  font-size: 12px;
  color: #757575;
}
.RefundArea_item_right {
  float: right;
  font-size: 12px;
  color: #757575;
}
.RefundArea_item {
  width: 100%;
  display: inline-block;
  /* border: 1px solid black; */
  height: 22px;
  line-height: 22px;
}
.RefundArea {
  width: 95%;
  min-height: 100px;
  margin: 0 auto;
  margin-top: 15px;
  margin-bottom: 11px;
  padding-bottom: 4px;
  border-bottom: 1px solid #f4f4f4;
  /* border:1px solid black; */
}
.RefundPopover {
  width: 450px;
  height: auto;
}
.RefundTitle {
  height: 45px;
  line-height: 45px;
  font-size: 18px;
  color: #222;
  font-weight: bold;
  width: 90%;
  margin: auto;
  border-bottom: 1px solid #f4f4f4;
  text-align: center;
}

/* //以下为发货 //////////////////////////////////////////////////////////////////////// */

.sendout_area_send_logic_value {
  height: 45px;
  line-height: 45px;
  font-size: 15px;
  color: #222;
  font-weight: bold;
  width: 90%;
  margin: auto;
  border-bottom: 1px solid #f4f4f4;
  text-align: center;
}
.sendout_area_send_logic_area {
  /* border:1px solid black; */
  height: auto;
  padding: 10px 0px;
}
.sendout_area_send_logic {
  width: 90%;
  /* border:1px solid black; */
  margin: auto;
  height: auto;
  margin-bottom: 8px;

}
.sendout_area_length {
  /* border:1px solid black; */
  width: 90%;
  margin: auto;
  text-align: right;
  font-size: 12px;
  color: #757575;
  margin-bottom: 10px;
}
.sendout_area_item_price {
  position: absolute;
  /* border:1px solid black; */
  /* width:  */
  right: 2px;
  bottom: 1px;
  font-weight: bold;
  font-size: 18px;
  line-height: 9px;
  color: #ff4444;
}
.sendout_area_item_sku {
  position: absolute;
  /* border:1px solid black; */
  /* width:  */
  left: 58px;
  bottom: 1px;
  font-size: 10px;
  line-height: 10px;
  color: #757575;
  /* max-height: 36px; */
  /* right: 3px; */
}
.sendout_area_item_name {
  position: absolute;
  /* border:1px solid black; */
  /* width:  */
  left: 58px;
  top: 3px;
  font-size: 14px;
  line-height: 17px;
  max-height: 36px;
  right: 3px;
}
.sendout_area_item_img {
  position: absolute;
  width: 52px;
  height: 52px;
  margin: 2px;
}
.sendout_area_item {
  height: 56px;
  position: relative;
  border: 1px solid #f4f4f4;
}
.sendout_area_area {
  width: 90%;
  overflow-y: scroll;
  border: 1px solid #f4f4f4;
  margin: 10px auto;
  max-height: 88px;
}
.sendout_area {
  width: 400px;
  height: auto;
}
.sendout_title {
  height: 45px;
  line-height: 45px;
  font-size: 18px;
  color: #222;
  font-weight: bold;
  width: 90%;
  margin: auto;
  border-bottom: 1px solid #f4f4f4;
  text-align: center;
}

/* //以下为查看  //////////////////////////////////////////////////////////////////////// */
.see_area {
  width: 400px;
  /* height: 200px; */
}
.see_area_area {
  width: 90%;
  margin-top: 20px;
}
/* //以下为修改收货地址  //////////////////////////////////////////////////////////////////////// */
.ChageAddress_chage_item_select {
  width: 30%;
  float: left;
  margin-left: 7px;
  /* max-width: 30% */
}
.ChageAddress_chage_item {
  width: 90%;
  height: auto;
  padding-top: 10px;
  min-height: 68px;
  /* border: 1px solid black; */
  margin: auto;
  text-align: center;

}
.ChageAddress_area_item_chage_btn {
  position: absolute;
  /* border: 1px solid black; */
  bottom: 5%;
  right: 1%;
  width: 75px;
  font-size: 11px;
  /* line-height: 14px; */
  /* height: 14px; */
}
.ChageAddress_area_item_getphone{
  position: absolute;
  /* border: 1px solid black; */
  bottom: 4px;
  left: 21%;
  font-size: 13px;
  line-height: 14px;
  height: 14px;
}
.ChageAddress_area_item_getaddress {
  position: absolute;
  /* border: 1px solid black; */
  left: 21%;
  top: 4px;
  right: 4px;
  font-size: 14px;
  line-height: 20px;
  max-height: 40px;
  overflow : hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}
.ChageAddress_area_item_getname {
  position: absolute;
  left: 0;
  top: 4px;
  width: 20%;
  /* border: 1px solid black; */
  height: 56px;
  line-height: 26px;
  text-align: center;
  overflow : hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}
.ChageAddress_area_item {
  position: relative;
  border: 1px solid #ddd;
  height: 56px;
  width: 96%;
  margin: 5px auto;
  margin-bottom: 20px;
}
.ChageAddress_area {
  /* border: 1px solid black; */
  /* height: 55px; */
  height: auto;
  margin: auto;
  width: 95%;
}
.BuyPeople_Info {
  border-bottom: 1px solid #f4f4f4;
  height: 26px;
  line-height: 26px;
  font-size: 14px;
  width: 96%;
  margin: 5px auto;
}
/* // 以下为修改商品价格 //////////////////////////////////////////////////////////////////////// */

.el-input__inner {
  /* height: 18px !important; */
  /* text-align: center !important; */
  /* font-size: 12px !important; */
}
.ChagePrice_item_chage_area_chage_price_input {
  position: absolute;
  top: -2px;
  left: 5%;
  /* height: 18px !important;
  text-align: center !important;
  font-size: 12px !important; */
  width: 90% !important;

}
.ChagePrice_area_bottom_action_btn {
  width: 96%;
  margin: auto;
  /* border-bottom: 1px solid #ddd; */
  /* border:1px solid black; */
  /* margin: 5px 0; */
  margin-top: 11px;
  margin-bottom: 7px;
}
.ChagePrice_area_bottom_chaged {
  width: 96%;
  margin: auto;
  border-bottom: 1px solid #ddd;
  /* border:1px solid black; */
  /* margin: 5px 0; */
  margin-top: 11px;
}
.ChagePrice_area_bottom_rel {
  width: 96%;
  margin: auto;
  /* border:1px solid black; */
  border-bottom: 1px solid #ddd;
  /* margin: 5px 0; */
  margin-top: 25px;
}
.ChagePrice_area_bottom_lop {
  width: 96%;
  margin: auto;
  /* border:1px solid black; */
  border-bottom: 1px solid #ddd;
  /* margin: 5px 0; */
  margin-top: 25px;
  height:44px;
  line-height: 40px;
}
.ChagePrice_item_chage_area_chage_btn_canel {
  position: absolute;
  /* border:1px solid black; */
  font-size: 11px;
  width: 40%;
  height: 20px;
  line-height: 20px;
  text-align: center;
  bottom: 3px;
  left: 3px;
  padding: 0 !important;
  margin: 0 !important;
}
.ChagePrice_item_chage_area_chage_btn_sure {
  position: absolute;
  /* border:1px solid black; */
  font-size: 11px;
  width: 48%;
  height: 20px;
  line-height: 20px;
  text-align: center;
  bottom: 3px;
  right: 0;
  padding: 0;
}
.ChagePrice_item_chage_area_chage_btn {
  position: absolute;
  /* border:1px solid black; */
  font-size: 11px;
  width: 70%;
  height: 20px;
  line-height: 20px;
  text-align: center;
  bottom: 3px;
  right: 0;
  padding: 0;

}
.ChagePrice_item_chage_area_chage_price {
  position: absolute;
  /* border:1px solid black; */
  font-size: 12px;
  width: 100%;
  height: 16px;
  line-height: 16px;
  text-align: center;
  top: 24px;
  right: 0;
}
.ChagePrice_item_chage_area_rel_price {
  position: absolute;
  /* border:1px solid black; */
  font-size: 12px;
  width: 100%;
  height: 16px;
  line-height: 16px;
  text-align: center;
  top: 5px;
  right: 0;
}
.ChagePrice_item_goodssku {
  position: absolute;
  /* border:1px solid black; */
  left: 68px;
  bottom: 2px;
  /* right: 5px; */
  /* top: 22px; */
  font-size: 11px;
  color: #757575;
  /* color: #ff4444; */
  /* font-weight: bold; */
}
.ChagePrice_item_goodsprice {
  position: absolute;
  /* border:1px solid black; */
  /* left: 68px; */
  /* bottom: 0; */
  right: 5px;
  bottom: 2px;
  font-size: 15px;
  color: #ff4444;
  font-weight: bold;
}
.ChagePrice_item_goodsnum {
  position: absolute;
  /* border:1px solid black; */
  right: 5px;
  top: 35px;
  height: 15px;
  line-height: 15px;
  font-size: 13px;
  /* color: #ff4444; */
  /* font-weight: bold; */
}
.ChagePrice_item_goodsname {
  position: absolute;
  /* border:1px solid black; */
  left: 68px;
  top: 3px;
  right: 5px;
  font-size: 15px;
  line-height: 19px;
  max-height: 40px;
  overflow : hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;

}
.ChagePrice_item_goodsimg {
  position: absolute;
  /* border:1px solid black; */
  width: 64px;
  height: 64px;
  margin: 2px;
}
.ChagePrice_item_chage_area {
  /* border: 1px solid black; */
  position: absolute;
  width: 20%;
  right: 0;
  top: 0;
  height: 68px;

}
.ChagePrice_item_goods_area{
  position: relative;
  width: 80%;
  height: 68px;
}
.ChagePrice_item {
  position: relative;
  width: 100%;
  height: 68px;
  border:1px solid #f1f1f1;
}
.ChagePrice_area_table {
  /* border:1px solid black; */
  width: 96%;
  max-height: 232px;
  margin: 5px auto;
  overflow-y: auto;
  /* overflow-y: hidden; */
}
/* .wp::-webkit-scrollbar {
    display: none;
} */
.ChagePrice_area_title {
  height: 66px;
  line-height: 66px;
  font-size: 20px;
  color: #222;
  font-weight: bold;
  width: 90%;
  margin: auto;
  border-bottom: 1px solid #f4f4f4;
  text-align: center;
}
.ChagePrice_area {
  width: 512px;
  height: auto;
}



.one_row_overflow_refund {
  color: #ff4444;
  font-weight: bold;
}
.one_row_overflow_refundno {
  color: #f57f33;
  font-weight: bold;
}
.one_row_overflow_refundget {
  color: #F54444;
  font-weight: bold;
}
.one_row_overflow {
  overflow : hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
}
</style>
