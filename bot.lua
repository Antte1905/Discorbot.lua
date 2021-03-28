local discordia = require("discordia")
local json = require("json")
local coro = require("coro-http")
local client = discordia.Client()

discordia.extensions()


client:on('ready', function()
	print('Logged in as '.. client.user.username)
    
    client:getChannel("825625097258926140"):send("start")
         
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
    local msg = message.content:split(" ")
	
	local bot = client.user
    local author = message.author


    if msg[1] == 'Hey' or  msg[1] == 'hey' or msg[1] == 'Yo' then
        message.channel:send("lut' ")
    end

    if msg[1] == 'comment' and msg[2] == 'va' or msg[2] == 'va?'then
        message.channel:send('bien et toi?')

    end

    
    if msg[1]:lower() == 'help' then
        rickrolled(message)
    end

	if msg[1]:lower() == '/norris' then
		ChuckNorris(message)
	end	


    
	if msg[1] == "/infobot" then
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
						value = "Bot créer en 2021 par Antte1905, a l'aide de discordia et de vs code",
						inline = true
					},
					{
						name = "Fonction:",
						value = "Ce bot sert a enrichir les discution, vos vocaux et à administrer le serveur",
						inline = false
					}
				},
				footer = {
					text = "claim by : "..message.author.username
				},
				color = 0xcb0000 -- hex color code
			}
		}
	end

    if msg[1] == "/infome" then
		message:reply {
			embed = {
				title = "InfoUser",
				description = "Ceci sont vos info",
				author = {
					name = author.username,
					icon_url = author.avatarURL
				},
				fields = { -- array of fields
					{
						name = "Id",
						value = message.author.id,
						inline = true
					},
					{
						name = "Foncti",
						value = "Ce bot sert a enrichir les discution, vos vocaux et à administrer le serveur",
						inline = false
					}
				},
				footer = {
					text = "claim by : "..message.author.username
				},
				color = 0x3d9717 -- hex color code
			}
		}
	end
end)




client:run("Bot "..io.open("./login.txt"):read())

