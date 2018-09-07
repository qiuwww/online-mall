module.exports = [{
  interval: '300s',
  immediate: true,
  cron: '0/1 * * * * ? *',
  handle: '/admin/crontab/test',
  type: 'one'
// }, {

},{
  interval: '100s',
  immediate: true,
  cron: '* * * * * ? *',
  handle: '/admin/crontab/TimingUpdate',
  type: 'one'
}
// ,{
//   cron: '0 */1 * * *',
//   handle: '/admin/crontab/TimingUpdate',
//   type: 'one'
// }
// ,{
//   interval: false,
//   cron: '0 */1 * * *',
//   // immediate: false,
//   // immediate: true,
//   handle: '/admin/crontab/TimingUpdate'
// }, {
//   type: 'one'
// }
]
