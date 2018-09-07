const Base = require('./base.js');

module.exports = class extends Base {
  async freightlistAction() {
    const page = this.post('page') || 1;
    const size = this.post('size') || 10;
    const name = this.post('name') || '';
    const data = await this.model('freight_template_main').where({temp_name: ['like', `%${name}%`]}).order(['id DESC']).page(page, size).countSelect();
    return this.success(data);
  }
  async selectprovinceAction() {
    const data = await this.model('region').where({type:1}).select()
    return this.success(data)
  }
  async findfreightinfoByIdAction() {
    const id = this.post('id')
    //主表信息
    const main_info = await this.model('freight_template_main').where({id:id}).find()
    // 副表列表
    const point_address_list = await this.model('freight_template_auxiliary').where({temp_main_id: id}).select()
    return this.success({
      main_info: main_info,
      point_address_list: point_address_list
    })
  }
  async updatefreghttempleAction() {
    const id = this.post('id')
    const info = this.post('info')
    const temp_list = this.post('temp')
    if (parseInt(id) == 0) {
      //没有主表id 新建操作
      console.log(id,info);
      console.log(temp_list);
      //主表添加记录
      const main_table_id = await this.model('freight_template_main').add({
        temp_name: info.temp_name,
        temp_method: info.Billing_Method,
        point_rules: temp_list.length,
        create_time: new Date().getTime()
      })
      console.log(main_table_id);
      // 副表添加记录
      for (var i = 0; i < temp_list.length; i++) {
        // array[i]
        await this.model('freight_template_auxiliary').add({
          temp_main_id: main_table_id,
          temp_point_city_id: temp_list[i].temp_point_city_id,
          temp_point_city_name: temp_list[i].temp_point_city_name,
          temp_point_city_JSONstr: temp_list[i].temp_point_city_JSONstr,
          temp_first_weight: temp_list[i].temp_first_weight,
          temp_first_freight: temp_list[i].temp_first_freight,
          temp_continue_weight: temp_list[i].temp_continue_weight,
          temp_continue_freight: temp_list[i].temp_continue_freight,
          create_time: new Date().getTime()
        })
      }
      return this.fail(17,'运费模板写入成功 ！')
    }else {
      //更新操作
      console.log(id,info);
      console.log(temp_list);
      const temp_main_info = await this.model('freight_template_main').where({id:id}).find()
      await this.model('freight_template_main').where({id:id}).update({
        temp_name: info.temp_name,
        temp_method: info.Billing_Method,
        point_rules: temp_list.length,
        handel_time: new Date().getTime(),
        handel_num: Number(temp_main_info.handel_num) + 1
      })
      await this.model('freight_template_auxiliary').where({temp_main_id:id}).delete()
      for (var j = 0; j < temp_list.length; j++) {
        await this.model('freight_template_auxiliary').add({
          temp_main_id: id,
          temp_point_city_id: temp_list[j].temp_point_city_id,
          temp_point_city_name: temp_list[j].temp_point_city_name,
          temp_point_city_JSONstr: temp_list[j].temp_point_city_JSONstr,
          temp_first_weight: temp_list[j].temp_first_weight,
          temp_first_freight: temp_list[j].temp_first_freight,
          temp_continue_weight: temp_list[j].temp_continue_weight,
          temp_continue_freight: temp_list[j].temp_continue_freight,
          create_time: new Date().getTime()
        })
      }
      return this.fail(506,'运费模板更新成功 ！')
    }
  }
  async delfreighttempAction() {
    const id = this.post('id')
    await this.model('freight_template_main').where({id:id}).delete()
    const data = await this.model('freight_template_auxiliary').where({temp_main_id:id}).delete()
    return this.success(data)
  }
}
