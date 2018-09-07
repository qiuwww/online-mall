const Base = require('./base.js');

module.exports = class extends Base {
  /**
   * 评论类型说明：
   * 0 商品
   * 1 专题
   */

  /**
   * 发表评论
   * @returns {Promise.<*|PreventPromise|void|Promise>}
   */
    async listiscommentAction(){
     const goodslist = this.post("goodslist")
     console.log(goodslist);
     let goodlist = []
     for (var i = 0; i < goodslist.orderGoods.length; i++) {
       // array[i]
       let obj = {}
       let goods = goodslist.orderGoods[i]
       const list = await this.model('comment').where({
         user_id:think.userId,
         goods_id:goods.goods_id,
         product_id:goods.product_id,
         order_id: goods.order_id
       }).select()
       if (list.length > 0) {
         // return this.fail(2,'发表过此评论');
       }else{
         obj = goodslist.orderGoods[i]
         goodlist.push(obj)
         // return this.fail(0,'未发表过此评论');
       }
       goodslist.nocomlist = goodlist

     }
     return this.success(goodslist);
    }


    async updatecommentAction(){
      const orderid = this.post('orderid')
      const update = await this.model('order').where({id:orderid}).update({
        is_comment:1
      })
      return this.success(update);
    }
    async lunchAction() {
      const goods = this.post('goods');
      const conent = this.post('conent');
      const starkey = this.post('starkey');
      const imglist = this.post('imglist');
      // const buffer = Buffer.from(content);
      // this.checkcomment()
      const insertId = await this.model('comment').add({
        user_id: think.userId,
        goods_id: goods.goods_id,
        product_id: goods.product_id,
        product_value: goods.goods_specifition_name_value,
        add_time: new Date().getTime(),
        content:conent,
        score:starkey,
        order_id: goods.order_id
      });
      if (imglist.length > 0) {
        for (var i = 0; i < imglist.length; i++) {
          // array[i]
          console.log(imglist[i]);
          var pic_url = 'http://resource.bbgshop.com/'+ imglist[i].imageURL
          const comimg = await this.model('comment_picture').add({
            comment_id:insertId,
            pic_url:pic_url
          })
        }

        // console.log("99999999999999999999");
      }
      if (insertId) {
        return this.fail(0,'评论添加成功');
      } else {
        return this.fail(1,'评论添加失败');
      }
    }
    async checkcommentAction(){
      const goods = this.post("goods")
    // const productid = this.post("product_id")
    // const goodsid = this.post("goods_id")
    const list = await this.model('comment').where({
      user_id:think.userId,
      goods_id:goods.goods_id,
      product_id:goods.product_id,
      order_id: goods.order_id
    }).select()
    if (list.length > 0) {
      return this.fail(2,'发表过此评论');
    }else{
      return this.fail(0,'未发表过此评论');
    }
    // const productid = this.post("product_id")
  }
  // async countAction() {
  //   const goodsId = this.get('goodsId');
  //   // const showType = this.get('showType'); // 选择评论的类型 0 全部， 1 只显示图片
  //   let comments = [];
  //   comments = await this.model('comment').where({
  //       goods_id: goodsId,
  //     }).select();
  //   const commentList = [];
  //   for (var p = 0; p < comments.length; p++) {
  //     let obj = {}
  //     obj.content = comments[p].content
  //     obj.goods_id = comments[p].goods_id;
  //     obj.id = comments[p].id;
  //     obj.add_time = think.datetime(new Date(comments[p].add_time * 1));
  //     obj.user_info = await this.model('user').field(['username', 'avatar', 'nickname']).where({id: comments[p].user_id}).find();
  //     obj.pic_list = await this.model('comment_picture').where({comment_id: comments[p].id}).select();
  //     commentList.push(obj);
  //   }
  //   let commentListpic = []
  //   for (var a = 0; a < commentList.length; a++) {
  //     if (commentList[a].pic_list.length > 0) {
  //       commentListpic.push(commentList[a])
  //     }else { }
  //   }
  //   return this.success({
  //     allCount: commentList,
  //     hasPicCount: commentListpic
  //   });
  // }

  async listAction() {
    const goodsId = this.get('goodsId');
    const showType = this.get('showType'); // 选择评论的类型 0 全部， 1 只显示图片
    let comments = [];
    comments = await this.model('comment').where({
        goods_id: goodsId,
      }).select();
    const commentList = [];
    for (var p = 0; p < comments.length; p++) {
      let obj = {}
      obj.content = comments[p].content
      obj.goods_id = comments[p].goods_id;
      obj.id = comments[p].id;
      obj.score = comments[p].score;
      obj.skuvalue = comments[p].product_value;
      obj.add_time = think.datetime(new Date(comments[p].add_time * 1));
      obj.user_info = await this.model('user').field(['username', 'avatar', 'nickname']).where({id: comments[p].user_id}).find();
      obj.pic_list = await this.model('comment_picture').where({comment_id: comments[p].id}).select();
      commentList.push(obj);
    }
    let commentListpic = []
    for (var a = 0; a < commentList.length; a++) {
      if (commentList[a].pic_list.length > 0) {
        commentListpic.push(commentList[a])
      }else { }
    }
    if (showType == 1) {
      comments = commentListpic;
      return this.success({
        comments:comments
      });
    }else if(showType == 0){
      comments = commentList;
      return this.success({
        comments:comments
      });
    }else if(showType == 3){
      comments = commentList;
      return this.success({
        allCount: commentList,
        hasPicCount: commentListpic
      });
    }
    // return this.success({
    //   comments:comments
    // });
  }
};
