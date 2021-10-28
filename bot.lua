local discordia = require("discordia")
local json = require("json")
local coro = require("coro-http")
local client = discordia.Client()
local key = "!"

discordia.extensions()


client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
	local content = message.content
	local args = content:split(" ") -- split all arguments into a table

	if args[1] == key then
		if args[2] == "roll" then 
			message:reply(math.random(args[3]))
		end
	end

	
	
end)

client:run("Bot "..io.open("./login.txt"):read())