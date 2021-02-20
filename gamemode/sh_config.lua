CreateConVar("horde_default_enemy_config", 1, SERVER_CAN_EXECUTE, "Use default enemy wave config settings.")
CreateConVar("horde_default_item_config", 1, SERVER_CAN_EXECUTE, "Use default item config settings.")
CreateConVar("horde_default_class_config", 1, SERVER_CAN_EXECUTE, "Use default class config settings.")
CreateConVar("horde_max_wave", 10, SERVER_CAN_EXECUTE, "Max waves." )
CreateConVar("horde_difficulty", 0, SERVER_CAN_EXECUTE, "Difficulty.")
CreateConVar("horde_break_time", 60, SERVER_CAN_EXECUTE, "Break time between waves.")
CreateConVar("horde_enable_shop", 1, SERVER_CAN_EXECUTE, "Enables shop menu or not.")
CreateConVar("horde_enable_client_gui", 1, SERVER_CAN_EXECUTE, "Enables client information ui or not.")
--CreateConVar("horde_enable_respawn", 0, SERVER_CAN_EXECUTE, "Players can respawn after death during a wave.")
CreateConVar("horde_max_spawn_distance", 2000, SERVER_CAN_EXECUTE, "Maximum enenmy respawn distance.")
CreateConVar("horde_min_spawn_distance", 500, SERVER_CAN_EXECUTE, "Minimum enenmy respawn distance.")
CreateConVar("horde_start_money", 1000, SERVER_CAN_EXECUTE, "Money given at start.")
CreateConVar("horde_npc_cleanup", 1, SERVER_CAN_EXECUTE, "Kills all NPCs after a wave.")
CreateConVar("horde_enable_scoreboard", 1, SERVER_CAN_EXECUTE, "Enables built-in scoreboard.")
CreateConVar("horde_external_lua_config", "", SERVER_CAN_EXECUTE, "Name of external config to load. This will take over the configs if exists.")

HORDE = {}
HORDE.__index = HORDE
HORDE.version = "1.0.0"
HORDE.color_crimson = Color(220, 20, 60)
HORDE.color_crimson_dim = Color(200, 0, 40)
HORDE.color_crimson_dark = Color(100,0,0)
HORDE.start_game = false
HORDE.total_enemies_per_wave = {15, 19, 23, 27, 30, 33, 36, 39, 42}
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
HORDE.enemy_spawn_z = 6
HORDE.player_ready = {}
HORDE.max_waves = math.min(10, math.max(1, GetConVarNumber("horde_max_wave")))
HORDE.difficulty = math.min(2, math.max(0, GetConVarNumber("horde_difficulty")))
HORDE.enable_shop = GetConVarNumber("horde_enable_shop")
HORDE.start_money = math.max(0, GetConVarNumber("horde_start_money"))
HORDE.total_enemies_this_wave_fixed = 0
HORDE.kill_reward_base = 100

-- Economy variables
HORDE.items = {}

HORDE.CreateItem = function (category, name, class, price, weight, description, whitelist, ammo_price, secondary_ammo_price)
    if category == nil or name == nil or class == nil or price == nil or weight == nil or description == nil then return end
    if name == "" or class == "" or whitelist == nil then return end
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
    HORDE.SetItemsData()
end

HORDE.SetItemsData = function()
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
        local t = util.JSONToTable(file.Read('horde/items.txt', 'DATA'))
        
        for _, item in pairs(t) do
            if item.name == "" or item.class == "" or item.name == nil or item.category == nil or item.class == nil or item.whitelist == nil or item.ammo_price == nil or item.secondary_ammo_price == nil then
		        notification.AddLegacy("Item config file validation failed! Please update your file or delete it.", NOTIFY_ERROR, 5)
		        notification.AddLegacy("Falling back to default config.", NOTIFY_ERROR, 5)
                return
            end
        end
        HORDE.items = t
    end
end

HORDE.GetDefaultItemsData = function()
    HORDE.CreateItem("Melee",      "Stunstick",      "weapon_stunstick",     100,  1, "Electric baton.", 
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true, Engineer=true}, 10, -1)
    HORDE.CreateItem("Melee",      "Crowbar",        "weapon_crowbar",       100,  1, "A rusty crowbar.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true, Engineer=true}, 10, -1)
    HORDE.CreateItem("Melee",      "Combat Knife",   "arccw_go_melee_knife", 500,  2, "A reliable bayonet.\nRMB to deal a heavy slash.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true, Engineer=true}, 10, -1)

    HORDE.CreateItem("Pistol",     "9mm",            "weapon_pistol",     400,  2, "Combine standard sidearm.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true, Engineer=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "357",            "weapon_357",        500,  2, "Colt python magnum pistol.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true, Engineer=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "Glock",          "arccw_go_glock",    750,  3, "The Glock 18 is a selective-fire variant of the Glock 17.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "USP",            "arccw_go_usp",      750,  3, "A semi-automatic pistol developed in Germany by H&K.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "P2000",          "arccw_go_p2000",    750,  3, "Accurate and controllable.\nA serviceable first-round pistol made by H&K.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "P250",           "arccw_go_p250",     750,  3, "A low-recoil firearm with a high rate of fire.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "R8 Revolver",    "arccw_go_r8",       750,  3, "Delivers a highly accurate and powerful round,\nbut at the expense of a lengthy trigger-pull.",
    {Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=true, Ghost=true, Engineer=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "Deagle",         "arccw_go_deagle",   750,  3, "Night Hawk .50C.\nAn iconic pistol that is diffuclt to master.",
    {Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=true, Ghost=true, Engineer=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "FiveSeven",      "arccw_go_fiveseven",750,  3, "ES Five-seven.\nA Belgian semi-automatic pistol made by FN Herstal",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "CZ75",           "arccw_go_cz75",     750,  3, "A fully automatic variant of the CZ75.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "M9",             "arccw_go_m9",       750,  3, "Beretta 92F semi-automatic pistol.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "Tec-9",          "arccw_go_tec9",     750,  3, "A Swedish-made semi-automatic pistol.\nLethal in close quarters.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("Pistol",     "TMP",            "arccw_mw2_tmp",     1000,  3, "Steyr TMP.\nA select-fire 9×19mm Parabellum caliber machine pistol.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)

    HORDE.CreateItem("SMG",        "MP7",            "weapon_smg1",       1250, 4, "A compact, fully automatic firearm.\nArmed with an M203 launcher.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, 75)
    HORDE.CreateItem("SMG",        "Mac10",          "arccw_go_mac10",    1500, 5, "MAC-10 SMG boasts a high rate of fire,\nwith poor spread accuracy and high recoil as trade-offs.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("SMG",        "MP9",            "arccw_go_mp9",      1500, 5, "Manufactured in Switzerland,\nthe MP9 is favored by private security firms world-wide.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("SMG",        "MP5",            "arccw_go_mp5",      1750, 5, "Often imitated but never equaled,\nthe MP5 is perhaps the most versatile SMG in the world.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("SMG",        "UMP45",          "arccw_go_ump",      1750, 5, "KM UMP45.\nA lighter and cheaper successor to the MP5.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("SMG",        "PP Bizon",       "arccw_go_bizon",    1750, 6, "PP-19 Bizon.\nOffers a high-capacity magazine that reloads quickly.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("SMG",        "P90",            "arccw_go_p90",      2000, 6, "ES C90.\nA Belgian bullpup PDW with a magazine of 50 rounds.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("SMG",        "Vector",         "arccw_mw2_vector",  2000, 6, "KRISS Vector Gen I.\nSses an unconventional delayed blowback system.",
    {Medic=true, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1)

    HORDE.CreateItem("Shotgun",    "SPAS12",         "weapon_shotgun",    1250, 7, "A standard 12-gauge shotgun.\nRMB to fire 2 shots at once.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("Shotgun",    "Nova",           "arccw_go_nova",     1500, 7, "Benelli Nova.\nPump-action 12-gauge shotgun.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("Shotgun",    "M870",           "arccw_go_870",      1500, 7, "Remington 870 Shotgun.\nManufactured in the United States.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("Shotgun",    "MAG7",           "arccw_go_mag7",     1500, 7, "Techno Arms MAG-7.\nFires a specialized 60mm 12 gauge shell.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("Shotgun",    "XM1014",         "arccw_go_m1014",    2000, 8, "Benelli M4 Super 90.\nFully automatic shotgun.",
    {Medic=false, Assault=true, Heavy=true, Demolition=false, Survivor=true, Ghost=false, Engineer=true}, 10, -1)
    HORDE.CreateItem("Shotgun",    "AA12",           "arccw_mw2_aa12",     2000, 8, "Atchisson Assault Shotgun.\nDevastating firepower at close to medium range.",
    {Medic=false, Assault=true, Heavy=true, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1)
    
    HORDE.CreateItem("Rifle",      "Combine AR2",    "weapon_ar2",        1500, 7, "Overwatch standard issue rifle.\nDark energy-powered assault rifle.",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=true}, 10, 50)
    HORDE.CreateItem("Rifle",      "FAMAS",          "arccw_go_famas",    2000, 7, "FAMAS bullpup assault rifle.\nRecognised for its high rate of fire.",
    {Medic=true, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1)
    HORDE.CreateItem("Rifle",      "Galil",          "arccw_go_ace",      2000, 7, "Galil ACE 22.\nDeveloped and originally manufactured by  Israel Military Industries.",
    {Medic=true, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1)
    HORDE.CreateItem("Rifle",      "AK47",           "arccw_go_ak47",     2250, 7, "Avtomat Kalashnikova.\nA gas-operated, 7.62×39mm assault rifle developed in the Soviet Union.",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1)
    HORDE.CreateItem("Rifle",      "M4A1",           "arccw_go_m4",       2250, 7, "Colt M4.\nA 5.56×45mm NATO, air-cooled, gas-operated, select fire carbine.",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1)
    HORDE.CreateItem("Rifle",      "SG556",          "arccw_go_sg556",    2250, 7, "SIG SG 550.\nAn assault rifle manufactured by Swiss Arms AG.",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1)
    HORDE.CreateItem("Rifle",      "AUG",            "arccw_go_aug",      2250, 7, "Steyr AUG.\nAn Austrian bullpup assault rifle.",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1)
    HORDE.CreateItem("Rifle",      "F2000",          "arccw_mw2_f2000",   2250, 7, "FN F2000.\nAn ambidextrous bullpup rifle developed by FN.",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1)
    HORDE.CreateItem("Rifle",      "Tavor",          "arccw_mw2_tavor",   2250, 7, "IWI Tavor-21.\nDesigned to maximize reliability, durability, simplicity.",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1)
    
    HORDE.CreateItem("Rifle",      "AWP",            "arccw_go_awp",      2000, 7, "Magnum Ghost Rifle.\nA series of sniper rifles manufactured by the United Kingdom.",
    {Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=false, Ghost=true, Engineer=false}, 10, -1)
    HORDE.CreateItem("Rifle",      "ACR",            "arccw_mw2_acr",     2150, 7, "Remington Adaptive Combat Rifle.\nA modular semi-Auto rifle.",
    {Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=true, Ghost=true, Engineer=false}, 10, -1)
    HORDE.CreateItem("Rifle",      "SCAR",           "arccw_go_scar",     2250, 8, "FN SCAR.\nAn assault rifle developed by Belgian manufacturer FN Herstal.",
    {Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=true, Ghost=true, Engineer=false}, 10, -1)
    HORDE.CreateItem("Rifle",      "G3",             "arccw_go_g3",       2250, 8, "G3 Battle Rifle.\nA 7.62×51mm NATO, select-fire battle rifle developed by H&K.",
    {Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=true, Ghost=true, Engineer=false}, 10, -1)
    
    HORDE.CreateItem("MG",         "M249",           "arccw_go_m249para",  2250, 10, "M249 light machine gun.\nA gas operated and air-cooled weapon of destruction.",
    {Medic=false, Assault=false, Heavy=true, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1)
    HORDE.CreateItem("MG",         "Negev",          "arccw_go_negev",     2250, 10, "IWI Negev.\nA 5.56×45mm NATO light machine gun developed by the IWI.",
    {Medic=false, Assault=false, Heavy=true, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1)

    HORDE.CreateItem("Explosive",  "Frag Grenade",   "weapon_frag",        75,   0, "A standard grenade.\nDoes its job well.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true, Engineer=true}, 75, -1)
    HORDE.CreateItem("Explosive",  "Incendiary Grenade",   "arccw_go_nade_incendiary",        200,   1, "Generates a pool of fire after some delay.\nSets everything on fire within its effect.",
    {Medic=false, Assault=false, Heavy=false, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 200, -1)
    HORDE.CreateItem("Explosive",  "Resistance RPG", "weapon_rpg",         2000, 7, "Laser-guided rocket propulsion device.",
    {Medic=false, Assault=false, Heavy=false, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1)
    HORDE.CreateItem("Explosive",  "SLAM",           "weapon_slam",        500,  2, "Selectable Lightweight Attack Munition.\nRMB to detonate.",
    {Medic=false, Assault=false, Heavy=false, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1)

    HORDE.CreateItem("Special",    "Heat Crossbow",  "weapon_crossbow",    1250, 5, "Improvised sniper weapon.\nShoots scorching rebars.",
    {Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=false, Ghost=true, Engineer=true}, 10, -1)
    HORDE.CreateItem("Special",    "Gravity Gun",  "weapon_physcannon",    1500, 5, "Zero Point Energy Field Manipulator.\nPinnacle of theoretical physics.",
    {Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=false, Ghost=false, Engineer=true}, 10, -1)

    HORDE.CreateItem("Equipment",  "Medkit",         "weapon_medkit",      50,   1, "Rechargeble medic.\nRMB to self-heal, LMB to heal others.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true, Engineer=true}, 10, -1)
end

if GetConVarNumber("horde_default_item_config") == 0 then
    GetItemsData()
else
    HORDE.GetDefaultItemsData()
end

if SERVER then
    util.AddNetworkString("Horde_GetItemsData")
    
    net.Receive("Horde_GetItemsData", function ()
        GetItemsData()
    end)
end

HORDE.GetSpecialItems = function ()
    -- Some built-in special items
    HORDE.CreateItem("Equipment", "Kevlar Armor", "armor", 1000, 0, "Full kevlar armor set.\nFills up 100% of your armor bar.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true, Engineer=true}, 10, -1)
end

HORDE.GetSpecialItems()

HORDE.max_weight = 15
HORDE.default_ammo_price = 10

-- Class
HORDE.classes = {}
HORDE.CreateClass = function (name, description, max_hp, movespd, sprintspd, perks)
    if name == nil or name == "" then return end
    local class = {}
    class.name = name
    class.description = description
    class.max_hp = max_hp
    class.movespd = movespd
    class.sprintspd = sprintspd
    class.perks = perks
    HORDE.classes[class.name] = class
end
-- Only allow 1 change per wave
HORDE.player_class_changed = {}

HORDE.CreateClass(
    "Survivor",
    "No bonus.\n\nHave access to all weapons except for special weapons.",
    100,
    180,
    220,
    {A="25% less damage taken.", B="25% increased damage."}
)

HORDE.CreateClass(
    "Medic",
    "Regenerate 2% health per second.\n\nHave partial access to Rifles and most light weapons.",
    100,
    180,
    220,
    {A="50% increased maximum health.", B="Adds 25 Poison damage to each attack."}
)

HORDE.CreateClass(
    "Demolition",
    "75% less explosive damage taken.\nRegenerate 1 frag grenade every 30 seconds, if you do not have one.\n\nHave full access to Explosive weapons.",
    100,
    180,
    220,
    {A="50% increased explosive damage", B="Enemies you kill explode,\ndealing (100 + 10% of their health) as AOE damage."}
)

HORDE.CreateClass(
    "Assault",
    "25% increased movement speed.\n\nHave full access to Rifles.",
    100,
    225,
    275,
    {A="25% chance to not consume ammo while firing.", B="Each enemy you kill grants you 1 Frenzy charge.\nEach frenzy charge increases your damage and movespeed by 6%."}
)

HORDE.CreateClass(
    "Heavy",
    "+5 to maximum carrying capacity.\nRegenerate 1 armor per second, up to 25.\n\nHave full access to Machine Guns and heavier weapons.",
    100,
    180,
    220,
    {A="Immune to damage while you have armor.", B="Enemies you hit are Pressured for 1 second.\nPressured enemies deal 25% less damage and take 25% increased damage."}
)

HORDE.CreateClass(
    "Ghost",
    "50% increased headshot damage.\n\nHave access to sniper rifles and selected light weapons.",
    100,
    180,
    220,
    {A={"100% increased damage with single shot weapons."}, B={"Headshot damage stacks,\ndealing 10% increased damage each stack."}}
)

--[[
HORDE.CreateClass(
    "Engineer",
    "No bonus.\n\nHave access to special weapons and equipment.",
    100,
    180,
    220
)]]--

function SetClassData()
    if GetConVarNumber("horde_default_class_config") == 1 then return end
	if not file.IsDir('horde', 'DATA') then
		file.CreateDir('horde')
	end
	
	file.Write('horde/class.txt', util.TableToJSON(HORDE.classes))
end

HORDE.UpdateClassData = function()
    SetClassData()
end

function GetClassData()
    if not file.IsDir('horde', 'DATA') then
		file.CreateDir('horde')
        return
	end
    
    if file.Read('horde/class.txt', 'DATA') then
        local t = util.JSONToTable(file.Read('horde/class.txt', 'DATA'))

        -- Integrity
        for _, class in pairs(t) do
            if class.name == nil or class.name == "" or class.perks == nil then
		        notification.AddLegacy("Class config file validation failed! Please update your file or delete it.", NOTIFY_ERROR, 5)
		        notification.AddLegacy("Falling back to default config.", NOTIFY_ERROR, 5)
                return
            end
        end

        for _, class in pairs(t) do
            HORDE.classes[class.name].description = class.description
        end
    end
end

if GetConVarNumber("horde_default_class_config") == 0 then
    -- Overwrite description
    GetClassData()
end

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
    HORDE.SetEnemiesData()
end

if SERVER then
util.AddNetworkString("Horde_GetEnemiesData")

net.Receive("Horde_GetEnemiesData", function ()
    GetEnemiesData()
end)
end

HORDE.SetEnemiesData = function()
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
        local t = util.JSONToTable(file.Read('horde/enemies.txt', 'DATA'))
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
        HORDE.FinalizeEnemies()
    end
end

HORDE.GetDefaultEnemiesData = function ()
    -- name, class, weight, wave, health_scale, damage_scale, reward_scale, model_scale, color
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
    HORDE.CreateEnemy("zombie torso vj", "npc_vj_zss_czombietor", 0.5, 2, false, 1, 1, 1, 1, nil)
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
    HORDE.CreateEnemy("zombie fast", "npc_fastzombie",           0.5, 5, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("red zombie fast", "npc_fastzombie",       0.25, 5, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))
    HORDE.CreateEnemy("zombie poison", "npc_poisonzombie",       0.5, 5, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie hulk", "npc_vj_zss_zhulk",         0.1, 5, true, 2, 2, 2, 1, nil)
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
    HORDE.CreateEnemy("zombie fast", "npc_fastzombie",           0.75, 6, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("red zombie fast", "npc_fastzombie",       0.5, 6, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))
    HORDE.CreateEnemy("zombie hulk", "npc_vj_zss_zhulk",         0.1, 6, true, 1, 1, 1, 1, nil)
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
    HORDE.CreateEnemy("red zombie fast", "npc_fastzombie",       0.75, 7, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))
    HORDE.CreateEnemy("zombie hulk", "npc_vj_zss_zhulk",         0.1, 7, true, 1, 1, 1, 1, nil)
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
    HORDE.CreateEnemy("red zombie fast", "npc_fastzombie",       0.75, 8, true, 1.25, 1.25, 1.25, 1.25, Color(255,0,0))
    HORDE.CreateEnemy("zombie hulk", "npc_vj_zss_zhulk",         0.1, 8, true, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("black zombie poison", "npc_poisonzombie", 0.25, 8, true, 1.5, 1.5, 1.5, 1.5, Color(0,0,0))
    HORDE.CreateEnemy("burnt", "npc_vj_zss_burnzie",             0.25, 8, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj fast black", "npc_vj_zss_zombfast", 0.25, 8, true, 2, 1, 2, 1.1, Color(0,0,0))
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
    HORDE.CreateEnemy("zombie hulk", "npc_vj_zss_zhulk",         0.1, 9, true, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("black zombie poison", "npc_poisonzombie", 0.25, 9, true, 1.5, 1.5, 1.5, 1.5, Color(0,0,0))
    HORDE.CreateEnemy("burnt", "npc_vj_zss_burnzie",             0.25, 9, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj fast black", "npc_vj_zss_zombfast", 0.25, 9, true, 2, 1, 2, 1.1, Color(0,0,0))

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
    HORDE.CreateEnemy("zombie hulk red", "npc_vj_zss_zhulk",         0.1, 10, true, 2, 2, 2, 1, Color(255,0,0))
    HORDE.CreateEnemy("zombie hulk black", "npc_vj_zss_zhulk",       0.1,10, true, 3, 3, 2, 1, Color(0,0,0))
    HORDE.CreateEnemy("black zombie poison", "npc_poisonzombie",     0.25, 10, true, 1.5, 1.5, 1.5, 1.5, Color(0,0,0))
    HORDE.CreateEnemy("burnt", "npc_vj_zss_burnzie",                 0.25, 10, false, 1, 1, 1, 1, nil)
    HORDE.CreateEnemy("zombie vj fast black", "npc_vj_zss_zombfast", 0.25, 10, true, 2, 1, 2, 1.1, Color(0,0,0))
    HORDE.CreateEnemy("zombie vj guard", "npc_vj_zss_zombguard",     0.25, 10, false, 1, 1, 1, 1, nil)
    
    HORDE.NormalizeEnemiesWeight()
end

if GetConVarNumber("horde_default_enemy_config") == 1 then
    HORDE.GetDefaultEnemiesData()
else
    GetEnemiesData()
end

HORDE.SaveTempData = function ()
    if not file.IsDir('horde', 'DATA') then
		file.CreateDir('horde')
	end
    if GetConVarString("horde_external_lua_config") and GetConVarString("horde_external_lua_config") ~= "" then
        file.Write('horde/temp_enemies.dat', util.TableToJSON(HORDE.enemies))
        file.Write('horde/temp_items.dat', util.TableToJSON(HORDE.items))
        print("???")
    end
end

HORDE.LoadTempData = function ()
    if not file.IsDir('horde', 'DATA') then
		file.CreateDir('horde')
        return
	end
    
    if file.Read('horde/temp_items.dat', 'DATA') then
        local t1 = util.JSONToTable(file.Read('horde/temp_items.dat', 'DATA'))
        
        for _, item in pairs(t1) do
            if item.name == "" or item.class == "" or item.name == nil or item.category == nil or item.class == nil or item.whitelist == nil or item.ammo_price == nil or item.secondary_ammo_price == nil then
                if CLIENT then
		            notification.AddLegacy("Item config file validation failed! Please update your file or delete it.", NOTIFY_ERROR, 5)
		            notification.AddLegacy("Falling back to default config.", NOTIFY_ERROR, 5)
                end
                return
            end
        end

        if file.Read('horde/temp_enemies.dat', 'DATA') then
            local t2 = util.JSONToTable(file.Read('horde/temp_enemies.dat', 'DATA'))
            -- Integrity
            for _, enemy in pairs(t2) do
                if enemy.name == nil or enemy.name == "" or enemy.class == nil or enemy.class == "" or enemy.weight == nil or enemy.wave == nil then
                    if CLIENT then
                        notification.AddLegacy("Enemy config file validation failed! Please update your file or delete it.", NOTIFY_ERROR, 5)
                        notification.AddLegacy("Falling back to default config.", NOTIFY_ERROR, 5)
                    end
                    return
                else
                    if not enemy.weapon then
                        enemy.weapon = ""
                    end
                end
            end
    
            -- Be careful of backwards compataiblity
            HORDE.items = t1
            HORDE.enemies = t2
            HORDE.NormalizeEnemiesWeight()
        end
    end
end

if SERVER then
util.AddNetworkString("Horde_UseExternalLuaConfig")

net.Receive("Horde_UseExternalLuaConfig", function ()
    HORDE.LoadTempData()
end)
end

-- Statistics
HORDE.player_damage = {}
HORDE.player_damage_taken = {}
HORDE.player_money_earned = {}
HORDE.player_headshots = {}
HORDE.player_elite_kills = {}