local discordia = require("discordia")
local json = require("json")
local coro = require("coro-http")
local client = discordia.Client()


discordia.extensions()


client:on('ready', function()
	print('Logged in as '.. client.user.username)
	client:getChannel("814800325645959169"):send("https://cdn.discordapp.com/attachments/814800325645959169/827210728456192040/PP.gif")
	client:getChannel("814800325645959169"):send("I'm here!")
end)



function rickrolled(message)
    message.channel:send("https://33.media.tumblr.com/2066c0aa69cca23b70b333f52cd4ac0c/tumblr_inline_nnbkq0IY5G1s3vxgv_500.gif")
    message.channel:send("rickrolled !")
end

function ChuckNorris(message)
	coroutine.wrap(function()
		local link = "https://api.chucknorris.io/jokes/random"
		local result, body = coro.request("GET", link)
		body = json.parse(body)
		message:reply("<@!"..message.member.id.."> "..body["value"])
	end)()
end	



client:on('messageCreate', function(message)
    local content = message.content
	local msg = content:split(" ")
	
	local bot = client.user
    local author = message.author

	local a = json.parse(io.open("./speaknb.json"):read())

	if msg[1] == "vous" and msg[2] == "allez" and msg[3] == "bien" and msg[4] == "?" or msg[3] == "bien?" then
		message.channel:send("super et vous ?")
	end


    if msg[1] == 'Hey' or  msg[1] == 'hey' or msg[1] == 'Yo' then
        message.channel:send("lut' ")
    end

    if msg[1] == 'comment' and msg[2] == 'va' or msg[2] == 'va?'then

		if a["value"] == 0 then

			message.channel:send('bien et toi?')

			local a = json.stringify(1) 
			message.channel:send(a)
		end
		
		if a["value"] == 1 then

			message.channel:send('super!')

			local a = json.stringify(2)
		end
		
		if a["value"] == 2 then 

			message.channel:send('https://tenor.com/view/je-vais-bien-gif-12277950')	

			local a = json.stringify(0) 
		end

	end

	if msg[1] == "tu" and msg[2] == "fait" and msg[3] == "quoi" and msg[4] == "?" or msg[3] == "quoi?" then
			message.channel:send("je suis a vos ordre UwU")
	end
    
    if msg[1]:lower() == '!help' then
        rickrolled(message)
    end

	if msg[1]:lower() == '#norris' then
		ChuckNorris(message)
	end	


    
	if msg[1] == "#infobot" or content == "qui est tu?" then
		
		local count = json.parse(io.open("./COUNT.json"):read())
		--local write2 = json.stringify(io.open("./COUNT.json"):write(count[message.author.id].value + 1)) 
		
		message:reply {
			embed = {
				title = "InfoBot",
				description = "Ceci est la description du bot",
				author = {
					name = bot.username,
					icon_url = bot.avatarURL
				},
				fields = { -- array of fields
					{
						name = "Origine:",
						value = "Bot créé en 2021 par Antte1905, à l'aide de Discordia et de VS code",
						inline = true
					},
					{
						name = "Fonction:",
						value = "Ce bot sert à enrichir les discutions, vos vocaux et à administrer le serveur",
						inline = false
					}
				},
				footer = {
					text = "claim by : "..message.author.username.." for the "--..count[message.member.id].value.. " time"
				},
				color = 0xcb0000 -- hex color code
			}
		}
	end


end)




client:run("Bot "..io.open("./login.txt"):read())

