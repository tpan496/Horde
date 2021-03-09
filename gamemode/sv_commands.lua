util.AddNetworkString("Horde_ForceCloseShop")
util.AddNetworkString("Horde_ToggleShop")
util.AddNetworkString("Horde_ToggleConfigMenu")
util.AddNetworkString("Horde_ToggleItemConfig")
util.AddNetworkString("Horde_ToggleEnemyConfig")
util.AddNetworkString("Horde_ToggleClassConfig")
util.AddNetworkString("Horde_RenderCenterText")
util.AddNetworkString("Horde_Console_Commands")


function BroadcastMessage(msg, delay)
    for _, ply in pairs(player.GetAll()) do
        net.Start("Horde_RenderCenterText")
        net.WriteString(msg)
        if delay then
            net.WriteInt(delay,16)
        else
            net.WriteInt(0,16)
        end
        net.Send(ply)
    end
end

function Start(ply)
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
end

function Ready(ply)
    if HORDE.current_wave > 0 then return end
    if not ply:Alive() then
        net.Start("Horde_LegacyNotification")
        net.WriteString("You can't get ready when you are dead!")
        net.WriteInt(1,2)
        net.Send(ply)
        return
    end
    
    HORDE.player_ready[ply] = 1
    local ready_count = 0
    local total_player = 0
    for _, ready_ply in pairs(player.GetAll()) do
        if HORDE.player_ready[ready_ply] == 1 then
            ready_count = ready_count + 1
        end
        total_player = total_player + 1
    end
    
    if ready_count >= total_player then
        HORDE.start_game = true
        HORDE.current_break_time = math.min(HORDE.current_break_time, 10)
    elseif ready_count >= HORDE.Round2(total_player * GetConVar("horde_ready_countdown_percentage"):GetFloat()) then
        HORDE.start_game = true
        HORDE.current_break_time = math.min(HORDE.current_break_time, HORDE.total_break_time)
    end

    net.Start("Horde_PlayerReadySync")
    net.WriteTable(HORDE.player_ready)
    net.Broadcast()

    if HORDE.start_game and HORDE.current_wave > 0 then return end
    BroadcastMessage("Players Ready: " .. tostring(ready_count) .. "/" .. tostring(total_player))
end

function End(ply)
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
end

function Shop(ply)
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
end

function ItemConfig(ply)
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
end

function EnemyConfig(ply)
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

function ClassConfig(ply)
    if HORDE.start_game then
        net.Start("Horde_LegacyNotification")
        net.WriteString("You cannot open config after a wave has started.")
        net.WriteInt(1,2)
        net.Send(ply)
        return
    end
    if ply:IsSuperAdmin() then
        net.Start("Horde_ToggleClassConfig")
        net.Send(ply)
    else
        net.Start("Horde_LegacyNotification")
        net.WriteString("You do not have access to this command.")
        net.WriteInt(1,2)
        net.Send(ply)
    end
end

function ConfigMenu(ply)
    if HORDE.start_game then
        net.Start("Horde_LegacyNotification")
        net.WriteString("You cannot open config after a wave has started.")
        net.WriteInt(1,2)
        net.Send(ply)
        return
    end
    if ply:IsSuperAdmin() then
        net.Start("Horde_ToggleConfigMenu")
        net.Send(ply)
    else
        net.Start("Horde_LegacyNotification")
        net.WriteString("You do not have access to this command.")
        net.WriteInt(1,2)
        net.Send(ply)
    end
end

hook.Add("PlayerSay", "Horde_Commands", function(ply, input, public)
    if not ply:IsValid() then return end
    local text = string.lower(input) -- Make the chat message entirely lowercase
    if text == "!help" then
        ply:PrintMessage(HUD_PRINTTALK, "'!ready' - Get ready")
        ply:PrintMessage(HUD_PRINTTALK, "'!shop' - Open shop")
        ply:PrintMessage(HUD_PRINTTALK, "'!drop' - Drop weapon")
        ply:PrintMessage(HUD_PRINTTALK, "'!throwmoney' - Drop 50$")
        ply:PrintMessage(HUD_PRINTTALK, "'!rtv' -Initiate a map change vote")
    elseif text == "!start" then
        Start(ply)
    elseif text == "!ready" then
        Ready(ply)
    elseif text == "!end" then
        End(ply)
    elseif text == "!shop" then
        Shop(ply)
    elseif text == "!itemconfig" then
        ItemConfig(ply)
    elseif text == "!enemyconfig" then
        EnemyConfig(ply)
    elseif text == "!classconfig" then
        ClassConfig(ply)
    elseif text == "!drop" then
        ply:DropWeapon()
    elseif text == "!throwmoney" then
        ply:DropHordeMoney()
    elseif text == "!rtv" then
        HORDE.VoteChangeMap(ply)
    end
end)

-- Console variants
concommand.Add("horde_start", function (ply, cmd, args)
    Start(ply)
end)

concommand.Add("horde_ready", function (ply, cmd, args)
    Ready(ply)
end)

concommand.Add("horde_end", function (ply, cmd, args)
    End(ply)
end)

concommand.Add("horde_shop", function (ply, cmd, args)
    Shop(ply)
end)

concommand.Add("horde_item_config", function (ply, cmd, args)
    ItemConfig(ply)
end)

concommand.Add("horde_enemy_config", function (ply, cmd, args)
    EnemyConfig(ply)
end)

concommand.Add("horde_class_config", function (ply, cmd, args)
    ClassConfig(ply)
end)