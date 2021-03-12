-- Manages player spawn/death settings

util.AddNetworkString("Horde_Votemap")
util.AddNetworkString("Horde_Votediff")
util.AddNetworkString("Horde_VotemapSync")
util.AddNetworkString("Horde_VotediffSync")
util.AddNetworkString("Horde_RemainingTime")

HORDE.vote_remaining_time = 60

local map_list = {}
local map_votes = {}
local diff_votes = {}

function HORDE:GameEnd(status)
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
        if HORDE.player_damage and HORDE.player_damage[id] then
            total_damage = total_damage + HORDE.player_damage[id]
            if HORDE.player_damage[id] > most_damage then
                second_damage_player = damage_player
                second_most_damage = most_damage
                most_damage = HORDE.player_damage[id]
                damage_player = ply
            end
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

    net.WriteString(status)

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

    net.WriteInt(total_damage, 32)

    map_list = HORDE:GetNextMaps()

    if not map_list then
        map_list = {game.GetMapNext()}
    end

    net.WriteTable(map_list)

    net.Broadcast()

    timer.Remove("Horde_Main")
    timer.Remove("Horder_Counter")
    BroadcastMessage(status .. " Wave: " .. HORDE.current_wave)

    timer.Create("Horde_MapVoteCountdown", 1, 0, function ()
        if HORDE.vote_remaining_time <= 0 then
            timer.Remove("Horde_MapVoteCountdown")

            local chosen_map = game.GetMapNext()
            local chosen_map_count = 0

            local map_collect = {}
            for _, map in ipairs(map_list) do
                map_collect[map] = 0
            end

            for ply, map_voted in pairs(map_votes) do
                for map, count in pairs(map_collect) do
                    if map == map_voted then
                        map_collect[map] = count + 1
                    end
                end
            end

            for map, count in pairs(map_collect) do
                if count > chosen_map_count then
                    chosen_map = map
                    chosen_map_count = count
                end
            end

            local chosen_diff = HORDE.difficulty
            local chosen_diff_count = 0

            local diff_collect = {}
            for _, diff in ipairs(HORDE.difficulty_text) do
                diff_collect[diff] = 0
            end

            for ply, diff_voted in pairs(diff_votes) do
                for diff, count in pairs(diff_collect) do
                    if diff == diff_voted then
                        diff_collect[diff] = count + 1
                    end
                end
            end

            for diff, count in pairs(diff_collect) do
                if count > chosen_diff_count then
                    chosen_diff = diff
                    chosen_diff_count = count
                end
            end

            if chosen_diff == "NORMAL" then
                GetConVar("horde_difficulty"):SetInt(0)
            elseif chosen_diff == "HARD" then
                GetConVar("horde_difficulty"):SetInt(1)
            else
                GetConVar("horde_difficulty"):SetInt(2)
            end
            
            
            timer.Simple(0, function() RunConsoleCommand("changelevel", chosen_map) end)
        end
        net.Start("Horde_RemainingTime")
        net.WriteInt(HORDE.vote_remaining_time, 8)
        net.Broadcast()
        HORDE.vote_remaining_time = HORDE.vote_remaining_time - 1
    end)
end

net.Receive("Horde_Votemap", function (len, ply)
    map_votes[ply] = net.ReadString()

    local map_collect = {}
    for _, map in ipairs(map_list) do
        map_collect[map] = 0
    end

    for ply, map_voted in pairs(map_votes) do
        for map, count in pairs(map_collect) do
            if map == map_voted then
                map_collect[map] = count + 1
            end
        end
    end

    local total_players = table.Count(player.GetAll())
    for map, count in pairs(map_collect) do
        if count >= total_players then
            HORDE.vote_remaining_time = math.min(HORDE.vote_remaining_time, 10)
        elseif count >= HORDE.Round2(total_players * 2 / 3) then
            HORDE.vote_remaining_time = math.min(HORDE.vote_remaining_time, 30)
            break
        end
    end

    net.Start("Horde_VotemapSync")
    net.WriteTable(map_collect)
    net.Broadcast()
end)

net.Receive("Horde_Votediff", function (len, ply)
    diff_votes[ply] = net.ReadString()

    local diff_collect = {}
    for _, diff in ipairs(HORDE.difficulty_text) do
        diff_collect[diff] = 0
    end

    for ply, diff_voted in pairs(diff_votes) do
        for diff, count in pairs(diff_collect) do
            if diff == diff_voted then
                diff_collect[diff] = count + 1
            end
        end
    end
    net.Start("Horde_VotediffSync")
    net.WriteTable(diff_collect)
    net.Broadcast()
end)

HORDE.VoteChangeMap = function (ply)
    HORDE.player_vote_map_change[ply] = 1
    if table.Count(HORDE.player_vote_map_change) == table.Count(player.GetAll()) then
        net.Start("Horde_LegacyNotification")
        net.WriteString("All players want to change map! Initiating map vote...")
        net.WriteInt(0,2)
        net.Broadcast()
        timer.Simple(5, function ()
            HORDE:GameEnd("Change Map")
        end)
    else
        net.Start("Horde_LegacyNotification")
        net.WriteString(ply:GetName() .. " wants to change the map. (" .. tostring(table.Count(HORDE.player_vote_map_change)) .. "/" .. tostring(table.Count(player.GetAll())) .. ")")
        net.WriteInt(0,2)
        net.Broadcast()
    end
end

hook.Add("PlayerSpawn", "Horde_PlayerInitialSpawn", function(ply)
    if ply:IsValid() then
        ply:SetCollisionGroup(15)
        ply:SetCanZoom(false)
        ply:ConCommand([[mat_colorcorrection 1]])
        ply:ConCommand([[cl_showhints 0]])
        ply:SetMoveType(MOVETYPE_WALK)
    end
end)

hook.Add("Move", "Horde_move", function (ply, mv)
    if ply:GetHordeClass() then
        ply:SetWalkSpeed(ply:GetHordeClass().movespd)
        ply:SetRunSpeed(ply:GetHordeClass().sprintspd)
        ply:SetJumpPower(150)
    end
end)

local function Horde_DeathSpectatingFunction(victim, inflictor, attacker)
    if not HORDE.start_game or HORDE.current_break_time > 0 then return end
    timer.Simple(1, function()
        if victim:IsValid() then
            victim:SetObserverMode(OBS_MODE_ROAMING)
            victim:SetMoveType(MOVETYPE_OBSERVER)
        end
    end)
end
hook.Add("PlayerDeath", "Horde_DeathSpectatingFunction", Horde_DeathSpectatingFunction)
hook.Add("PlayerSilentDeath", "Horde_DeathSpectatingFunction", Horde_DeathSpectatingFunction)

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
        HORDE:GameEnd("DEFEAT!")
    end
end

hook.Add("PlayerSpawn", "Horde_PlayerSpawnMidWave", function (ply)
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
