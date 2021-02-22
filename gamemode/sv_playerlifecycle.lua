if CLIENT then return end
-- Manages player spawn/death settings

HORDE.GameEnd = function (status)
    local randomplayer = table.Random(player.GetAll())
    local mvp_player = randomplayer
    local mvp_damage = 0
    local mvp_kills = 0

    local kills_player = randomplayer
    local most_kills = 0
    local second_kills_player = 0
    local second_most_kills = 0

    local money_player = randomplayer
    local most_money = 0

    local headshot_player = randomplayer
    local most_headshots = 0

    local damage_player = randomplayer
    local most_damage = 0
    local second_damage_player = 0
    local second_most_damage = 0
    local total_damage = 0

    local damage_taken_player = randomplayer
    local most_damage_taken = 0

    local elite_kill_player = randomplayer
    local most_elite_kills = 0

    for _,ply in pairs(player.GetAll()) do
        if not ply:IsValid() then goto cont end
        local id = ply:SteamID()
        if (not id) or (id == "") then goto cont end
        if HORDE.player_damage and HORDE.player_damage[id] and HORDE.player_damage[id] > most_damage then
            second_damage_player = damage_player
            second_most_damage = most_damage
            most_damage = HORDE.player_damage[id]
            damage_player = ply
        end

        if ply:Frags() > most_kills then
            second_kills_player = kills_player
            second_most_kills = most_kills
            most_kills = ply:Frags()
            kills_player = ply
        end

        if HORDE.player_money_earned and HORDE.player_money_earned[id] and HORDE.player_money_earned[id] > most_money then
            most_money = HORDE.player_money_earned[id]
            money_player = ply
        end

        if HORDE.player_damage_taken and HORDE.player_damage_taken[id] and HORDE.player_damage_taken[id] > most_damage_taken then
            most_damage_taken = HORDE.player_damage_taken[id]
            damage_taken_player = ply
        end

        if HORDE.player_elite_kills and HORDE.player_elite_kills[id] and HORDE.player_elite_kills[id] > most_elite_kills then
            most_elite_kills = HORDE.player_elite_kills[id]
            elite_kill_player = ply
        end

        if HORDE.player_headshots and HORDE.player_headshots[id] and HORDE.player_headshots[id] > most_headshots then
            most_headshots = HORDE.player_headshots[id]
            headshot_player = ply
        end

        ::cont::
    end

    -- Find out mvp
    if kills_player:SteamID() == damage_player:SteamID() then
        mvp_player = kills_player
        mvp_kills = most_kills
        mvp_damage = most_damage
    else
        if kills_player:SteamID() == second_damage_player:SteamID() then
            mvp_player = kills_player
            mvp_kills = most_kills
            mvp_damage = second_most_damage
        elseif damage_player:SteamID() == second_kills_player:SteamID() then
            mvp_player = kills_player
            mvp_kills = second_most_kills
            mvp_damage = most_damage
        else
            if HORDE.player_elite_kills[damage_player:SteamID()] > HORDE.player_elite_kills[kills_player:SteamID()] then
                mvp_player = damage_player
                mvp_kills = damage_player:Frags()
                mvp_damage = most_damage
            else
                mvp_player = kills_player
                mvp_kills = most_kills
                mvp_damage = HORDE.player_damage[kills_player:SteamID()]
            end
        end
    end

    net.Start("Horde_GameEnd")

    net.WriteEntity(mvp_player)
    net.WriteInt(mvp_damage, 32)
    net.WriteInt(mvp_kills, 32)

    net.WriteEntity(damage_player)
    net.WriteInt(most_damage, 32)

    net.WriteEntity(kills_player)
    net.WriteInt(most_kills, 32)

    net.WriteEntity(money_player)
    net.WriteInt(most_money, 32)

    net.WriteEntity(headshot_player)
    net.WriteInt(most_headshots, 32)

    net.WriteEntity(elite_kill_player)
    net.WriteInt(most_elite_kills, 32)

    net.WriteEntity(damage_taken_player)
    net.WriteInt(most_damage_taken, 32)

    net.Broadcast()

    timer.Remove('Horde_Main')
    timer.Remove('Horder_Counter')
    BroadcastMessage(status)
end

hook.Add("PlayerSpawn", "Horde_PlayerSpawn", function(ply)
    if ply:IsValid() then
        ply:SetCollisionGroup(15)
        ply:SetCanZoom(false)
        ply:ConCommand([[mat_colorcorrection 1]])
        ply:ConCommand([[cl_showhints 0]])
        ply:SetMoveType(MOVETYPE_WALK)
    end
end)

hook.Add("Move", "Horde_move", function (ply, mv)
    if ply:GetClass() then
        ply:SetWalkSpeed(ply:GetClass().movespd)
        ply:SetRunSpeed(ply:GetClass().sprintspd)
        ply:SetJumpPower(150)
    end
end)

hook.Add("PlayerDeath", "Horde_DeathSpectatingFunction", function(victim, inflictor, attacker)
    if not HORDE.start_game or HORDE.current_break_time > 0 then return end
    timer.Simple(1, function()
        if victim:IsValid() then
            victim:SetObserverMode(OBS_MODE_ROAMING)
            victim:SetMoveType(MOVETYPE_OBSERVER)
        end
    end)
end)

function CheckAlivePlayers()
    local aliveplayers = 0 
    local deadplayers = 0
    for _, ply in pairs(player.GetAll()) do 
        if ply:IsValid() and ply:Alive() then 
            aliveplayers = aliveplayers + 1 
        end
        if ply:IsValid() and not ply:Alive() then 
            deadplayers = deadplayers + 1 
        end 
    end
    if aliveplayers == 0 and deadplayers > 0 then
        for _, ply in pairs(player.GetAll()) do 
            -- ply:ScreenFade(SCREENFADE.OUT, Color(0,0,0), 6, 2)
            -- ply:Freeze(true)
        end
        
        net.Start("Horde_LegacyNotification")
        net.WriteString("All players are dead! Restarting...")
        net.WriteInt(1,2)
        net.Broadcast()
        HORDE.GameEnd("Defeat")
        timer.Simple(10, function() timer.Simple(0, function() RunConsoleCommand("changelevel", game.GetMap()) end) end)
    end
end

hook.Add("PlayerSpawn", "Horde_PlayerSpawn", function (ply)
    if HORDE.start_game and HORDE.current_break_time <= 0 then
        if ply:IsValid() then
            ply:KillSilent()
            net.Start("Horde_LegacyNotification")
            net.WriteString("You will respawn next wave.")
            net.Send(ply)
        end
    end
end)

hook.Add("PlayerDeathThink", "Horde_PlayerDeathThink", function (ply)
    --if GetConVarNumber("horde_enable_respawn") == 1 then return true end
    if HORDE.current_break_time > 0 then return true end
    if HORDE.start_game then return false end
    return true
end);

hook.Add("DoPlayerDeath", "Horde_DoPlayerDeath", function(victim)
    if (not HORDE.start_game) or (HORDE.current_break_time > 0) then
        timer.Simple(1, function() if victim:IsValid() then victim:Spawn() end end)
        return
    end
    net.Start("Horde_LegacyNotification")
    net.WriteString("You are dead. You will respawn next wave.")
    net.Send(victim)
    for _, wpn in pairs(victim:GetWeapons()) do
        victim:DropWeapon(wpn)
    end
    CheckAlivePlayers()
end)
