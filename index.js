const Telegraf = require('telegraf')
const axios = require('axios');
const bot = new Telegraf('XXX')
const { exec } = require('child_process');
const fs = require('fs');
const readline = require('readline');


bot.on('text', async (ctx, next) => {
console.log(ctx.message)

if (ctx.message.text == '/start' || ctx.message.text == '/start@@bounty_hunt_idna_bot') {
ctx.replyWithHTML(
'<i>oi bro</i> @<b>'+ ctx.from.username +'</b> \n bot kie nggo gawe node shared api \n nek ora ko bisa melu masang mining lewat bot kie, \n carane PM bae bot kie \n terus ketik bae /tulung \n nko di njlentrehna carane kepriwe \n nek ora mudeng PM sing due bae ',
{'reply_to_message_id':ctx.message.message_id})}

if (ctx.message.text == '/tulung' || ctx.message.text == '/tulung@@bounty_hunt_idna_bot') {
ctx.replyWithMarkdown('kie nggo ko @*'+ ctx.from.username +'* \n /newapi - nggo gawe random api \n /listapi kie nggo ndeleng kabeh apikey sing ws pernah ko gawe \n /nodekey - nek pengin masang nodekey ben bsa melu mining neng kene',
{'reply_to_message_id':ctx.message.message_id})}

if (ctx.message.text == '/newapi@bounty_hunt_idna_bot' || ctx.message.text == '/listapi@bounty_hunt_idna_bot' || ctx.message.text == '/nodekey@bounty_hunt_idna_bot' ) {
ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* \n PM bae luih enak \n langsung pm @bounty_hunt_idna_bot',
{'reply_to_message_id':ctx.message.message_id})}

if (ctx.message.text == '/newapi') {
exec('sed -n "1{p;q}" api.txt >>'+ ctx.from.username +'.txt && tail -1 '+ ctx.from.username +'.txt && sed -i "1d" api.txt', (error, stdout, stderr) => {
    if (error) {
        ctx.reply(`error: ${error.message}`);
    }
    if (stderr) {
        ctx.reply(`stderr: ${stderr}`);
    }
    ctx.reply(`api mu`);
    ctx.reply(`${stdout}`);
});}
if (ctx.message.text == '/listapi') {
async function processLineByLine() {
  const fileStream = fs.createReadStream(''+ ctx.from.username +'.txt');

  const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity
  });

  for await (const line of rl) {
    console.log(ctx.reply(`${line}`));
  }
}

processLineByLine();}

if (ctx.message.text == '/nodekey' && ctx.chat.type == 'private') {
	ctx.replyWithHTML(
'<i>oi bro</i> @<b>'+ ctx.from.username +'</b> \n upload file nodekey mu ben nko di proses',
{'reply_to_message_id':ctx.message.message_id})
bot.on('document', async (ctx) => {
  const {file_id: fileId} = ctx.update.message.document;
  const fileUrl = await ctx.telegram.getFileLink(fileId);
  const response = await axios.get(fileUrl);
  ctx.reply('ok lagi di prosess sekitar 1-15 menitan ngasi syncron\n\n');
  exec('echo '+ response.data +' >> ./'+ ctx.from.username +'.txt', (error, stdout, stderr, stdio) => {
    if (error) {
        ctx.reply(`error: ${error.message}`);
    }
    if (stderr) {
        ctx.reply(`stderr: ${stderr}`);
    }
    ctx.reply(`nodekey mu iki ya ${response.data}`);
    //ctx.reply(`${stdout}`);
});
});
}
//else{ ctx.reply(`lewat PM ae , kui ana sing salah kodene ko`) }
})
bot.startPolling()