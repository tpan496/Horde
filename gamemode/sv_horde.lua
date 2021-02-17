if CLIENT then return end
-- HORDE SERVER

util.AddNetworkString("Horde_HighlightEnemies")

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
            print("Notify Highlight")
            net.Start("Horde_HighlightEnemies")
            net.WriteInt(1, 2)
            net.Broadcast()
        end
        HORDE.killed_enemies_this_wave = HORDE.killed_enemies_this_wave + 1
        BroadcastMessage("Enemies: " .. HORDE.total_enemies_per_wave[HORDE.current_wave] - HORDE.killed_enemies_this_wave)

        if killer:IsPlayer() then
            killer:AddMoney(150)
            killer:SyncEconomy()
        end
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

function SpawnEnemy(class, pos)
    local npc_info = list.Get("NPC")[class]
    if not npc_info then
        Print("NPC does not exist in ", list.Get("NPC"))
    end

    local enemy = ents.Create(class)
    enemy:SetPos(pos)
    enemy:SetAngles(Angle(0, math.random(0, 360), 0))
    enemy:Spawn()

    HORDE.spawned_enemies[enemy:EntIndex()] = true

    if npc_info["Model"] then
        enemy:SetModel(npc_info["Model"])
    end

    if npc_info["SpawnFlags"] then
        enemy:SetKeyValue("spawnflags", npc_info["SpawnFlags"])
    end
    enemy:SetKeyValue("spawnflags", SF_NPC_FADE_CORPSE)

    if npc_info["KeyValues"] then
        for k, v in pairs(npc_info["KeyValues"]) do
            enemy:SetKeyValue(k, v)
        end
    end
            
    enemy:Fire("StartPatrolling")
    enemy:Fire("SetReadinessHigh")
    if enemy:IsNPC() then
        enemy:SetNPCState(NPC_STATE_COMBAT)
    end

    return enemy
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
        if 0 < HORDE.current_break_time then
            HORDE.current_break_time = HORDE.current_break_time - 1
        end
        
        BroadcastMessage("Next wave starts in " .. HORDE.current_break_time)
        
        if HORDE.current_break_time == 0 then
            -- New round
            HORDE.current_wave = HORDE.current_wave + 1
            BroadcastMessage("Wave " .. HORDE.current_wave .. " has started!")

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
            net.WriteString("Enemies list are empy. Config the enemyy list or no enemies wil spawn.")
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
        HORDE.total_enemies_this_wave = HORDE.total_enemies_per_wave[HORDE.current_wave]
        HORDE.alive_enemies_this_wave = 0
        HORDE.current_break_time = -1
        HORDE.killed_enemies_this_wave = 0
        BroadcastMessage("Enemies: " .. HORDE.total_enemies_this_wave)
        -- Close all the shop menus
        net.Start("Horde_ForceCloseShop")
        net.Broadcast()
    end

    local enemies = ScanEnemies()

    --Check zombie
    for _, enemy in pairs(enemies) do
        local closest = 99999
        local closest_ply = NULL
        local enemy_pos = enemy:GetPos()

        for _, ply in pairs(player.GetAll()) do
            local dist = enemy_pos:Distance(ply:GetPos())

            if dist < closest then
                closest_ply = ply
                closest = dist
            end
        end

        if closest > HORDE.max_spawn_distance * 1.25 then
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
                    local enemy
                    local enemy_wave = HORDE.current_wave
                    if table.IsEmpty(HORDE.enemies_normalized[enemy_wave]) then
                        enemy_wave = enemy_wave - 1
                    end
                    for class, weight in pairs(HORDE.enemies_normalized[enemy_wave]) do
                        p_cum = p_cum + weight
                        if p <= p_cum then
                            enemy = SpawnEnemy(class, pos + Vector(0,0,HORDE.enemy_spawn_z))
                            table.insert(enemies, enemy)
                            break
                        end
                    end
                    HORDE.total_enemies_this_wave = HORDE.total_enemies_this_wave - 1
                    HORDE.alive_enemies_this_wave = HORDE.alive_enemies_this_wave + 1
                    print("OnSpawn", enemy:EntIndex(), HORDE.alive_enemies_this_wave, HORDE.total_enemies_this_wave)
                end
            else
                break
            end
        end
    end

    if HORDE.total_enemies_this_wave <= 0 and HORDE.alive_enemies_this_wave <= 0 then
        HORDE.current_break_time = HORDE.total_break_time
        StartBreak()
        local enemies = ScanEnemies()
        if not table.IsEmpty(enemies) then
            for _, enemy in pairs(enemies) do
                enemy:Remove()
            end
        end
        if HORDE.current_wave == HORDE.max_waves then
            BroadcastMessage("Final Wave Completed! You have survived!")
        else
            BroadcastMessage("Wave Completed!")
        end
        net.Start("Horde_HighlightEnemies")
        net.WriteInt(0, 2)
        net.Broadcast()

        for _, ply in pairs(player.GetAll()) do
            if not ply:Alive() then ply:Spawn() end
            HORDE.player_class_changed[ply:SteamID()] = false
            HORDE.player_ready[ply:SteamID()] = false
        end
    end
    end)

    if not status then
        print(err)
    end
end)