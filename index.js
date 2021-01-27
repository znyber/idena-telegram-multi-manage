require('dotenv-flow').config();
const Telegraf = require('telegraf')
const axios = require('axios');
const bot = new Telegraf(process.env.BOT_TELE)
const { exec } = require('child_process');
const fs = require('fs');
const readline = require('readline');
const bot_name = process.env.BOT_NAME

//start command
bot.start((ctx) =>{
        ctx.replyWithHTML('<i>oi bro</i> @<b>'+ ctx.from.username +'</b> \n bot kie nggo gawe node shared api \n nek ora ko bisa melu masang mining lewat bot kie, \n carane PM bae bot kie \n terus ketik bae /tulung \n nko di njlentrehna carane kepriwe \n nek ora mudeng PM sing due bae ',
        {'reply_to_message_id':ctx.message.message_id})
        console.log(ctx.from.username);
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)
})
bot.command('oi', (ctx) =>{
        ctx.replyWithHTML('<i>oi bro</i> @<b>'+ ctx.from.username +'</b> \n bot kie nggo gawe node shared api \n nek ora ko bisa melu masang mining lewat bot kie, \n carane PM bae bot kie \n terus ketik bae /tulung \n nko di njlentrehna carane kepriwe \n nek ora mudeng PM sing due bae ',
        {'reply_to_message_id':ctx.message.message_id})
        console.log(ctx.from.username);
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('oi'+ bot_name, (ctx) =>{
        ctx.replyWithHTML('<i>oi bro</i> @<b>'+ ctx.from.username +'</b> \n bot kie nggo gawe node shared api \n nek ora ko bisa melu masang mining lewat bot kie, \n carane PM bae bot kie \n terus ketik bae /tulung \n nko di njlentrehna carane kepriwe \n nek ora mudeng PM sing due bae ',
        {'reply_to_message_id':ctx.message.message_id})
        console.log(ctx.from.username);
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//help command
bot.command('tulung'+ bot_name, (ctx) =>{
	async function processLineByLine() {
        const fileStream = fs.createReadStream('/home/tulung.txt');
            const r1 = readline.createInterface({
                input: fileStream,
                crlfDelay: Infinity
            });

        const freq = {}
        for await(const line of r1) {
            const lak = `/${line}\n`
            const pi = lak.split(',')[0]
            freq[pi] = (freq[pi])
        }
        const obj = Object.keys(freq)
        ctx.reply(`,${obj}`, {'reply_to_message_id':ctx.message.message_id})
    }
                processLineByLine();
        
        console.log(ctx.from.username);
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('tulung', (ctx) =>{
	async function processLineByLine() {
        const fileStream = fs.createReadStream('/home/tulung.txt');
            const r1 = readline.createInterface({
                input: fileStream,
                crlfDelay: Infinity
            });

        const freq = {}
        for await(const line of r1) {
            const lak = `/${line}\n`
            const pi = lak.split(',')[0]
            freq[pi] = (freq[pi])
        }
        const obj = Object.keys(freq)
        ctx.reply(`,${obj}`, {'reply_to_message_id':ctx.message.message_id})
    }
                processLineByLine();
        
        console.log(ctx.from.username);
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//newapi command
bot.command('newapi', (ctx) =>{
        console.log(ctx.from.username);
        if (ctx.chat.type == 'private') {
                exec('sed -n "1{p;q}" /home/api.txt >> /home/'+ ctx.from.username +'-api.txt && tail -1 /home/'+ ctx.from.username +'-api.txt && sed -i "1d" /home/api.txt', (error, stdout, stderr) => {
                if (error) {
                        ctx.reply(`error: ${error.message}`);
                }
                if (stderr) {
                        ctx.reply(`stderr: ${stderr}`);
                }
                ctx.reply(`api mu`,{'reply_to_message_id':ctx.message.message_id});
                ctx.reply(`${stdout}`);
                });
        }else{
                ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* nek neng grup ra bisa \n langsung PM bot kie ae > *'+ bot_name +'*',
                {'reply_to_message_id':ctx.message.message_id})
        }
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('newapi'+ bot_name, (ctx) =>{
        ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* nek neng grup ra bisa \n langsung PM bot kie ae > *'+ bot_name +'*',
        {'reply_to_message_id':ctx.message.message_id})
        console.log(ctx.from.username);
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//listapi command
bot.command('listapi', (ctx) =>{
        console.log(ctx.from.username);
        if (ctx.chat.type == 'private') {
			if(fs.existsSync('/home/'+ ctx.from.username +'-api.txt')) {
				console.log("The file exists.");
                async function processLineByLine() {
                const fileStream = fs.createReadStream('/home/'+ ctx.from.username +'-api.txt');
                const rl = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
                });
                for await (const line of rl) {
                        console.log(ctx.reply(`${line}`));
                }
                }
                processLineByLine();
			} else {
			console.log('The file does not exist.');
            ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko urung pernah gawe api > *'+ bot_name +'*',
            {'reply_to_message_id':ctx.message.message_id})}
        }else{
                ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* nek neng grup ra bisa \n langsung PM bot kie ae > *'+ bot_name +'*',
                {'reply_to_message_id':ctx.message.message_id})
        }
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('listapi'+ bot_name, (ctx) =>{
        console.log(ctx.from.username);
        ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* nek neng grup ra bisa \n langsung PM bot kie ae > *'+ bot_name +'*',
        {'reply_to_message_id':ctx.message.message_id})
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//nodekey command
bot.command('nodekey', (ctx) =>{
        console.log(ctx.from.username);
        if (ctx.chat.type == 'private') {
                ctx.replyWithHTML(
                        '<i>oi bro</i> @<b>'+ ctx.from.username +'</b> \n upload file nodekey mu ben nko di proses',
                        {'reply_to_message_id':ctx.message.message_id})
		/*		async function comblaXread () {
										exec('tail -1 /home/'+ ctx.from.username +'/'+ ctx.from.username +'-portRpc.txt', (err, stdoutX, stderr) => {
											if (err) {
												console.error(err);
												return;
												}
												const portRpd = stdoutX
												console.log('port saat ini '+ portRpd +'')
										fs.readFile('/home/'+ ctx.from.username +'/'+ portRpd +'.bat', function (err, dat2x) {
										ctx.reply(`download and open file ${portRpd}.bat`);
											ctx.telegram.sendDocument(ctx.from.id, {
												source: dat2x,
												filename: ''+ portRpd +'.bat'
											}).catch(function(error){ console.log(error); })
										})
										})
				}
		*/
                bot.on('document', async (ctx) => {
                        const {file_id: fileId} = ctx.update.message.document;
                        const fileUrl = await ctx.telegram.getFileLink(fileId);
                        const response = await axios.get(fileUrl);
                        ctx.reply('ok lagi di prosess sekitar 1-15 menitan ngasi syncron\n\n');
                                exec('idena-multi '+ ctx.from.username +' '+ response.data +'', (error, stdout, stderr) => {
                                        if (error) {
                                                ctx.reply(`error: ${error.message}`);
                                        }
                                        if (stderr) {
                                        console.log(`stderr: ${stderr}`);
                                        }
                                        ctx.reply(`proses install...`);
								//comblaXread();
								exec('tail -1 /home/'+ ctx.from.username +'/'+ ctx.from.username +'-portRpc.txt', (err, stdoutX, stderr) => {
											if (err) {
												console.error(err);
												return;
												}
												const portRpd = stdoutX
												console.log('port saat ini '+ portRpd +'')
										fs.readFile('/home/'+ ctx.from.username +'/'+ portRpd +'.bat', function (err, dat2x) {
										ctx.reply(`download and open file ${portRpd}.bat`);
											ctx.telegram.sendDocument(ctx.from.id, {
												source: dat2x,
												filename: ''+ portRpd +'.bat'
											}).catch(function(error){ console.log(error); })
										})
										})
                                });
                });
        }else{
                ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* nek neng grup ra bisa \n langsung PM bot kie ae > *'+ bot_name +'*',
                {'reply_to_message_id':ctx.message.message_id})
        }
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('nodekey'+ bot_name, (ctx) =>{
        console.log(ctx.from.username);
        ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* nek neng grup ra bisa \n langsung PM bot kie ae > *'+ bot_name +'*',
        {'reply_to_message_id':ctx.message.message_id})
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//mininglist command
bot.command('mininglist', (ctx) =>{
        console.log(ctx.from.username);
		if(fs.existsSync('/home/'+ ctx.from.username +'/'+ ctx.from.username +'-portRpc.txt')) {
		console.log("The file exists.");
        async function processLineByLine() {
                const fileStream = fs.createReadStream('/home/'+ ctx.from.username +'/'+ ctx.from.username +'-portRpc.txt');
                const rl = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
                });

                for await (const line of rl) {
                        async function makePostRequest() {
                                bcn_syncing = {"method":"bcn_syncing","params":[],"id":1,"key":`${ctx.from.username}`}
                                dna_identity = {"method":"dna_identity","params":[],"id":1,"key":`${ctx.from.username}`}
                                const res_sync = await axios.post('http://localhost:'+ line, bcn_syncing);
                                const res_iden = await axios.post('http://localhost:'+ line, dna_identity);
                                if ( res_sync.data.result.syncing === false ){
                                        if ( res_iden.data.result.online === true){ ctx.reply(`Idena address : ${res_iden.data.result.address} \n status mining : ON`,
                                        {'reply_to_message_id':ctx.message.message_id})}
                                        else {ctx.reply(`Idena address : ${res_iden.data.result.address} \n status mining : OFF`,
                                        {'reply_to_message_id':ctx.message.message_id});}
                                }else {ctx.reply('node syncing...',
                                {'reply_to_message_id':ctx.message.message_id});}
                        }
                        makePostRequest();
                }
        }
		ctx.reply('jika data tidak muncul kemungkinan off \n nyalakan terlebih dahulu menggunakan command \n /startall')
        processLineByLine();
		} else {
			console.log('The file does not exist.');
            ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko urung pernah pasang node neng kene > *'+ bot_name +'*',
		{'reply_to_message_id':ctx.message.message_id})}
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('mininglist'+ bot_name, (ctx) =>{
        console.log(ctx.from.username);
		if(fs.existsSync('/home/'+ ctx.from.username +'/'+ ctx.from.username +'-portRpc.txt')) {
		console.log("The file exists.");
        async function processLineByLine() {
                const fileStream = fs.createReadStream('/home/'+ ctx.from.username +'/'+ ctx.from.username +'-portRpc.txt');
                const rl = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
                });

                for await (const line of rl) {
                        async function makePostRequest() {
                                bcn_syncing = {"method":"bcn_syncing","params":[],"id":1,"key":`${ctx.from.username}`}
                                dna_identity = {"method":"dna_identity","params":[],"id":1,"key":`${ctx.from.username}`}
                                const res_sync = await axios.post('http://localhost:'+ line, bcn_syncing);
                                const res_iden = await axios.post('http://localhost:'+ line, dna_identity);
                                if ( res_sync.data.result.syncing === false ){
                                        if ( res_iden.data.result.online === true){ ctx.reply(`Idena address : ${res_iden.data.result.address} \n status mining : ON`,
                                        {'reply_to_message_id':ctx.message.message_id})}
                                        else {ctx.reply(`Idena address : ${res_iden.data.result.address} \n status mining : OFF`,
                                        {'reply_to_message_id':ctx.message.message_id});}
                                }else {ctx.reply('node syncing...',
                                {'reply_to_message_id':ctx.message.message_id});}
                        }
                        makePostRequest();
                }
        }
		ctx.reply('jika data tidak muncul kemungkinan off \n nyalakan terlebih dahulu menggunakan command \n /startall')
        processLineByLine();
		} else {
			console.log('The file does not exist.');
            ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko urung pernah pasang node neng kene > *'+ bot_name +'*',
		{'reply_to_message_id':ctx.message.message_id})}
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//nodeall command
bot.command('nodeall', (ctx) =>{
        console.log(ctx.from.username);
        if (ctx.chat.type == 'private') {
			if(fs.existsSync('/home/'+ ctx.from.username +'/'+ ctx.from.username +'-portRpc.txt')) {
			console.log("The file exists.");
                async function processLineByLine() {
                        const fileStream = fs.createReadStream('/home/'+ ctx.from.username +'/'+ ctx.from.username +'-portRpc.txt');
                        const rl = readline.createInterface({
                                input: fileStream,
                                crlfDelay: Infinity
                        });
                        for await (const line of rl) {
                                        async function makePostRequest() {
                                        bcn_syncing = {"method":"bcn_syncing","params":[],"id":1,"key":`${ctx.from.username}`}
                                        dna_identity = {"method":"dna_identity","params":[],"id":1,"key":`${ctx.from.username}`}
										
                                        const res_sync = await axios.post('http://localhost:'+ line, bcn_syncing);
                                        const res_iden = await axios.post('http://localhost:'+ line, dna_identity);
										
										dna_getBalance = {"method":"dna_getBalance","params":[`${res_iden.data.result.address}`],"id":1,"key":`${ctx.from.username}`}
										const res_getb = await axios.post('http://localhost:'+ line, dna_getBalance);
										
                                        if ( res_sync.data.result.syncing === false ){
                                                if ( res_iden.data.result.online === true){ ctx.replyWithHTML(`Idena address : <a href='https://scan.idena.io/identity/${res_iden.data.result.address}'>${res_iden.data.result.address}</a> \n Age : ${res_iden.data.result.age} \n Status : ${res_iden.data.result.state} \n balance : ${res_getb.data.result.balance} \n stake : ${res_getb.data.result.stake} \n flip yang sudah dibuat : ${res_iden.data.result.madeFlips} \n Mining : ON`,
                                                {'reply_to_message_id':ctx.message.message_id})
													fs.readFile('/home/'+ ctx.from.username +'/'+ line +'.bat', function (err, dat2) {
														ctx.reply(`download and open file ${line}.bat`);
														ctx.telegram.sendDocument(ctx.from.id, {
															source: dat2,
															filename: ''+ line +'.bat'
														}).catch(function(error){ console.log(error); })
												})}
                                                else {ctx.replyWithHTML(`Idena address : <a href='https://scan.idena.io/identity/${res_iden.data.result.address}'>${res_iden.data.result.address}</a> \n Age : ${res_iden.data.result.age} \n Status : ${res_iden.data.result.state} \n balance : ${res_getb.data.result.balance} \n stake : ${res_getb.data.result.stake} \n flip yang sudah dibuat : ${res_iden.data.result.madeFlips} \n Mining : OFF`,
                                                {'reply_to_message_id':ctx.message.message_id});
													fs.readFile('/home/'+ ctx.from.username +'/'+ line +'.bat', function (err, dat2) {
														ctx.reply(`download and open file ${line}.bat`);
														ctx.telegram.sendDocument(ctx.from.id, {
															source: dat2,
															filename: ''+ line +'.bat'
														}).catch(function(error){ console.log(error); })
												})}
                                        }else {ctx.reply('node sync...\n block saat ini '+ res_sync.data.result.currentBlock +'\n block yang harus di peroleh '+ res_sync.data.result.highestBlock +' ',
                                        {'reply_to_message_id':ctx.message.message_id});}
                                        }
                        makePostRequest();
                        }
                }
				ctx.reply('jika data tidak muncul kemungkinan off \n nyalakan terlebih dahulu menggunakan command \n /startall')
                processLineByLine();
			} else {
			console.log('The file does not exist.');
            ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko urung pernah pasang node neng kene > *'+ bot_name +'*',
		{'reply_to_message_id':ctx.message.message_id})}
        }else{
                ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* nek neng grup ra bisa \n langsung PM bot kie ae > *'+ bot_name +'*',
                {'reply_to_message_id':ctx.message.message_id})
        }
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('nodeall'+ bot_name, (ctx) =>{
        console.log(ctx.from.username);
        ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* nek neng grup ra bisa \n langsung PM bot kie ae > *'+ bot_name +'*',
        {'reply_to_message_id':ctx.message.message_id})
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//miningoff
bot.command('miningoff', (ctx) =>{
        console.log(ctx.from.username);
	if(fs.existsSync('/home/'+ ctx.from.username +'/'+ ctx.from.username +'-portRpc.txt')) {
	console.log("The file exists.");
        async function processLineByLine() {
                const fileStream = fs.createReadStream('/home/'+ ctx.from.username +'/'+ ctx.from.username +'-portRpc.txt');
                const rl = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
                });
                for await (const line of rl) {
                        async function makePostRequest() {
                                        bcn_syncing = {"method":"bcn_syncing","params":[],"id":1,"key":`${ctx.from.username}`}
                                        dna_offline = {"method":"dna_becomeOffline","params":[{}],"id":1,"key":`${ctx.from.username}`}
                                        dna_identity = {"method":"dna_identity","params":[],"id":1,"key":`${ctx.from.username}`}
                                        const res_sync = await axios.post('http://localhost:'+ line, bcn_syncing);
                                        const res_offl = await axios.post('http://localhost:'+ line, dna_offline);
                                        const res_iden = await axios.post('http://localhost:'+ line, dna_identity);
                                        if ( res_sync.data.result.syncing === false ){
                                                console.log(res_offl.data)
                                                if ( res_iden.data.result.online === true){ ctx.reply(`Idena address : ${res_iden.data.result.address} \n Mining : sedang dimatikan... tunggu 1-5 menit`,
                                                {'reply_to_message_id':ctx.message.message_id})
                                                }else {ctx.reply(`Idena address : ${res_iden.data.result.address} \n Mining : OFF`,
                                                {'reply_to_message_id':ctx.message.message_id});}
                                        }else {ctx.reply('node sync...\n block saat ini '+ res_sync.data.result.currentBlock +'\n block yang harus di peroleh '+ res_sync.data.result.highestBlock +' ',
                                        {'reply_to_message_id':ctx.message.message_id});}
                        }
                makePostRequest();
                }
        }
		ctx.reply('jika data tidak muncul kemungkinan off \n nyalakan terlebih dahulu menggunakan command \n /startall')
        processLineByLine();
		} else {
			console.log('The file does not exist.');
            ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko urung pernah pasang node neng kene > *'+ bot_name +'*',
		{'reply_to_message_id':ctx.message.message_id})}
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('miningoff'+ bot_name, (ctx) =>{
         console.log(ctx.from.username);
	if(fs.existsSync('/home/'+ ctx.from.username +'/'+ ctx.from.username +'-portRpc.txt')) {
	console.log("The file exists.");
        async function processLineByLine() {
                const fileStream = fs.createReadStream('/home/'+ ctx.from.username +'/'+ ctx.from.username +'-portRpc.txt');
                const rl = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
                });
                for await (const line of rl) {
                        async function makePostRequest() {
                                        bcn_syncing = {"method":"bcn_syncing","params":[],"id":1,"key":`${ctx.from.username}`}
                                        dna_offline = {"method":"dna_becomeOffline","params":[{}],"id":1,"key":`${ctx.from.username}`}
                                        dna_identity = {"method":"dna_identity","params":[],"id":1,"key":`${ctx.from.username}`}
                                        const res_sync = await axios.post('http://localhost:'+ line, bcn_syncing);
                                        const res_offl = await axios.post('http://localhost:'+ line, dna_offline);
                                        const res_iden = await axios.post('http://localhost:'+ line, dna_identity);
                                        if ( res_sync.data.result.syncing === false ){
                                                console.log(res_offl.data)
                                                if ( res_iden.data.result.online === true){ ctx.reply(`Idena address : ${res_iden.data.result.address} \n Mining : sedang dimatikan... tunggu 1-5 menit`,
                                                {'reply_to_message_id':ctx.message.message_id})
                                                }else {ctx.reply(`Idena address : ${res_iden.data.result.address} \n Mining : OFF`,
                                                {'reply_to_message_id':ctx.message.message_id});}
                                        }else {ctx.reply('node sync...\n block saat ini '+ res_sync.data.result.currentBlock +'\n block yang harus di peroleh '+ res_sync.data.result.highestBlock +' ',
                                        {'reply_to_message_id':ctx.message.message_id});}
                        }
                makePostRequest();
                }
        }
		ctx.reply('jika data tidak muncul kemungkinan off \n nyalakan terlebih dahulu menggunakan command \n /startall')
        processLineByLine();
		} else {
			console.log('The file does not exist.');
            ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko urung pernah pasang node neng kene > *'+ bot_name +'*',
		{'reply_to_message_id':ctx.message.message_id})}
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
// miningon command
bot.command('miningon', (ctx) =>{
        console.log(ctx.from.username);
	if(fs.existsSync('/home/'+ ctx.from.username +'/'+ ctx.from.username +'-portRpc.txt')) {
	console.log("The file exists.");
        async function processLineByLine() {
                const fileStream = fs.createReadStream('/home/'+ ctx.from.username +'/'+ ctx.from.username +'-portRpc.txt');
                const rl = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
                });
                for await (const line of rl) {
                        async function makePostRequest() {
                                        bcn_syncing = {"method":"bcn_syncing","params":[],"id":1,"key":`${ctx.from.username}`}
                                        dna_online = {"method":"dna_becomeOnline","params":[{}],"id":1,"key":`${ctx.from.username}`}
                                        dna_identity = {"method":"dna_identity","params":[],"id":1,"key":`${ctx.from.username}`}
                                        const res_sync = await axios.post('http://localhost:'+ line, bcn_syncing);
                                        const res_onli = await axios.post('http://localhost:'+ line, dna_online);
                                        const res_iden = await axios.post('http://localhost:'+ line, dna_identity);
                                        if ( res_sync.data.result.syncing === false ){
                                                console.log(res_onli.data)
                                                if ( res_iden.data.result.online === true){ ctx.reply(`Idena address : ${res_iden.data.result.address} \n Mining : sedang aktifkan... tunggu 1-5 menit`,
                                                {'reply_to_message_id':ctx.message.message_id})
                                                }else {ctx.reply(`Idena address : ${res_iden.data.result.address} \n Mining : OFF`,
                                                {'reply_to_message_id':ctx.message.message_id});}
                                        }else {ctx.reply('node sync...\n block saat ini '+ res_sync.data.result.currentBlock +'\n block yang harus di peroleh '+ res_sync.data.result.highestBlock +' ',
                                        {'reply_to_message_id':ctx.message.message_id});}
                        }
                makePostRequest();
                }
        }
		ctx.reply('jika data tidak muncul kemungkinan off \n nyalakan terlebih dahulu menggunakan command \n /startall')
        processLineByLine();
		} else {
			console.log('The file does not exist.');
            ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko urung pernah pasang node neng kene > *'+ bot_name +'*',
		{'reply_to_message_id':ctx.message.message_id})}
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('miningon'+ bot_name, (ctx) =>{
        console.log(ctx.from.username);
	if(fs.existsSync('/home/'+ ctx.from.username +'/'+ ctx.from.username +'-portRpc.txt')) {
	console.log("The file exists.");
        async function processLineByLine() {
                const fileStream = fs.createReadStream('/home/'+ ctx.from.username +'/'+ ctx.from.username +'-portRpc.txt');
                const rl = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
                });
                for await (const line of rl) {
                        async function makePostRequest() {
                                        bcn_syncing = {"method":"bcn_syncing","params":[],"id":1,"key":`${ctx.from.username}`}
                                        dna_online = {"method":"dna_becomeOnline","params":[{}],"id":1,"key":`${ctx.from.username}`}
                                        dna_identity = {"method":"dna_identity","params":[],"id":1,"key":`${ctx.from.username}`}
                                        const res_sync = await axios.post('http://localhost:'+ line, bcn_syncing);
                                        const res_onli = await axios.post('http://localhost:'+ line, dna_online);
                                        const res_iden = await axios.post('http://localhost:'+ line, dna_identity);
                                        if ( res_sync.data.result.syncing === false ){
                                                console.log(res_onli.data)
                                                if ( res_iden.data.result.online === true){ ctx.reply(`Idena address : ${res_iden.data.result.address} \n Mining : sedang aktifkan... tunggu 1-5 menit`,
                                                {'reply_to_message_id':ctx.message.message_id})
                                                }else {ctx.reply(`Idena address : ${res_iden.data.result.address} \n Mining : OFF`,
                                                {'reply_to_message_id':ctx.message.message_id});}
                                        }else {ctx.reply('node sync...\n block saat ini '+ res_sync.data.result.currentBlock +'\n block yang harus di peroleh '+ res_sync.data.result.highestBlock +' ',
                                        {'reply_to_message_id':ctx.message.message_id});}
                        }
                makePostRequest();
                }
        }
		ctx.reply('jika data tidak muncul kemungkinan off \n nyalakan terlebih dahulu menggunakan command \n /startall')
        processLineByLine();
		} else {
			console.log('The file does not exist.');
            ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko urung pernah pasang node neng kene > *'+ bot_name +'*',
		{'reply_to_message_id':ctx.message.message_id})}
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//miningalloff
bot.command('miningalloff', (ctx) =>{
console.log(ctx.from.username);
	if(fs.existsSync('/home/user.txt')) {
	console.log("The file exists.");
	fs.readFile('/home/user.txt', function (err, data) {
		if (err) throw err;
		if(data.includes(ctx.from.username)){
			console.log(data)
			ctx.replyWithMarkdown('ok @*'+ ctx.from.username +'* lagi di pateni neng bot kie > *'+ bot_name +'*',
			{'reply_to_message_id':ctx.message.message_id})

        async function processLineByLine() {
                const fileStream = fs.createReadStream('/home/user.txt');
                const r1 = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
                });

                for await(const line of r1) {
					bcn_syncing = {"method":"bcn_syncing","params":[],"id":1,"key":`${line}`}
					dna_offline = {"method":"dna_becomeOffline","params":[{}],"id":1,"key":`${line}`}
                    dna_identity = {"method":"dna_identity","params":[],"id":1,"key":`${line}`}
					const fileStream = fs.createReadStream('/home/'+ line +'/'+ line +'-portRpc.txt');
					const r2 = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
					});
					const freq = {} 
						for await (const line2 of r2) {
							const res_sync = await axios.post('http://localhost:'+ line2, bcn_syncing);
							const res_offl = await axios.post('http://localhost:'+ line2, dna_offline);
							const res_iden = await axios.post('http://localhost:'+ line2, dna_identity);
							if ( res_sync.data.result.syncing === false ){
							if( res_iden.data.result.online === true ){
							const lak = `${res_iden.data.result.online}`
							const pi = lak.split(' ')[0]
							freq[pi] = (freq[pi] + 1) || 1
							}else{const lak = 'kosong'}
							}
                }
				const obj = Object.entries(freq)
				const list = Object.values(freq)
				ctx.replyWithMarkdown(`ini org => @${line} \n punya : *${list}* node yang sedang di matikan \n tunggu 1-15 menit`)
        }
		}
		processLineByLine();
		} else {
			ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko ora due akses mateni mining neng bot > *'+ bot_name +'*',
			{'reply_to_message_id':ctx.message.message_id})}
	})
		} else {
			console.log('The file does not exist.');
            ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko urung pernah pasang node neng kene > *'+ bot_name +'*',
			{'reply_to_message_id':ctx.message.message_id})}
			ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})

bot.command('miningalloff'+ bot_name, (ctx) =>{
console.log(ctx.from.username);
	if(fs.existsSync('/home/user.txt')) {
	console.log("The file exists.");
	fs.readFile('/home/user.txt', function (err, data) {
		if (err) throw err;
		if(data.includes(ctx.from.username)){
			console.log(data)
			ctx.replyWithMarkdown('ok @*'+ ctx.from.username +'* lagi di pateni neng bot kie > *'+ bot_name +'*',
			{'reply_to_message_id':ctx.message.message_id})

        async function processLineByLine() {
                const fileStream = fs.createReadStream('/home/user.txt');
                const r1 = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
                });

                for await(const line of r1) {
					bcn_syncing = {"method":"bcn_syncing","params":[],"id":1,"key":`${line}`}
					dna_offline = {"method":"dna_becomeOffline","params":[{}],"id":1,"key":`${line}`}
                    dna_identity = {"method":"dna_identity","params":[],"id":1,"key":`${line}`}
					const fileStream = fs.createReadStream('/home/'+ line +'/'+ line +'-portRpc.txt');
					const r2 = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
					});
					const freq = {} 
						for await (const line2 of r2) {
							const res_sync = await axios.post('http://localhost:'+ line2, bcn_syncing);
							const res_offl = await axios.post('http://localhost:'+ line2, dna_offline);
							const res_iden = await axios.post('http://localhost:'+ line2, dna_identity);
							if ( res_sync.data.result.syncing === false ){
							if( res_iden.data.result.online === true ){
							const lak = `${res_iden.data.result.online}`
							const pi = lak.split(' ')[0]
							freq[pi] = (freq[pi] + 1) || 1
							}else{const lak = 'kosong'}
							}
                }
				const obj = Object.entries(freq)
				const list = Object.values(freq)
				ctx.replyWithMarkdown(`ini org => @${line} \n punya : *${list}* node yang sedang di matikan \n tunggu 1-15 menit`)
        }
		}
		processLineByLine();
		} else {
			ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko ora due akses mateni mining neng bot > *'+ bot_name +'*',
			{'reply_to_message_id':ctx.message.message_id})}
	})
		} else {
			console.log('The file does not exist.');
            ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko urung pernah pasang node neng kene > *'+ bot_name +'*',
			{'reply_to_message_id':ctx.message.message_id})}
			ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//miningallon
bot.command('miningallon', (ctx) =>{
console.log(ctx.from.username);
	if(fs.existsSync('/home/user.txt')) {
	console.log("The file exists.");
	fs.readFile('/home/user.txt', function (err, data) {
		if (err) throw err;
		if(data.includes(ctx.from.username)){
			console.log(data)
			ctx.replyWithMarkdown('ok @*'+ ctx.from.username +'* lagi di pateni neng bot kie > *'+ bot_name +'*',
			{'reply_to_message_id':ctx.message.message_id})

        async function processLineByLine() {
                const fileStream = fs.createReadStream('/home/user.txt');
                const r1 = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
                });

                for await(const line of r1) {
					bcn_syncing = {"method":"bcn_syncing","params":[],"id":1,"key":`${line}`}
					dna_online = {"method":"dna_becomeOnline","params":[{}],"id":1,"key":`${line}`}
                    dna_identity = {"method":"dna_identity","params":[],"id":1,"key":`${line}`}
					const fileStream = fs.createReadStream('/home/'+ line +'/'+ line +'-portRpc.txt');
					const r2 = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
					});
					const freq = {} 
						for await (const line2 of r2) {
							const res_sync = await axios.post('http://localhost:'+ line2, bcn_syncing);
							const res_onli = await axios.post('http://localhost:'+ line2, dna_online);
							const res_iden = await axios.post('http://localhost:'+ line2, dna_identity);
							if ( res_sync.data.result.syncing === false ){
							if( res_iden.data.result.online === false ){
							const lak = `${res_iden.data.result.online}`
							const pi = lak.split(' ')[0]
							freq[pi] = (freq[pi] + 1) || 1
							}else{const lak = 'kosong'}
							}
                }
				const obj = Object.entries(freq)
				const list = Object.values(freq)
				ctx.replyWithMarkdown(`ini org => @${line} \n punya : *${list}* node yang sedang di hidupkan \n tunggu 1-15 menit`)
        }
		}
		processLineByLine();
		} else {
			ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko ora due akses mateni mining neng bot > *'+ bot_name +'*',
			{'reply_to_message_id':ctx.message.message_id})}
	})
		} else {
			console.log('The file does not exist.');
            ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko urung pernah pasang node neng kene > *'+ bot_name +'*',
			{'reply_to_message_id':ctx.message.message_id})}
			ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('miningallon'+ bot_name, (ctx) =>{
console.log(ctx.from.username);
	if(fs.existsSync('/home/user.txt')) {
	console.log("The file exists.");
	fs.readFile('/home/user.txt', function (err, data) {
		if (err) throw err;
		if(data.includes(ctx.from.username)){
			console.log(data)
			ctx.replyWithMarkdown('ok @*'+ ctx.from.username +'* lagi di pateni neng bot kie > *'+ bot_name +'*',
			{'reply_to_message_id':ctx.message.message_id})

        async function processLineByLine() {
                const fileStream = fs.createReadStream('/home/user.txt');
                const r1 = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
                });

                for await(const line of r1) {
					bcn_syncing = {"method":"bcn_syncing","params":[],"id":1,"key":`${line}`}
					dna_online = {"method":"dna_becomeOnline","params":[{}],"id":1,"key":`${line}`}
                    dna_identity = {"method":"dna_identity","params":[],"id":1,"key":`${line}`}
					const fileStream = fs.createReadStream('/home/'+ line +'/'+ line +'-portRpc.txt');
					const r2 = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
					});
					const freq = {} 
						for await (const line2 of r2) {
							const res_sync = await axios.post('http://localhost:'+ line2, bcn_syncing);
							const res_onli = await axios.post('http://localhost:'+ line2, dna_online);
							const res_iden = await axios.post('http://localhost:'+ line2, dna_identity);
							if ( res_sync.data.result.syncing === false ){
							if( res_iden.data.result.online === false ){
							const lak = `${res_iden.data.result.online}`
							const pi = lak.split(' ')[0]
							freq[pi] = (freq[pi] + 1) || 1
							}else{const lak = 'kosong'}
							}
                }
				const obj = Object.entries(freq)
				const list = Object.values(freq)
				ctx.replyWithMarkdown(`ini org => @${line} \n punya : *${list}* node yang sedang di hidupkan \n tunggu 1-15 menit`)
        }
		}
		processLineByLine();
		} else {
			ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko ora due akses mateni mining neng bot > *'+ bot_name +'*',
			{'reply_to_message_id':ctx.message.message_id})}
	})
		} else {
			console.log('The file does not exist.');
            ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko urung pernah pasang node neng kene > *'+ bot_name +'*',
			{'reply_to_message_id':ctx.message.message_id})}
			ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//shutdownall
bot.command('shutdownall', (ctx) =>{
                console.log(ctx.from.username);
                exec('systemctl stop idena.target && systemctl status idena.target |grep Active', (error, stdout, stderr) => {
                if (error) {
                        ctx.reply(`error: ${error.message}`);
                }
                if (stderr) {
                        ctx.reply(`stderr: ${stderr}`);
                }
                ctx.reply(`idena status : ${stdout}`,{'reply_to_message_id':ctx.message.message_id});
                });
				ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('shutdownall'+ bot_name, (ctx) =>{
                console.log(ctx.from.username);
                exec('systemctl stop idena.target && systemctl status idena.target |grep Active', (error, stdout, stderr) => {
                if (error) {
                        ctx.reply(`error: ${error.message}`);
                }
                if (stderr) {
                        ctx.reply(`stderr: ${stderr}`);
                }
                ctx.reply(`idena status : ${stdout}`,{'reply_to_message_id':ctx.message.message_id});
                });
				ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//startall
bot.command('startall', (ctx) =>{
                console.log(ctx.from.username);
                exec('systemctl start idena.target && systemctl status idena.target |grep Active', (error, stdout, stderr) => {
                if (error) {
                        ctx.reply(`error: ${error.message}`);
                }
                if (stderr) {
                        ctx.reply(`stderr: ${stderr}`);
                }
                ctx.reply(`idena status : ${stdout}`,{'reply_to_message_id':ctx.message.message_id});
                });
				ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('startall'+ bot_name, (ctx) =>{
                console.log(ctx.from.username);
                exec('systemctl start idena.target && systemctl status idena.target |grep Active', (error, stdout, stderr) => {
                if (error) {
                        ctx.reply(`error: ${error.message}`);
                }
                if (stderr) {
                        ctx.reply(`stderr: ${stderr}`);
                }
                ctx.reply(`idena status : ${stdout}`,{'reply_to_message_id':ctx.message.message_id});
                });
				ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//update
bot.command('update', (ctx) =>{
                console.log(ctx.from.username);
                exec('idena-update', (error, stdout, stderr) => {
                if (error) {
                        ctx.reply(`error: ${error.message}`);
                }
                if (stderr) {
                        ctx.reply(`stderr: ${stderr}`);
                }
                ctx.reply(`idena status : ${stdout}`,{'reply_to_message_id':ctx.message.message_id});
                });
				ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('update'+ bot_name, (ctx) =>{
                console.log(ctx.from.username);
                exec('idena-update', (error, stdout, stderr) => {
                if (error) {
                        ctx.reply(`error: ${error.message}`);
                }
                if (stderr) {
                        ctx.reply(`stderr: ${stderr}`);
                }
                ctx.reply(`idena status : ${stdout}`,{'reply_to_message_id':ctx.message.message_id});
                });
				ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//uptime
bot.command('uptime', (ctx) =>{
                console.log(ctx.from.username);
                exec('uptime', (error, stdout, stderr) => {
                if (error) {
                        ctx.reply(`error: ${error.message}`);
                }
                if (stderr) {
                        ctx.reply(`stderr: ${stderr}`);
                }
                ctx.reply(`idena status : ${stdout}`,{'reply_to_message_id':ctx.message.message_id});
                });
				ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('uptime'+ bot_name, (ctx) =>{
                console.log(ctx.from.username);
                exec('uptime', (error, stdout, stderr) => {
                if (error) {
                        ctx.reply(`error: ${error.message}`);
                }
                if (stderr) {
                        ctx.reply(`stderr: ${stderr}`);
                }
                ctx.reply(`idena status : ${stdout}`,{'reply_to_message_id':ctx.message.message_id});
                });
				ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//uptime detail
bot.command('resource', (ctx) =>{
                console.log(ctx.from.username);
                exec('cool-uptime', (error, stdout, stderr) => {
                if (error) {
                        ctx.reply(`error: ${error.message}`);
                }
                if (stderr) {
                        ctx.reply(`stderr: ${stderr}`);
                }
                ctx.reply(`idena status : ${stdout}`,{'reply_to_message_id':ctx.message.message_id});
                });
				ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('resource'+ bot_name, (ctx) =>{
                console.log(ctx.from.username);
                exec('cool-uptime', (error, stdout, stderr) => {
                if (error) {
                        ctx.reply(`error: ${error.message}`);
                }
                if (stderr) {
                        ctx.reply(`stderr: ${stderr}`);
                }
                ctx.reply(`idena status : ${stdout}`,{'reply_to_message_id':ctx.message.message_id});
                });
				ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//speedtest
bot.command('speedtest', (ctx) =>{
                console.log(ctx.from.username);
                exec('speedtest --progress=no', (error, stdout, stderr) => {
                if (error) {
                        ctx.reply(`error: ${error.message}`);
                }
                if (stderr) {
                        ctx.reply(`stderr: ${stderr}`);
                }
                ctx.reply(`idena status : ${stdout}`,{'reply_to_message_id':ctx.message.message_id});
                });
				ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('speedtest'+ bot_name, (ctx) =>{
                console.log(ctx.from.username);
                exec('speedtest --progress=no', (error, stdout, stderr) => {
                if (error) {
                        ctx.reply(`error: ${error.message}`);
                }
                if (stderr) {
                        ctx.reply(`stderr: ${stderr}`);
                }
                ctx.reply(`idena status : ${stdout}`,{'reply_to_message_id':ctx.message.message_id});
                });
				ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//list WhoHaveInvite
bot.command('listic', (ctx) =>{
console.log(ctx.from.username);
	if(fs.existsSync('/home/user.txt')) {
	console.log("The file exists.");
        async function processLineByLine() {
                const fileStream = fs.createReadStream('/home/user.txt');
                const r1 = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
                });

                for await(const line of r1) {
					bcn_syncing = {"method":"bcn_syncing","params":[],"id":1,"key":`${line}`}
                    dna_identity = {"method":"dna_identity","params":[],"id":1,"key":`${line}`}
					const fileStream = fs.createReadStream('/home/'+ line +'/'+ line +'-portRpc.txt');
					const r2 = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
					});
					const freq = {} 
						for await (const line2 of r2) {
							const res_sync = await axios.post('http://localhost:'+ line2, bcn_syncing);
							const res_iden = await axios.post('http://localhost:'+ line2, dna_identity);
							if ( res_sync.data.result.syncing === false ){
							if( res_iden.data.result.invites != '0'){
							const lak = `ada ${res_iden.data.result.invites}`
							const pi = lak.split(' ')[0]
							freq[pi] = (freq[pi] + 1) || 1
							}else{const lak = 'kosong'}
							}
                }
				const obj = Object.entries(freq)
				const list = Object.values(freq)
				ctx.replyWithMarkdown(`ini org => @${line} \n punya : *${list}* node yang bisa produksi IC \n langsung PM ae`)
        }
		}
		processLineByLine();
		} else {
			console.log('The file does not exist.');
            ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko urung pernah pasang node neng kene > *'+ bot_name +'*',
			{'reply_to_message_id':ctx.message.message_id})}
			ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('listic'+ bot_name, (ctx) =>{
console.log(ctx.from.username);
	if(fs.existsSync('/home/user.txt')) {
	console.log("The file exists.");
        async function processLineByLine() {
                const fileStream = fs.createReadStream('/home/user.txt');
                const r1 = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
                });

                for await(const line of r1) {
					bcn_syncing = {"method":"bcn_syncing","params":[],"id":1,"key":`${line}`}
                    dna_identity = {"method":"dna_identity","params":[],"id":1,"key":`${line}`}
					const fileStream = fs.createReadStream('/home/'+ line +'/'+ line +'-portRpc.txt');
					const r2 = readline.createInterface({
                        input: fileStream,
                        crlfDelay: Infinity
					});
					const freq = {} 
						for await (const line2 of r2) {
							const res_sync = await axios.post('http://localhost:'+ line2, bcn_syncing);
							const res_iden = await axios.post('http://localhost:'+ line2, dna_identity);
							if ( res_sync.data.result.syncing === false ){
							if( res_iden.data.result.invites != '0'){
							const lak = `ada ${res_iden.data.result.invites}`
							const pi = lak.split(' ')[0]
							freq[pi] = (freq[pi] + 1) || 1
							}else{const lak = 'kosong'}
							}
                }
				const obj = Object.entries(freq)
				const list = Object.values(freq)
				ctx.replyWithMarkdown(`ini org => @${line} \n punya : *${list}* node yang bisa produksi IC \n langsung PM ae`)
        }
		}
		processLineByLine();
		} else {
			console.log('The file does not exist.');
            ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* ko urung pernah pasang node neng kene > *'+ bot_name +'*',
			{'reply_to_message_id':ctx.message.message_id})}
			ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
//add notif mining/node down
bot.command('addnotif', (ctx) =>{
console.log(ctx.from.username);
if (ctx.chat.type == 'private') {
                ctx.replyWithHTML(
                        '<i>oi bro</i> @<b>'+ ctx.from.username +'</b> \n masukan address mu ben nko di proses',
                        {'reply_to_message_id':ctx.message.message_id})
                bot.on('text', (ctx) => {
                        ctx.reply('ok lagi di prosess sekitar 1-15 menitan ngasi syncron\n\n');
						exec('addnotX '+ ctx.from.username +' '+ ctx.from.id +' '+ ctx.message.text +'', (error, stdout, stderr) => {
                                        if (error) {
                                        console.log(`error: ${error.message}`);
                                        }
                                        if (stderr) {
                                        console.log(`stderr: ${stderr}`);
                                        }
                                        ctx.reply(`proses install...`);
                                        console.log(`${stdout}`);
        console.log('user '+ ctx.from.username +'chatid'+ ctx.from.id +'pesan-'+ ctx.message.text +'')
                        });
                });
        }else{
                ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* nek neng grup ra bisa \n langsung PM bot kie ae > *'+ bot_name +'*',
                {'reply_to_message_id':ctx.message.message_id})
        }
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('addnotif'+ bot_name, (ctx) =>{
        console.log(ctx.from.username);
        ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* nek neng grup ra bisa \n langsung PM bot kie ae > *'+ bot_name +'*',
        {'reply_to_message_id':ctx.message.message_id})
		ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)
})
//toturial web
bot.command('toturialweb', (ctx) =>{
console.log(ctx.from.username);
            ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* \n langsung gas gan pake video ini \n https://youtu.be/sQ-xLDZc4JI',
			{'reply_to_message_id':ctx.message.message_id})
			ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.command('toturialweb'+ bot_name, (ctx) =>{
console.log(ctx.from.username);
            ctx.replyWithMarkdown('oi @*'+ ctx.from.username +'* \n langsung gas gan pake video ini \n https://youtu.be/sQ-xLDZc4JI',
			{'reply_to_message_id':ctx.message.message_id})
			ctx.replyWithHTML(`donate iDna : <code> 0x4783e0841d72a8cbf49312d98a49a93f512b6d99 </code>`)

})
bot.startPolling()