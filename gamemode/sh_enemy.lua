-- Enemies
HORDE.enemies = {}
HORDE.enemies_normalized = {}
HORDE.CreateEnemy = function (name, class, weight, wave, is_elite, health_scale, damage_scale, reward_scale, model_scale, color, weapon)
    if name == nil or class == nil or wave == nil or wave <= 0 or name == "" or class == "" then return end
    local enemy = {}
    enemy.name = name
    enemy.class = class
    enemy.weight = math.min(1,weight)
    enemy.wave = math.max(1,wave)
    enemy.is_elite = is_elite
    enemy.health_scale = health_scale and health_scale or 1
    enemy.damage_scale = damage_scale and damage_scale or 1
    enemy.reward_scale = reward_scale and reward_scale or 1
    enemy.model_scale = model_scale and model_scale or 1
    enemy.color = color
    enemy.weapon = weapon
    HORDE.enemies[name .. tostring(enemy.wave)] = enemy
end

HORDE.NormalizeEnemiesWeight = function ()
    if table.IsEmpty(HORDE.enemies) then return end
    -- NormalizeHORDE.NormalizeE
    for wave = 1, HORDE.max_max_waves do
        HORDE.enemies_normalized[wave] = {}
        local total_weight = 0
        for _, enemy in pairs(HORDE.enemies) do
            if enemy.wave == wave then
                total_weight = total_weight + enemy.weight
            end
        end
        for _, enemy in pairs(HORDE.enemies) do
            if enemy.wave == wave then
                -- For some reason lua table key does not support nested tables lmao
                HORDE.enemies_normalized[wave][enemy.name] = enemy.weight / total_weight
            end
        end
    end
end

HORDE.SyncEnemies = function ()
    if player then
        for _, ply in pairs(player.GetAll()) do
            net.Start("Horde_SyncEnemies")
            net.WriteTable(HORDE.enemies)
            net.Send(ply)
        end
    end
end

HORDE.SetEnemiesData = function()
    if SERVER then
        HORDE.NormalizeEnemiesWeight()

        if GetConVarNumber("horde_default_enemy_config") == 1 then return end
        if not file.IsDir("horde", "DATA") then
            file.CreateDir("horde")
        end

        file.Write("horde/enemies.txt", util.TableToJSON(HORDE.enemies))

        HORDE.SyncEnemies()
    end
end

function GetEnemiesData()
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
                    notification.AddLegacy("Enemy config file validation failed! Please update your file or delete it.", NOTIFY_ERROR, 5)
                    notification.AddLegacy("Falling back to default config.", NOTIFY_ERROR, 5)
                    return
                else
                    if not enemy.weapon then
                        enemy.weapon = ""
                    end
                end
            end

            -- Be careful of backwards compataiblity
            HORDE.enemies = t
            HORDE.NormalizeEnemiesWeight()

            print("[HORDE] - Loaded custom enemy config.")
        end


        HORDE.SyncEnemies()
    end
end

HORDE.GetDefaultEnemiesData = function ()
    -- name, class, weight, wave, elite, health_scale, damage_scale, reward_scale, model_scale, color
    HORDE.CreateEnemy("zombie", "npc_zombie", 0.1, 1, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj", "npc_vj_zss_czombie", 0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow1", "npc_vj_zss_zombie1",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow2", "npc_vj_zss_zombie2",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow3", "npc_vj_zss_zombie3",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow4", "npc_vj_zss_zombie4",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow5", "npc_vj_zss_zombie5",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow6", "npc_vj_zss_zombie6",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow7", "npc_vj_zss_zombie7",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow8", "npc_vj_zss_zombie8",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow9", "npc_vj_zss_zombie9",     0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10",   0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11",   0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12",   0.1, 1, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("red zombie", "npc_zombie",                  0.5, 1, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))
    HORDE.CreateEnemy("zombie torso", "npc_zombie_torso",          0.5, 1, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie torso vj", "npc_vj_zss_czombietors", 0.5, 1, false, 0.5, 1, 1, 1, nil)

    HORDE.CreateEnemy("zombie", "npc_zombie", 0.1, 2, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj",        "npc_vj_zss_czombie",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",  0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10", 0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11", 0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12", 0.1, 2, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie torso", "npc_zombie_torso",        0.5, 2, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie torso vj", "npc_vj_zss_czombietors", 0.5, 2, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie fast torso", "npc_fastzombie_torso", 0.5, 2, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie poison vj", "npc_vj_zss_cpzombie", 0.5, 2, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("red zombie", "npc_zombie",                0.5, 2, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))

    HORDE.CreateEnemy("zombie", "npc_zombie", 0.1, 3, false, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj",        "npc_vj_zss_czombie",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",  0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10", 0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11", 0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12", 0.1, 3, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("red zombie", "npc_zombie",                0.75, 3, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))
    HORDE.CreateEnemy("black zombie", "npc_zombie",              0.75, 3, true, 1.5, 1.25, 1.25, 1.25, Color(0,0,0))
    HORDE.CreateEnemy("zombie poison vj", "npc_vj_zss_cpzombie", 0.75, 3, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie fast", "npc_fastzombie",           0.75, 3, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj guard", "npc_vj_zss_zombguard", 0.25, 3, false, 1, 1, 1, 1, nil)

    HORDE.CreateEnemy("zombie", "npc_zombie", 0.1, 4, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj",        "npc_vj_zss_czombie",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",  0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10", 0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11", 0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12", 0.1, 4, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("black zombie", "npc_zombie",              0.75, 4, true, 1.5, 1.25, 1.25, 1.25, Color(0,0,0))
    HORDE.CreateEnemy("zombie fast", "npc_fastzombie",           0.5, 4, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie poison", "npc_poisonzombie",       0.5, 4, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie poison vj", "npc_vj_zss_cpzombie", 0.5, 4, false, 1, 1, 1, 1, nil)

    HORDE.CreateEnemy("zombie",           "npc_zombie",          0.1, 5, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj",        "npc_vj_zss_czombie",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",  0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10", 0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11", 0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12", 0.1, 5, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("black zombie", "npc_zombie",              0.75, 5, true, 1.5, 1.25, 1.25, 1.25, Color(0,0,0))
    HORDE.CreateEnemy("zombie poison vj", "npc_vj_zss_cpzombie", 0.20, 5, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombe panic 1", "npc_vj_zss_zp1",         0.20, 5, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie fast", "npc_fastzombie",           0.5, 5, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("red zombie fast", "npc_fastzombie",       0.25, 5, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))
    HORDE.CreateEnemy("zombie poison", "npc_poisonzombie",       0.5, 5, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie hulk", "npc_vj_zss_zhulk",         0.05, 5, true, 2, 2, 2, 1, nil)
    HORDE.CreateEnemy("zombie vj guard", "npc_vj_zss_zombguard", 0.25, 5, false, 1, 1, 1, 1, nil)

    HORDE.CreateEnemy("black zombie", "npc_zombie", 0.1, 6, true, 1.5, 1.25, 1.25, 1.25, Color(0,0,0))
    HORDE.CreateEnemy("zombie vj",        "npc_vj_zss_czombie",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",  0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10", 0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11", 0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12", 0.1, 6, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie poison vj", "npc_vj_zss_cpzombie", 0.20, 6, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombe panic 1", "npc_vj_zss_zp1",         0.20, 6, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie fast", "npc_fastzombie",           0.75, 6, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("red zombie fast", "npc_fastzombie",       0.5, 6, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))
    HORDE.CreateEnemy("zombie hulk", "npc_vj_zss_zhulk",         0.05, 6, true, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("black zombie poison", "npc_poisonzombie", 0.25, 6, true, 1.5, 1.5, 1.5, 1.5, Color(0,0,0))

    HORDE.CreateEnemy("black zombie", "npc_zombie", 0.1, 7, true, 1.5, 1.25, 1.25, 1.25, Color(0,0,0))
    HORDE.CreateEnemy("zombie vj",        "npc_vj_zss_czombie",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",  0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10", 0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11", 0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12", 0.1, 7, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie poison vj", "npc_vj_zss_cpzombie", 0.20, 7, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombe panic 1", "npc_vj_zss_zp1",         0.20, 7, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("red zombie fast", "npc_fastzombie",       0.75, 7, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))
    HORDE.CreateEnemy("zombie hulk", "npc_vj_zss_zhulk",         0.05, 7, true, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("black zombie poison", "npc_poisonzombie", 0.5, 7, true, 1.5, 1.5, 1.5, 1.5, Color(0,0,0))
    HORDE.CreateEnemy("burnt", "npc_vj_zss_burnzie",             0.25, 7, false, 1, 1, 1, 1, nil)

    HORDE.CreateEnemy("black zombie", "npc_zombie", 0.1, 8, true, 1.5, 1.25, 1.25, 1.25, Color(0,0,0))
    HORDE.CreateEnemy("zombie vj",        "npc_vj_zss_czombie",  0.1, 8, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",  0.1, 8, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",  0.1, 8, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",  0.1, 8, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",  0.1, 8, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",  0.1, 8, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",  0.1, 8, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",  0.1, 8, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",  0.1, 8, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",  0.1, 8, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10", 0.1, 8, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11", 0.1, 8, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12", 0.1, 8, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombe panic 1", "npc_vj_zss_zp1",         0.20, 8, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("red zombie fast", "npc_fastzombie",       0.75, 8, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))
    HORDE.CreateEnemy("zombie hulk", "npc_vj_zss_zhulk",         0.05, 8, true, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("black zombie poison", "npc_poisonzombie", 0.25, 8, true, 1.5, 1.5, 1.5, 1.5, Color(0,0,0))
    HORDE.CreateEnemy("burnt", "npc_vj_zss_burnzie",             0.25, 8, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj guard", "npc_vj_zss_zombguard", 0.25, 8, false, 1, 1, 1, 1, nil)

    HORDE.CreateEnemy("zombie vj",        "npc_vj_zss_czombie",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",  0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10", 0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11", 0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12", 0.1, 9, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombe panic 1",    "npc_vj_zss_zp1",      0.20, 9, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie poison vj", "npc_vj_zss_cpzombie", 0.25, 9, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("red zombie fast", "npc_fastzombie",       0.50, 9, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))
    HORDE.CreateEnemy("zombie hulk", "npc_vj_zss_zhulk",         0.05, 9, true, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("black zombie poison", "npc_poisonzombie", 0.25, 9, true, 1.5, 1.5, 1.5, 1.5, Color(0,0,0))
    HORDE.CreateEnemy("burnt", "npc_vj_zss_burnzie",             0.25, 9, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj fast black", "npc_vj_zss_cfastzombie", 0.05, 9, true, 1.25, 1.25, 1.25, 1.1, Color(0,0,0))

    HORDE.CreateEnemy("zombie vj",        "npc_vj_zss_czombie",      0.1, 10, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow1",  "npc_vj_zss_zombie1",      0.1, 10, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow2",  "npc_vj_zss_zombie2",      0.1, 10, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow3",  "npc_vj_zss_zombie3",      0.1, 10, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow4",  "npc_vj_zss_zombie4",      0.1, 10, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow5",  "npc_vj_zss_zombie5",      0.1, 10, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow6",  "npc_vj_zss_zombie6",      0.1, 10, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow7",  "npc_vj_zss_zombie7",      0.1, 10, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow8",  "npc_vj_zss_zombie8",      0.1, 10, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow9",  "npc_vj_zss_zombie9",      0.1, 10, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow10", "npc_vj_zss_zombie10",     0.1, 10, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow11", "npc_vj_zss_zombie11",     0.1, 10, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj slow12", "npc_vj_zss_zombie12",     0.1, 10, false, 0.4, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombe panic 1",    "npc_vj_zss_zp1",          0.20, 10, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("red zombie fast",  "npc_fastzombie",          0.50, 10, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))
    HORDE.CreateEnemy("zombie hulk red",  "npc_vj_zss_zhulk",        0.02, 10, true, 1.5, 1.5, 1.5, 1, Color(255,0,0))
    HORDE.CreateEnemy("zombie hulk black", "npc_vj_zss_zhulk",       0.02, 10, true, 1.5, 2, 2, 1, Color(0,0,0))
    HORDE.CreateEnemy("black zombie poison", "npc_poisonzombie",     0.25, 10, true, 1.5, 1.5, 1.5, 1.5, Color(0,0,0))
    HORDE.CreateEnemy("burnt", "npc_vj_zss_burnzie",                 0.25, 10, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj fast black", "npc_vj_zss_cfastzombie", 0.05, 10, true, 1.25, 1.25, 1.25, 1.1, Color(0,0,0))
    HORDE.CreateEnemy("zombie vj guard", "npc_vj_zss_zombguard",     0.25, 10, false, 1, 1, 1, 1, nil)
    
    HORDE.NormalizeEnemiesWeight()

    print("[HORDE] - Loaded default enemy config.")
end

-- Startup
if SERVER then
    util.AddNetworkString("Horde_SetEnemiesData")

    if GetConVarNumber("horde_default_enemy_config") == 1 then
        HORDE.GetDefaultEnemiesData()
        HORDE.SyncEnemies()
    else
        GetEnemiesData()
    end

    net.Receive("Horde_SetEnemiesData", function ()
        HORDE.enemies = net.ReadTable()
        HORDE.SetEnemiesData()
    end)
end