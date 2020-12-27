const Telegraf = require('telegraf')
const bot = new Telegraf('XXXXXX')
const { exec } = require('child_process');
const fs = require('fs');
const readline = require('readline');
const { Validator } = require('node-input-validator');

bot.on('text', (ctx) => {
console.log(ctx.message)

if (ctx.message.text == '/start') {
ctx.replyWithHTML(
'<i>oi bro</i> @<b>'+ ctx.from.username +'</b> \n bot kie nggo gawe node shared api \n nek ora ko bisa melu masang mining lewat bot kie, \n carane PM bae bot kie \n terus ketik bae /tulung \n nko di njlentrehna carane kepriwe \n nek ora mudeng PM sing due bae ',
{'reply_to_message_id':ctx.message.message_id})}

if (ctx.message.text == '/tulung') {
ctx.replyWithMarkdown('kie nggo ko @*'+ ctx.from.username +'* \n /newapi - nggo gawe random api \n /listapi kie nggo ndeleng kabeh apikey sing ws pernah ko gawe \n /nodekey - nek pengin masang nodekey ben bsa melu mining neng kene',
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
exec('cat ./znyber.txt', (error, stdout, stderr) => {
    if (error) {
        ctx.reply(`error: ${error.message}`);
    }
    if (stderr) {
        ctx.reply(`stderr: ${stderr}`);
    }
    ctx.reply(`api mu ${ctx.message.text}`);
    ctx.reply(`${stdout}`);
});}
else{ ctx.reply(`lewat PM ae , kui ana sing salah kodene ko`) }
})
bot.startPolling()
