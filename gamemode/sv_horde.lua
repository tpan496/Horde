if CLIENT then return end
-- HORDE SERVER

util.AddNetworkString("HighlightEnemies")

hook.Add("Initialize", "Horde_Init", function()
    _G.ai_nodes = {}
    _G.spawned_enemies = {}
    _G.found_ai_nodes = false
    ParseFile()
end)

hook.Add("EntityKeyValue", "Horde_EntityKeyValue", function(ent)
    if ent:GetClass() == "info_player_teamspawn" then
        local valid = true
        for k,v in pairs(_G.ai_nodes) do
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
            table.insert(_G.ai_nodes, node)
        end
    end
end)

hook.Add("OnNPCKilled","Horde_OnNPCKilled", function(victim, killer, weapon)
    if _G.spawned_enemies[victim:EntIndex()] then
        _G.spawned_enemies[victim:EntIndex()] = nil
        _G.alive_enemies_this_wave = _G.alive_enemies_this_wave - 1
        print("OnKill", _G.alive_enemies_this_wave, _G.total_enemies_this_wave)
        if _G.alive_enemies_this_wave <= 10 and _G.total_enemies_this_wave <= 10 then
            print("Notify Highlight")
            net.Start("HighlightEnemies")
            net.WriteInt(1, 2)
            net.Broadcast()
        end
    end
end)

hook.Add("EntityRemoved", "Horde_EntityRemoved", function(ent)
    if _G.spawned_enemies[ent:EntIndex()] then
        _G.spawned_enemies[ent:EntIndex()] = nil
        _G.alive_enemies_this_wave = _G.alive_enemies_this_wave - 1
        _G.total_enemies_this_wave = _G.total_enemies_this_wave + 1
        print("OnRemove", ent:EntIndex(), _G.alive_enemies_this_wave, _G.total_enemies_this_wave)
    end
end)

function Reset()
    _G.total_enemies_this_wave = 0
    _G.alive_enemies_this_wave = 0
    _G.current_wave = 0
    _G.current_break_time = _G.total_break_time
    -- TODO: clean up all the spawned enemies
end

function SpawnEnemy(class, pos)
    npc_info = list.Get("NPC")[class]
    if not npc_info then
        Print("NPC does not exist in ", list.Get("NPC"))
    end

    local enemy = ents.Create(class)
    enemy:SetPos(pos)
    enemy:SetAngles(Angle(0, math.random(0, 360), 0))
    enemy:Spawn()

    _G.spawned_enemies[enemy:EntIndex()] = true

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
    for ent_idx, _ in pairs(_G.spawned_enemies) do
        if not IsValid(Entity(ent_idx)) then
            _G.spawned_enemies[ent_idx] = nil
        else
            table.insert(enemies, Entity(ent_idx))
        end
    end
    return enemies
end

function StartBreak()
    timer.Create('Horder_Counter', 1, 0, function ()
        if not _G.start_game then return end
        if 0 < _G.current_break_time then
            _G.current_break_time = _G.current_break_time - 1
        end
        if _G.current_break_time <= 10 then
            PrintMessage(HUD_PRINTTALK, "Countdown " .. _G.current_break_time)
        end
        if _G.current_break_time == 0 then
            -- New round
            _G.current_wave = _G.current_wave + 1
            PrintMessage(HUD_PRINTTALK, "WAVE " .. _G.current_wave .. " has started!")
            timer.Remove('Horder_Counter')
        end
    end)    
end

timer.Create('Horde_Main', 5, 0, function ()
    local status, err = pcall( function()
    local valid_nodes = {}
    if table.Count(player.GetAll()) <= 0 then
        timer.Remove('Horde')
        Reset()
        return
    end

    if not _G.start_game then
        Reset()
        local enemies = ScanEnemies()
        for _, enemy in enemies do
            enemy:Remove()
        end
        PrintMessage(HUD_PRINTTALK, "Waiting to start the game...")
        return 
    end
    
    if not _G.found_ai_nodes then
        ParseFile()
    end

    if not _G.ai_nodes or table.Count(_G.ai_nodes) < 1 then
        print("No info_node(s) in map! NPCs will not spawn.")
        return
    end

    if table.Count(_G.ai_nodes) <= 35 then
        print("Enemies may not spawn well on this map, please try another.")
    end

    if _G.current_break_time == _G.total_break_time then
        StartBreak()
    end

    if _G.current_break_time > 0 then
        return
    end

    -- Start round
    if _G.current_break_time == 0 then
        _G.total_enemies_this_wave = _G.total_enemies_per_wave[_G.current_wave]
        _G.alive_enemies_this_wave = 0
        _G.current_break_time = -1
        PrintMessage(HUD_PRINTTALK, "Total Enemies: " .. _G.total_enemies_this_wave)
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

        if closest > _G.max_spawn_distance * 1.25 then
            table.RemoveByValue(enemies, v)
            enemy:Remove()
        else
            enemy:SetLastPosition(closest_ply:GetPos())
            enemy:SetTarget(closest_ply)
        end
    end

    if #enemies >= _G.max_enemies_alive then
        return
    end

    --Get valid nodes
    for k, v in pairs(_G.ai_nodes) do
        local valid = false

        for k2, v2 in pairs(player.GetAll()) do
            local dist = v["pos"]:Distance(v2:GetPos())

            if dist <= _G.min_spawn_distance then
                valid = false
                break
            elseif dist < _G.max_spawn_distance then
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
        for i = 0, 4 do
            if (#enemies + i < 20) and (_G.total_enemies_this_wave > 0) then
                local pos = table.Random(valid_nodes)
                if pos ~= nil then
                    table.RemoveByValue(valid_nodes, pos)
                    local p = math.random()
                    local p_cum = 0
                    local enemy
                    for class, weight in pairs(EnemiesList[_G.current_wave]) do
                        p_cum = p_cum + weight
                        if p <= p_cum then
                            enemy = SpawnEnemy(class, pos + Vector(0,0,_G.enemy_spawn_z))
                            table.insert(enemies, enemy)
                            break
                        end
                    end
                    _G.total_enemies_this_wave = _G.total_enemies_this_wave - 1
                    _G.alive_enemies_this_wave = _G.alive_enemies_this_wave + 1
                    print("OnSpawn", enemy:EntIndex(), _G.alive_enemies_this_wave, _G.total_enemies_this_wave)
                end
            else
                break
            end
        end
    end

    if _G.total_enemies_this_wave <= 0 and _G.alive_enemies_this_wave <= 0 then
        _G.current_break_time = _G.total_break_time
        StartBreak()
        if _G.current_wave == 5 then
            PrintMessage(HUD_PRINTTALK ,"Final Wave Completed! You have survived!")
        else
            PrintMessage(HUD_PRINTTALK ,"Wave Completed!")
        end
        net.Start("HighlightEnemies")
        net.WriteInt(0, 2)
        net.Broadcast()

        for _, ply in pairs(player.GetAll()) do
            if not ply:Alive() then ply:Spawn() end
        end
    end
    end)

    if not status then
        print(err)
    end
end)