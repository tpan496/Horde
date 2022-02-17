util.AddNetworkString("Horde_HighlightEntities")
util.AddNetworkString("Horde_DeathMarkHighlight")
util.AddNetworkString("Horde_RemoveDeathMarkHighlight")
util.AddNetworkString("Horde_GameEnd")

local horde_players_count = 0
local horde_spawned_ammoboxes = {}
local horde_ammobox_refresh_timer = HORDE.ammobox_refresh_interval / 2
local horde_in_break = nil
local horde_perk_progress = 1
local horde_current_enemies_list = {}
local horde_force_spawn_enemies = {}

HORDE.horde_boss = nil
HORDE.horde_boss_name = nil
local horde_boss_spawned = false
local horde_boss_reposition = false
local horde_boss_properties = nil
local boss_music_loop = nil

-- These are for horde default bosses only,
local horde_boss_critical = nil

local entmeta = FindMetaTable("Entity")
function entmeta:Horde_SetMostRecentAttacker(attacker)
	self.most_recent_attacker = attacker
end

function entmeta:Horde_GetMostRecentAttacker()
	return self.most_recent_attacker
end

function entmeta:Horde_SetName(name)
    self.horde_name = name
end

function entmeta:Horde_GetName()
    return self.horde_name
end

function entmeta:Horde_SetBossProperties(boss_properties)
    self.horde_boss_properties = boss_properties
end

function entmeta:Horde_GetBossProperties()
    return self.horde_boss_properties
end

hook.Add("InitPostEntity", "Horde_Init", function()
    HORDE.ai_nodes = {}
    local horde_nodes = ents.FindByClass("info_horde_enemy_spawn")
    local horde_boss_nodes = ents.FindByClass("info_horde_boss_spawn")
    HORDE.spawned_enemies = {}
    HORDE.found_ai_nodes = false
    HORDE.found_horde_nodes = false
    if not table.IsEmpty(horde_nodes) then
        for _, node in pairs(horde_nodes) do
            local new_node = {}
            new_node["pos"] = node:GetPos()
            table.insert(HORDE.ai_nodes, new_node)
        end
        HORDE.found_horde_nodes = true
        HORDE.found_ai_nodes = true
    else
        ParseFile()
    end

    if not table.IsEmpty(horde_boss_nodes) then
        HORDE.boss_spawns = {}
        for _, node in pairs(horde_boss_nodes) do
            table.insert(HORDE.boss_spawns, node:GetPos())
        end
    end

    HORDE.ammobox_nodes = {}
    local ammobox_nodes = ents.FindByClass("info_horde_ammobox_spawn")
    if not table.IsEmpty(ammobox_nodes) then
        for _, node in pairs(ammobox_nodes) do
            table.insert(HORDE.ammobox_nodes, node:GetPos())
        end
    end

    HORDE.has_buy_zone = not table.IsEmpty(ents.FindByClass("trigger_horde_buyzone"))

    -- Check spawn distribution
    HORDE.spawn_distribution = HORDE.SPAWN_PROXIMITY
    if not table.IsEmpty(ents.FindByClass("info_horde_spawn_distribution_uniform")) then
        HORDE.spawn_distribution = HORDE.SPAWN_UNIFORM
    elseif not table.IsEmpty(ents.FindByClass("info_horde_spawn_distribution_proximity_noisy")) then
        HORDE.spawn_distribution = HORDE.SPAWN_PROXIMITY_NOISY
    end

    -- Load economy
    for _, ent in pairs(ents.FindByClass("logic_horde_economy")) do
        ent:KeyValue("startingmoney", ent:GetInternalVariable("startingmoney"))
        ent:KeyValue("killrewardbase", ent:GetInternalVariable("killrewardbase"))
        ent:KeyValue("roundbonusbase", ent:GetInternalVariable("roundbonusbase"))
    end
end)

hook.Add("EntityKeyValue", "Horde_EntityKeyValue", function(ent)
    if HORDE.found_horde_nodes then return end 
    if ent:GetClass() == "info_player_teamspawn" then
        local valid = true
        for k,v in pairs(HORDE.ai_nodes) do
            if v["pos"] and v["pos"] == ent:GetPos() then
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

function HORDE:OnEnemyKilled(victim, killer, weapon)
    if victim:IsNPC() and not victim:GetVar("horde_killed") then
        victim:SetVar("horde_killed", true)
        hook.Run("Horde_OnEnemyKilled", victim, killer, weapon)
    end
    if HORDE.spawned_enemies[victim:EntIndex()] then
        HORDE.spawned_enemies[victim:EntIndex()] = nil
        if (not HORDE.horde_boss) or (HORDE.horde_boss and (not horde_boss_properties.unlimited_enemies_spawn)) then
            HORDE.alive_enemies_this_wave = HORDE.alive_enemies_this_wave - 1
            HORDE.killed_enemies_this_wave = HORDE.killed_enemies_this_wave + 1
        end
        
        if (HORDE.total_enemies_this_wave_fixed - HORDE.killed_enemies_this_wave) <= 10 then
            net.Start("Horde_HighlightEntities")
            net.WriteInt(HORDE.render_highlight_enemies, 3)
            net.Broadcast()
        end
        
        if HORDE.endless == 1 then
            if HORDE.horde_boss and HORDE.horde_boss:IsValid() and HORDE.horde_boss:Health() > 0 then
                HORDE:BroadcastEnemiesCountMessage(true, tostring(HORDE.current_wave) .. "/∞", 0)
            else
                HORDE:BroadcastEnemiesCountMessage(false, tostring(HORDE.current_wave) .. "/∞", HORDE.total_enemies_this_wave_fixed - HORDE.killed_enemies_this_wave)
            end
        else
            if HORDE.horde_boss and HORDE.horde_boss:IsValid() and HORDE.horde_boss:Health() > 0 then
                HORDE:BroadcastEnemiesCountMessage(true, tostring(HORDE.current_wave) .. "/" .. tostring(HORDE.max_waves), 0)
            else
                HORDE:BroadcastEnemiesCountMessage(false, tostring(HORDE.current_wave) .. "/" .. tostring(HORDE.max_waves), HORDE.total_enemies_this_wave_fixed - HORDE.killed_enemies_this_wave)
            end
        end
        
        local boss_properties = victim:Horde_GetBossProperties()
        local defer_reward = false
        local reward = 0
        if killer:IsValid() and killer:IsPlayer() or killer:GetNWEntity("HordeOwner"):IsPlayer() then
            if killer:GetNWEntity("HordeOwner"):IsPlayer() then killer = killer:GetNWEntity("HordeOwner") end
            local scale = 1
            if victim:GetVar("reward_scale") then
                scale = victim:GetVar("reward_scale")
            end
            
            reward = HORDE.kill_reward_base * scale
            if boss_properties and boss_properties.is_boss then
                -- Boss reward is global. Defer reward.
                defer_reward = true
            end
            if not defer_reward then
                killer:Horde_AddMoney(reward)
            end

            if victim:GetVar("is_elite") then
                if not HORDE.player_elite_kills[killer:SteamID()] then HORDE.player_elite_kills[killer:SteamID()] = 0 end
                HORDE.player_elite_kills[killer:SteamID()] = HORDE.player_elite_kills[killer:SteamID()] + 1
            end

            killer:AddFrags(1)
            killer:Horde_SyncEconomy()
        end

        -- When a boss is killed.
        if boss_properties then
            -- There could only be 1 boss.
            HORDE.horde_boss = nil
            horde_boss_properties = nil
            if boss_properties.end_wave and boss_properties.end_wave == true then
                HORDE:WaveEnd()
            end

            -- Boss reward is global.
            for _, ply in pairs(player.GetAll()) do
                ply:Horde_AddMoney(reward)
                ply:Horde_SyncEconomy()
            end
        end

        victim:Horde_SetMostRecentAttacker(nil)
        --hook.Run("Horde_OnEnemyKilled", victim, killer, weapon)
    end
end

hook.Add("OnNPCKilled", "Horde_EnemyKilled", function(victim, killer, weapon)
    HORDE:OnEnemyKilled(victim, killer, weapon)
end)

-- Corpse settings
if GetConVar("horde_corpse_cleanup"):GetInt() == 1 then
	RunConsoleCommand("g_ragdoll_maxcount", "0")
    hook.Add("OnEntityCreated", "Horde_CorpseRemoval", function(ent)
        if ent:IsRagdoll() then
            timer.Simple(0, function ()
                if ent:IsValid() then
                    ent:Horde_SetMostRecentAttacker(nil)
                    ent:Remove()
                end
            end)
        end
    end)
else
    RunConsoleCommand("g_ragdoll_maxcount", "20") -- default value
end

-- Record statistics
hook.Add("PostEntityTakeDamage", "Horde_PostDamage", function (ent, dmg, took)
    if took then
        if ent:IsNPC() then
            if dmg:GetAttacker():IsPlayer() then
                local id = dmg:GetAttacker():SteamID()
                if not HORDE.player_damage[id] then HORDE.player_damage[id] = 0 end
                HORDE.player_damage[id] = HORDE.player_damage[id] + dmg:GetDamage()
                ent:Horde_SetMostRecentAttacker(dmg:GetAttacker())
                if GetConVar("horde_testing_display_damage"):GetInt() == 1 then
                    local dmgtype = HORDE:GetDamageType(dmg)
                    net.Start("Horde_LegacyNotification")
                        if dmgtype == HORDE.DMG_PURE then
                            net.WriteString("You dealt " .. dmg:GetDamage() .. " damage to " .. ent:GetClass())
                            net.WriteInt(0,2)
                        else
                            net.WriteString("You dealt " .. dmg:GetDamage() .. " " .. HORDE.DMG_TYPE_STRING[dmgtype] .. " damage to " .. ent:GetClass())
                            net.WriteInt(0,2)
                        end
                    net.Send(dmg:GetAttacker())
                end

                local boss_properties = ent:Horde_GetBossProperties()
                if boss_properties and boss_properties.is_boss and boss_properties.is_boss == true then
                    net.Start("Horde_SyncBossHealth")
                    net.WriteInt(ent:Health(), 32)
                    net.Broadcast()

                    -- Some special music for horde default boss.
                    if GetConVar("horde_default_enemy_config"):GetInt() == 1 and boss_music_loop and not horde_boss_critical and ent.Critical then
                        timer.Remove("Horde_BossMusic")
                        boss_music_loop:Stop()
                        local fierce_music = {"music/hl1_song10.mp3", "music/hl2_song4.mp3", "music/hl2_song25_teleporter.mp3"}
                        local fierce_music_duration = {103, 65, 43}
                        local selected_id = math.random(#fierce_music)
                        boss_music_loop = CreateSound(game.GetWorld(), fierce_music[selected_id])
                        boss_music_loop:SetSoundLevel(0)
                        timer.Create("Horde_BossMusic", fierce_music_duration[selected_id], 0, function()
                            boss_music_loop:Stop()
                            boss_music_loop:Play()
                        end)
                        boss_music_loop:Play()
                        horde_boss_critical = true
                    end
                end
            end
        elseif ent:IsPlayer() and dmg:GetAttacker():IsNPC() then
            local id = ent:SteamID()
            if not HORDE.player_damage_taken[id] then HORDE.player_damage_taken[id] = 0 end
            HORDE.player_damage_taken[id] = HORDE.player_damage_taken[id] + dmg:GetDamage()
            if GetConVar("horde_testing_display_damage"):GetInt() == 1 then
                local dmgtype = HORDE:GetDamageType(dmg)
                net.Start("Horde_LegacyNotification")
                    if dmgtype == HORDE.DMG_PURE then
                        net.WriteString("You received " .. dmg:GetDamage() .. " damage from " .. dmg:GetAttacker():GetClass())
                        net.WriteInt(0,2)
                    else
                        net.WriteString("You received " .. dmg:GetDamage() .. " " .. HORDE.DMG_TYPE_STRING[dmgtype] ..  " damage from " .. dmg:GetAttacker():GetClass())
                        net.WriteInt(0,2)
                    end
                net.Send(ent)
            end
        end
    end
end)

hook.Add("ScaleNPCDamage", "Horde_HeadshotCounter", function (npc, hitgroup, dmg)
    if npc:IsValid() and dmg:GetAttacker():IsPlayer() and hitgroup == HITGROUP_HEAD then
        local id = dmg:GetAttacker():SteamID()
        if not HORDE.player_headshots[id] then HORDE.player_headshots[id] = 0 end
        HORDE.player_headshots[id] = HORDE.player_headshots[id] + 1
    end
end)

hook.Add("EntityRemoved", "Horde_EntityRemoved", function(ent)
    if (ent:IsNPC() or ent:IsNextBot()) and ent:Horde_GetMostRecentAttacker() then
        HORDE:OnEnemyKilled(ent, ent:Horde_GetMostRecentAttacker())
    else
        if HORDE.spawned_enemies[ent:EntIndex()] then
            HORDE.spawned_enemies[ent:EntIndex()] = nil
            HORDE.alive_enemies_this_wave = HORDE.alive_enemies_this_wave - 1
            HORDE.total_enemies_this_wave = HORDE.total_enemies_this_wave + 1
            local count = HORDE.spawned_enemies_count[ent:Horde_GetName()]
            if count and count > 0 then
                HORDE.spawned_enemies_count[ent:Horde_GetName()] = count - 1
            end
            if ent.Horde_Forced_Spawn_Flag then
                local name = ent.Horde_Forced_Spawn_Flag
                table.insert(horde_force_spawn_enemies[name], math.random(1, HORDE.total_enemies_this_wave_fixed))
            end
        end
    end
end)

-- This resets the director.
function HORDE:HardResetDirector()
    HORDE.start_game = false
    HORDE.killed_enemies_this_wave = 0
    HORDE.total_enemies_this_wave = 0
    HORDE.alive_enemies_this_wave = 0
    HORDE.current_wave = 0
    HORDE.current_break_time = HORDE.total_break_time
    horde_in_break = nil
    horde_boss_spawned = false
    HORDE.horde_boss = nil
    horde_boss_properties = nil
    horde_boss_reposition = false
    HORDE.horde_boss_name = nil
    if boss_music_loop then
        boss_music_loop:Stop()
        boss_music_loop = nil
    end
    net.Start("Horde_SyncGameInfo")
        net.WriteUInt(HORDE.current_wave, 16)
    net.Broadcast()
end

-- This resets the enemies.
function HORDE:HardResetEnemies()
    local enemies = HORDE:ScanEnemies()
    if not table.IsEmpty(enemies) then
        for _, enemy in pairs(enemies) do
            enemy:Horde_SetMostRecentAttacker(nil)
            enemy:Remove()
        end
    end
    HORDE.spawned_enemies_count = {}
end

-- Spawns a Horde enemy at the give position.
-- The enemy is tracked by Horde.
function HORDE:SpawnEnemy(enemy, pos)
    local npc_info = list.Get("NPC")[enemy.class]
    if not npc_info then
        print("[HORDE] NPC does not exist in ", list.Get("NPC"))
    end

    local spawned_enemy = ents.Create(enemy.class)
    spawned_enemy:SetPos(pos)
    timer.Simple(0, function() spawned_enemy:SetAngles(Angle(0, math.random(0, 360), 0)) end)
    spawned_enemy:Spawn()

    HORDE.spawned_enemies[spawned_enemy:EntIndex()] = true
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
    if enemy.is_elite and enemy.is_elite == true then
        spawned_enemy:SetVar("is_elite", true)
        local scale
        local add
        if enemy.boss_properties and enemy.boss_properties.is_boss == true then
            scale = horde_players_count
            add = 0.75
        else
            scale = math.min(8, horde_players_count)
            add = 0.60
            if scale > 4 then
                add = 0.55
            end
        end
        spawned_enemy:SetMaxHealth(spawned_enemy:GetMaxHealth() * math.max(HORDE.difficulty_elite_health_scale_multiplier[HORDE.difficulty], scale * HORDE.difficulty_elite_health_scale_multiplier[HORDE.difficulty] * (add + HORDE.difficulty_elite_health_scale_add[HORDE.difficulty])))
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

    -- Mutation
    if enemy.mutation and enemy.mutation ~= "" then
        timer.Simple(0.1, function() spawned_enemy:Horde_SetMutation(enemy.mutation) end)
    else
        local mut_prob = 0
        if enemy.is_elite and enemy.is_elite == true then
            if enemy.boss_properties and enemy.boss_properties.is_boss == true then
                if HORDE.difficulty >= 2 then
                    mut_prob = 1.0
                else
                    mut_prob = 0
                end
            else
                mut_prob = HORDE.difficulty_elite_mutation_probability[HORDE.difficulty]
            end
        else
            mut_prob = HORDE.difficulty_mutation_probability[HORDE.difficulty]
        end

        if mut_prob > 0 then
            local p = math.random()
            if p <= mut_prob then
                local mut = HORDE.current_mutations[math.random(1, #HORDE.current_mutations)]
                timer.Simple(0.1, function() spawned_enemy:Horde_SetMutation(mut) end)
            end

            if HORDE.difficulty >= 4 then
                p = math.random()
                if p <= 0.25 then
                    local mut = HORDE.current_mutations[math.random(1, #HORDE.current_mutations)]
                    timer.Simple(0.1, function() spawned_enemy:Horde_SetMutation(mut) end)
                end
            end
        end
    end
    --[[spawned_enemy.DoRelationshipCheck = function (ent)
        if ent:IsPlayer() or ent:GetNWEntity("HordeOwner"):IsValid() then return true end
        return false
    end]]--
    
    --spawned_enemy:AddRelationship("player D_HT 99")
    --VJ_AddSpeed(spawned_enemy, 4)
    hook.Run("HordeEnemySpawn", spawned_enemy)
    return spawned_enemy
end

-- Scan for Horde enemies.
function HORDE:ScanEnemies()
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

-- Removes enemies that are too far away from players.
function HORDE:RemoveDistantEnemies(enemies)
    if HORDE.found_horde_nodes then return end
    for _, enemy in pairs(enemies) do
        local boss_properties = enemy:Horde_GetBossProperties()
        local closest = 99999
        local closest_z = 99999
        local closest_ply = nil
        local enemy_pos = enemy:GetPos()

        for _, ply in pairs(player.GetAll()) do
            if ply:Alive() then
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
        end

        if closest > HORDE.max_spawn_distance or (closest_z > GetConVarNumber("horde_max_spawn_z_distance")) then
            -- Do not remove bosses, change their positions instead.
            if boss_properties and boss_properties.is_boss and boss_properties.is_boss == true then
                horde_boss_reposition = true
            else
                table.RemoveByValue(enemies, enemy)
                if enemy:IsValid() then
                    enemy:Horde_SetMostRecentAttacker(nil)
                    enemy:Remove()
                end
            end
        else
            if enemy:IsValid() and enemy:IsNPC() then
                enemy:SetLastPosition(closest_ply:GetPos())
                enemy:SetTarget(closest_ply)
            end
        end
    end
end

function HORDE:GetValidNodes(enemies)
    local valid_nodes = {}
    local invalid_nodes = {}
    if HORDE.spawn_distribution == HORDE.SPAWN_UNIFORM then
        for _, node in pairs(HORDE.ai_nodes) do
            table.insert(valid_nodes, node["pos"])
        end
        return valid_nodes
    end

    for _, node in pairs(HORDE.ai_nodes) do
        local valid = false
        local z_dist

        for _, ply in pairs(player.GetAll()) do
            if ply:Alive() then
                local dist = node["pos"]:Distance(ply:GetPos())
                z_dist = math.abs(node["pos"].z - ply:GetPos().z)

                if (dist <= HORDE.min_spawn_distance) or (z_dist >= GetConVarNumber("horde_max_spawn_z_distance")) then
                    valid = false
                    break
                elseif dist < HORDE.max_spawn_distance then
                    valid = true
                end
            end
        end

        if not valid then
            if HORDE.found_horde_nodes then
                table.insert(invalid_nodes, node["pos"])
            end
            goto cont
        end

        for _, enemy in pairs(enemies) do
            local dist = node["pos"]:Distance(enemy:GetPos())
            if dist <= HORDE.spawn_radius then
                valid = false
                break
            end
        end

        if valid then
            table.insert(valid_nodes, node["pos"])
        elseif HORDE.found_horde_nodes then
            table.insert(invalid_nodes, node["pos"])
        end

        ::cont::
    end

    -- Add some noise to spawn
    if HORDE.found_horde_nodes and (HORDE.spawn_distribution == HORDE.SPAWN_PROXIMITY_NOISY or (#valid_nodes <= 0 and #invalid_nodes > 0)) then
        table.insert(valid_nodes, invalid_nodes[math.random(#invalid_nodes)])
    end
    return valid_nodes
end

-- Loops over valid nodes and spawn enemies.
-- Boss should not be spawned in this function.
function HORDE:SpawnEnemies(enemies, valid_nodes)
    for i = 0, math.random(HORDE.min_base_enemy_spawns_per_think + HORDE.difficulty_additional_pack[HORDE.difficulty] + math.floor(horde_players_count/2), HORDE.max_base_enemy_spawns_per_think + HORDE.difficulty_additional_pack[HORDE.difficulty] + horde_players_count) do
        if (#enemies + 1 <= HORDE.max_enemies_alive) and (HORDE.total_enemies_this_wave > 0) then
            local pos = table.Random(valid_nodes)
            if pos ~= nil then
                table.RemoveByValue(valid_nodes, pos)
                local z = pos.z
                pos = pos + VectorRand() * 5
                pos.z = z
                local p = math.random()
                local p_cum = 0
                local spawned_enemy
                local enemy_wave = ((HORDE.current_wave - 1) % HORDE.max_max_waves) + 1

                -- This in fact should not happen
                if table.IsEmpty(horde_current_enemies_list) then
                    net.Start("Horde_LegacyNotification")
                        net.WriteString("Current enemy list is empty!")
                        net.WriteInt(1,2)
                    net.Broadcast()
                    return
                end

                -- Check if we need to force spawn
                local renormalize = nil
                for name, orders in pairs(horde_force_spawn_enemies) do
                    for idx, order in pairs(orders) do
                        if HORDE.total_enemies_this_wave < order then
                            horde_force_spawn_enemies[name][idx] = nil
                            -- Spawn
                            local enemy = HORDE.enemies[name .. tostring(enemy_wave)]
                            if enemy.spawn_limit and enemy.spawn_limit > 0 then
                                -- Do not spawn if exceeds spawn limit
                                local count = HORDE.spawned_enemies_count[name]
                                if count and count >= enemy.spawn_limit then
                                    renormalize = true
                                    horde_current_enemies_list[name] = nil
                                    goto cont3
                                else
                                    spawned_enemy = HORDE:SpawnEnemy(enemy, pos + Vector(0,0,HORDE.enemy_spawn_z))
                                    table.insert(enemies, spawned_enemy)
                                    spawned_enemy.Horde_Forced_Spawn_Flag = name
                                    if count then
                                        HORDE.spawned_enemies_count[name] = count + 1
                                    else
                                        HORDE.spawned_enemies_count[name] = 1
                                    end
                                    goto cont2
                                end
                            else
                                spawned_enemy = HORDE:SpawnEnemy(enemy, pos + Vector(0,0,HORDE.enemy_spawn_z))
                                table.insert(enemies, spawned_enemy)
                                spawned_enemy.Horde_Forced_Spawn_Flag = name
                                goto cont2
                            end
                        end
                    end
                    ::cont3::
                end

                for name, weight in pairs(horde_current_enemies_list) do
                    p_cum = p_cum + weight
                    if p <= p_cum then
                        local enemy = HORDE.enemies[name .. tostring(enemy_wave)]
                        if enemy.spawn_limit and enemy.spawn_limit > 0 then
                            -- Do not spawn if exceeds spawn limit
                            local count = HORDE.spawned_enemies_count[name]
                            if count and count >= enemy.spawn_limit then
                                renormalize = true
                                horde_current_enemies_list[name] = nil
                                goto cont
                            else
                                spawned_enemy = HORDE:SpawnEnemy(enemy, pos + Vector(0,0,HORDE.enemy_spawn_z))
                                table.insert(enemies, spawned_enemy)
                                if count then
                                    HORDE.spawned_enemies_count[name] = count + 1
                                else
                                    HORDE.spawned_enemies_count[name] = 1
                                end
                            end
                        else
                            spawned_enemy = HORDE:SpawnEnemy(enemy, pos + Vector(0,0,HORDE.enemy_spawn_z))
                            table.insert(enemies, spawned_enemy)
                        end

                        break
                    end
                    ::cont::
                end

                ::cont2::

                if renormalize then
                    HORDE:NormalizeEnemiesWeightOnWave(horde_current_enemies_list)
                end

                HORDE.total_enemies_this_wave = HORDE.total_enemies_this_wave - 1
                HORDE.alive_enemies_this_wave = HORDE.alive_enemies_this_wave + 1
            end
        else
            break
        end
    end
end

-- Spawns a Horde boss. Boss is unique.
function HORDE:SpawnBoss(enemies, valid_nodes)
    if (HORDE.horde_boss_name) and (#enemies + 1 <= HORDE.max_enemies_alive) and (not HORDE.horde_boss) and (HORDE.total_enemies_this_wave > 0) then
        -- Boss is unique
        local pos = table.Random(valid_nodes)
        if not pos then return end
        table.RemoveByValue(valid_nodes, pos)
        local spawned_enemy
        local enemy_wave = ((HORDE.current_wave - 1) % HORDE.max_max_waves) + 1

        local enemy = HORDE.bosses[HORDE.horde_boss_name .. tostring(enemy_wave)]
        enemy.is_elite = true
        spawned_enemy = HORDE:SpawnEnemy(enemy, pos + Vector(0,0,HORDE.enemy_spawn_z))
        HORDE.horde_boss = spawned_enemy
        horde_boss_reposition = false
        table.insert(enemies, spawned_enemy)

        net.Start("Horde_SyncBossSpawned")
            net.WriteString(enemy.name)
            net.WriteInt(spawned_enemy:GetMaxHealth(),32)
            net.WriteInt(spawned_enemy:Health(),32)
            if enemy.boss_properties.music then
                boss_music_loop = CreateSound(game.GetWorld(), enemy.boss_properties.music)
                boss_music_loop:SetSoundLevel(0)
                if enemy.boss_properties.music_duration and enemy.boss_properties.music_duration > 0 then
                    timer.Create("Horde_BossMusic", enemy.boss_properties.music_duration, 0, function()
                        boss_music_loop:Stop()
                        boss_music_loop:Play()
                    end)
                end
                boss_music_loop:Play()
            end
        net.Broadcast()

        net.Start("Horde_HighlightEntities")
        net.WriteInt(HORDE.render_highlight_enemies, 3)
        net.Broadcast()

        timer.Simple(5, function()
            net.Start("Horde_HighlightEntities")
            net.WriteInt(HORDE.render_highlight_disable, 3)
            net.Broadcast()
        end)

        HORDE.total_enemies_this_wave = HORDE.total_enemies_this_wave - 1
        HORDE.alive_enemies_this_wave = HORDE.alive_enemies_this_wave + 1
    end
end

function HORDE:RepositionBoss(valid_nodes)
    if (not HORDE.horde_boss) or (not horde_boss_spawned) then return end
    local pos = table.Random(valid_nodes)
    if not pos then return end
    HORDE.horde_boss:SetPos(pos)
end

function HORDE:CheckBossStuck()
    if (not HORDE.horde_boss) or (not horde_boss_spawned) then return end
    local pos = HORDE.horde_boss:GetPos()
    local tr = util.TraceHull({
        start = pos,
        endpos = pos,
        filter = HORDE.horde_boss,
        mins = HORDE.horde_boss:OBBMins(),
        maxs = HORDE.horde_boss:OBBMaxs(),
    })
    if tr.Hit then
        local ent = tr.Entity
        if ent:IsValid() and (ent:GetClass() == "npc_turret_floor" or ent:IsNPC() or ent:IsPlayer()) then return end
        horde_boss_reposition = true
        print("[HORDE] Boss is stuck. Attempting to reposition...")
    end
end

function HORDE:SpawnAmmoboxes(valid_nodes)
    for _, box in pairs(horde_spawned_ammoboxes) do
        if box:IsValid() then box:Remove() end
    end
    horde_spawned_ammoboxes = {}

    for i = 0, math.min(table.Count(player.GetAll()), HORDE.ammobox_max_count_limit) + HORDE.difficulty_additional_ammoboxes[HORDE.difficulty] do
        local pos = table.Random(valid_nodes)
        local spawned_ammobox = ents.Create("horde_ammobox")
        spawned_ammobox:SetPos(pos)
        spawned_ammobox:Spawn()
        table.insert(horde_spawned_ammoboxes, spawned_ammobox)
    end

    if table.Count(horde_spawned_ammoboxes) > 0 then
        net.Start("Horde_HighlightEntities")
        net.WriteInt(HORDE.render_highlight_ammoboxes, 3)
        net.Broadcast()
    end

    horde_ammobox_refresh_timer = HORDE.ammobox_refresh_interval
end

-- Start's a break between waves.
function HORDE:StartBreak()
    if horde_in_break then return end
    horde_in_break = true
    net.Start("Horde_SyncGameInfo")
        net.WriteUInt(HORDE.current_wave, 16)
    net.Broadcast()
    timer.Create("Horder_Counter", 1, 0, function ()
        if not HORDE.start_game then return end
        HORDE:BroadcastBreakCountDownMessage(HORDE.current_break_time, false)

        if 0 < HORDE.current_break_time then
            HORDE.current_break_time = HORDE.current_break_time - 1
        end

        if HORDE.current_break_time == 0 then
            -- New round
            HORDE.current_wave = HORDE.current_wave + 1
            net.Start("Horde_SyncGameInfo")
                net.WriteUInt(HORDE.current_wave, 16)
            net.Broadcast()
            HORDE:BroadcastBreakCountDownMessage(0, false)
            horde_in_break = nil
            timer.Remove("Horder_Counter")
        end
    end)
end

function HORDE:InBreak()
    return horde_in_break
end

-- Starts a wave.
-- 1. Sets the spawn configuration for the current wave.
-- 2. Decides the boss to spawn, if there is one available.
function HORDE:WaveStart()
    if (HORDE.enemies_normalized == nil) or table.IsEmpty(HORDE.enemies_normalized) then
        HORDE:HardResetDirector()
        net.Start("Horde_LegacyNotification")
        net.WriteString("Enemies list is empty. Config the enemy list or no enemies wil spawn.")
        net.WriteInt(1,2)
        net.Broadcast()
        HORDE.start_game = false
        return
    end

    if HORDE.endless == 0 and table.IsEmpty(HORDE.enemies_normalized[HORDE.current_wave]) then
        net.Start("Horde_LegacyNotification")
        net.WriteString("No enemy config set for this wave. Falling back to previous wave settings.")
        net.WriteInt(1,2)
        net.Broadcast()
    end

    local current_wave = ((HORDE.current_wave - 1) % HORDE.max_max_waves) + 1
    horde_players_count = table.Count(player.GetAll())
    horde_current_enemies_list = table.Copy(HORDE.enemies_normalized[current_wave])
    local difficulty_coefficient = HORDE.difficulty * 0.05

    if HORDE.endless == 0 then
        -- No endless
        HORDE.total_enemies_this_wave = HORDE.total_enemies_per_wave[HORDE.current_wave] * math.ceil(horde_players_count * (0.75 + difficulty_coefficient))
    else
        if HORDE.total_enemies_per_wave[HORDE.current_wave] ~= nil then
             -- If we have enough waves, still use them
             HORDE.total_enemies_this_wave = HORDE.total_enemies_per_wave[HORDE.current_wave] * math.ceil(horde_players_count * (0.75 + difficulty_coefficient))
        else
            -- Use wave 10 settings scaled
            HORDE.total_enemies_this_wave = (HORDE.total_enemies_per_wave[HORDE.max_max_waves] + 5 * (HORDE.current_wave - HORDE.max_max_waves)) * math.ceil(horde_players_count * (0.75 + difficulty_coefficient))
            -- Scale damage and health
            HORDE.endless_damage_multiplier = math.max(1, 1.1 ^ (HORDE.current_wave - HORDE.max_max_waves))
            HORDE.endless_health_multiplier = math.max(1, 1.1 ^ (HORDE.current_wave - HORDE.max_max_waves))
        end
    end

    -- Get mutations
    HORDE.current_mutations = {}
    for _, mutation in pairs(HORDE.mutations_rand) do
        if mutation.Wave and HORDE.current_wave >= mutation.Wave then
            table.insert(HORDE.current_mutations, mutation.ClassName)
        elseif not mutation.Wave then
            table.insert(HORDE.current_mutations, mutation.ClassName)
        end
    end
    
    -- Additional custom scaling
    if GetConVar("horde_total_enemies_scaling"):GetInt() > 1 then
        HORDE.total_enemies_this_wave = HORDE.total_enemies_this_wave * GetConVar("horde_total_enemies_scaling"):GetInt()
    end

    
    HORDE.total_enemies_this_wave_fixed = HORDE.total_enemies_this_wave
    local max_enemies_alive_base = GetConVarNumber("horde_max_enemies_alive_base")
    local scale = GetConVarNumber("horde_max_enemies_alive_scale_factor")
    local max_enemies_alive_max = GetConVarNumber("horde_max_enemies_alive_max")
    HORDE.max_enemies_alive = math.floor(math.min(max_enemies_alive_max, max_enemies_alive_base * HORDE.difficulty_max_enemies_alive_scale_factor + scale * horde_players_count))
    HORDE.alive_enemies_this_wave = 0
    HORDE.current_break_time = -1
    HORDE.killed_enemies_this_wave = 0

    -- Decides the boss to spawn.
    local has_boss = HORDE.bosses_normalized[current_wave] and not table.IsEmpty(HORDE.bosses_normalized[current_wave])
    if has_boss then
        local p = math.random()
        local p_cum = 0
        for name, weight in pairs(HORDE.bosses_normalized[current_wave]) do
            p_cum = p_cum + weight
            if p <= p_cum then
                HORDE.horde_boss_name = name
                break
            end
        end

        horde_boss_properties = HORDE.bosses[HORDE.horde_boss_name .. current_wave].boss_properties
        if horde_boss_properties.enemies_spawn_threshold <= 0 and horde_boss_properties.end_wave == true then
            -- No enemies will spawn, just the boss.
            HORDE.total_enemies_this_wave = 1
            HORDE.total_enemies_this_wave_fixed = 1
        end
    end

    horde_ammobox_refresh_timer = HORDE.ammobox_refresh_interval
    if HORDE.endless == 1 then
        if horde_boss_properties then
            HORDE:BroadcastEnemiesCountMessage(true, tostring(HORDE.current_wave) .. "/∞", 0)
        else
            HORDE:BroadcastEnemiesCountMessage(false, tostring(HORDE.current_wave) .. "/∞", HORDE.total_enemies_this_wave_fixed - HORDE.killed_enemies_this_wave)
        end
    else
        if horde_boss_properties then
            HORDE:BroadcastEnemiesCountMessage(true, tostring(HORDE.current_wave) .. "/" .. tostring(HORDE.max_waves), 0)
        else
            HORDE:BroadcastEnemiesCountMessage(false, tostring(HORDE.current_wave) .. "/" .. tostring(HORDE.max_waves), HORDE.total_enemies_this_wave_fixed - HORDE.killed_enemies_this_wave)
        end
    end

    local enemy_wave = ((HORDE.current_wave - 1) % HORDE.max_max_waves) + 1
    horde_force_spawn_enemies = HORDE:GetForcedEnemiesOnWave(horde_current_enemies_list, enemy_wave, HORDE.total_enemies_this_wave_fixed)

    -- Close all the shop menus
    net.Start("Horde_ForceCloseShop")
    net.Broadcast()

    if not HORDE.has_buy_zone then
        net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_CanBuy, 8)
        net.WriteUInt(0, 8)
        net.Broadcast()
    end

    for _, ent in pairs(ents.FindByClass("logic_horde_waves")) do
        if ent.Wave == current_wave or ent.Wave == -1 then
            ent:Input("onwavestart", ent, ent, current_wave)
        end
    end
end

-- Ends a wave.
function HORDE:WaveEnd()
    timer.Remove("Horde_BossMusic")
    if boss_music_loop then
        boss_music_loop:Stop()
    end

    HORDE.current_break_time = HORDE.total_break_time
    HORDE.horde_boss = nil
    HORDE.horde_boss_name = nil
    horde_in_break = nil
    horde_boss_spawned = false
    horde_boss_properties = nil
    horde_boss_reposition = false
    horde_boss_critical = false

    HORDE:StartBreak()
    local enemies = HORDE:ScanEnemies()
    if not table.IsEmpty(enemies) then
        for _, enemy in pairs(enemies) do
            enemy:Horde_SetMostRecentAttacker(nil)
            enemy:Remove()
        end
    end
    HORDE.spawned_enemies_count = {}

    if (HORDE.current_wave >= HORDE.max_waves) and (HORDE.endless == 0) then
        -- TODO: change this magic number
        if boss_music_loop then boss_music_loop:Stop() end
        HORDE:GameEnd("VICTORY")

        boss_music_loop = CreateSound(game.GetWorld(), "music/hl2_song23_suitsong3.mp3")
        boss_music_loop:SetSoundLevel(0)
        timer.Create("Horde_BossMusic", 43, 0, function()
            boss_music_loop:Stop()
            boss_music_loop:Play()
        end)
        boss_music_loop:Play()
    else
        HORDE:BroadcastBreakCountDownMessage(0, true)
        net.Start("Horde_LegacyNotification")
            net.WriteString("Wave Completed!")
            net.WriteInt(0,2)
        net.Broadcast()

        -- Send Tips
        local tip = HORDE:GetTip()
        if tip then
            net.Start("Horde_SyncTip")
                net.WriteString(HORDE:GetTip())
            net.Broadcast()
        end
    end

    net.Start("Horde_HighlightEntities")
    net.WriteInt(HORDE.render_highlight_disable, 3)
    net.Broadcast()

    for _, ply in pairs(player.GetAll()) do
        if not ply:Alive() then ply:Spawn() end
        HORDE.player_class_changed[ply:SteamID()] = false
        HORDE.player_ready[ply] = 0
    end

    if GetConVarNumber("horde_npc_cleanup") == 1 then
        for _, ent in pairs(ents.GetAll()) do
            if ent:IsNPC() and not ent:GetNWEntity("HordeOwner"):IsPlayer() then
                ent:Remove()
            end
        end
    end

    -- Also turnoff boss health bar.
    net.Start("Horde_SyncBossHealth")
        net.WriteInt(0, 32)
    net.Broadcast()

    -- Global Wave End Effects
    if horde_perk_progress <= 4 and HORDE:Horde_GetWaveForPerk(horde_perk_progress) and HORDE.current_wave >= HORDE:Horde_GetWaveForPerk(horde_perk_progress) then
        timer.Simple(1, function()
            net.Start("Horde_LegacyNotification")
                net.WriteString("Tier " .. horde_perk_progress .. " perks have been unlocked!")
                net.WriteInt(0,2)
            net.Broadcast()
            horde_perk_progress = horde_perk_progress + 1
        end)
    end
    for _, ply in pairs(player.GetAll()) do
        -- Minion life recovery
        if HORDE.player_drop_entities[ply:SteamID()] then
            for _, ent in pairs(HORDE.player_drop_entities[ply:SteamID()]) do
                if ent:IsNPC() then
                    ent:SetHealth(ent:GetMaxHealth())
                end
            end
        end
        -- Round bonus
        ply:Horde_AddMoney(HORDE.round_bonus_base)
        ply:Horde_SyncEconomy()
        ply:Horde_SetGivenStarterWeapons(nil)
        ply:Horde_ApplyPerksForClass()
        if GetConVar("horde_enable_rank"):GetInt() == 1 then
            HORDE:SaveRank(ply)
        end
        
        ply:Horde_SyncExp()
    end

    if not HORDE.has_buy_zone then
        net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_CanBuy, 8)
        net.WriteUInt(1, 8)
        net.Broadcast()
    end

    for _, ent in pairs(ents.FindByClass("logic_horde_waves")) do
        if ent.Wave == HORDE.current_wave or ent.Wave == -1 then
            ent:Input("onwaveend", ent, ent, HORDE.current_wave)
        end
    end
end

-- Referenced some spawning mechanics from Zombie Invasion+
local director_interval = 5
if GetConVarNumber("horde_director_interval") then
    director_interval = math.max(9, GetConVarNumber("horde_director_interval"))
end

-- Game Director. Executes at every given interval.
-- The director is responsible for:
-- 1. spawning enemies/ammoboxes.
-- 2. updating player/wave states.
function HORDE:Direct()
    if table.Count(player.GetAll()) <= 0 then
        -- Reset game state
        HORDE:HardResetDirector()
        HORDE:HardResetEnemies()
        HORDE.player_ready = {}
    end

    if not HORDE.start_game then
        HORDE:HardResetDirector()
        HORDE:HardResetEnemies()

        local ready_count = 0
        local total_player = 0
        for _, ply in pairs(player.GetAll()) do
            if HORDE.player_ready[ply] == 1 then
                ready_count = ready_count + 1
            end
            total_player = total_player + 1
        end

        if total_player > 0 and total_player == ready_count then 
            HORDE.start_game = true
        else
            HORDE:BroadcastPlayersReadyMessage(tostring(ready_count) .. "/" .. tostring(total_player))
        end
        return
    end

    if not HORDE.found_ai_nodes then
        ParseFile()
    end

    if not HORDE.ai_nodes or table.IsEmpty(HORDE.ai_nodes) then
        print("[HORDE] No info_node(s) in map! NPCs will not spawn.")
        net.Start("Horde_LegacyNotification")
            net.WriteString("Map has no info nodes! NPCs will not spawn.")
            net.WriteInt(1,2)
        net.Broadcast()
        return
    end

    if (not HORDE.found_horde_nodes) and (#HORDE.ai_nodes <= 35) then
        print("Enemies may not spawn well on this map, please try another.")
    end

    if HORDE.current_break_time > 0 and HORDE.current_break_time <= HORDE.total_break_time then
        HORDE:StartBreak()
    end

    if HORDE.current_break_time > 0 then
        return
    end

    -- Start round
    if HORDE.current_break_time == 0 then
        HORDE:WaveStart()
        hook.Run("HordeWaveStart", HORDE.current_wave)
    end

    -- Decrease ammobox refresh timer
    if HORDE.enable_ammobox == 1 then
        horde_ammobox_refresh_timer = horde_ammobox_refresh_timer - director_interval
        net.Start("Horde_AmmoboxCountdown")
        net.WriteInt(horde_ammobox_refresh_timer, 8)
        net.Broadcast()
    end
    
    -- Check enemy
    local enemies = HORDE:ScanEnemies()
    HORDE:RemoveDistantEnemies(enemies)

    if #enemies >= HORDE.max_enemies_alive then
        return
    end

    --Get valid nodes
    local valid_nodes = HORDE:GetValidNodes(enemies)
    if #valid_nodes > 0 then
        -- If we already have a boss, check if he is stuck.
        HORDE:CheckBossStuck()

        -- Spawn boss
        local wave = HORDE.current_wave % HORDE.max_max_waves
        if wave == 0 then wave = 10 end
        local has_boss = HORDE.bosses_normalized[wave]
        if has_boss and (not horde_boss_spawned) and (not HORDE.horde_boss) then
            if HORDE.boss_spawns and #HORDE.boss_spawns > 0 then
                HORDE:SpawnBoss(enemies, HORDE.boss_spawns)
            else
                HORDE:SpawnBoss(enemies, valid_nodes)
            end
            hook.Run("HordeBossSpawn", HORDE.horde_boss)
            horde_boss_spawned = true
        elseif horde_boss_reposition then
            HORDE:RepositionBoss(valid_nodes)
            horde_boss_reposition = false
        end

        --Spawn enemies
        if (not horde_boss_properties) then
            HORDE:SpawnEnemies(enemies, valid_nodes)
        else
            if HORDE.horde_boss and (HORDE.horde_boss:Health() <= horde_boss_properties.enemies_spawn_threshold * HORDE.horde_boss:GetMaxHealth()) then
                HORDE:SpawnEnemies(enemies, valid_nodes)
            end
        end
        
        -- Spawn ammoboxes
        if horde_ammobox_refresh_timer <= 0 then
            if HORDE.ammobox_nodes and not (table.IsEmpty(HORDE.ammobox_nodes)) then
                HORDE:SpawnAmmoboxes(HORDE.ammobox_nodes)
            else
                HORDE:SpawnAmmoboxes(valid_nodes)
            end
        end
    end

    if HORDE.total_enemies_this_wave <= 0 and HORDE.alive_enemies_this_wave <= 0 then
        HORDE:WaveEnd()
        hook.Run("HordeWaveEnd", HORDE.current_wave)
    end
end

timer.Create("Horde_Main", director_interval, 0, function ()
    local status, err = pcall(function() HORDE:Direct() end)

    if not status then
        print(err)
    end
end)