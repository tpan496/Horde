util.AddNetworkString("Horde_ForceCloseShop")
util.AddNetworkString("Horde_ToggleShop")
util.AddNetworkString("Horde_ToggleStats")
util.AddNetworkString("Horde_ToggleConfigMenu")
util.AddNetworkString("Horde_ToggleItemConfig")
util.AddNetworkString("Horde_ToggleEnemyConfig")
util.AddNetworkString("Horde_ToggleClassConfig")
util.AddNetworkString("Horde_ToggleMapConfig")
util.AddNetworkString("Horde_RenderCenterText")
util.AddNetworkString("Horde_RenderPlayersReady")
util.AddNetworkString("Horde_RenderBreakCountDown")
util.AddNetworkString("Horde_RenderEnemiesCount")
util.AddNetworkString("Horde_RenderObjectives")
util.AddNetworkString("Horde_RenderGameResult")
util.AddNetworkString("Horde_Console_Commands")
util.AddNetworkString("Horde_Disable_Levels")

function HORDE:BroadcastPlayersReadyMessage(str)
    net.Start("Horde_RenderPlayersReady")
        net.WriteString(str)
    net.Broadcast()
end

function HORDE:BroadcastBreakCountDownMessage(wave, is_end_message)
    net.Start("Horde_RenderBreakCountDown")
        net.WriteInt(wave,8)
        net.WriteBool(is_end_message)
    net.Broadcast()
end

function HORDE:BroadcastEnemiesCountMessage(is_boss, wave_str, count)
    net.Start("Horde_RenderEnemiesCount")
        net.WriteBool(is_boss)
        net.WriteString(wave_str)
        net.WriteInt(count, 32)
    net.Broadcast()
end

function HORDE:BroadcastGameResultMessage(status, wave)
    net.Start("Horde_RenderGameResult")
        net.WriteString(status)
        net.WriteUInt(wave, 32)
    net.Broadcast()
end

function Start(ply)
    if ply:IsAdmin() then
        if not HORDE.start_game then
            HORDE.start_game = true
        else
            ply:PrintMessage(HUD_PRINTTALK, "Game has already started!")
        end
    else
        HORDE:SendNotificationDenyAccess(ply)
        return
    end
end

function Ready(ply)
    if HORDE.current_wave > 0 then return end
    if not ply:Alive() then
        HORDE:SendNotification("You can't get ready when you are dead!", 1, ply)
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
    elseif ready_count >= HORDE:Round2(total_player * GetConVar("horde_ready_countdown_ratio"):GetFloat()) then
        HORDE.start_game = true
        HORDE.current_break_time = math.min(HORDE.current_break_time, HORDE.total_break_time)
    end

    net.Start("Horde_PlayerReadySync")
    net.WriteTable(HORDE.player_ready)
    net.Broadcast()

    if HORDE.start_game and HORDE.current_wave > 0 then return end
    HORDE:BroadcastPlayersReadyMessage(tostring(ready_count) .. "/" .. tostring(total_player))
end

function End(ply)
    if not ply:IsAdmin() then
        HORDE:SendNotificationDenyAccess(ply)
        return
    end
    HORDE.start_game = false
    HORDE.player_ready = {}
    ply:PrintMessage(HUD_PRINTTALK, "Stopping game...")
end

function Shop(ply)
    if GetConVar("horde_enable_shop"):GetInt() == 0 then
        HORDE:SendNotification("Shop has been disabled.", 1, ply)
    end

    if ply:Alive() then
        local res = hook.Run("Horde_OnPlayerOpenShop", ply)
        if res ~= true then
            if HORDE.has_buy_zone and (not ply:Horde_GetInBuyZone()) then
                return
            end
    
            if HORDE.current_break_time <= 0 then
                HORDE:SendNotification("You cannot shop after a wave has started.", 1, ply)
                return
            end
        end
    end
    ply:Horde_RecalcWeight()
    net.Start("Horde_ToggleShop")
    net.Send(ply)
end

function ItemConfig(ply)
    if HORDE.start_game then
        HORDE:SendNotification("You cannot open config after a game has started.", 1, ply)
        return
    end
    if ply:IsSuperAdmin() then
        net.Start("Horde_ToggleItemConfig")
        net.Send(ply)
    else
        HORDE:SendNotificationDenyAccess(ply)
    end
end

function EnemyConfig(ply)
    if HORDE.start_game then
        HORDE:SendNotification("You cannot open config after a game has started.", 1, ply)
        return
    end
    if ply:IsSuperAdmin() then
        HORDE:SyncEnemiesTo(ply)
        HORDE:SyncMutationsTo(ply)
        net.Start("Horde_ToggleEnemyConfig")
        net.Send(ply)
    else
        nHORDE:SendNotificationDenyAccess(ply)
    end
end

function ClassConfig(ply)
    if HORDE.start_game then
        HORDE:SendNotification("You cannot open config after a game has started.", 1, ply)
        return
    end
    if ply:IsSuperAdmin() then
        net.Start("Horde_ToggleClassConfig")
        net.Send(ply)
    else
        HORDE:SendNotificationDenyAccess(ply)
    end
end

function MapConfig(ply)
    if HORDE.start_game then
        HORDE:SendNotification("You cannot open config after a game has started.", 1, ply)
        return
    end
    if ply:IsSuperAdmin() then
        HORDE:SyncMapsTo(ply)
        net.Start("Horde_ToggleMapConfig")
        net.Send(ply)
    else
        HORDE:SendNotificationDenyAccess(ply)
    end
end

function ConfigMenu(ply)
    if not ply:IsSuperAdmin() then
        StatsMenu(ply)
        return
    end

    net.Start("Horde_ToggleConfigMenu")
    net.Send(ply)
end

function StatsMenu(ply)
    net.Start("Horde_ToggleStats")
    net.Send(ply)
end

hook.Add("PlayerSay", "Horde_Commands", function(ply, input, public)
    if not ply:IsValid() then return end
    local text = {}
	
    for str in string.gmatch(string.lower(input), "([^".."%s".."]+)") do -- splits and lowercases the input string
       table.insert(text, str)
    end
	
    if text[1] == "!help" then
        ply:PrintMessage(HUD_PRINTTALK, "'!ready' - Get ready")
        ply:PrintMessage(HUD_PRINTTALK, "'!shop' - Open shop")
        ply:PrintMessage(HUD_PRINTTALK, "'!drop' - Drop weapon")
        ply:PrintMessage(HUD_PRINTTALK, "'!throwmoney <amount>' - Drop money")
        ply:PrintMessage(HUD_PRINTTALK, "'!rtv' -Initiate a map change vote")
    elseif text[1] == "!start" then
        Start(ply)
    elseif text[1] == "!ready" then
        Ready(ply)
    elseif text[1] == "!end" then
        End(ply)
    elseif text[1] == "!shop" then
        Shop(ply)
    elseif text[1] == "!itemconfig" then
        ItemConfig(ply)
    elseif text[1] == "!enemyconfig" then
        EnemyConfig(ply)
    elseif text[1] == "!classconfig" then
        ClassConfig(ply)
    elseif text[1] == "!mapconfig" then
        MapConfig(ply)
    elseif text[1] == "!drop" then
        if ply:GetActiveWeapon() and ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon().Base == "horde_spell_weapon_base" then
            return
        end
        ply:DropWeapon()
    elseif text[1] == "!throwmoney" then
        ply:Horde_DropMoney(text[2])
    elseif text[1] == "!rtv" then
        HORDE.VoteChangeMap(ply)
    elseif text[1] == "!stats" then
        StatsMenu(ply)
    --[[elseif text == "!sync_to_local" then
        HORDE:SyncToLocal(ply)
    elseif text == "!sync_to_server" then
        HORDE:SyncToServer(ply)]]--
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

concommand.Add("horde_map_config", function (ply, cmd, args)
    MapConfig(ply)
end)

concommand.Add("horde_stats", function (ply, cmd, args)
    StatsMenu(ply)
end)

concommand.Add("horde_testing_gorlami", function (ply, cmd, args)
    if GetConVar("horde_enable_sandbox"):GetInt() == 0 then
        HORDE:SendNotificationSandboxOnly(ply)
        return
    end
    if ply:IsAdmin() then
        RunConsoleCommand("horde_testing_free_perks", 0)
        local amount = 500
        ply:Horde_AddSkullTokens(amount)
        ply:Horde_SyncEconomy()
        RunConsoleCommand("horde_testing_disable_level_restrictions")
    end
end)

concommand.Add("horde_testing_give_money", function (ply, cmd, args)
    if GetConVar("horde_enable_sandbox"):GetInt() == 0 then
        HORDE:SendNotificationSandboxOnly(ply)
        return
    end

	local amount = math.floor(tonumber(args[1]))

    if (ply:Horde_GetMoney() + amount) < 0 then
        ply:Horde_AddMoney(-(ply:Horde_GetMoney()))
        ply:Horde_SyncEconomy()
        return
    end

    ply:Horde_AddMoney(amount)
    ply:Horde_SyncEconomy()
end)

concommand.Add("horde_testing_free_perks", function (ply, cmd, args)
    if GetConVar("horde_enable_sandbox"):GetInt() == 0 then
        HORDE:SendNotificationSandboxOnly(ply)
        return
    end
    if ply:IsAdmin() then
        RunConsoleCommand("horde_perk_start_wave", 0)
        RunConsoleCommand("horde_perk_scaling", 0)
    end
end)

concommand.Add("horde_testing_wave_goto", function (ply, cmd, args)
    if GetConVar("horde_enable_sandbox"):GetInt() == 0 then
        HORDE:SendNotificationSandboxOnly(ply)
        return
    end
    if ply:IsAdmin() then
        HORDE.start_game = true
        HORDE.current_wave = tonumber(args[1])
        HORDE:WaveStart()
    end
end)

concommand.Add("horde_testing_disable_level_restrictions", function (ply, cmd, args)
    if GetConVar("horde_enable_sandbox"):GetInt() == 0 then
        HORDE:SendNotificationSandboxOnly(ply)
        return
    end
    HORDE.disable_levels_restrictions = 1
    net.Start("Horde_Disable_Levels")
    net.Broadcast()
end)

concommand.Add("horde_testing_give_skull_tokens", function (ply, cmd, args)
    if GetConVar("horde_enable_sandbox"):GetInt() == 0 then
        HORDE:SendNotificationSandboxOnly(ply)
        return
    end
    local amount = math.floor(tonumber(args[1]))
    ply:Horde_AddSkullTokens(amount)
    ply:Horde_SyncEconomy()
end)

concommand.Add("horde_use_gadget", function (ply, cmd, args)
    HORDE:UseGadget(ply)
end)

concommand.Add("horde_use_perk_skill", function (ply, cmd, args)
    HORDE:UsePerkSkill(ply)
end)

concommand.Add("horde_testing_spawn_enemy", function (ply, cmd, args)
    if GetConVar("horde_enable_sandbox"):GetInt() == 0 then
        HORDE:SendNotificationSandboxOnly(ply)
        return
    end
    local name = args[1]
    local wave = args[2]
    local mutation = args[3]
    local player_count = args[4]
    local enemy = HORDE.enemies[name .. tostring(wave)]
    local npc_info = list.Get("NPC")[enemy.class]
    if not npc_info then
        print("[HORDE] NPC does not exist in ", list.Get("NPC"))
    end

    local spawned_enemy = ents.Create(enemy.class)
    local trace = ply:GetEyeTrace()
    if not trace.Hit then return end
    spawned_enemy:SetPos(trace.HitPos)
    timer.Simple(0, function() spawned_enemy:SetAngles(Angle(0, math.random(0, 360), 0)) end)
    spawned_enemy:Spawn()

    spawned_enemy:Horde_SetName(enemy.name)

    if npc_info["Model"] then
        spawned_enemy:SetModel(npc_info["Model"])
    end

    if npc_info["SpawnFlags"] then
        -- We need to cleanup corpses otherwise it's going to be a mess
        spawned_enemy:SetKeyValue("spawnflags", bit.bor(npc_info["SpawnFlags"], SF_NPC_FADE_CORPSE))
    end

    if npc_info["KeyValues"] then
        for k, v in pairs(npc_info["KeyValues"]) do
            spawned_enemy:SetKeyValue(k, v)
        end
    end

    spawned_enemy:Fire("StartPatrolling")
    spawned_enemy:Fire("SetReadinessHigh")
    if spawned_enemy:IsNPC() then
        spawned_enemy:SetNPCState(NPC_STATE_COMBAT)
    end

    if enemy.model_scale and enemy.model_scale ~= 1 then
        timer.Simple(0, function()
            if not spawned_enemy:IsValid() then return end
            local scale = spawned_enemy:GetModelScale()
            spawned_enemy:SetModelScale(enemy.model_scale * scale)
        end)
    end

    if enemy.boss_properties and enemy.boss_properties.is_boss == true then
        spawned_enemy:Horde_SetBossProperties(enemy.boss_properties)
    end

    -- Health settings
    local horde_players_count = player_count or table.Count(player.GetAll())
    if enemy.is_elite and enemy.is_elite == true then
        spawned_enemy:Horde_SetElite()
        local scale
        local add
        if enemy.boss_properties and enemy.boss_properties.is_boss == true then
            scale = horde_players_count
            add = 0.75
        else
            scale = math.min(8, horde_players_count)
            add = 0.60
        end
        spawned_enemy:SetMaxHealth(spawned_enemy:GetMaxHealth() * math.max(1, scale * (add + HORDE.difficulty_elite_health_scale_add[HORDE.difficulty])))
    end

    if enemy.health_scale then
        spawned_enemy:SetMaxHealth(spawned_enemy:GetMaxHealth() * enemy.health_scale)
    end

    if HORDE.endless == 1 then
        spawned_enemy:SetMaxHealth(spawned_enemy:GetMaxHealth() * HORDE.endless_health_multiplier)
    end

    spawned_enemy:SetMaxHealth(spawned_enemy:GetMaxHealth() * HORDE.difficulty_health_multiplier[HORDE.difficulty])

    spawned_enemy:SetHealth(spawned_enemy:GetMaxHealth())

    if enemy.reward_scale then
        spawned_enemy:SetVar("reward_scale", enemy.reward_scale)
    end

    if enemy.damage_scale then
        spawned_enemy:SetVar("damage_scale", enemy.damage_scale)
    end

    if enemy.color then
        spawned_enemy:SetColor(enemy.color)
        spawned_enemy:SetRenderMode(RENDERMODE_TRANSCOLOR)
    end

    if enemy.weapon then
        if enemy.weapon == "" or enemy.weapon == "_gmod_none" then
            -- Do nothing
        elseif enemy.weapon == "_gmod_default" then
            local wpns = npc_info["Weapons"]
            if wpns then
                local wpn = wpns[math.random(#wpns)]
                spawned_enemy:Give(wpn)
            end
        else
            spawned_enemy:Give(enemy.weapon)
        end
    end

    if enemy.skin then
        spawned_enemy:SetSkin(enemy.skin)
    end

    if enemy.model then
        spawned_enemy:SetModel(enemy.model)
    end

    spawned_enemy:SetLagCompensated(true)

    if args[3] then
        timer.Simple(0.1, function() spawned_enemy:Horde_SetMutation(args[3]) end)
    end

    if args[4] then
        timer.Simple(0.1, function() spawned_enemy:Horde_SetMutation(args[4]) end)
    end
end)
