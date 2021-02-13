if CLIENT then return end

hook.Add("PlayerSay", "Horde_!help", function(ply, text, public)
	text = string.lower(text) -- Make the chat message entirely lowercase
	if text == "!help" then
		ply:PrintMessage(HUD_PRINTTALK, "'!start' - Start the game")
        ply:PrintMessage(HUD_PRINTTALK, "'!end' - End the game")
		return ""
	end
end)

hook.Add("PlayerSay", "Horde_!start", function(ply, text, public)
	text = string.lower(text) -- Make the chat message entirely lowercase
	if text == "!start" then
        if not _G.start_game then
            _G.start_game = true
            ply:PrintMessage(HUD_PRINTTALK, "Horde gamemode initiated!")
        else
            ply:PrintMessage(HUD_PRINTTALK, "Game has already started!")
        end
		return ""
	end
end)

hook.Add("PlayerSay", "Horde_!end", function(ply, text, public)
	text = string.lower(text) -- Make the chat message entirely lowercase
	if text == "!end" then
        _G.start_game = false
        ply:PrintMessage(HUD_PRINTTALK, "Stopping game...")
		return ""
	end
end)

hook.Add("PlayerInitialSpawn", "Horde_SpawnMessage", function(ply)
	ply:PrintMessage(HUD_PRINTTALK, "Use '!help' to see special commands!")
end)