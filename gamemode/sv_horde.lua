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
        --print("OnKill", HORDE.alive_enemies_this_wave, HORDE.total_enemies_this_wave)
        HORDE.killed_enemies_this_wave = HORDE.killed_enemies_this_wave + 1
        if (HORDE.total_enemies_this_wave_fixed - HORDE.killed_enemies_this_wave) <= 10 then
            --print("Highlight")
            net.Start("Horde_HighlightEnemies")
            net.WriteInt(1, 2)
            net.Broadcast()
        end
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

            killer:AddFrags(1)
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
        --print("OnRemove", ent:EntIndex(), HORDE.alive_enemies_this_wave, HORDE.total_enemies_this_wave)
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

    if enemy.weapon and enemy.weapon ~= "" then
        spawned_enemy:Give(enemy.weapon)
    end

    -- This is experimental
    --spawned_enemy:SetSquad("horde")

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

-- Referenced some spawning mechanics from Zombie Invasion+
local director_interval = 5
if GetConVarNumber("horde_director_interval") then
    director_interval = GetConVarNumber("horde_director_interval")
end

timer.Create('Horde_Main', director_interval, 0, function ()
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
        local max_enemies_alive_base = GetConVarNumber("horde_max_enemies_alive_base")
        local scale = GetConVarNumber("horde_max_enemies_alive_scale_factor")
        local max_enemies_alive_max = GetConVarNumber("horde_max_enemies_alive_max")
        HORDE.max_enemies_alive = math.min(max_enemies_alive_max, max_enemies_alive_base + scale * players_count)
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
        local closest_z = 99999
        local closest_ply = nil
        local enemy_pos = enemy:GetPos()

        for _, ply in pairs(player.GetAll()) do
            local dist = enemy_pos:Distance(ply:GetPos())
            local z_dist = math.abs(ply:GetPos().z - enemy_pos.z)

            if dist < closest then
                closest_ply = ply
                closest = dist
            end
            if z_dist < closest_z then
                closest_z = z_dist
            end
        end

        if closest > HORDE.max_spawn_distance or (closest_z > GetConVarNumber("horde_max_spawn_z_distance")) then
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
    for _, node in pairs(HORDE.ai_nodes) do
        local valid = false

        for _, ply in pairs(player.GetAll()) do
            local dist = node["pos"]:Distance(ply:GetPos())
            local z_dist = math.abs(node["pos"].z - ply:GetPos().z)

            if (dist <= HORDE.min_spawn_distance) or (z_dist >= GetConVarNumber("horde_max_spawn_z_distance")) then
                valid = false
                break
            elseif dist < HORDE.max_spawn_distance then
                valid = true
            end
        end

        if not valid then goto cont end

        for _, enemy in pairs(enemies) do
            local dist = node["pos"]:Distance(enemy:GetPos())
            if dist <= 50 then
                valid = false
                break
            end
        end

        if valid then
            table.insert(valid_nodes, node["pos"])
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
                    -- print("OnSpawn", spawned_enemy:EntIndex(), HORDE.alive_enemies_this_wave, HORDE.total_enemies_this_wave)
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
        
        if HORDE.current_wave == HORDE.max_waves then
            BroadcastMessage("Final Wave Completed! You have survived!")
            HORDE.GameEnd("Victory")
            timer.Simple(5, function ()
                net.Start("Horde_LegacyNotification")
                net.WriteString("Changing map to " .. game.GetMapNext() .. " in 30 seconds!", NOTIFY_GENERIC, 5)
                net.Broadcast()
            end)
            timer.Simple(35, function() timer.Simple(0, function() RunConsoleCommand("changelevel", game.GetMapNext()) end) end)
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