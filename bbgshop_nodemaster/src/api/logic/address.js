module.exports = class extends think.Logic {
  indexAction() {

  }
  textphoneAction() {
    const Phone = this.post('Phone');
    this.rules = {
     Phone: {
       regexp: /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/g
     }
   }
   this.validate()
  }
};
