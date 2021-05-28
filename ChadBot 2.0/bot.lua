
--[[
    Made by Shadi432 :)
]]--

local discordia = require("discordia")
local client = discordia.Client()
local token = "NzM0ODUzMTY3Njc3ODMzMjY3.XxXvWA.BgMAgQw06ybGVWr5CUDbqFh-Dpg"

-- Do not change above this line

-- Underscore
local US_References = {"US", "USA", "America", "Freedom", "Eagle", "Q","Texas","South","Alabama", "Bama","Free","Trump","Wall","Antifa","Antifer"}
local Version = 0.45

local versFile = io.open("version.txt","r")
io.input(versFile)
    
if versFile then -- For allowing a version update to be posted to connected servers by just changing the Version constant above.
    local lastVers = io.read():sub(10)
    io.close()
    
    if tonumber(lastVers) < Version then
        local updateVers = io.open("version.txt","w")
        io.output(updateVers)
        io.write("Version: " .. Version)
        io.close()
        
        client:on("guildAvailable", function(guild) -- Will allow it to send to every guild chadbot is connected to.
            guild.systemChannel:send("I have been updated to Version: " .. Version) 
        end)
    end
else
    local newFile = io.open("version.txt","w") 
    io.output(newFile)
    io.write("Version: " .. Version)
    io.close()
end
    

local function getEmojiId(guild, emojiName) -- guild that the message was sent from, emojiName with right capitalisation and no colons e.g. KKonaW not kkonaw or :KKonaW:
    return(
        guild.emojis:find( function(emoji)
        if emoji.name == emojiName then
            return emoji
        end
    end)) -- Returns a table with details of the emoji such as guild sent in and the emoji Name and Id 4 is the index for emoji Id. Returns nil if emoji not in guild
end

local function splitString(str,sep) -- Split the string into individual words based on a defined separator, ignore punctuation. Useful because you don't want to pattern match several characters that can mean a lot on their own  or be used within other words
    local fields = {}
    str:gsub("([^%p" .. sep .. "]+)", function(c)
        table.insert(fields,c)
    end)
    
    return fields
end




client:on("ready", function()
    splitString("Hello, world!! Test!!"," ")
    

end)




client:on("messageCreate", function(message)
    local messageUnits = splitString(message.content," ")
    
    if message.content:match("United States") then
        message.channel:send("<:KKonaW:" .. getEmojiId(message.guild,"KKonaW")[4] .. ">")
    elseif message.content:lower():match("research q") then
        message.channel:send("https://media.giphy.com/media/pWeLDLEd0PmlXqtSyQ/giphy.gif")
    elseif message.content:lower():match("ddd") or message.content:lower():match("dedede") then
        message:delete()
    elseif message.content == "https://tenor.com/view/eh-hey-marmot-squirrel-calling-out-gif-16861592" then
        message.channel:send{
            content = "....",
            file = "images/FeelsWeirdMan.jpg"
        }
    elseif message.content == "!shutdown" and message.author.tag == "Shadi432#1826" then
        client:stop()
    else
        for messageNum,messageContent in pairs(messageUnits) do
            if messageContent == "Q" or messageContent:upper() == "QANON"then
                local emoji = getEmojiId(message.guild,"OOOOO")
                if emoji then
                    for i=1, 5 do
                        message.channel:send("<:OOOOO:" .. emoji[4] .. ">")
                    end
                    break
                else
                    break
                end
            end
            
            for index, usRef in pairs(US_References) do
                if messageContent == usRef then
                    message.channel:send("<:KKonaW:" .. getEmojiId(message.guild,"KKonaW")[4] .. ">")
                end
            end
        end
    end
    
    --[[
    for index,usRef in pairs (usReferences) do
        
        if message.content:match(usRef) and (message.content == "Q" or message.content == "Q Anon") then
            
        elseif message.content:match(usRef) then
            
        end
    end
    ]]--
end)

client:run("Bot " .. token)
