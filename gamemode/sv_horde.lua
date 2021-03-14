util.AddNetworkString("Horde_HighlightEntities")
util.AddNetworkString("Horde_GameEnd")

local horde_players_count = 0
local horde_spawned_ammoboxes = {}
local horde_ammobox_refresh_timer = HORDE.ammobox_refresh_interval / 2
local horde_in_break = false

HORDE.horde_boss = nil
HORDE.horde_boss_name = nil
local horde_boss_spawned = false
local horde_boss_reposition = false
local horde_boss_properties = nil
local boss_music_loop = nil

-- These are for horde default bosses only,
local horde_boss_critical = nil

local entmeta = FindMetaTable("Entity")
function entmeta:SetHordeMostRecentAttacker(attacker)
	self.most_recent_attacker = attacker
end

function entmeta:GetHordeMostRecentAttacker()
	return self.most_recent_attacker
end

function entmeta:SetHordeName(name)
    self.horde_name = name
end

function entmeta:GetHordeName()
    return self.horde_name
end

function entmeta:SetHordeBossProperties(boss_properties)
    self.horde_boss_properties = boss_properties
end

function entmeta:GetHordeBossProperties()
    return self.horde_boss_properties
end

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

function HORDE:OnEnemyKilled(victim, killer, weapon)
    if HORDE.spawned_enemies[victim:EntIndex()] then
        HORDE.spawned_enemies[victim:EntIndex()] = nil
        if (not HORDE.horde_boss) or (HORDE.horde_boss and (not horde_boss_properties.unlimited_enemies_spawn)) then
            HORDE.alive_enemies_this_wave = HORDE.alive_enemies_this_wave - 1
            HORDE.killed_enemies_this_wave = HORDE.killed_enemies_this_wave + 1
        end
        --print("OnKill", "[HORDE] Killing ", HORDE.alive_enemies_this_wave, HORDE.total_enemies_this_wave)
        
        if (HORDE.total_enemies_this_wave_fixed - HORDE.killed_enemies_this_wave) <= 10 then
            net.Start("Horde_HighlightEntities")
            net.WriteInt(HORDE.render_highlight_enemies, 3)
            net.Broadcast()
        end
        
        if HORDE.endless == 1 then
            if HORDE.horde_boss and HORDE.horde_boss:IsValid() and HORDE.horde_boss:Health() > 0 then
                BroadcastMessage("[" .. HORDE.difficulty_text[HORDE.difficulty] .. "]: " .. tostring(HORDE.current_wave) .. "/∞ BOSS")
            else
                BroadcastMessage("[" .. HORDE.difficulty_text[HORDE.difficulty] .. "]: " .. tostring(HORDE.current_wave) .. "/∞  Enemies: " .. HORDE.total_enemies_this_wave_fixed - HORDE.killed_enemies_this_wave)
            end
        else
            if HORDE.horde_boss and HORDE.horde_boss:IsValid() and HORDE.horde_boss:Health() > 0 then
                BroadcastMessage("[" .. HORDE.difficulty_text[HORDE.difficulty] .. "]: " .. tostring(HORDE.current_wave) .. "/" .. tostring(HORDE.max_waves) .. "  BOSS")
            else
                BroadcastMessage("[" .. HORDE.difficulty_text[HORDE.difficulty] .. "]: " .. tostring(HORDE.current_wave) .. "/" .. tostring(HORDE.max_waves) .. "  Enemies: " .. HORDE.total_enemies_this_wave_fixed - HORDE.killed_enemies_this_wave)
            end
        end
        
        local boss_properties = victim:GetHordeBossProperties()
        local defer_reward = false
        local reward = 0
        if killer:IsPlayer() or killer:GetNWEntity("HordeOwner"):IsPlayer() then
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
                killer:AddHordeMoney(reward)
            end
            
            if not HORDE.player_money_earned[killer:SteamID()] then HORDE.player_money_earned[killer:SteamID()] = 0 end
            HORDE.player_money_earned[killer:SteamID()] = HORDE.player_money_earned[killer:SteamID()] + reward

            if victim:GetVar("is_elite") then
                if not HORDE.player_elite_kills[killer:SteamID()] then HORDE.player_elite_kills[killer:SteamID()] = 0 end
                HORDE.player_elite_kills[killer:SteamID()] = HORDE.player_elite_kills[killer:SteamID()] + 1
            end

            killer:AddFrags(1)
            killer:SyncEconomy()
        end

        -- When a boss is killed.
        if boss_properties then
            -- There could only be 1 boss.
            HORDE.horde_boss = nil
            horde_boss_properties = nil
            if boss_properties.end_wave and boss_properties.end_wave == true then
                HORDE:WaveEnd()
            end
            timer.Remove("Horde_BossMusic")
            if boss_music_loop then
                boss_music_loop:Stop()
            end

            -- Boss reward is global.
            for _, ply in pairs(player.GetAll()) do
                ply:AddHordeMoney(reward)
                ply:SyncEconomy()
            end
        end

        victim:SetHordeMostRecentAttacker(nil)
    end
end

hook.Add("OnNPCKilled", "Horde_OnEnemyKilled", function(victim, killer, weapon)
    HORDE:OnEnemyKilled(victim, killer, weapon)
end)

-- Corpse settings
if GetConVar("horde_corpse_cleanup"):GetInt() == 1 then
	RunConsoleCommand("g_ragdoll_maxcount", "0")
    hook.Add("OnEntityCreated", "Horde_CorpseRemoval", function(ent)
        if ent:IsRagdoll() then
            timer.Simple(0, function ()
                if ent:IsValid() then
                    ent:SetHordeMostRecentAttacker(nil)
                    ent:Remove()
                end
            end)
        end
    end)
else
    RunConsoleCommand("g_ragdoll_maxcount", "20") -- default value
end

-- Record statistics
hook.Add("EntityTakeDamage", "Horde_MinionDamageBelongsToOwner", function (target, dmg)
    if target:IsNPC() then
        local owner = dmg:GetAttacker():GetNWEntity("HordeOwner")
        if owner and owner:IsPlayer() then
            dmg:SetAttacker(owner)
        end
    end
end)

hook.Add("PostEntityTakeDamage", "Horde_PostDamage", function (ent, dmg, took)
    if took then
       if ent:IsNPC() then
            if dmg:GetAttacker():IsPlayer() then
                local id = dmg:GetAttacker():SteamID()
                if not HORDE.player_damage[id] then HORDE.player_damage[id] = 0 end
                HORDE.player_damage[id] = HORDE.player_damage[id] + dmg:GetDamage()
                ent:SetHordeMostRecentAttacker(dmg:GetAttacker())
            end
            local boss_properties = ent:GetHordeBossProperties()
            if boss_properties and boss_properties.is_boss and boss_properties.is_boss == true then
                net.Start("Horde_SyncBossHealth")
                net.WriteInt(ent:Health(), 32)
                net.Broadcast()

                -- Some special music for horde default boss.
                if GetConVar("horde_default_enemy_config"):GetInt() == 1 and boss_music_loop and not horde_boss_critical and ent:Health() < ent:GetMaxHealth() / 2 and ent:GetClass() == "npc_vj_alpha_gonome" then
                    timer.Remove("Horde_BossMusic")
                    boss_music_loop:Stop()
                    boss_music_loop = CreateSound(game.GetWorld(), "music/hl1_song10.mp3")
                    boss_music_loop:SetSoundLevel(0)
                    timer.Create("Horde_BossMusic", 103, 0, function()
                        boss_music_loop:Stop()
                        boss_music_loop:Play()
                    end)
                    boss_music_loop:Play()
                    horde_boss_critical = true
                end
            end
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
    if ent:IsNPC() and ent:GetHordeMostRecentAttacker() then
        HORDE:OnEnemyKilled(ent, ent:GetHordeMostRecentAttacker())
    else
        if HORDE.spawned_enemies[ent:EntIndex()] then
            HORDE.spawned_enemies[ent:EntIndex()] = nil
            HORDE.alive_enemies_this_wave = HORDE.alive_enemies_this_wave - 1
            HORDE.total_enemies_this_wave = HORDE.total_enemies_this_wave + 1
            --print("OnRemove", "[HORDE] Remove ", ent:EntIndex(), HORDE.alive_enemies_this_wave, HORDE.total_enemies_this_wave)
            local count = HORDE.spawned_enemies_count[ent:GetHordeName()]
            if count and count > 0 then
                HORDE.spawned_enemies_count[ent:GetHordeName()] = count - 1
            end
        end
    end
end)

function BroadcastMessage(msg)
    net.Start("Horde_RenderCenterText")
    if msg then
        net.WriteString(msg)
    else
        net.WriteString("")
    end
    net.WriteInt(-1,8)
    net.Broadcast()
end

function BroadcastWaveMessage(msg, wave)
    net.Start("Horde_RenderCenterText")
    net.WriteString(msg)
    net.WriteInt(wave,8)
    net.Broadcast()
end

-- This resets the director.
function HORDE:HardResetDirector()
    HORDE.start_game = false
    HORDE.killed_enemies_this_wave = 0
    HORDE.total_enemies_this_wave = 0
    HORDE.alive_enemies_this_wave = 0
    HORDE.current_wave = 0
    HORDE.current_break_time = HORDE.total_break_time
    horde_in_break = false
    horde_boss_spawned = false
    HORDE.horde_boss = nil
    horde_boss_properties = nil
    horde_boss_reposition = false
    HORDE.horde_boss_name = nil
    if boss_music_loop then
        boss_music_loop:Stop()
        boss_music_loop = nil
    end
end

-- This resets the enemies.
function HORDE:HardResetEnemies()
    local enemies = HORDE:ScanEnemies()
    if not table.IsEmpty(enemies) then
        for _, enemy in pairs(enemies) do
            enemy:SetHordeMostRecentAttacker(nil)
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
    spawned_enemy:SetAngles(Angle(0, math.random(0, 360), 0))
    spawned_enemy:Spawn()

    HORDE.spawned_enemies[spawned_enemy:EntIndex()] = true
    spawned_enemy:SetHordeName(enemy.name)

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

    if enemy.model_scale then
        spawned_enemy:SetModelScale(enemy.model_scale)
    end

    if enemy.boss_properties and enemy.boss_properties.is_boss == true then
        spawned_enemy:SetHordeBossProperties(enemy.boss_properties)
    end

    -- Health settings
    if enemy.is_elite then
        spawned_enemy:SetVar("is_elite", true)
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

    -- This is experimental
    spawned_enemy:SetLagCompensated(true)

    --spawned_enemy:AddRelationship("player D_HT 99")
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
    for _, enemy in pairs(enemies) do
        local boss_properties = enemy:GetHordeBossProperties()
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
                    enemy:SetHordeMostRecentAttacker(nil)
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

        if not valid then goto cont end

        for _, enemy in pairs(enemies) do
            local dist = node["pos"]:Distance(enemy:GetPos())
            if dist <= HORDE.spawn_radius then
                valid = false
                break
            end
        end

        if valid then
            table.insert(valid_nodes, node["pos"])
        end

        ::cont::
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
                local p = math.random()
                local p_cum = 0
                local spawned_enemy
                local enemy_wave = HORDE.current_wave
                
                -- This in fact should not happen
                if HORDE.endless == 0 and table.IsEmpty(HORDE.enemies_normalized[enemy_wave]) then
                    enemy_wave = enemy_wave - 1
                end
                
                -- Endless
                if HORDE.endless == 1 and enemy_wave > HORDE.max_max_waves then
                    enemy_wave = HORDE.max_max_waves
                end
                
                for name, weight in pairs(HORDE.enemies_normalized[enemy_wave]) do
                    p_cum = p_cum + weight
                    if p <= p_cum then
                        local enemy = HORDE.enemies[name .. tostring(enemy_wave)]
                        if enemy.spawn_limit and enemy.spawn_limit > 0 then
                            -- Do not spawn if exceeds spawn limit
                            local count = HORDE.spawned_enemies_count[name]
                            if count and count >= enemy.spawn_limit then
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
                
                HORDE.total_enemies_this_wave = HORDE.total_enemies_this_wave - 1
                HORDE.alive_enemies_this_wave = HORDE.alive_enemies_this_wave + 1
                --print("OnSpawn", "[HORDE] Spawning ", spawned_enemy:EntIndex(), HORDE.alive_enemies_this_wave, HORDE.total_enemies_this_wave)
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
        local enemy_wave = HORDE.current_wave
        
        -- Endless
        -- Boss only spawns on multiples of 10.
        if HORDE.endless == 1 and enemy_wave > HORDE.max_max_waves then
            enemy_wave = HORDE.max_max_waves
        end
        
        local enemy = HORDE.bosses[HORDE.horde_boss_name .. tostring(enemy_wave)]
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
    timer.Create("Horder_Counter", 1, 0, function ()
        if not HORDE.start_game then return end
        BroadcastWaveMessage("Next wave starts in " .. HORDE.current_break_time, HORDE.current_break_time)

        if 0 < HORDE.current_break_time then
            HORDE.current_break_time = HORDE.current_break_time - 1
        end

        if HORDE.current_break_time == 0 then
            -- New round
            HORDE.current_wave = HORDE.current_wave + 1
            BroadcastWaveMessage("Wave " .. HORDE.current_wave .. " has started!", 0)
            horde_in_break = false
            timer.Remove("Horder_Counter")
        end
    end)
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

    horde_players_count = table.Count(player.GetAll())
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
    local current_boss_wave = HORDE.current_wave
    if HORDE.endless == 1 then
        current_boss_wave = current_boss_wave % HORDE.max_max_waves
        if current_boss_wave == 0 then current_boss_wave = 10 end
    end

    local has_boss = HORDE.bosses_normalized[current_boss_wave] and not table.IsEmpty(HORDE.bosses_normalized[HORDE.current_wave])
    if has_boss then
        local p = math.random()
        local p_cum = 0
        for name, weight in pairs(HORDE.bosses_normalized[current_boss_wave]) do
            p_cum = p_cum + weight
            if p <= p_cum then
                HORDE.horde_boss_name = name
                break
            end
        end

        horde_boss_properties = HORDE.bosses[HORDE.horde_boss_name .. current_boss_wave].boss_properties
        if horde_boss_properties.enemies_spawn_threshold <= 0 and horde_boss_properties.end_wave == true then
            -- No enemies will spawn, just the boss.
            HORDE.total_enemies_this_wave = 1
            HORDE.total_enemies_this_wave_fixed = 1
        end
    end

    horde_ammobox_refresh_timer = HORDE.ammobox_refresh_interval
    if HORDE.endless == 1 then
        if horde_boss_properties then
            BroadcastMessage("[" .. HORDE.difficulty_text[HORDE.difficulty] .. "]: " .. tostring(HORDE.current_wave) .. "/∞  BOSS")
        else
            BroadcastMessage("[" .. HORDE.difficulty_text[HORDE.difficulty] .. "]: " .. tostring(HORDE.current_wave) .. "/∞  Enemies: " .. HORDE.total_enemies_this_wave_fixed - HORDE.killed_enemies_this_wave)
        end
    else
        if horde_boss_properties then
            BroadcastMessage("[" .. HORDE.difficulty_text[HORDE.difficulty] .. "]: " .. tostring(HORDE.current_wave) .. "/" .. tostring(HORDE.max_waves) .. "  BOSS")
        else
            BroadcastMessage("[" .. HORDE.difficulty_text[HORDE.difficulty] .. "]: " .. tostring(HORDE.current_wave) .. "/" .. tostring(HORDE.max_waves) .. "  Enemies: " .. HORDE.total_enemies_this_wave_fixed - HORDE.killed_enemies_this_wave)
        end
    end
    -- Close all the shop menus
    net.Start("Horde_ForceCloseShop")
    net.Broadcast()
end

-- Ends a wave.
function HORDE:WaveEnd()
    HORDE.current_break_time = HORDE.total_break_time
    HORDE.horde_boss = nil
    HORDE.horde_boss_name = nil
    horde_in_break = false
    horde_boss_spawned = false
    horde_boss_properties = nil
    horde_boss_reposition = false
    horde_boss_critical = false

    HORDE:StartBreak()
    local enemies = HORDE:ScanEnemies()
    if not table.IsEmpty(enemies) then
        for _, enemy in pairs(enemies) do
            enemy:SetHordeMostRecentAttacker(nil)
            enemy:Remove()
        end
    end
    HORDE.spawned_enemies_count = {}

    if (HORDE.current_wave == HORDE.max_waves) and (HORDE.endless == 0) then
        -- TODO: change this magic number
        BroadcastWaveMessage("Final Wave Completed! You have survived!", -2)
        if boss_music_loop then boss_music_loop:Stop() end
        HORDE:GameEnd("VICTORY!")
    else
        BroadcastWaveMessage("Wave Completed!", -2)
        net.Start("Horde_LegacyNotification")
        net.WriteString("Wave Completed!")
        net.WriteInt(0,2)
        net.Broadcast()
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

    -- Global Wave End Effects
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
        ply:AddHordeMoney(HORDE.round_bonus_base)
        ply:SyncEconomy()
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
        local has_boss = HORDE.bosses_normalized[HORDE.current_wave]
        if has_boss and (not horde_boss_spawned) and (not HORDE.horde_boss) then
            HORDE:SpawnBoss(enemies, valid_nodes)
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
            HORDE:SpawnAmmoboxes(valid_nodes)
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