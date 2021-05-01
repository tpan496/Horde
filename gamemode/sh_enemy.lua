-- Enemies
HORDE.enemies = {}
HORDE.bosses = {}
HORDE.enemies_normalized = {}
HORDE.bosses_normalized = {}

-- Creates a Horde enemy.
function HORDE:CreateEnemy(name, class, weight, wave, is_elite, health_scale, damage_scale, reward_scale, model_scale, color, weapon, spawn_limit, boss_properties, mutation, skin, model)
    if name == nil or class == nil or wave == nil or wave <= 0 or name == "" or class == "" then return end
    local enemy = {}
    enemy.name = name
    enemy.class = class
    enemy.weight = math.max(0,weight)
    enemy.wave = math.max(1,wave)
    enemy.health_scale = health_scale and health_scale or 1
    enemy.damage_scale = damage_scale and damage_scale or 1
    enemy.reward_scale = reward_scale and reward_scale or 1
    enemy.model_scale = model_scale and model_scale or 1
    enemy.color = color
    enemy.weapon = weapon
    enemy.spawn_limit = spawn_limit and spawn_limit or 0
    enemy.is_elite = is_elite and is_elite or 0
    enemy.boss_properties = boss_properties and boss_properties or {}
    -- Prevent infinite rounds
    if enemy.boss_properties then
        if enemy.boss_properties.unlimited_enemies_spawn and (not enemy.boss_properties.end_wave) then
            enemy.boss_properties.end_wave = true
        end
    end
    enemy.mutation = mutation or nil
    if skin and skin ~= "" then
        enemy.skin = skin
    end
    if model and model ~= "" then enemy.model = model end

    HORDE.enemies[name .. tostring(enemy.wave)] = enemy
end

function HORDE:NormalizeEnemiesWeightOnWave(enemies)
    local total_weight = 0
    for name, weight in pairs(enemies) do
        total_weight = total_weight + weight
    end
    for name, weight in pairs(enemies) do
        enemies[name] = weight / total_weight
    end
end

function HORDE:NormalizeEnemiesWeight()
    if table.IsEmpty(HORDE.enemies) then return end

    for _, enemy in pairs(HORDE.enemies) do
        if enemy.boss_properties and enemy.boss_properties.is_boss and enemy.boss_properties.is_boss == true then
            if not HORDE.bosses[enemy.wave] then HORDE.bosses[enemy.wave] = {} end
            HORDE.bosses[enemy.name .. enemy.wave] = enemy
        end
    end

    for wave = 1, HORDE.max_max_waves do
        HORDE.enemies_normalized[wave] = {}
        local total_weight = 0
        for _, enemy in pairs(HORDE.enemies) do
            if enemy.boss_properties and enemy.boss_properties.is_boss and enemy.boss_properties.is_boss == true then
                goto cont
            end
            if enemy.wave == wave then
                total_weight = total_weight + enemy.weight
            end
            ::cont::
        end
        for _, enemy in pairs(HORDE.enemies) do
            if enemy.boss_properties and enemy.boss_properties.is_boss and enemy.boss_properties.is_boss == true then
                goto cont
            end
            if enemy.wave == wave then
                -- For some reason lua table key does not support nested tables lmao
                HORDE.enemies_normalized[wave][enemy.name] = enemy.weight / total_weight
            end
            ::cont::
        end
    end

    for wave = 1, HORDE.max_max_waves do
        HORDE.bosses_normalized[wave] = {}
        local total_weight = 0
        for _, enemy in pairs(HORDE.bosses) do
            if enemy.wave == wave then
                total_weight = total_weight + enemy.weight
            end
        end
        for _, enemy in pairs(HORDE.bosses) do
            if enemy.wave == wave then
                HORDE.bosses_normalized[wave][enemy.name] = enemy.weight / total_weight
            end
        end
    end

end

HORDE.InvalidateHordeEnemyCache = 1
HORDE.CachedHordeEnemies = nil
HORDE.GetCachedHordeEnemies = function()
    if HORDE.InvalidateHordeEnemyCache == 1 then
        local tab = util.TableToJSON(HORDE.enemies)
        local str = util.Compress(tab)
        HORDE.CachedHordeEnemies = str
        HORDE.InvalidateHordeEnemyCache = 0
    end
    return HORDE.CachedHordeEnemies
end

function HORDE:SyncEnemiesTo(ply)
    local str = HORDE.GetCachedHordeEnemies()
    net.Start("Horde_SyncEnemies")
        net.WriteUInt(string.len(str), 32)
        net.WriteData(str, string.len(str))
    net.Send(ply)
end

function HORDE:SyncMutationsTo(ply)
    net.Start("Horde_SyncMutations")
        -- Send the client simplified mutations
        local muts = {}
        for mut_name, mut in pairs(HORDE.mutations) do
            muts[mut_name] = mut.Description
        end
        net.WriteTable(muts)
    net.Send(ply)
end

function HORDE:SetEnemiesData()
    if SERVER then
        HORDE:NormalizeEnemiesWeight()

        if GetConVarNumber("horde_default_enemy_config") == 1 then return end
        if not file.IsDir("horde", "DATA") then
            file.CreateDir("horde")
        end

        file.Write("horde/enemies.txt", util.TableToJSON(HORDE.enemies))
    end
end

local function GetEnemiesData()
    if SERVER then
        if not file.IsDir("horde", "DATA") then
            file.CreateDir("horde")
            return
        end

        if file.Read("horde/enemies.txt", "DATA") then
            local t = util.JSONToTable(file.Read("horde/enemies.txt", "DATA"))
            -- Integrity
            for _, enemy in pairs(t) do
                if enemy.name == nil or enemy.name == "" or enemy.class == nil or enemy.class == "" or enemy.weight == nil or enemy.wave == nil then
                    net.Start("Horde_LegacyNotification")
                        net.WriteString("Enemy config file validation failed! Please update your file or delete it.")
                    net.WriteInt(1,2)
                    return
                else
                    if not enemy.weapon then
                        enemy.weapon = ""
                    end
                end
            end

            -- Be careful of backwards compataiblity
            HORDE.enemies = t
            HORDE:NormalizeEnemiesWeight()

            print("[HORDE] - Loaded custom enemy config.")
        end
    end
end

function HORDE:GetDefaultEnemiesData ()
    -- name, class, weight, wave, elite, health_scale, damage_scale, reward_scale, model_scale, color
    HORDE:CreateEnemy("zombie", "npc_zombie", 0.1, 1, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj", "npc_vj_zss_czombie", 0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow1", "npc_vj_zss_zombie1",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow2", "npc_vj_zss_zombie2",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow3", "npc_vj_zss_zombie3",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow4", "npc_vj_zss_zombie4",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow5", "npc_vj_zss_zombie5",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow6", "npc_vj_zss_zombie6",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow7", "npc_vj_zss_zombie7",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow8", "npc_vj_zss_zombie8",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow9", "npc_vj_zss_zombie9",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10",   0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11",   0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12",   0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("red zombie", "npc_zombie",                  0.5, 1, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0), nil, nil, nil, "nemesis")
    HORDE:CreateEnemy("zombie torso", "npc_zombie_torso",          0.5, 1, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie torso vj", "npc_vj_zss_czombietors", 0.5, 1, false, 0.5, 1, 1, 1, nil)

    HORDE:CreateEnemy("zombie", "npc_zombie", 0.1, 2, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj",        "npc_vj_zss_czombie",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10", 0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11", 0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12", 0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie torso", "npc_zombie_torso",        0.5, 2, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie torso vj", "npc_vj_zss_czombietors", 0.5, 2, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie fast",      "npc_fastzombie",      0.5, 2, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie poison vj", "npc_vj_zss_cpzombie", 0.5, 2, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("red zombie", "npc_zombie",                0.5, 2, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0), nil, nil, nil, "nemesis")

    HORDE:CreateEnemy("zombie", "npc_zombie", 0.1, 3, false, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj",        "npc_vj_zss_czombie",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10", 0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11", 0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12", 0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("red zombie",       "npc_zombie",          0.5, 3, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0), nil, nil, nil, "nemesis")
    HORDE:CreateEnemy("black zombie",     "npc_zombie",          0.5, 3, true, 1.5, 1.25, 1.25, 1.25, Color(0,0,0))
    HORDE:CreateEnemy("zombie poison",    "npc_poisonzombie",    0.5, 3, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie fast",      "npc_fastzombie",      0.5, 3, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("vomitter",         "npc_vj_vomitter",     0.5, 3, false, 1, 1, 1, 1, nil)

    HORDE:CreateEnemy("zombie", "npc_zombie", 0.1, 4, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj",        "npc_vj_zss_czombie",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10", 0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11", 0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12", 0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("black zombie",     "npc_zombie",          0.75, 4, true, 1.5, 1.25, 1.25, 1.25, Color(0,0,0))
    HORDE:CreateEnemy("zombie fast",      "npc_fastzombie",      0.5,  4, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie poison",    "npc_poisonzombie",    0.5,  4, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("vomitter",         "npc_vj_vomitter",     0.5,  4, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj guard",  "npc_vj_zss_zombguard",0.25, 4, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("red zombie fast", "npc_fastzombie",       0.15, 4, true, 1.25, 1.5, 1.25, 1.25, Color(255,0,0))

    HORDE:CreateEnemy("zombie",           "npc_zombie",          0.1, 5, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj",        "npc_vj_zss_czombie",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10", 0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11", 0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12", 0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("black zombie", "npc_zombie",              0.75, 5, true, 1.5, 1.25, 1.25, 1.25, Color(0,0,0))
    HORDE:CreateEnemy("zombie poison vj", "npc_vj_vomitter",     0.20, 5, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombe panic 1", "npc_vj_zss_zp1",         0.20, 5, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie fast", "npc_fastzombie",           0.60, 5, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("red zombie fast", "npc_fastzombie",       0.15, 5, true, 1.25, 1.5, 1.25, 1.25, Color(255,0,0))
    HORDE:CreateEnemy("zombie poison", "npc_poisonzombie",       0.5,  5, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj guard", "npc_vj_zss_zombguard", 0.25, 5, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("Mutated Hulk",  "npc_vj_mutated_hulk",       1, 5, true,  1, 1, 10, 1, nil, nil, nil,
    {is_boss=true, end_wave=true, unlimited_enemies_spawn=false, enemies_spawn_threshold=1.0, music="music/hl2_song20_submix0.mp3", music_duration=104}, "fume")
    HORDE:CreateEnemy("Host",  "npc_poisonzombie",                  1, 5, true, 30, 2, 10, 2, Color(255,0,255), nil, nil,
    {is_boss=true, end_wave=true, unlimited_enemies_spawn=false, enemies_spawn_threshold=1.0, music="music/hl2_song20_submix0.mp3", music_duration=104}, "fume")
    HORDE:CreateEnemy("Slasher",  "npc_vj_slasher",                 1, 5, true, 1, 0.5, 10, 1.5, nil, nil, nil,
    {is_boss=true, end_wave=true, unlimited_enemies_spawn=false, enemies_spawn_threshold=1.0, music="music/hl2_song20_submix0.mp3", music_duration=104}, "frenzy")

    HORDE:CreateEnemy("zombie", "npc_zombie", 0.1, 6, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("black zombie", "npc_zombie", 0.1, 6, true, 1.5, 1.25, 1.25, 1.25, Color(0,0,0))
    HORDE:CreateEnemy("zombie vj",        "npc_vj_zss_czombie",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10", 0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11", 0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12", 0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie poison vj", "npc_vj_vomitter",     0.20, 6, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombe panic 1", "npc_vj_zss_zp1",         0.20, 6, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie fast", "npc_fastzombie",           0.20, 6, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie fast vj", "npc_vj_zss_cfastzombie",0.20, 6, false, 0.4, 0.5, 1, 1.25, nil)
    HORDE:CreateEnemy("lurker",                  "npc_vj_lurker",0.20, 6, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("red zombie fast", "npc_fastzombie",       0.20, 6, true, 1.25, 1.5, 1.25, 1.25, Color(255,0,0))
    HORDE:CreateEnemy("zombie hulk", "npc_vj_horde_hulk",        0.05, 6, true, 0.8, 1, 2, 1, nil)
    HORDE:CreateEnemy("black zombie poison", "npc_poisonzombie", 0.20, 6, true, 1.25, 1.5, 1.5, 1.5, Color(0,0,0))
    HORDE:CreateEnemy("zombie vj guard", "npc_vj_zss_zombguard", 0.20, 6, false, 1, 1, 1, 1, nil)

    HORDE:CreateEnemy("zombie", "npc_zombie", 0.1, 7, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("black zombie", "npc_zombie", 0.1, 7, true, 1.5, 1.25, 1.25, 1.25, Color(0,0,0))
    HORDE:CreateEnemy("zombie vj",        "npc_vj_zss_czombie",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10", 0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11", 0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12", 0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombe panic 1", "npc_vj_zss_zp1",         0.20, 7, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie poison vj", "npc_vj_vomitter",     0.20, 7, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie fast vj", "npc_vj_zss_cfastzombie",0.20, 7, false, 0.4, 0.5, 1, 1.25, nil)
    HORDE:CreateEnemy("burnt", "npc_vj_ranged_burnzie",          0.20, 7, false, 0.8, 1, 1, 1, nil)
    HORDE:CreateEnemy("lurker",                  "npc_vj_lurker",0.20, 7, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("red zombie fast", "npc_fastzombie",       0.20, 7, true, 1.25, 1.5, 1.25, 1.25, Color(255,0,0))
    HORDE:CreateEnemy("zombie hulk", "npc_vj_horde_hulk",        0.05, 7, true, 0.8, 1, 2, 1, nil)
    HORDE:CreateEnemy("black zombie poison", "npc_poisonzombie", 0.20, 7, true, 1.25, 1.5, 1.5, 1.5, Color(0,0,0))
    HORDE:CreateEnemy("corruptor", "npc_vj_corruptor",           0.05, 7, true, 2, 1.5, 2, 1.5, nil, nil, nil, nil)
    HORDE:CreateEnemy("zombie vj guard", "npc_vj_zss_zombguard", 0.20, 7, false, 1, 1, 1, 1, nil)

    HORDE:CreateEnemy("zombie", "npc_zombie", 0.1, 8, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("black zombie", "npc_zombie", 0.1, 8, true, 1.5, 1.25, 1.25, 1.25, Color(0,0,0))
    HORDE:CreateEnemy("zombie vj",        "npc_vj_zss_czombie",  0.1, 8,  false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",  0.1, 8,  false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",  0.1, 8,  false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",  0.1, 8,  false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",  0.1, 8,  false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",  0.1, 8,  false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",  0.1, 8,  false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",  0.1, 8,  false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",  0.1, 8,  false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",  0.1, 8,  false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10", 0.1, 8,  false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11", 0.1, 8,  false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12", 0.1, 8,  false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombe panic 1", "npc_vj_zss_zp1",         0.20, 8, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie poison vj", "npc_vj_vomitter",     0.20, 8, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie fast vj", "npc_vj_zss_cfastzombie",0.20, 8, false, 0.4, 0.5, 1, 1.25, nil)
    HORDE:CreateEnemy("burnt", "npc_vj_ranged_burnzie",          0.20, 8, false, 0.8, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj guard", "npc_vj_zss_zombguard", 0.20, 8, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("lurker",                  "npc_vj_lurker",0.20, 8, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("red zombie fast", "npc_fastzombie",       0.15, 8, true, 1.25, 1.5, 1.25, 1.25, Color(255,0,0))
    HORDE:CreateEnemy("zombie hulk", "npc_vj_horde_hulk",        0.05, 8, true, 0.8, 1, 2, 1, nil)
    HORDE:CreateEnemy("black zombie poison", "npc_poisonzombie", 0.20, 8, true, 1.25, 1.5, 1.5, 1.5, Color(0,0,0))
    HORDE:CreateEnemy("corruptor", "npc_vj_corruptor",           0.05, 8, true, 2, 1.5, 2, 1.5, nil, nil, nil, nil)

    HORDE:CreateEnemy("zombie", "npc_zombie", 0.1, 9, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj",        "npc_vj_zss_czombie",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10", 0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11", 0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12", 0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombe panic 1",    "npc_vj_zss_zp1",      0.20, 9, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie poison vj", "npc_vj_vomitter",     0.20, 9, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie fast vj",   "npc_vj_zss_cfastzombie",0.20, 9, false, 0.4, 0.5, 1, 1.25, nil)
    HORDE:CreateEnemy("burnt", "npc_vj_ranged_burnzie",          0.20, 9, false, 0.8, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie vj guard", "npc_vj_zss_zombguard", 0.20, 9, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("lurker",                  "npc_vj_lurker",0.20, 9, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("red zombie fast", "npc_fastzombie",       0.15, 9, true, 1.25, 1.5, 1.25, 1.25, Color(255,0,0))
    HORDE:CreateEnemy("zombie hulk", "npc_vj_horde_hulk",         0.05, 9, true, 0.8, 1, 2, 1, nil)
    HORDE:CreateEnemy("black zombie poison", "npc_poisonzombie", 0.20, 9, true, 1.25, 1.5, 1.5, 1.5, Color(0,0,0))
    HORDE:CreateEnemy("zombie vj fast black", "npc_vj_zss_cfastzombie", 0.05, 9, true, 1.25, 1.25, 1.25, 1.1, Color(0,0,0))
    HORDE:CreateEnemy("corruptor", "npc_vj_corruptor",           0.05, 9, true, 2, 1.5, 2, 1.5, nil, nil, nil, nil)

    HORDE:CreateEnemy("zombie vj",        "npc_vj_zss_czombie",      1,    10, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie fast",      "npc_fastzombie",          1,    10, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("zombie poison",    "npc_poisonzombie",        0.5,  10, false, 1, 1, 1, 1, nil)
    HORDE:CreateEnemy("Alpha Gonome",     "npc_vj_alpha_gonome",     1,    10, true,  1, 1, 10, 1, nil, nil, nil,
    {is_boss=true, end_wave=true, unlimited_enemies_spawn=true, enemies_spawn_threshold=0.5, music="music/hl1_song24.mp3", music_duration=105}, "fume")
    HORDE:CreateEnemy("Infested Beast",   "npc_vj_infested_beast",   100,    10, true,  1, 1, 10, 1, nil, nil, nil,
    {is_boss=true, end_wave=true, unlimited_enemies_spawn=false, enemies_spawn_threshold=0,  music="music/hl1_song24.mp3", music_duration=105}, nil)
    
    HORDE:NormalizeEnemiesWeight()

    print("[HORDE] - Loaded default enemy config.")
end

-- Startup
if SERVER then
    util.AddNetworkString("Horde_SetEnemiesData")

    if GetConVar("horde_external_lua_config"):GetString() and GetConVar("horde_external_lua_config"):GetString() ~= "" then
    else
        if GetConVarNumber("horde_default_enemy_config") == 1 then
            HORDE:GetDefaultEnemiesData()
        else
            GetEnemiesData()
        end
    end

    net.Receive("Horde_SetEnemiesData", function (len, ply)
        if not ply:IsSuperAdmin() then return end
        local enemies_len = net.ReadUInt(32)
        local data = net.ReadData(enemies_len)
        local str = util.Decompress(data)
        HORDE.enemies = util.JSONToTable(str)
        HORDE.InvalidateHordeEnemyCache = 1
        HORDE:SetEnemiesData()
    end)
end