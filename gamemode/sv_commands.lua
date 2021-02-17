if CLIENT then return end

util.AddNetworkString("Horde_ForceCloseShop")
util.AddNetworkString("Horde_ToggleShop")
util.AddNetworkString("Horde_ToggleItemConfig")
util.AddNetworkString("Horde_ToggleEnemyConfig")
util.AddNetworkString("Horde_RenderCenterText")

function BroadcastMessage(msg, delay)
    for _, ply in pairs(player.GetAll()) do
        net.Start("Horde_RenderCenterText")
        net.WriteString(msg)
        net.WriteInt(delay,16)
        net.Send(ply)
    end
end

hook.Add("PlayerSay", "Horde_Commands", function(ply, text, public)
    text = string.lower(text) -- Make the chat message entirely lowercase
    if text == "!help" then
        ply:PrintMessage(HUD_PRINTTALK, "'!ready' - Get ready")
        ply:PrintMessage(HUD_PRINTTALK, "'!start' - Start the game (Admin only)")
        ply:PrintMessage(HUD_PRINTTALK, "'!end' - End the game (Admin only)")
    
    elseif text == "!start" then
        if ply:IsAdmin() then
            if not HORDE.start_game then
                HORDE.start_game = true
                BroadcastMessage("Horde gamemode initiated!")
            else
                ply:PrintMessage(HUD_PRINTTALK, "Game has already started!")
            end
        else
            net.Start("Horde_LegacyNotification")
            net.WriteString("You do not have access to this command.")
            net.WriteInt(1,2)
            net.Send(ply)
            return
        end

    elseif text == "!ready" then
        if not ply:Alive() then
            net.Start("Horde_LegacyNotification")
            net.WriteString("You can't get ready when you are dead!")
            net.WriteInt(1,2)
            net.Send(ply)
            return
        end
        if HORDE.start_game then return end
        HORDE.player_ready[ply:SteamID()] = true
        local ready_count = 0
        local total_player = 0
        for _, ply in pairs(player.GetAll()) do
            if HORDE.player_ready[ply:SteamID()] then
                ready_count = ready_count + 1
            end
            total_player = total_player + 1
        end
       
        if total_player == ready_count then
            HORDE.start_game = true
        end
        BroadcastMessage("Players Ready: " .. tostring(ready_count) .. "/" .. tostring(total_player))
    
    elseif text == "!end" then
        if not ply:IsAdmin() then
            net.Start("Horde_LegacyNotification")
            net.WriteString("You do not have access to this command.")
            net.WriteInt(1,2)
            net.Send(ply)
            return
        end
        HORDE.start_game = false
        HORDE.player_ready = {}
        ply:PrintMessage(HUD_PRINTTALK, "Stopping game...")

    elseif text == "!shop" then
        if not HORDE.enable_shop then
            net.Start("Horde_LegacyNotification")
            net.WriteString("Shop has been disabled.")
            net.WriteInt(1,2)
            net.Send(ply)
        end
        if not ply:Alive() then
            net.Start("Horde_LegacyNotification")
            net.WriteString("You can't buy when you are dead!")
            net.WriteInt(1,2)
            net.Send(ply)
            return
        end
        if HORDE.current_break_time <= 0 then
            net.Start("Horde_LegacyNotification")
            net.WriteString("You cannot shop after a wave has started.")
            net.WriteInt(1,2)
            net.Send(ply)
            return
        end
        net.Start("Horde_ToggleShop")
        net.Send(ply)
    elseif text == "!itemconfig" then
        if HORDE.start_game then
            net.Start("Horde_LegacyNotification")
            net.WriteString("You cannot open config after a wave has started.")
            net.WriteInt(1,2)
            net.Send(ply)
            return
        end
        if ply:IsSuperAdmin() then
            net.Start("Horde_ToggleItemConfig")
            net.Send(ply)
        else
            net.Start("Horde_LegacyNotification")
            net.WriteString("You do not have access to this command.")
            net.WriteInt(1,2)
            net.Send(ply)
        end
    elseif text == "!enemyconfig" then
        if HORDE.start_game then
            net.Start("Horde_LegacyNotification")
            net.WriteString("You cannot open config after a wave has started.")
            net.WriteInt(1,2)
            net.Send(ply)
            return
        end
        if ply:IsSuperAdmin() then
            net.Start("Horde_ToggleEnemyConfig")
            net.Send(ply)
        else
            net.Start("Horde_LegacyNotification")
            net.WriteString("You do not have access to this command.")
            net.WriteInt(1,2)
            net.Send(ply)
        end
    end
    return ""
end)

hook.Add("PlayerInitialSpawn", "Horde_SpawnMessage", function(ply)
    ply:PrintMessage(HUD_PRINTTALK, "Use '!help' to see special commands!")
    local ready_count = 0
    local total_player = 0
    for _, ply in pairs(player.GetAll()) do
        if HORDE.player_ready[ply:SteamID()] then
            ready_count = ready_count + 1
        end
        total_player = total_player + 1
    end
    
    if total_player == ready_count then
        HORDE.start_game = true
    end
    BroadcastMessage("Players Ready: " .. tostring(ready_count) .. "/" .. tostring(total_player))
end)