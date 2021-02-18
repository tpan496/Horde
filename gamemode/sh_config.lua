CreateConVar("horde_default_enemy_config", 1, SERVER_CAN_EXECUTE, "Use default enemy wave config settings.")
CreateConVar("horde_default_item_config", 1, SERVER_CAN_EXECUTE, "Use default item config settings.")
CreateConVar("horde_max_wave", 10, SERVER_CAN_EXECUTE, "Max waves." )
CreateConVar("horde_difficulty", 0, SERVER_CAN_EXECUTE, "Difficulty.")
CreateConVar("horde_break_time", 60, SERVER_CAN_EXECUTE, "Break time between waves.")
CreateConVar("horde_enable_shop", 1, SERVER_CAN_EXECUTE, "Enables shop menu or not.")
CreateConVar("horde_enable_client_gui", 1, SERVER_CAN_EXECUTE, "Enables client information ui or not.")
CreateConVar("horde_enable_respawn", 0, SERVER_CAN_EXECUTE, "Players can respawn after death during a wave.")
CreateConVar("horde_max_spawn_distance", 2000, SERVER_CAN_EXECUTE, "Maximum enenmy respawn distance.")
CreateConVar("horde_min_spawn_distance", 500, SERVER_CAN_EXECUTE, "Minimum enenmy respawn distance.")
CreateConVar("horde_start_money", 1000, SERVER_CAN_EXECUTE, "Money given at start.")

HORDE = {}
HORDE.__index = HORDE
HORDE.color_crimson = Color(220, 20, 60)
HORDE.color_crimson_dim = Color(200, 0, 40)
HORDE.color_crimson_dark = Color(100,0,0)
HORDE.start_game = false
HORDE.total_enemies_per_wave = {15, 20, 25, 30, 40, 45, 50, 55, 60}
HORDE.total_enemies_this_wave = 0
HORDE.alive_enemies_this_wave = 0
HORDE.killed_enemies_this_wave = 0
HORDE.current_wave = 0
HORDE.total_break_time = math.max(10, GetConVarNumber("horde_break_time"))
HORDE.first_break_time = 10
HORDE.current_break_time = HORDE.first_break_time
HORDE.max_spawn_distance = math.max(100, GetConVarNumber("horde_max_spawn_distance"))
HORDE.min_spawn_distance = math.max(100, GetConVarNumber("horde_min_spawn_distance"))
HORDE.max_enemies_alive = 20
HORDE.spawned_enemies = {}
HORDE.ai_nodes = {}
HORDE.found_ai_nodes = false
HORDE.enemy_spawn_z = 15
HORDE.player_ready = {}
HORDE.max_waves = math.min(10, math.max(1, GetConVarNumber("horde_max_wave")))
HORDE.difficulty = math.min(2, math.max(0, GetConVarNumber("horde_difficulty")))
HORDE.enable_shop = GetConVarNumber("horde_enable_shop")
HORDE.start_money = math.max(0, GetConVarNumber("horde_start_money"))
HORDE.total_enemies_this_wave_fixed = 0
HORDE.kill_reward_base = 150

-- Economy variables
HORDE.items = {}

HORDE.CreateItem = function (category, name, class, price, weight, description, whitelist, ammo_price, secondary_ammo_price)
    if category == nil or name == nil or class == nil or price == nil or weight == nil or description == nil then return end
    if category ~= "Melee" and category ~= "Pistol" and category ~= "SMG" and category ~= "MG" and category ~= "Shotgun" and category ~= "Rifle" and category ~= "Explosive" and category ~= "Special" and category ~= "Equipment" then return end
    if string.len(name) <= 0 or string.len(class) <= 0 then return end
    if price < 0 or weight < 0 then return end
    local item = {}
    item.category = category
    item.name = name
    item.class = class
    item.price = price
    item.weight = weight
    item.description = description
    item.whitelist = whitelist
    item.ammo_price = ammo_price
    item.secondary_ammo_price = secondary_ammo_price
    HORDE.items[item.class] = item
    SetItemsData()
end

function SetItemsData()
    if GetConVarNumber("horde_default_item_config") == 1 then return end
	if not file.IsDir('horde', 'DATA') then
		file.CreateDir('horde')
	end
	
	file.Write('horde/items.txt', util.TableToJSON(HORDE.items))
end

function GetItemsData()
    if not file.IsDir('horde', 'DATA') then
		file.CreateDir('horde')
        return
	end
    
    if file.Read('horde/items.txt', 'DATA') then
        HORDE.items = util.JSONToTable(file.Read('horde/items.txt', 'DATA'))
    end
end

if GetConVarNumber("horde_default_item_config") == 0 then
    GetItemsData()
else
    HORDE.CreateItem("Melee",      "Stunstick",      "weapon_stunstick",     100,  1, "Electric baton.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Melee",      "Crowbar",        "weapon_crowbar",       100,  1, "A rusty crowbar.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Melee",      "Combat Knife",   "arccw_go_melee_knife", 500,  2, "A reliable bayonet.\nRMB to deal a heavy slash.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)

    HORDE.CreateItem("Pistol",     "9mm",            "weapon_pistol",     400,  2, "Combine standard sidearm.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "357",            "weapon_357",        750,  3, "Colt python magnum pistol.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "Glock",          "arccw_go_glock",    750,  3, "The Glock 18 is a selective-fire variant of the Glock 17.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "USP",            "arccw_go_usp",      750,  3, "A semi-automatic pistol developed in Germany by H&K.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "P2000",          "arccw_go_p2000",    750,  3, "Accurate and controllable.\nA serviceable first-round pistol made by H&K.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "P250",           "arccw_go_p250",     750,  3, "A low-recoil firearm with a high rate of fire.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "R8 Revolver",    "arccw_go_r8",       750,  3, "Delivers a highly accurate and powerful round,\nbut at the expense of a lengthy trigger-pull.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "Deagle",         "arccw_go_deagle",   750,  3, "Night Hawk .50C.\nAn iconic pistol that is diffuclt to master.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "FiveSeven",      "arccw_go_fiveseven",750,  3, "ES Five-seven.\nA Belgian semi-automatic pistol made by FN Herstal", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "CZ75",           "arccw_go_cz75",     750,  3, "A fully automatic variant of the CZ75.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "M9",             "arccw_go_m9",       750,  3, "Beretta 92F semi-automatic pistol.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "Tec-9",          "arccw_go_tec9",     750,  3, "A Swedish-made semi-automatic pistol.\nLethal in close quarters.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)

    HORDE.CreateItem("SMG",        "MP7",            "weapon_smg1",       1250, 5, "A compact, fully automatic firearm.\nArmed with an M203 launcher.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, 75)
    HORDE.CreateItem("SMG",        "Mac10",          "arccw_go_mac10",    1500, 5, "MAC-10 SMG boasts a high rate of fire,\nwith poor spread accuracy and high recoil as trade-offs.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("SMG",        "MP9",            "arccw_go_mp9",      1500, 5, "Manufactured in Switzerland,\nthe MP9 is favored by private security firms world-wide.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("SMG",        "MP5",            "arccw_go_mp5",      1750, 5, "Often imitated but never equaled,\nthe MP5 is perhaps the most versatile SMG in the world.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("SMG",        "UMP45",          "arccw_go_ump45",    1750, 5, "KM UMP45.\nA lighter and cheaper successor to the MP5.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("SMG",        "PP Bizon",       "arccw_go_bizon",    1750, 6, "PP-19 Bizon.\nOffers a high-capacity magazine that reloads quickly.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("SMG",        "P90",            "arccw_go_p90",      2000, 6, "ES C90.\nA Belgian bullpup PDW with a magazine of 50 rounds.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)

    HORDE.CreateItem("Shotgun",    "SPAS12",         "weapon_shotgun",    1250, 7, "A standard 12-gauge shotgun.\nRMB to fire 2 shots at once.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Shotgun",    "Nova",           "arccw_go_nova",     1500, 7, "Benelli Nova.\nPump-action 12-gauge shotgun.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Shotgun",    "M870",           "arccw_go_870",      1500, 7, "Remington 870 Shotgun.\nManufactured in the United States.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Shotgun",    "MAG7",           "arccw_go_mag7",     1500, 7, "Techno Arms MAG-7.\nFires a specialized 60mm 12 gauge shell.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Shotgun",    "XM1014",         "arccw_go_m1014",    2000, 8, "Benelli M4 Super 90.\nFully automatic shotgun.", {Medic=false, Assault=true, Heavy=true, Demolition=false, Survivor=true}, 10, -1)
    
    HORDE.CreateItem("Rifle",      "Combine AR2",    "weapon_ar2",        1500, 7, "Overwatch standard issue rifle.\nDark energy-powered assault rifle.", {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true}, 10, 50)
    HORDE.CreateItem("Rifle",      "FAMAS",          "arccw_go_famas",    2000, 7, "FAMAS bullpup assault rifle.\nRecognised for its high rate of fire.", {Medic=true, Assault=true, Heavy=false, Demolition=false, Survivor=true}, 10, -1)
    HORDE.CreateItem("Rifle",      "Galil",          "arccw_go_ace",      2000, 7, "Galil ACE 22.\nDeveloped and originally manufactured by  Israel Military Industries.", {Medic=true, Assault=true, Heavy=false, Demolition=false, Survivor=true}, 10, -1)
    HORDE.CreateItem("Rifle",      "AK47",           "arccw_go_ak47",     2250, 7, "Avtomat Kalashnikova.\nA gas-operated, 7.62×39mm assault rifle developed in the Soviet Union.", {Medic=true, Assault=true, Heavy=false, Demolition=false, Survivor=true}, 10, -1)
    HORDE.CreateItem("Rifle",      "M4A1",           "arccw_go_m4",       2250, 7, "Colt M4.\nA 5.56×45mm NATO, air-cooled, gas-operated, select fire carbine.", {Medic=true, Assault=true, Heavy=false, Demolition=false, Survivor=true}, 10, -1)
    HORDE.CreateItem("Rifle",      "SG556",          "arccw_go_sg556",    2250, 7, "SIG SG 550.\nAn assault rifle manufactured by Swiss Arms AG.", {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true}, 10, -1)
    HORDE.CreateItem("Rifle",      "AUG",            "arccw_go_aug",      2250, 7, "Steyr AUG\nAn Austrian bullpup assault rifle.", {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true}, 10, -1)
    HORDE.CreateItem("Rifle",      "SCAR",           "arccw_go_scar",     2250, 8, "FN SCAR.\nAn assault rifle developed by Belgian manufacturer FN Herstal.", {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true}, 10, -1)
    HORDE.CreateItem("Rifle",      "G3",             "arccw_go_g3",       2250, 8, "G3 Battle Rifle.\nA 7.62×51mm NATO, select-fire battle rifle developed by H&K.", {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true}, 10, -1)
    HORDE.CreateItem("Rifle",      "AWP",            "arccw_go_awp",      2250, 7, "Magnum Sniper Rifle.\nA series of sniper rifles manufactured by the United Kingdom.", {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true}, 10, -1)
    
    HORDE.CreateItem("MG",         "M249",           "arccw_go_m249para",  2250, 10, "M249 light machine gun.\nA gas operated and air-cooled weapon of destruction.", {Medic=false, Assault=false, Heavy=true, Demolition=false, Survivor=true}, 10, -1)
    HORDE.CreateItem("MG",         "Negev",          "arccw_go_negev",     2250, 10, "IWI Negev.\nA 5.56×45mm NATO light machine gun developed by the IWI.", {Medic=false, Assault=false, Heavy=true, Demolition=false, Survivor=true}, 10, -1)

    HORDE.CreateItem("Explosive",  "Frag Grenade",   "weapon_frag",        75,   0, "A standard grenade.\nDoes its job well.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 75, -1)
    HORDE.CreateItem("Explosive",  "Incendiary Grenade",   "arccw_go_nade_incendiary",        200,   1, "Generates a pool of fire after some delay.\nSets everything on fire within its effect.", {Medic=false, Assault=false, Heavy=false, Demolition=true, Survivor=true}, 200, -1)
    HORDE.CreateItem("Explosive",  "Resistance RPG", "weapon_rpg",         2000, 7, "Laser-guided rocket propulsion device.", {Medic=false, Assault=false, Heavy=false, Demolition=true, Survivor=true}, 10, -1)
    HORDE.CreateItem("Explosive",  "SLAM",           "weapon_slam",        500,  2, "Selectable Lightweight Attack Munition.\nRMB to detonate.", {Medic=false, Assault=false, Heavy=false, Demolition=true, Survivor=true}, 10, -1)

    HORDE.CreateItem("Special",    "Heat Crossbow",  "weapon_crossbow",    1250, 5, "Long-raned sniper weapon.", {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true}, 10, -1)

    HORDE.CreateItem("Equipment",  "Medkit",         "weapon_medkit",      50,   1, "Rechargeble medic.\nRMB to self-heal, LMB to heal others.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)
end

-- Some built-in special items
HORDE.CreateItem("Equipment", "Kevlar Armor", "armor", 1000, 0, "Full kevlar armor set.\nFills up 100% of your armor bar.", {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true}, 10, -1)

HORDE.max_weight = 15
HORDE.default_ammo_price = 10

-- Class
HORDE.classes = {}
HORDE.CreateClass = function (name, description, max_hp, movespd, sprintspd)
    local class = {}
    class.name = name
    class.description = description
    class.max_hp = max_hp
    class.movespd = movespd
    class.sprintspd = sprintspd
    HORDE.classes[class.name] = class
end
-- Only allow 1 change per wave
HORDE.player_class_changed = {}

-- Enemies
HORDE.enemies = {}
HORDE.enemies_normalized = {}
HORDE.CreateEnemy = function (name, class, weight, wave, is_elite, health_scale, damage_scale, reward_scale, model_scale, color)
    if name == nil or class == nil then return end
    local enemy = {}
    enemy.name = name
    enemy.class = class
    enemy.weight = math.min(1,weight)
    enemy.wave = math.max(1,wave)
    enemy.is_elite = is_elite
    enemy.health_scale = health_scale
    enemy.damage_scale = damage_scale
    enemy.reward_scale = reward_scale
    enemy.model_scale = model_scale
    enemy.color = color
    HORDE.enemies[name .. tostring(enemy.wave)] = enemy
end

HORDE.NormalizeEnemiesWeight = function ()
    if table.IsEmpty(HORDE.enemies) then return end
    -- Normalize
    for wave = 1, HORDE.max_waves do
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

HORDE.FinalizeEnemies = function ()
    HORDE.NormalizeEnemiesWeight()
    SetEnemiesData()
end

function SetEnemiesData()
    if GetConVarNumber("horde_default_enemy_config") == 1 then return end
	if not file.IsDir('horde', 'DATA') then
		file.CreateDir('horde')
	end
	
	file.Write('horde/enemies.txt', util.TableToJSON(HORDE.enemies))
end

function GetEnemiesData()
    if not file.IsDir('horde', 'DATA') then
		file.CreateDir('horde')
        return
	end
    
    if file.Read('horde/enemies.txt', 'DATA') then
        HORDE.enemies = util.JSONToTable(file.Read('horde/enemies.txt', 'DATA'))
        HORDE.FinalizeEnemies()
    end
end

if GetConVarNumber("horde_default_enemy_config") == 1 then
    -- name, class, weight, wave, health_scale, damage_scale, model_scale, color
    HORDE.CreateEnemy("zombie", "npc_zombie", 1, 1, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("red zombie", "npc_zombie", 1, 1, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))
    HORDE.CreateEnemy("zombie torso", "npc_zombie_torso", 1, 1, 1, 1, 1, 1, nil)

    HORDE.CreateEnemy("zombie", "npc_zombie", 1, 2, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie torso", "npc_zombie_torso", 1, 2, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie fast torso", "npc_fastzombie_torso", 1, 2, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("red zombie", "npc_zombie", 1, 2, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))

    HORDE.CreateEnemy("zombie", "npc_zombie", 1, 3, false, 1, 1, 1, nil)
    HORDE.CreateEnemy("red zombie", "npc_zombie", 1, 3, false, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))
    HORDE.CreateEnemy("black zombie", "npc_zombie", 1, 3, true, 1.5, 1.25, 1.25, 1.25, Color(0,0,0))
    HORDE.CreateEnemy("zombie poison", "npc_poisonzombie", 1, 3, false, 1, 1, 1, 1, nil)

    HORDE.CreateEnemy("zombie", "npc_zombie", 1, 4, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("black zombie", "npc_zombie", 1, 4, true, 1.5, 1.25, 1.25, 1.25, Color(0,0,0))
    HORDE.CreateEnemy("zombie fast", "npc_fastzombie", 1, 4, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie poison", "npc_poisonzombie", 1, 4, false, 1, 1, 1, 1, nil)

    HORDE.CreateEnemy("zombie", "npc_zombie", 1, 5, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("black zombie", "npc_zombie", 1, 5, true, 1.5, 1.25, 1.25, 1.25, Color(0,0,0))
    HORDE.CreateEnemy("zombie fast", "npc_fastzombie", 1, 5, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("red zombie fast", "npc_fastzombie", 1, 5, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))
    HORDE.CreateEnemy("zombie poison", "npc_poisonzombie", 1, 5, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("black zombie poison", "npc_poisonzombie", 1, 5, true, 1.5, 1.5, 1.5, 1.5, Color(0,0,0))

    HORDE.NormalizeEnemiesWeight()
else
    GetEnemiesData()
end