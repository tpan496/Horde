if CLIENT then return end
-- HORDE SERVER

util.AddNetworkString("Horde_HighlightEnemies")
util.AddNetworkString("Horde_GameEnd")

local players_count = 0

hook.Add("Initialize", "Horde_Init", function()
    HORDE.ai_nodes = {}
    HORDE.spawned_enemies = {}
    HORDE.found_ai_nodes = false
    ParseFile()
end)

hook.Add("EntityKeyValue", "Horde_EntityKeyValue", function(ent)
    if ent:GetClass() == "info_player_teamspawn" then
        local valid = true
        for k,v in pairs(HORDE.ai_nodes) do
            if v["pos"] == ent:GetPos() then
                valid = false
            end
        end

        if valid then
            local node = {
                pos = ent:GetPos(),
                yaw = 0,
                offset = 0,
                type = 0,
                info = 0,
                zone = 0,
                neighbor = {},
                numneighbors = 0,
                link = {},
                numlinks = 0
            }
            table.insert(HORDE.ai_nodes, node)
        end
    end
end)

hook.Add("OnNPCKilled", "Horde_OnNPCKilled", function(victim, killer, weapon)
    if HORDE.spawned_enemies[victim:EntIndex()] then
        HORDE.spawned_enemies[victim:EntIndex()] = nil
        HORDE.alive_enemies_this_wave = HORDE.alive_enemies_this_wave - 1
        print("OnKill", HORDE.alive_enemies_this_wave, HORDE.total_enemies_this_wave)
        if HORDE.alive_enemies_this_wave <= 10 and HORDE.total_enemies_this_wave <= 10 then
            net.Start("Horde_HighlightEnemies")
            net.WriteInt(1, 2)
            net.Broadcast()
        end
        HORDE.killed_enemies_this_wave = HORDE.killed_enemies_this_wave + 1
        BroadcastMessage("Enemies: " .. HORDE.total_enemies_this_wave_fixed - HORDE.killed_enemies_this_wave)

        if killer:IsPlayer() then
            local scale = 1
            if victim:GetVar("reward_scale") then
                scale = victim:GetVar("reward_scale")
            end
            local reward = HORDE.kill_reward_base * scale
            killer:AddMoney(reward)
            if not HORDE.player_money_earned[killer:SteamID()] then HORDE.player_money_earned[killer:SteamID()] = 0 end
            HORDE.player_money_earned[killer:SteamID()] = HORDE.player_money_earned[killer:SteamID()] + reward

            if victim:GetVar("is_elite") then
                if not HORDE.player_elite_kills[killer:SteamID()] then HORDE.player_elite_kills[killer:SteamID()] = 0 end
                HORDE.player_elite_kills[killer:SteamID()] = HORDE.player_elite_kills[killer:SteamID()] + 1
            end
            killer:SyncEconomy()
        end
    end
end)

-- Record statistics 
hook.Add("PostEntityTakeDamage", "Horde_PostDamage", function (ent, dmg, took)
    if took then
        if ent:IsNPC() and dmg:GetAttacker():IsPlayer() then
            local id = dmg:GetAttacker():SteamID()
            if not HORDE.player_damage[id] then HORDE.player_damage[id] = 0 end
            HORDE.player_damage[id] = HORDE.player_damage[id] + dmg:GetDamage()
        elseif ent:IsPlayer() and dmg:GetAttacker():IsNPC() then
            local id = ent:SteamID()
            if not HORDE.player_damage_taken[id] then HORDE.player_damage_taken[id] = 0 end
            HORDE.player_damage_taken[id] = HORDE.player_damage_taken[id] + dmg:GetDamage()
        end
    end
end)

hook.Add("ScaleNPCDamage", "Horde_HeadshotCounter", function (npc, hitgroup, dmg)
    if npc:IsValid() and dmg:GetAttacker():IsPlayer() then
        local id = dmg:GetAttacker():SteamID()
        if not HORDE.player_headshots[id] then HORDE.player_headshots[id] = 0 end
        HORDE.player_headshots[id] = HORDE.player_headshots[id] + 1
    end
end)

hook.Add("EntityRemoved", "Horde_EntityRemoved", function(ent)
    if HORDE.spawned_enemies[ent:EntIndex()] then
        HORDE.spawned_enemies[ent:EntIndex()] = nil
        HORDE.alive_enemies_this_wave = HORDE.alive_enemies_this_wave - 1
        HORDE.total_enemies_this_wave = HORDE.total_enemies_this_wave + 1
        print("OnRemove", ent:EntIndex(), HORDE.alive_enemies_this_wave, HORDE.total_enemies_this_wave)
    end
end)

function BroadcastMessage(msg)
    net.Start("Horde_RenderCenterText")
    net.WriteString(msg)
    net.WriteInt(-1,8)
    net.Broadcast()
end

function BroadcastWaveMessage(msg, wave)
    net.Start("Horde_RenderCenterText")
    net.WriteString(msg)
    net.WriteInt(wave,8)
    net.Broadcast()
end

function HardReset()
    HORDE.killed_enemies_this_wave = 0
    HORDE.total_enemies_this_wave = 0
    HORDE.alive_enemies_this_wave = 0
    HORDE.current_wave = 0
    HORDE.current_break_time = HORDE.first_break_time
    -- TODO: clean up all the spawned enemies
end

function SpawnEnemy(enemy, pos)
    local npc_info = list.Get("NPC")[enemy.class]
    if not npc_info then
        print("NPC does not exist in ", list.Get("NPC"))
    end

    local spawned_enemy = ents.Create(enemy.class)
    spawned_enemy:SetPos(pos)
    spawned_enemy:SetAngles(Angle(0, math.random(0, 360), 0))
    spawned_enemy:Spawn()

    HORDE.spawned_enemies[spawned_enemy:EntIndex()] = true

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

    if enemy.is_elite then
        spawned_enemy:SetVar("is_elite", true)
        spawned_enemy:SetMaxHealth(spawned_enemy:GetMaxHealth() * math.max(1, players_count * 0.75))
        spawned_enemy:SetHealth(spawned_enemy:GetMaxHealth())
    end

    if enemy.model_scale then
        spawned_enemy:SetModelScale(enemy.model_scale)
    end

    if enemy.health_scale then
        spawned_enemy:SetMaxHealth(spawned_enemy:GetMaxHealth() * enemy.health_scale)
        spawned_enemy:SetHealth(spawned_enemy:GetMaxHealth())
    end

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

    return spawned_enemy
end

function ScanEnemies()
    local enemies = {}
    for ent_idx, _ in pairs(HORDE.spawned_enemies) do
        if not IsValid(Entity(ent_idx)) then
            HORDE.spawned_enemies[ent_idx] = nil
        else
            table.insert(enemies, Entity(ent_idx))
        end
    end
    return enemies
end

function StartBreak()
    timer.Create('Horder_Counter', 1, 0, function ()
        if not HORDE.start_game then return end
        BroadcastWaveMessage("Next wave starts in " .. HORDE.current_break_time, HORDE.current_break_time)

        if 0 < HORDE.current_break_time then
            HORDE.current_break_time = HORDE.current_break_time - 1
        end
        

        if HORDE.current_break_time <= 10 then
            --surface.PlaySound("radiovoice/eight")
        end
        
        if HORDE.current_break_time == 0 then
            -- New round
            HORDE.current_wave = HORDE.current_wave + 1
            BroadcastWaveMessage("Wave " .. HORDE.current_wave .. " has started!", 0)

            timer.Remove('Horder_Counter')
        end
    end)    
end

timer.Create('Horde_Main', 5, 0, function ()
    local status, err = pcall( function()
    local valid_nodes = {}
    if table.Count(player.GetAll()) <= 0 then
        timer.Remove('Horde')
        HardReset()
        return
    end

    if not HORDE.start_game then
        HardReset()
        local enemies = ScanEnemies()
        if not table.IsEmpty(enemies) then
            for _, enemy in pairs(enemies) do
                enemy:Remove()
            end
        end

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
        else
            BroadcastMessage("Players Ready: " .. tostring(ready_count) .. "/" .. tostring(total_player))
        end
        return
    end
    
    if not HORDE.found_ai_nodes then
        ParseFile()
    end

    if not HORDE.ai_nodes or table.IsEmpty(HORDE.ai_nodes) then
        print("No info_node(s) in map! NPCs will not spawn.")
        return
    end

    if #HORDE.ai_nodes <= 35 then
        print("Enemies may not spawn well on this map, please try another.")
    end

    if (HORDE.current_wave == 0 and HORDE.current_break_time == HORDE.first_break_time) or (HORDE.current_break_time == HORDE.total_break_time) then
        StartBreak()
    end

    if HORDE.current_break_time > 0 then
        return
    end

    -- Start round
    if HORDE.current_break_time == 0 then
        if (HORDE.enemies_normalized == nil) or table.IsEmpty(HORDE.enemies_normalized) then
            HardReset()
            net.Start("Horde_LegacyNotification")
            net.WriteString("Enemies list is empy. Config the enemyy list or no enemies wil spawn.")
            net.WriteInt(1,2)
            net.Broadcast()
            HORDE.start_game = false
            return
        end

        if table.IsEmpty(HORDE.enemies_normalized[HORDE.current_wave]) then
            net.Start("Horde_LegacyNotification")
            net.WriteString("No enemy config set for this wave. Falling back to previous wave settings.")
            net.WriteInt(1,2)
            net.Broadcast()
        end

        players_count = table.Count(player.GetAll())
        local difficulty_coefficient = HORDE.difficulty * 0.05
        HORDE.total_enemies_this_wave = HORDE.total_enemies_per_wave[HORDE.current_wave] * math.ceil(players_count * (0.75 + difficulty_coefficient))
        HORDE.total_enemies_this_wave_fixed = HORDE.total_enemies_this_wave
        HORDE.max_enemies_alive = math.min(50, 20 + 5 * players_count)
        HORDE.alive_enemies_this_wave = 0
        HORDE.current_break_time = -1
        HORDE.killed_enemies_this_wave = 0
        BroadcastMessage("Enemies: " .. HORDE.total_enemies_this_wave)
        -- Close all the shop menus
        net.Start("Horde_ForceCloseShop")
        net.Broadcast()
    end

    local enemies = ScanEnemies()

    -- Check enemy
    for _, enemy in pairs(enemies) do
        local closest = 99999
        local closest_ply = nil
        local enemy_pos = enemy:GetPos()

        for _, ply in pairs(player.GetAll()) do
            local dist = enemy_pos:Distance(ply:GetPos())

            if dist < closest then
                closest_ply = ply
                closest = dist
            end
        end

        if closest > HORDE.max_spawn_distance then
            table.RemoveByValue(enemies, enemy)
            enemy:Remove()
        else
            enemy:SetLastPosition(closest_ply:GetPos())
            enemy:SetTarget(closest_ply)
        end
    end

    if #enemies >= HORDE.max_enemies_alive then
        return
    end

    --Get valid nodes
    for k, v in pairs(HORDE.ai_nodes) do
        local valid = false

        for k2, v2 in pairs(player.GetAll()) do
            local dist = v["pos"]:Distance(v2:GetPos())

            if dist <= HORDE.min_spawn_distance then
                valid = false
                break
            elseif dist < HORDE.max_spawn_distance then
                valid = true
            end
        end

        if not valid then goto cont end

        for k2, v2 in pairs(enemies) do
            local dist = v["pos"]:Distance(v2:GetPos())
            if dist <= 100 then
                valid = false
                break
            end
        end

        if valid then
            table.insert(valid_nodes, v["pos"])
        end

        ::cont::
    end

    --Spawn enemies
    if #valid_nodes > 0 then
        for i = 0, math.random(4,6) do
            if (#enemies + 1 <= HORDE.max_enemies_alive) and (HORDE.total_enemies_this_wave > 0) then
                local pos = table.Random(valid_nodes)
                if pos ~= nil then
                    table.RemoveByValue(valid_nodes, pos)
                    local p = math.random()
                    local p_cum = 0
                    local spawned_enemy
                    local enemy_wave = HORDE.current_wave
                    if table.IsEmpty(HORDE.enemies_normalized[enemy_wave]) then
                        enemy_wave = enemy_wave - 1
                    end
                    for name, weight in pairs(HORDE.enemies_normalized[enemy_wave]) do
                        p_cum = p_cum + weight
                        if p <= p_cum then
                            local enemy = HORDE.enemies[name .. tostring(enemy_wave)]
                            spawned_enemy = SpawnEnemy(enemy, pos + Vector(0,0,HORDE.enemy_spawn_z))
                            table.insert(enemies, spawned_enemy)
                            break
                        end
                    end
                    HORDE.total_enemies_this_wave = HORDE.total_enemies_this_wave - 1
                    HORDE.alive_enemies_this_wave = HORDE.alive_enemies_this_wave + 1
                    print("OnSpawn", spawned_enemy:EntIndex(), HORDE.alive_enemies_this_wave, HORDE.total_enemies_this_wave)
                end
            else
                break
            end
        end
    end

    if HORDE.total_enemies_this_wave <= 0 and HORDE.alive_enemies_this_wave <= 0 then
        HORDE.current_break_time = HORDE.total_break_time
        StartBreak()
        enemies = ScanEnemies()
        if not table.IsEmpty(enemies) then
            for _, enemy in pairs(enemies) do
                enemy:Remove()
            end
        end
        print(HORDE.current_wave, HORDE.max_waves)
        if HORDE.current_wave == HORDE.max_waves then
            BroadcastMessage("Final Wave Completed! You have survived!")
            GameEnd()
        else
            BroadcastMessage("Wave Completed!")
            net.Start("Horde_LegacyNotification")
            net.WriteString("Wave Completed!")
            net.WriteInt(0,2)
            net.Broadcast()
        end

        net.Start("Horde_HighlightEnemies")
        net.WriteInt(0, 2)
        net.Broadcast()

        for _, ply in pairs(player.GetAll()) do
            if not ply:Alive() then ply:Spawn() end
            HORDE.player_class_changed[ply:SteamID()] = false
            HORDE.player_ready[ply:SteamID()] = false
        end

        if GetConVarNumber("horde_npc_cleanup") then
            for _, ent in pairs(ents.GetAll()) do
                if ent:IsNPC() then
                    ent:Remove()
                end
            end
        end
    end
    end)

    if not status then
        print(err)
    end
end)

function GameEnd()
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
        local id = ply:SteamID()
        if HORDE.player_damage[id] and HORDE.player_damage[id] > most_damage then
            second_damage_player = damage_player
            second_most_damage = most_damage
            most_damage = HORDE.player_damage[id]
            damage_player = ply
        end
        total_damage = total_damage + HORDE.player_damage[id]

        if ply:Frags() > most_kills then
            second_kills_player = kills_player
            second_most_kills = most_kills
            most_kills = ply:Frags()
            kills_player = ply
        end

        if HORDE.player_money_earned[id] and HORDE.player_money_earned[id] > most_money then
            most_money = HORDE.player_money_earned[id]
            money_player = ply
        end

        if HORDE.player_damage_taken[id] and HORDE.player_damage_taken[id] > most_damage_taken then
            most_damage_taken = HORDE.player_damage_taken[id]
            damage_taken_player = ply
        end

        if HORDE.player_elite_kills[id] and HORDE.player_elite_kills[id] > most_elite_kills then
            most_elite_kills = HORDE.player_elite_kills[id]
            elite_kill_player = ply
        end

        if HORDE.player_headshots[id] and HORDE.player_headshots[id] > most_headshots then
            most_headshots = HORDE.player_headshots[id]
            headshot_player = ply
        end
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
    BroadcastMessage('Victory!')
end