const Base = require('./base.js');

module.exports = class extends Base {
  indexAction() {
    return this.display();
  }
  async findindexloopAction() {
  const data = await this.model('ad').select()
    return this.success(data)
  }
  async delloopAction() {
  const data = await this.model('ad').delete()
    return this.success(data)
  }
  //删除指定下标的循环图
  async delloopimageByIdAction() {
    const id = this.post('id')
    const data = await this.model('ad').where({id:id}).delete()
    return this.success(data)
  }
  //更新指定下标或新建循环图的循环图
  async updateloopimageByIdorNotAction() {
    const info = this.post('info')
    console.log(info);
    if (think.isEmpty(info.id)) {
      const data = await this.model('ad').add({
        ad_position_id:1,
        media_type:1,
        name: info.name,
        link: info.link,
        image_url: info.url,
        content: info.content,
        end_time: 0,
        enabled: 1,
      })
      return this.fail(1,'已新增主页轮播图 ！')
    }else {
      const data = await this.model('ad').where({id:info.id}).update({
        link: info.link,
        image_url: info.url,
        content: info.content,
        name: info.name,
      })
      return this.fail(2,'已更新主页轮播图 ！')
    }
  }
  //goodsroute
  //选择循环图跳转到具体商品
  async goodsrouteAction() {
    const page = this.get('page') || 1;
    const size = this.get('size') || 7;
    const goodsname = this.get('goodsname') || '';
    // const consignee = this.get('consignee') || '';

    const model = this.model('goods');
    const data = await model.where({name: ['like', `%${goodsname}%`]}).field(['id', 'name']).order(['id DESC']).page(page, size).countSelect();
    return this.success(data);
  }




  async findissueAction() {
    const data = await this.model('goods_issue').select();
    // const data = await this.model('ad').delete()
      return this.success(data)
  }
  async updateissueAction() {
    const info = this.post("info")
    console.log(info);
    if (info.id == 0) {
      const data = await this.model('goods_issue').add({
        question:info.question,
        answer:info.answer
      })
      return this.success(data)
    }else {
      const data = await this.model('goods_issue').where({id:info.id}).update({
        question:info.question,
        answer:info.answer
      })
      return this.success(data)
    }
  }
  async delissueAction() {
    const id = this.post('id')
    console.log(id);
    const data = await this.model('goods_issue').where({id:id}).limit(1).delete()
    return this.success(data)
  }

  // async setissueAction() {
  //   const value = this.post('issue')
  //   console.log(value);
  //   for (var i = 0; i < value.length; i++) {
  //     const data = await this.model('goods_issue').where({id:i+1}).update({
  //       goods_id:"0",
  //       question:value[i].question,
  //       answer:value[i].answer,
  //     });
  //
  //   }
    // const data = await this.model('ad').delete()
      // return this.success(data)
  // }




};
