-- Manages player spawn/death settings

util.AddNetworkString("Horde_Votemap")
util.AddNetworkString("Horde_Votediff")
util.AddNetworkString("Horde_VotemapSync")
util.AddNetworkString("Horde_VotediffSync")
util.AddNetworkString("Horde_RemainingTime")
util.AddNetworkString("Horde_ClearStatus")
util.AddNetworkString("Horde_SyncGameInfo")
util.AddNetworkString("Horde_SaveAchievements")
util.AddNetworkString("Horde_SaveExtraAchievements")
util.AddNetworkString("Horde_SyncClientExps")

HORDE.vote_remaining_time = 60
HORDE.game_end = nil
local plymeta = FindMetaTable("Player")
local map_list = {}
local map_votes = {}
local diff_votes = {}

function plymeta:Horde_SetGivenStarterWeapons(given)
    self.Horde_GivenStarterWeapons = given
end

function plymeta:Horde_GetGivenStarterWeapons()
    return self.Horde_GivenStarterWeapons or nil
end

function HORDE:GiveStarterWeapons(ply)
    if GetConVar("horde_enable_starter"):GetInt() == 0 then return end
    if ply:Alive() and (not ply:Horde_GetGivenStarterWeapons()) then
        if HORDE.starter_weapons[ply:Horde_GetCurrentSubclass()] then
            for _, wpn_class in pairs(HORDE.starter_weapons[ply:Horde_GetCurrentSubclass()]) do
                ply:Give(wpn_class)
            end
        end

        if HORDE.starter_weapons["All"] then
            for _, wpn_class in pairs(HORDE.starter_weapons["All"]) do
                ply:Give(wpn_class)
            end
        end

        ply:GiveAmmo(200, 3)
        ply:Horde_SetGivenStarterWeapons(true)
    end
end

function HORDE:GameEnd(status)
    if HORDE.game_end then return end
    timer.Simple(HORDE.vote_remaining_time + 3, function ()
        -- I don't know why some servers get stuck on voting.
        -- Adding this to force map change.
        map_list = HORDE:GetNextMaps()

        if not map_list then
            map_list = {game.GetMapNext()}
        end
        timer.Simple(0, function() RunConsoleCommand("changelevel", table.Random(map_list)) end)
    end)

    if status == "DEFEAT" then
        HORDE:SendNotification("All players are dead!", 1)
    end

    if status == "VICTORY" then
        net.Start("Horde_SaveAchievements")
        net.Broadcast()
    end

    local tokens = math.floor(HORDE.current_wave / 2)
    if status == "VICTORY" then
        tokens = tokens + math.max(0, HORDE.difficulty - 1)
    end
    for _, ply in pairs(player.GetHumans()) do
        ply:Horde_AddSkullTokens(tokens)
    end

    HORDE.game_end = true
    if not player.GetHumans() or player.GetCount() < 1 then
        map_list = HORDE:GetNextMaps()

        if not map_list then
            map_list = {game.GetMapNext()}
        end
        timer.Simple(0, function() RunConsoleCommand("changelevel", table.Random(map_list)) end)
        return
    end
    local randomplayer = player.GetHumans()[1]

    local mvp_player = randomplayer
    local mvp_damage = 0
    local mvp_kills = 0

    local kills_player = randomplayer
    local most_kills = 0
    local second_kills_player = 0
    local second_most_kills = 0

    local most_heal_player = randomplayer
    local most_heal = 0

    local headshot_player = randomplayer
    local most_headshots = 0

    local damage_player = randomplayer
    local most_damage = 0
    local second_damage_player = randomplayer
    local second_most_damage = 0
    local total_damage = 0

    local damage_taken_player = randomplayer
    local most_damage_taken = 0

    local elite_kill_player = randomplayer
    local most_elite_kills = 0

    for _,ply in pairs(player.GetHumans()) do
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
            elseif HORDE.player_damage[id] > second_most_damage then
                second_damage_player = ply
                second_most_damage = HORDE.player_damage[id]
            end
        end

        if ply:Frags() > most_kills then
            second_kills_player = kills_player
            second_most_kills = most_kills
            most_kills = ply:Frags()
            kills_player = ply
        end

        if HORDE.player_heal and HORDE.player_heal[id] and HORDE.player_heal[id] > most_heal then
            most_heal = HORDE.player_heal[id]
            most_heal_player = ply
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
            if HORDE.player_elite_kills and HORDE.player_elite_kills[damage_player:SteamID()] > HORDE.player_elite_kills[kills_player:SteamID()] then
                mvp_player = damage_player
                mvp_kills = damage_player:Frags()
                mvp_damage = most_damage
            else
                mvp_player = kills_player
                mvp_kills = most_kills
                mvp_damage = HORDE.player_damage[kills_player:SteamID()] or 0
            end
        end
    end

    net.Start("Horde_GameEnd")

    net.WriteString(status)

    net.WriteEntity(mvp_player)
    net.WriteUInt(mvp_damage, 32)
    net.WriteUInt(mvp_kills, 32)

    net.WriteEntity(damage_player)
    net.WriteUInt(most_damage, 32)

    net.WriteEntity(kills_player)
    net.WriteUInt(most_kills, 32)

    net.WriteEntity(most_heal_player)
    net.WriteUInt(most_heal, 32)

    net.WriteEntity(headshot_player)
    net.WriteUInt(most_headshots, 32)

    net.WriteEntity(elite_kill_player)
    net.WriteUInt(most_elite_kills, 32)

    net.WriteEntity(damage_taken_player)
    net.WriteUInt(most_damage_taken, 32)

    net.WriteUInt(total_damage, 32)

    map_list = HORDE:GetNextMaps()

    if not map_list then
        map_list = {game.GetMapNext()}
    end

    net.WriteTable(map_list)

    net.Broadcast()

    net.Start("Horde_SyncEscapeEnd")
    net.Broadcast()

    timer.Remove("Horde_Main")
    timer.Remove("Horder_Counter")
    HORDE:BroadcastGameResultMessage(status, HORDE.current_wave)

    for _, ply in pairs(player.GetHumans()) do
        if not ply:IsValid() then goto cont end
        if GetConVar("horde_enable_rank"):GetInt() == 1 then
            HORDE:SaveRank(ply)
        end
        ::cont::
    end

    timer.Create("Horde_MapVoteCountdown", 1, 0, function ()
        if HORDE.vote_remaining_time <= 0 then
            timer.Remove("Horde_MapVoteCountdown")

            local chosen_map = game.GetMapNext()
            local chosen_map_count = 0

            local map_collect = {}
            for _, map in pairs(map_list) do
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
            elseif chosen_diff == "REALISM" then
                GetConVar("horde_difficulty"):SetInt(2)
            elseif chosen_diff == "NIGHTMARE" then
                GetConVar("horde_difficulty"):SetInt(3)
            else
                GetConVar("horde_difficulty"):SetInt(4)
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
    for _, map in pairs(map_list) do
        map_collect[map] = 0
    end

    for _, map_voted in pairs(map_votes) do
        for map, count in pairs(map_collect) do
            if map == map_voted then
                map_collect[map] = count + 1
            end
        end
    end

    local total_players = table.Count(player.GetAll())
    for _, count in pairs(map_collect) do
        if count >= total_players then
            HORDE.vote_remaining_time = math.min(HORDE.vote_remaining_time, 10)
        elseif count >= HORDE:Round2(total_players * 2 / 3) then
            HORDE.vote_remaining_time = math.min(HORDE.vote_remaining_time, 30)
            break
        end
    end

    net.Start("Horde_VotemapSync")
    net.WriteTable(map_collect)
    net.Broadcast()
end)

-- Player Spawn Initialize
function HORDE:PlayerInit(ply)
    HORDE.current_players = player.GetAll()
    HORDE:LoadRank(ply)

    net.Start("Horde_SyncItems")
    local str = HORDE.GetCachedHordeItems()
    net.WriteUInt(string.len(str), 32)
        net.WriteData(str, string.len(str))
    net.Send(ply)

    net.Start("Horde_SyncClasses")
        net.WriteTable(HORDE.classes)
    net.Send(ply)

    net.Start("Horde_SyncDifficulty")
        net.WriteUInt(HORDE.difficulty,3)
    net.Send(ply)

    net.Start("Horde_SyncGameInfo")
        net.WriteUInt(HORDE.current_wave, 16)
    net.Send(ply)

    if HORDE.disable_levels_restrictions == 1 then
        net.Start("Horde_Disable_Levels")
        net.Send(ply)
    end
    if not HORDE.start_game then
        HORDE.player_ready[ply] = 0
        net.Start("Horde_PlayerReadySync")
            net.WriteTable(HORDE.player_ready)
        net.Broadcast()
    end

    if HORDE.start_game then
        net.Start("Horde_RemoveReadyPanel")
        net.Send(ply)
        if HORDE.player_money_wave[ply:SteamID()] and HORDE.player_money[ply:SteamID()] and HORDE.player_money_wave[ply:SteamID()] == HORDE.current_wave then
            -- Already provided social welfare.
            ply:Horde_SetMoney(HORDE.player_money[ply:SteamID()])
        else
            ply:Horde_SetMoney(HORDE.start_money + math.max(0, HORDE.current_wave - 1) * 150)
        end
        HORDE:LoadSkullTokens(ply)
        if HORDE.horde_boss and HORDE.horde_boss:IsValid() and HORDE.horde_boss_name then
            net.Start("Horde_SyncBossSpawned")
                net.WriteString(HORDE.horde_boss_name)
                net.WriteInt(HORDE.horde_boss:GetMaxHealth(),32)
                net.WriteInt(HORDE.horde_boss:Health(),32)
            net.Send(ply)
        end

        local tip = HORDE:GetTip()
        if tip and (not HORDE.horde_boss) then
            net.Start("Horde_SyncTip")
                net.WriteString(HORDE:GetTip())
            net.Send(ply)
        end

        if HORDE.horde_active_holdzones then
            for id, zone in pairs(HORDE.horde_active_holdzones) do
                net.Start("Horde_SyncHoldLocation")
                net.WriteUInt(zone.Horde_Zone_Id, 4)
                net.WriteVector(zone:GetPos())
                net.WriteVector(zone:OBBMins())
                net.WriteVector(zone:OBBMaxs())
                net.Send(ply)
            end

            net.Start("Horde_RenderObjectives")
            net.WriteUInt(HORDE.finished_objs, 4)
            net.WriteUInt(HORDE.max_objs, 4)
            net.Send(ply)
        end

        if HORDE.horde_active_escapezones then
            for id, zone in pairs(HORDE.horde_active_escapezones) do
                net.Start("Horde_SyncEscapeLocation")
                net.WriteUInt(zone.Horde_Zone_Id, 4)
                net.WriteVector(zone:GetPos())
                net.WriteVector(zone:OBBMins())
                net.WriteVector(zone:OBBMaxs())
                net.Send(ply)
            end
            net.Start("Horde_RenderObjectives")
            net.WriteUInt(HORDE.finished_objs, 4)
            net.WriteUInt(HORDE.max_objs, 4)
            net.Send(ply)
        end

        if HORDE.horde_active_payload_spawns then
            for id, spawn in pairs(HORDE.horde_active_payload_spawns) do
                net.Start("Horde_SyncPayloadLocation")
                net.WriteUInt(spawn.Horde_Payload_Spawn_Id, 4)
                net.WriteVector(spawn:GetPos())
                net.Send(ply)

                net.Start("Horde_SyncPayloadIcon")
                net.WriteUInt(spawn.Horde_Payload_Spawn_Id, 4)
                net.WriteUInt(spawn.Horde_Payload_Icon, 4)
                net.Send(ply)
            end
            net.Start("Horde_SyncEscapeStart")
            net.Send(ply)
        end

        if HORDE.horde_active_payload_destinations then
            for id, dest in pairs(HORDE.horde_active_payload_destinations) do
                net.Start("Horde_SyncPayloadDestinationLocation")
                net.WriteUInt(dest.Horde_Payload_Destination_Id, 4)
                net.WriteVector(dest:GetPos())
                net.WriteVector(dest:OBBMins())
                net.WriteVector(dest:OBBMaxs())
                net.Send(ply)
            end
        end
    else
        if HORDE.player_money[ply:SteamID()] then
            ply:Horde_SetMoney(HORDE.player_money[ply:SteamID()])
        else
            ply:Horde_SetMoney(HORDE.start_money)
        end
        HORDE:LoadSkullTokens(ply)
    end
    ply:Horde_SetDropEntities({})
    ply:Horde_SetMaxWeight(HORDE.max_weight)
    if not ply:Horde_GetClass() then
        ply:Horde_SetClass(HORDE.classes[HORDE.Class_Survivor])
    end

    hook.Run("Horde_ResetStatus", ply)
    -- Misc stuff
    ply.Horde_Spectre_Max_Count = 1
    ply:Horde_ApplyPerksForClass()
    ply:Horde_SetWeight(ply:Horde_GetMaxWeight())
    HORDE.player_class_changed[ply:SteamID()] = false
    ply:Horde_SyncEconomy()
    if ply:Alive() and not (HORDE.start_game and HORDE.current_break_time <= 0) then
        HORDE:GiveStarterWeapons(ply)
    end

    ply.Horde_Status = {}
    ply:PrintMessage(HUD_PRINTTALK, "Use '!help' to see special commands!")

    ply:Horde_SyncExp()
    for _, other_ply in pairs(player.GetAll()) do
        if other_ply == ply then goto cont end
        local subclass = other_ply:Horde_GetCurrentSubclass()
        if not subclass then goto cont end
        net.Start("Horde_SyncExp")
            net.WriteEntity(other_ply)
            net.WriteString(subclass)
            net.WriteUInt(other_ply:Horde_GetExp(subclass), 32)
            net.WriteUInt(other_ply:Horde_GetLevel(subclass), 8)
        net.Send(ply)

        net.Start("Horde_SyncPerk")
            net.WriteEntity(other_ply)
            net.WriteTable(other_ply.Horde_PerkChoices[subclass])
        net.Send(ply)
        ::cont::
    end
    net.Start("Horde_SyncClientExps")
    net.Send(ply)

    if GetConVar("horde_enable_sandbox"):GetInt() == 1 then
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_ExpDisabled, 8)
            net.WriteUInt(1, 8)
        net.Send(ply)
    end

    ply.Horde_Init_Complete = true
    local added = HORDE:TryAddTopTen(ply)
    if not added then
        net.Start("Horde_SyncTopTen")
            net.WriteString(util.TableToJSON(HORDE.top_tens))
        net.Broadcast()
    end

    if not HORDE.has_buy_zone then
        net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_CanBuy, 8)
        if HORDE.current_break_time > 0 then
            net.WriteUInt(1, 8)
        else
            net.WriteUInt(0, 8)
        end
        net.Send(ply)
    end

    if HORDE.start_game then return end

    local ready_count = 0
    local total_player = 0
    for _, other_ply in pairs(player.GetAll()) do
        if HORDE.player_ready[other_ply] == 1 then
            ready_count = ready_count + 1
        end
        total_player = total_player + 1
    end
    
    if total_player > 0 and total_player == ready_count then
        HORDE.start_game = true
    end

    HORDE:BroadcastPlayersReadyMessage(tostring(ready_count) .. "/" .. tostring(total_player))
end

net.Receive("Horde_PlayerInit", function (len, ply)
    HORDE:PlayerInit(ply)
end)

HORDE.player_money = {}
HORDE.player_money_wave = {}
hook.Add("PlayerDisconnected", "Horde_PlayerDisconnect", function(ply)
    HORDE.current_players = player.GetAll()
    if HORDE.player_vote_map_change[ply] then
        HORDE.player_vote_map_change[ply] = nil
    end

    -- Keep player money to prevent money duping
    if ply:IsValid() then
        HORDE.player_money[ply:SteamID()] = ply:Horde_GetMoney()
        HORDE.player_money_wave[ply:SteamID()] = HORDE.current_wave
    end

    if (not HORDE.start_game) and HORDE.player_ready[ply] then
        HORDE.player_ready[ply] = nil
        net.Start("Horde_PlayerReadySync")
        net.WriteTable(HORDE.player_ready)
        net.Broadcast()
    end

    if not ply:IsValid() then return end
    
    -- Remove all the entities he owns
    if HORDE.player_drop_entities[ply:SteamID()] then
        for _, ent in pairs(HORDE.player_drop_entities[ply:SteamID()]) do
            if ent:IsValid() then
                ent.Horde_Minion_Respawn = nil
                timer.Remove("Horde_ManhackRespawn" .. ent:GetCreationID())
                ent:Remove()
            end
        end
    end

    timer.Simple(0, function() HORDE:CheckAlivePlayers() end)
end)

net.Receive("Horde_Votediff", function (len, ply)
    diff_votes[ply] = net.ReadString()

    local diff_collect = {}
    for _, diff in ipairs(HORDE.difficulty_text) do
        diff_collect[diff] = 0
    end

    for _, diff_voted in pairs(diff_votes) do
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
        HORDE:SendNotification("All players want to change map! Initiating map vote...", 0)
        timer.Simple(1, function ()
            HORDE:GameEnd("Change Map")
        end)
    else
        HORDE:SendNotification(ply:GetName() .. " wants to change the map. (" .. tostring(table.Count(HORDE.player_vote_map_change)) .. "/" .. tostring(table.Count(player.GetAll())) .. ")", 0)
    end
end

hook.Add("PlayerSpawn", "Horde_PlayerInitialSpawn", function(ply)
    if ply.Horde_Fake_Respawn == true then return end
    if ply:IsValid() then
        ply:SetCollisionGroup(15)
        ply:SetCanZoom(false)
        ply:ConCommand([[mat_colorcorrection 1]])
        ply:ConCommand([[cl_showhints 0]])
        ply:SetMoveType(MOVETYPE_WALK)

        local beacons = ents.FindByClass("horde_watchtower_beacon")
        if beacons and #beacons > 0 then
            local i = math.random(1, #beacons)
            ply:SetPos(beacons[i]:GetPos() + Vector(0,0,24))
        end
    end
end)

hook.Add("Move", "Horde_PlayerMove", function (ply, mv)
    if ply:Horde_GetClass() then
        ply:SetJumpPower(150)
        local bonus_walk = {more = 1, increase = 0}
        local bonus_run = {more = 1, increase = 0}
        hook.Run("Horde_PlayerMoveBonus", ply, bonus_walk, bonus_run)
        ply:SetWalkSpeed(ply:Horde_GetClass().movespd * bonus_walk.more * (1 + bonus_walk.increase))
        ply:SetRunSpeed(ply:Horde_GetClass().sprintspd * bonus_run.more * (1 + bonus_run.increase))
    end
end)

hook.Add("Horde_PlayerMoveBonus", "Horde_PlayerPayloadMove", function (ply, bonus_walk, bonus_run)
    if ply:Horde_HasPayload() then
        local mass = ply.Horde_Payload_Spawn.Horde_Payload_Mass
        if mass and mass > 0 then
            bonus_walk.more = bonus_walk.more * (1 - math.max(0.1, mass/100))
            bonus_run.more = bonus_run.more * (1 - math.max(0.1, mass/100))
        end
    end
end)


local function Horde_DeathSpectatingFunction(victim, inflictor, attacker)
    if not HORDE.start_game or HORDE.current_break_time > 0 then return end
    timer.Simple(1, function()
        if victim:IsValid() and (not victim:Alive()) then
            victim:SetObserverMode(OBS_MODE_ROAMING)
            victim:SetMoveType(MOVETYPE_OBSERVER)
        end
    end)
end

local function Horde_GetAllLivingPlayers()
    if not HORDE.alive_players then HORDE.alive_players = {} end
    if HORDE.refresh_living_players then
        HORDE.alive_players = {}
        for _, ply in pairs(player.GetAll()) do
            if ply:Alive() then
                table.insert(HORDE.alive_players, ply)
            end
        end
        HORDE.refresh_living_players = nil
    end
end

function plymeta:Horde_SpectatePrevPlayer()
    local plys = HORDE.alive_players
    if #plys > 0 then
        local cur_target = self:GetObserverTarget()
        local index

        if !IsValid( cur_target ) then
            index = 1
        else
            for i, v in ipairs( plys ) do
                if v == cur_target then
                    index = i - 1
                    break
                end
            end
        end

        if !index then index = 1 end

        if index < 1 then
            index = #plys
        end

        local target = plys[index]

        if target ~= cur_target then
            self:SpectateEntity( target )
        end
    end
end

function plymeta:Horde_SpectateNextPlayer()
    local plys = HORDE.alive_players
    if #plys > 0 then
        local cur_target = self:GetObserverTarget()
        local index

        if !IsValid( cur_target ) or (not cur_target:Alive()) then
            index = 1
        else
            for i, v in ipairs( plys ) do
                if v == cur_target then
                    index = i + 1
                    break
                end
            end
        end

        if !index then index = 1 end

        if index > #plys then
            index = 1
        end

        local target = plys[index]

        if target ~= cur_target then
            self:SpectateEntity( target )
        end
    end
end

hook.Add("KeyPress", "PlayerChangeSpectate", function(ply, key)
    if ply:Alive() then return end
    Horde_GetAllLivingPlayers()
    if #HORDE.alive_players == 0 then
        ply:SetObserverMode(OBS_MODE_ROAMING)
        return
    end
	if (key == IN_JUMP) then
		if ply:GetObserverMode() == OBS_MODE_ROAMING then
            ply:SetObserverMode(OBS_MODE_CHASE)
            ply:Horde_SpectateNextPlayer()
        else
            ply:SetObserverMode(OBS_MODE_ROAMING)
        end
	end

    if (key == IN_ATTACK) and ply:GetObserverMode() == OBS_MODE_CHASE then
        ply:Horde_SpectateNextPlayer()
    end

    if (key == IN_ATTACK2) and ply:GetObserverMode() == OBS_MODE_CHASE then
        ply:Horde_SpectatePrevPlayer()
    end
end)

hook.Add("PlayerDeath", "Horde_DeathSpectatingFunction", Horde_DeathSpectatingFunction)
hook.Add("PlayerSilentDeath", "Horde_DeathSpectatingFunction", Horde_DeathSpectatingFunction)

function HORDE:CheckAlivePlayers()
    HORDE.refresh_living_players = true
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
        local ret = hook.Run("Horde_ShouldContinueGameWhenAllPlayersAreDead")
        if ret then return end
        HORDE:GameEnd("DEFEAT")
    end
end


hook.Add("PlayerDeathThink", "Horde_PlayerDeathThink", function (ply)
    --if GetConVarNumber("horde_enable_respawn") == 1 then return true end
    if HORDE.current_break_time > 0 then return true end
    if HORDE.start_game then return false end
    return true
end)

hook.Add("DoPlayerDeath", "Horde_DoPlayerDeath", function(victim)
    net.Start("Horde_ClearStatus")
    net.Send(victim)
    for _, wpn in pairs(victim:GetWeapons()) do
        victim:DropWeapon(wpn)
    end
    if (not HORDE.start_game) or (HORDE.current_break_time > 0) then
        timer.Simple(1, function() if victim:IsValid() then
            victim:Spawn()
        end end)
        return
    end
    HORDE:SendNotification("You are dead. You will respawn next wave.", 1, victim)
    HORDE:CheckAlivePlayers()

    local tip = HORDE:GetTip()
    if tip and (not HORDE.horde_boss) then
        net.Start("Horde_SyncTip")
            net.WriteString(HORDE:GetTip())
        net.Send(victim)
    end
end)
