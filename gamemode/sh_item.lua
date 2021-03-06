-- Economy variables
HORDE.items = {}

HORDE.ENTITY_PROPERTY_WPN = 1
HORDE.ENTITY_PROPERTY_GIVE = 2
HORDE.ENTITY_PROPERTY_DROP = 3
HORDE.ENTITY_PROPERTY_ARMOR = 4
HORDE.ENTITY_PROPERTY_GADGET = 5

HORDE.categories = {"Melee", "Pistol", "SMG", "Shotgun", "Rifle", "MG", "Explosive", "Special", "Equipment", "Attachment", "Gadget"}
HORDE.entity_categories = {"Special", "Equipment"}
HORDE.arccw_attachment_categories = {"Optic", "Underbarrel", "Tactical", "Barrel", "Muzzle", "Magazine", "Stock", "Ammo Type", "Perk"}

HORDE.max_weight = 15
HORDE.default_ammo_price = 10

-- Creates a Horde item. The item will appear in the shop.
function HORDE:CreateItem(category, name, class, price, weight, description, whitelist, ammo_price, secondary_ammo_price, entity_properties, shop_icon)
    if category == nil or name == nil or class == nil or price == nil or weight == nil or description == nil then return end
    if name == "" or class == "" then return end
    if not table.HasValue(HORDE.categories, category) then return end
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
    if entity_properties then
        item.entity_properties = entity_properties
    else
        item.entity_properties = {type=HORDE.ENTITY_PROPERTY_WPN}
    end
    if item.class == "_horde_armor_100" then
        item.entity_properties = {type=HORDE.ENTITY_PROPERTY_ARMOR, armor=100}
    end
    if shop_icon and shop_icon ~= "" then
        item.shop_icon = shop_icon
    end
    HORDE.items[item.class] = item
    HORDE:SetItemsData()
end

HORDE.InvalidateHordeItemCache = 1
HORDE.CachedHordeItems = nil
HORDE.GetCachedHordeItems = function()
    if HORDE.InvalidateHordeItemCache == 1 then
        local tab = util.TableToJSON(HORDE.items)
        local str = util.Compress(tab)
        HORDE.CachedHordeItems = str
        HORDE.InvalidateHordeItemCache = 0
    end
    return HORDE.CachedHordeItems
end

function HORDE:SyncItems()
    local str = HORDE.GetCachedHordeItems()
    if player then
        for _, ply in pairs(player.GetAll()) do
            net.Start("Horde_SyncItems")
                net.WriteUInt(string.len(str), 32)
                net.WriteData(str, string.len(str))
            net.Send(ply)
        end
    end
end

function HORDE:SetItemsData()
    if SERVER then
        if GetConVarNumber("horde_default_item_config") == 1 then return end
        if not file.IsDir("horde", "DATA") then
            file.CreateDir("horde")
        end

        file.Write("horde/items.txt", util.TableToJSON(HORDE.items))

        HORDE:SyncItems()
    end
end

local function GetItemsData()
    if SERVER then
        if not file.IsDir("horde", "DATA") then
            file.CreateDir("horde")
            return
        end

        if file.Read("horde/items.txt", "DATA") then
            local t = util.JSONToTable(file.Read("horde/items.txt", "DATA"))

            for _, item in pairs(t) do
                if item.name == "" or item.class == "" or item.name == nil or item.category == nil or item.class == nil or item.ammo_price == nil or item.secondary_ammo_price == nil then
                    net.Start("Horde_LegacyNotification")
                        net.WriteString("Item config file validation failed! Please update your file or delete it.")
                    net.WriteInt(1,2)
                    return
                end
            end
            HORDE.items = t

            print("[HORDE] - Loaded custom item config.")
        end

        HORDE:SyncItems()
    end
end

function HORDE:GetDefaultGadgets()
    HORDE:CreateItem("Gadget", "Detoxifier", "gadget_detoxifier", 1500, 0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})
    HORDE:CreateItem("Gadget", "Heat Plating", "gadget_heat_plating", 1500, 0, "nil",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})
    HORDE:CreateItem("Gadget", "Shock Plating", "gadget_shock_plating", 1500, 0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})
    HORDE:CreateItem("Gadget", "Blast Plating", "gadget_blast_plating", 1500, 0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})
    HORDE:CreateItem("Gadget", "Diamond Plating", "gadget_diamond_plating", 1750, 0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})

    HORDE:CreateItem("Gadget", "Vitality Booster", "gadget_vitality_booster", 2500, 0, "",
    {Survivor=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})
    HORDE:CreateItem("Gadget", "Damage Booster", "gadget_damage_booster", 2500, 0, "",
    {Survivor=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})

    HORDE:CreateItem("Gadget", "IV Injection", "gadget_iv_injection", 2000, 0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})
    HORDE:CreateItem("Gadget", "Cortex", "gadget_cortex", 2500, 0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})

    HORDE:CreateItem("Gadget", "Life Diffuser", "gadget_life_diffuser", 2000, 0, "",
    {Medic=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})
    HORDE:CreateItem("Gadget", "Projectile Launcher (Heal)", "gadget_projectile_launcher_heal", 2500, 0, "",
    {Medic=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})

    HORDE:CreateItem("Gadget", "Energy Shield", "gadget_energy_shield", 2000, 0, "",
    {Heavy=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})
    HORDE:CreateItem("Gadget", "Hardening Injection", "gadget_hardening_injection", 2500, 0, "",
    {Heavy=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})

    HORDE:CreateItem("Gadget", "Proximity Defense", "gadget_proximity_defense", 2000, 0, "",
    {Demolition=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})
    HORDE:CreateItem("Gadget", "Projectile Launcher (Blast)", "gadget_projectile_launcher_blast", 2500, 0, "",
    {Demolition=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})

    HORDE:CreateItem("Gadget", "Optical Camouflage", "gadget_optical_camouflage", 2500, 0, "",
    {Ghost=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})
    HORDE:CreateItem("Gadget", "Projectile Launcher (Ballistic)", "gadget_projectile_launcher_ballistic", 2500, 0, "",
    {Ghost=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})

    HORDE:CreateItem("Gadget", "E-Parasite", "gadget_e_parasite", 2500, 0, "",
    {Engineer=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})
    HORDE:CreateItem("Gadget", "Turret Pack", "gadget_turret_pack", 2500, 0, "",
    {Engineer=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})

    HORDE:CreateItem("Gadget", "Berserk Armor", "gadget_berserk_armor", 2500, 0, "",
    {Berserker=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})
    HORDE:CreateItem("Gadget", "Flash", "gadget_flash", 2500, 0, "",
    {Berserker=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})

    HORDE:CreateItem("Gadget", "Solar Array", "gadget_solar_array", 2000, 0, "",
    {Warden=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})
    HORDE:CreateItem("Gadget", "Projectile Launcher (Shock)", "gadget_projectile_launcher_shock", 2500, 0, "",
    {Warden=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})

    HORDE:CreateItem("Gadget", "Butane Can", "gadget_butane_can", 2000, 0, "",
    {Cremator=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})
    HORDE:CreateItem("Gadget", "Projectile Launcher (Fire)", "gadget_projectile_launcher_fire", 2500, 0, "",
    {Cremator=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GADGET})
end

function HORDE:GetDefaultItemsData()
    HORDE:CreateItem("Melee",      "Stunstick",      "weapon_stunstick",     100,  0, "Electric baton.",
    nil, 10, -1)
    HORDE:CreateItem("Melee",      "Crowbar",        "weapon_crowbar",       100,  0, "A rusty crowbar.",
    nil, 10, -1)
    HORDE:CreateItem("Melee",      "Combat Knife",   "arccw_go_melee_knife", 500,  2, "A reliable bayonet.\nRMB to deal a heavy slash.",
    nil, 10, -1)
    HORDE:CreateItem("Melee",      "Katana",         "arccw_horde_katana",  2000,  4, "Ninja sword.\nLong attack range and fast attack speed.",
    {Survivor=true, Berserker=true}, 10, -1)
    HORDE:CreateItem("Melee",      "Bat",            "arccw_horde_bat",     2000,  4, "Sturdy baseball bat.\nHits like a truck.",
    {Survivor=true, Berserker=true}, 10, -1)

    HORDE:CreateItem("Pistol",     "9mm",            "weapon_pistol",     150,  0, "Combine standard sidearm.",
    nil, 2, -1)
    HORDE:CreateItem("Pistol",     "357",            "weapon_357",        300,  1, "Colt python magnum pistol.\nUsed by Black Mesa security guards.",
    nil, 3, -1)
    HORDE:CreateItem("Pistol",     "Glock",          "arccw_go_glock",    750,  2, "Glock 18.\nSemi-automatic pistols manufactured in Austrian.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Engineer=true, Warden=true, Cremator=true}, 5, -1)
    HORDE:CreateItem("Pistol",     "USP",            "arccw_go_usp",      750,  2, "Universelle Selbstladepistole.\nA semi-automatic pistol developed in Germany by H&K.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Engineer=true, Warden=true, Cremator=true}, 5, -1)
    HORDE:CreateItem("Pistol",     "P2000",          "arccw_go_p2000",    750,  2, "Heckler & Koch P2000.\nA serviceable first-round pistol made by H&K.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Engineer=true, Warden=true, Cremator=true}, 5, -1)
    HORDE:CreateItem("Pistol",     "P250",           "arccw_go_p250",     750,  2, "SIG Sauer P250.\nA low-recoil sidearm with a high rate of fire.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Engineer=true, Warden=true, Cremator=true}, 5, -1)
    HORDE:CreateItem("Pistol",     "R8",             "arccw_go_r8",       750,  2, "R8 Revolver.\nDelivers a highly accurate and powerful round,\nbut at the expense of a lengthy trigger-pull.",
    {Survivor=true, Ghost=true}, 5, -1)
    HORDE:CreateItem("Pistol",     "Deagle",         "arccw_go_deagle",   750,  2, "Night Hawk .50C.\nAn iconic pistol that is diffcult to master.",
    {Survivor=true, Ghost=true}, 5, -1)
    HORDE:CreateItem("Pistol",     "M1911",          "arccw_mw2_m1911",   750,  2, "Colt 1911.\nStandard-issue sidearm for the United States Armed Forces.",
    {Ghost=true}, 5, -1)
    HORDE:CreateItem("Pistol",     "Anaconda",       "arccw_horde_anaconda",1000,  3, "Colt Anaconda.\nChambered for the powerful .44 Magnum.",
    {Ghost=true}, 10, -1)
    HORDE:CreateItem("Pistol",     "CZ75",           "arccw_go_cz75",     750,  2, "CZ 75.\nA semi-automatic pistol manufactured in Czech Republic.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Engineer=true, Warden=true, Cremator=true}, 5, -1)
    HORDE:CreateItem("Pistol",     "M9",             "arccw_go_m9",       750,  2, "Beretta M9.\nSidearm used by the United States Armed Forces.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Engineer=true, Warden=true, Cremator=true}, 5, -1)
    HORDE:CreateItem("Pistol",     "FiveSeven",      "arccw_go_fiveseven",750,  3, "ES Five-seven.\nA Belgian semi-automatic pistol made by FN Herstal.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Engineer=true, Warden=true, Cremator=true}, 5, -1)
    HORDE:CreateItem("Pistol",     "Tec-9",          "arccw_go_tec9",     900,  3, "A Swedish-made semi-automatic pistol.\nLethal in close quarters.",
    {Medic=true, Assault=true, Heavy=true, Survivor=true, Engineer=true, Warden=true}, 8, -1)
    HORDE:CreateItem("Pistol",     "TMP",            "arccw_mw2_tmp",     900,  3, "Steyr TMP.\nA select-fire 9×19mm Parabellum caliber machine pistol.",
    {Medic=true, Assault=true, Heavy=true, Survivor=true, Engineer=true, Warden=true,}, 8, -1)
    HORDE:CreateItem("Pistol",     "Flare Gun",      "arccw_horde_flaregun",  1000,  4, "Orion Safety Flare Gun.\nIgnites enemies and deals Fire damage.",
    {Cremator=true}, 8, -1)

    HORDE:CreateItem("SMG",        "SMG1",           "weapon_smg1",       750, 3, "A compact, fully automatic firearm.\nArmed with an M203 launcher.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Warden=true, Cremator=true}, 3, 50)
    HORDE:CreateItem("SMG",        "Mac10",          "arccw_go_mac10",    1500, 4, "Military Armament Corporation Model 10.\nBoasts a high rate of fire,\nwith poor spread accuracy and high recoil as trade-offs.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Warden=true, Cremator=true}, 8, -1)
    HORDE:CreateItem("SMG",        "MP9",            "arccw_go_mp9",      1500, 4, "Brügger & Thomet MP9.\nManufactured in Switzerland,\nthe MP9 is favored by private security firms world-wide.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Warden=true, Cremator=true}, 8, -1)
    HORDE:CreateItem("SMG",        "MP5K",           "arccw_mw2_mp5k",    1500, 4, "Heckler & Koch MP5K.\nA more convert and mobile version of the MP5.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Warden=true, Cremator=true}, 8, -1)
    HORDE:CreateItem("SMG",        "MP5",            "arccw_go_mp5",      1750, 5, "Heckler & Koch MP5.\nOften imitated but never equaled,\nthe MP5 is perhaps the most versatile SMG in the world.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Warden=true, Cremator=true}, 8, -1)
    HORDE:CreateItem("SMG",        "UMP45",          "arccw_go_ump",      1750, 5, "KM UMP45.\nA lighter and cheaper successor to the MP5.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Warden=true, Cremator=true}, 8, -1)
    HORDE:CreateItem("SMG",        "PP Bizon",       "arccw_go_bizon",    2000, 6, "PP-19 Bizon.\nOffers a high-capacity magazine that reloads quickly.",
    {Medic=true, Assault=true, Survivor=true}, 15, -1)
    HORDE:CreateItem("SMG",        "P90",            "arccw_go_p90",      2000, 6, "ES C90.\nA Belgian bullpup PDW with a magazine of 50 rounds.",
    {Medic=true, Assault=true, Survivor=true}, 15, -1)
    HORDE:CreateItem("SMG",        "Vector",         "arccw_horde_vector",2500, 6, "KRISS Vector Gen I.\nUses an unconventional blowback system that results in its high firerate.",
    {Survivor=true, Medic=true}, 8, -1)

    HORDE:CreateItem("Shotgun",    "Pump-Action",    "weapon_shotgun",    1000, 6, "A standard 12-gauge shotgun.\nRMB to fire 2 shots at once.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Engineer=true, Warden=true, Cremator=true}, 10, -1)
    HORDE:CreateItem("Shotgun",    "Nova",           "arccw_go_nova",     1500, 7, "Benelli Nova.\nItalian pump-action 12-gauge shotgun.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Engineer=true, Warden=true}, 10, -1)
    HORDE:CreateItem("Shotgun",    "M870",           "arccw_go_870",      1500, 7, "Remington 870 Shotgun.\nManufactured in the United States.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Engineer=true, Warden=true}, 10, -1)
    HORDE:CreateItem("Shotgun",    "MAG7",           "arccw_go_mag7",     1500, 7, "Techno Arms MAG-7.\nFires a specialized 60mm 12 gauge shell.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Engineer=true, Warden=true}, 10, -1)
    HORDE:CreateItem("Shotgun",    "XM1014",         "arccw_go_m1014",    2000, 7, "Benelli M4 Super 90.\nFully automatic shotgun.",
    {Medic=true, Assault=true, Heavy=true, Survivor=true, Engineer=true, Warden=true}, 10, -1)
    HORDE:CreateItem("Shotgun",    "Double Barrel",  "arccw_horde_doublebarrel",    2000, 7, "Double Barrel Shotgun.\nDevastating power at close range.",
    {Survivor=true, Warden=true}, 10, -1)
    HORDE:CreateItem("Shotgun",    "Trench Gun",     "arccw_horde_trenchgun", 2250, 7, "Winchester Model 1200.\nShoots incendiary pellets.",
    {Warden=true, Cremator=true}, 15, -1)
    HORDE:CreateItem("Shotgun",    "SPAS-12",        "arccw_mw2_spas12",  2500, 8, "Franchi SPAS-12.\nA combat shotgun manufactured by Italian firearms company Franchi.",
    {Survivor=true, Warden=true}, 15, -1)
    HORDE:CreateItem("Shotgun",    "Striker",        "arccw_horde_striker", 2500, 8, "Armsel Striker.\nA 12-gauge shotgun with a revolving cylinder from South Africa.",
    {Warden=true}, 15, -1)
    HORDE:CreateItem("Shotgun",    "AA12",           "arccw_horde_aa12",  3000, 10, "Atchisson Assault Shotgun.\nDevastating firepower at close to medium range.",
    {Heavy=true, Survivor=true, Warden=true}, 25, -1)

    HORDE:CreateItem("Rifle",      "AR15",           "arccw_go_ar15",     2000, 7, "AR-15 Style Rifle.\nA lightweight semi-automatic rifle based on ArmaLite AR-15 design.",
    {Medic=true, Assault=true, Survivor=true, Ghost=true}, 10, -1)
    HORDE:CreateItem("Rifle",      "FAMAS",          "arccw_go_famas",    2000, 7, "FAMAS bullpup assault rifle.\nRecognised for its high rate of fire.",
    {Medic=true, Assault=true, Survivor=true}, 10, -1)
    HORDE:CreateItem("Rifle",      "Galil",          "arccw_go_ace",      2000, 7, "Galil ACE 22.\nDeveloped and originally manufactured by IMI.",
    {Medic=true, Assault=true, Survivor=true}, 10, -1)
    HORDE:CreateItem("Rifle",      "AK47",           "arccw_go_ak47",     2500, 7, "Avtomat Kalashnikova.\nA gas-operated, 7.62×39mm assault rifle developed in the Soviet Union.",
    {Assault=true, Survivor=true}, 10, -1)
    HORDE:CreateItem("Rifle",      "M4A1",           "arccw_go_m4",       2500, 7, "Colt M4.\nA 5.56×45mm NATO, air-cooled, gas-operated, select fire carbine.",
    {Assault=true, Survivor=true}, 10, -1)
    HORDE:CreateItem("Rifle",      "SG556",          "arccw_go_sg556",    2500, 7, "SIG SG 550.\nAn assault rifle manufactured by Swiss Arms AG.",
    {Assault=true, Survivor=true}, 10, -1)
    HORDE:CreateItem("Rifle",      "AUG",            "arccw_go_aug",      2500, 7, "Steyr AUG.\nAn Austrian bullpup assault rifle.",
    {Assault=true, Survivor=true}, 10, -1)
    HORDE:CreateItem("Rifle",      "F2000",          "arccw_horde_f2000", 3000, 7, "FN F2000.\nAn ambidextrous bullpup rifle developed by FN.",
    {Assault=true}, 10, -1)
    HORDE:CreateItem("Rifle",      "Tavor",          "arccw_horde_tavor", 3000, 7, "IWI Tavor-21.\nDesigned to maximize reliability, durability, and simplicity.",
    {Assault=true}, 10, -1)

    HORDE:CreateItem("Rifle",      "ACR",            "arccw_mw2_acr",       2250, 7, "Remington Adaptive Combat Rifle.\nA modular semi-Auto rifle.",
    {Survivor=true,  Ghost=true}, 10, -1)
    HORDE:CreateItem("Rifle",      "M200 Obrez",     "arccw_horde_m200",    2250, 7, "CheyTec M200 Intervention Obrez.\nAmerican bolt-action sniper rifle.\nSawed-off version for medium-ranged combat.",
    {Ghost=true}, 15, -1)
    HORDE:CreateItem("Rifle",      "AWP",            "arccw_horde_awp",     2500, 8, "Magnum Ghost Rifle.\nA series of sniper rifles manufactured by the United Kingdom.",
    {Ghost=true}, 10, -1)
    HORDE:CreateItem("Rifle",      "SCAR",           "arccw_go_scar",       2500, 8, "FN SCAR.\nAn assault rifle developed by Belgian manufacturer FN Herstal.",
    {Survivor=true,  Ghost=true}, 15, -1)
    HORDE:CreateItem("Rifle",      "G3",             "arccw_horde_g3",      3000, 8, "G3 Battle Rifle.\nA 7.62×51mm NATO, select-fire battle rifle developed by H&K.",
    {Ghost=true}, 15, -1)
    HORDE:CreateItem("Rifle",      "Barrett AMR",    "arccw_horde_barret",  3500, 10, ".50 Cal Anti-Material Sniper Rifle.\nDoes huge amounts of ballistic damage.",
    {Ghost=true}, 50, -1)

    HORDE:CreateItem("Rifle",    "SSG08 Medic SR",   "arccw_horde_medic_rifle",  1500,   6, "A medic sniper rifle that shoots healing darts.\nDamages enemies and heals players.",
    {Medic=true}, 10, -1)

    HORDE:CreateItem("MG",         "Negev",          "arccw_go_negev",     2250, 9, "IWI Negev.\nA 5.56×45mm NATO light machine gun developed by the IWI.",
    {Heavy=true, Survivor=true}, 25, -1)
    HORDE:CreateItem("MG",         "M249",           "arccw_go_m249para",  2500, 9, "M249 light machine gun.\nA gas operated and air-cooled weapon of destruction.",
    {Heavy=true, Survivor=true}, 25, -1)
    HORDE:CreateItem("MG",         "L86 LSW",        "arccw_horde_l86",    2500, 9, "SA80 L86 LSW.\nBullpup light machine gun.",
    {Heavy=true, Survivor=true}, 25, -1)
    HORDE:CreateItem("MG",         "M240B",          "arccw_mw2_m240",     3000, 10, "M240 Bravo.\nFires 7.62mm NATO ammunition.\nEquipped by U.S. Armed Forces.",
    {Heavy=true}, 35, -1)
    HORDE:CreateItem("MG",         "MG4",            "arccw_mw2_mg4",      3000, 10, "Heckler & Koch MG4.\nA belt-fed 5.56 mm light machine gun that replaced MG3.",
    {Heavy=true}, 35, -1)

    HORDE:CreateItem("Explosive",  "Frag Grenade",   "weapon_frag",        100,  0, "A standard frag grenade.\nGood for crowd control.",
    {Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true, Engineer=true, Warden=true, Cremator=true}, 100, -1)
    HORDE:CreateItem("Explosive",  "M67 Grenade",    "arccw_go_nade_frag",1500,  2, "M67 High Explosive Fragmentation Grenade.\nMilitary grade, does large amounts of Blast damage.",
    {Demolition=true}, 100, -1)
    HORDE:CreateItem("Explosive",  "Stun Grenade",   "arccw_horde_nade_stun", 800,  2, "Deals damage and Stuns enemy for 2 seconds.\nStun cooldown is 10 seconds.",
    {Assault=true}, 100, -1, nil, "items/arccw_nade_stun.png")
    HORDE:CreateItem("Explosive",  "Resistance RPG", "weapon_rpg",         1500,  6, "Laser-guided rocket propulsion device.",
    {Demolition=true, Survivor=true}, 10, -1)
    HORDE:CreateItem("Explosive",  "M79 GL",         "arccw_horde_m79",    2000,  6, "M79 Grenade Launcher.\nShoots 40x46mm grenades the explodes on impact.",
    {Demolition=true, Survivor=true}, 10, -1)
    HORDE:CreateItem("Explosive",  "M32 GL",         "arccw_horde_m32",    3000,  8, "Milkor Multiple Grenade Launcher.\nA lightweight 40mm six-shot revolver grenade launcher.",
    {Demolition=true}, 50, -1)
    HORDE:CreateItem("Explosive",  "RPG-7",          "arccw_horde_rpg7",   3000,  9, "Ruchnoy Protivotankoviy Granatomyot.\nAnti-tank rocket launcher developed by Soviet Union.",
    {Demolition=true}, 15, -1)
    HORDE:CreateItem("Explosive",  "SLAM",           "weapon_slam",        400,   1, "Selectable Lightweight Attack Munition.\nRMB to detonate. Attach to wall to active laser mode.",
    {Demolition=true, Survivor=true}, 0, 100)
    HORDE:CreateItem("Explosive",  "Incendiary Grenade",   "arccw_horde_nade_incendiary",        1500,   2, "Generates a pool of fire after some delay.\nSets everything on fire within its effect.",
    {Cremator=true}, 100, -1)
    HORDE:CreateItem("Explosive",  "Molotov",   "arccw_horde_nade_molotov",        1500,   2, "Generates a pool of fire on impact.\nSets everything on fire within its effect.",
    {Cremator=true}, 100, -1)
    HORDE:CreateItem("Explosive",  "Incendiary Launcher",  "arccw_horde_incendiary_launcher", 3000,  8, "Incendiary Grenade Launcher.\nShoots incendiary grenades the erupt into flames on impact.",
    {Cremator=true}, 50, -1)

    --HORDE:CreateItem("Special",    "Combine AR2",    "weapon_ar2",         2250, 7, "Overwatch standard issue rifle.\nDark energy-powered assault rifle.",
    --{Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=false, Ghost=false, Engineer=true}, 5, 100)
    HORDE:CreateItem("Special",    "Heat Crossbow",  "weapon_crossbow",     800,  4, "Improvised sniper weapon.\nShoots scorching rebars.",
    {Ghost=true, Engineer=true, Cremator=true}, 2, -1)
    HORDE:CreateItem("Special",    "Turret",         "npc_turret_floor",    900,  0, "Combine Overwatch turret.\n\nUsed to guard chocke points and vital areas.",
    {Engineer=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_DROP, x=50, z=15, yaw=0, limit=3}, "items/npc_turret_floor.png")
    HORDE:CreateItem("Special",    "Medic Grenade",  "arccw_nade_medic",    800,  1, "A grenade that releases contiuous bursts of detoxication clouds.\nHeals players and damages enemies.",
    {Medic=true}, 100, -1, nil, "items/arccw_nade_medic.png")
    HORDE:CreateItem("Special",    "Throwing Knives", "arccw_go_nade_knife",800,  2, "Ranged throwing knives.\nThrown blades are retrievable.",
    {Berserker=true}, 10, -1)
    HORDE:CreateItem("Special",    "Watchtower",      "horde_watchtower",     800,  0, "A watchtower that provides resupply.\nGenerates 1 ammobox every 30 seconds.\n(Entity Class: horde_watchtower)",
    {Warden=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_DROP, x=50, z=15, yaw=0, limit=2}, "items/horde_watchtower.png")
    HORDE:CreateItem("Special",    "M2 Flamethrower", "horde_m2",            2500,  8, "M2-2 Flamethrower.\nAn American man-portable backpack flamethrower.",
    {Cremator=true}, 50, -1)

    HORDE:CreateItem("Equipment",  "Medkit",         "weapon_horde_medkit",      50,   1, "Rechargeble medkit.\nRMB to self-heal, LMB to heal others.",
    nil, 10, -1, nil, "items/weapon_medkit.png")
    HORDE:CreateItem("Equipment",  "Health Vial",    "item_healthvial",    15,   0, "A capsule filled with sticky green liquid.\nHeals instantly when picked up.",
    {Medic=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_DROP, x=50, z=15, yaw=0, limit=5})
    HORDE:CreateItem("Equipment", "Kevlar Armor Battery", "item_battery", 160, 0, "Armor battery.\nEach one provides 15 armor. Personal use only.",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE}, "items/armor_15.png")
    HORDE:CreateItem("Equipment", "Full Kevlar Armor", "armor100", 1000, 0, "Full kevlar armor set.\nFills up 100% of your armor bar.",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_ARMOR, armor=100}, "items/armor_100.png")

    HORDE:GetDefaultGadgets()

    if ArcCWInstalled == true and GetConVar("horde_arccw_attinv_free"):GetInt() == 0 then
        print("[HORDE] ArcCW detected. Loading attachments into shop.")
        HORDE.GetArcCWAttachments()
    end

    print("[HORDE] - Loaded default item config.")
end

HORDE.GetArcCWAttachments = function ()
    -- Optics
    HORDE:CreateItem("Attachment", "C-MORE (RDS)",   "go_optic_cmore",  100,  0, "RDS",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Optic"})
    HORDE:CreateItem("Attachment", "EOTech 553 (RDS)",    "go_optic_eotech",  100,  0, "RDS",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Optic"})
    HORDE:CreateItem("Attachment", "Kobra (RDS)",   "go_optic_kobra",  100,  0, "RDS",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Optic"})
    HORDE:CreateItem("Attachment", "CompM4 (RDS)",   "go_optic_compm4",  100,  0, "RDS",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Optic"})
    HORDE:CreateItem("Attachment", "MICRO T1 (RDS)",   "go_optic_t1",  100,  0, "RDS",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Optic"})
    HORDE:CreateItem("Attachment", "MARS (RDS)",   "optic_mw2_mars",  100,  0, "RDS",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Optic"})
    HORDE:CreateItem("Attachment", "BARSKA (RDS)",   "go_optic_barska",  100,  0, "RDS",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Optic"})

    HORDE:CreateItem("Attachment", "PVS-4 (2x)",   "go_optic_pvs4",  110,  0, "RDS",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Optic"})
    HORDE:CreateItem("Attachment", "Leupold HAMR (Hybrid)",   "go_optic_hamr",  110,  0, "RDS",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Optic"})
    HORDE:CreateItem("Attachment", "Hunter Compact (2.5x)",   "go_optic_hunter",  110,  0, "RDS",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Optic"})


    HORDE:CreateItem("Attachment", "ELCAN C79 (3.5x)",   "go_optic_elcan",  115,  0, "RDS",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Optic"})
    HORDE:CreateItem("Attachment", "ACOG (x4)",   "go_optic_acog",  120,  0, "RDS",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Optic"})
    HORDE:CreateItem("Attachment", "CheyTac (2-4.3x)",   "optic_cheytacscope",  125,  0, "RDS",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Optic"})

    HORDE:CreateItem("Attachment", "PM-II (7x)",   "go_optic_schmidt",  130,  0, "RDS",
    {Ghost=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Optic"})
    
    HORDE:CreateItem("Attachment", "LPVO (8x)",   "go_optic_ssr",  140,  0, "RDS",
    {Ghost=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Optic"})
    
    HORDE:CreateItem("Attachment", "Arctic Warfare (10x)",   "go_optic_awp",  140,  0, "RDS",
    {Ghost=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Optic"})
    
    -- Underbarrel
    HORDE:CreateItem("Attachment", "Pistol Foregrip",   "go_nova_stock_pistol",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Underbarrel"})
    HORDE:CreateItem("Attachment", "Ergo Foregrip",   "go_foregrip_ergo",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Underbarrel"})
    HORDE:CreateItem("Attachment", "Battle Foregrip",   "go_foregrip",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Underbarrel"})
    HORDE:CreateItem("Attachment", "Stubby Foregrip",   "go_foregrip_stubby",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Underbarrel"})
    HORDE:CreateItem("Attachment", "Tactical Grip",   "go_ak_grip_tactical",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Underbarrel"})
    HORDE:CreateItem("Attachment", "Snatch Foregrip",   "go_foregrip_snatch",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Underbarrel"})
    HORDE:CreateItem("Attachment", "Angled Foregrip",   "go_foregrip_angled",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Underbarrel"})
    HORDE:CreateItem("Attachment", "Bipod",             "go_fore_bipod",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Underbarrel"})


    -- Tactical
    HORDE:CreateItem("Attachment", "Flashlight",   "go_flashlight",  80,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Tactical"})
    HORDE:CreateItem("Attachment", "Combo Flashlight",   "go_flashlight_combo",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Tactical"})
    HORDE:CreateItem("Attachment", "5mW Laser",   "go_laser_peq",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Tactical"})
    HORDE:CreateItem("Attachment", "3mW Laser",   "go_laser_surefire",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Tactical"})
    HORDE:CreateItem("Attachment", "1mW Laser",   "go_laser",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Tactical"})

    -- Barrel
    HORDE:CreateItem("Attachment", "[MP9] 210mm Plus Barrel",    "go_mp9_barrel_med",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_mp9"})
    HORDE:CreateItem("Attachment", "[MP9] 350mm Carbine Barrel",    "go_mp9_barrel_long",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_mp9"})
    HORDE:CreateItem("Attachment", "[MP5] 150mm Kurz Barrel",   "go_mp5_barrel_short",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_mp5"})
    HORDE:CreateItem("Attachment", "[MP5] 500mm Carbine Barrel",   "go_mp5_barrel_long",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_mp5"})
    HORDE:CreateItem("Attachment", "[MP5] 550mm Whisper Barrel",   "go_mp5_barrel_sd",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_mp5"})
    HORDE:CreateItem("Attachment", "[MAC10] 50mm Stub Barrel",   "go_mac10_barrel_stub",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_mac10"})
    HORDE:CreateItem("Attachment", "[MAC10] 200mm Patrol Barrel",   "go_mac10_barrel_med",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_mac10"})
    HORDE:CreateItem("Attachment", "[MAC10] 350mm Carbine Barrel",   "go_mac10_barrel_long",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_mac10"})
    HORDE:CreateItem("Attachment", "[UMP] 220mm HK Barrel",   "go_ump_barrel_med",  100,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_ump"})
    HORDE:CreateItem("Attachment", "[UMP] 350mm USC Barrel",   "go_ump_barrel_long",  100,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_ump"})
    HORDE:CreateItem("Attachment", "[PP-Bizon] 230mm FSB Barrel",   "go_bizon_barrel_med",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_bizon"})
    HORDE:CreateItem("Attachment", "[PP-Bizon] 290mm GRU Barrel",   "go_bizon_barrel_long",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_bizon"})
    HORDE:CreateItem("Attachment", "[P90] 410mm PS90 Barrel",   "go_p90_barrel_med",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_p90"})
    HORDE:CreateItem("Attachment", "[P90] 800mm Devolution Barrel",   "go_p90_barrel_long",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_p90"})

    HORDE:CreateItem("Attachment", "[M1014] 350mm M1014 Barrel",   "go_m1014_barrel_short",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_m1014"})
    HORDE:CreateItem("Attachment", "[M1014] 750mm M1014 Barrel",   "go_m1014_barrel_long",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_m1014"})
    HORDE:CreateItem("Attachment", "[MAG7] 280mm BodyGuard Barrel",   "go_mag7_barrel_short",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_mag7"})
    HORDE:CreateItem("Attachment", "[MAG7] 440mm Longsword Barrel",   "go_mag7_barrel_long",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_mag7"})
    HORDE:CreateItem("Attachment", "[Nova] 300mm BodyGuard Barrel",   "go_nova_barrel_short",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_nova"})
    HORDE:CreateItem("Attachment", "[Nova] 710mm Longsword Barrel",   "go_nova_barrel_long",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_nova"})
    HORDE:CreateItem("Attachment", "[M870] 350mm 870 Barrel",   "go_870_barrel_short",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_870"})
    HORDE:CreateItem("Attachment", "[M870] 750mm 870 Barrel",   "go_870_barrel_long",  75,  0, "",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_870"})

    HORDE:CreateItem("Attachment", "[Galil] 216mm Navy Barrel",   "go_ace_barrel_short",  100,  0, "",
    {Medic=true, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_ace"})
    HORDE:CreateItem("Attachment", "[Galil] 409mm Carbine Barrel",   "go_ace_barrel_med",  100,  0, "",
    {Medic=true, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_ace"})
    HORDE:CreateItem("Attachment", "[Galil] 510mm SAW Barrel",   "go_ace_barrel_long",  100,  0, "",
    {Medic=true, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_ace"})
    HORDE:CreateItem("Attachment", "[Famas] 405mm Raider Barrel",   "go_famas_barrel_short",  100,  0, "",
    {Medic=true, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_famas"})
    HORDE:CreateItem("Attachment", "[Famas] 620mm Tireur Barrel",   "go_famas_barrel_long",  100,  0, "",
    {Medic=true, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_famas"})
    HORDE:CreateItem("Attachment", "[M4A1] 50mm Stub Barrel",   "go_m4_barrel_stub",  100,  0, "",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_m4"})
    HORDE:CreateItem("Attachment", "[M4A1] 210mm Compact Barrel",   "go_m4_barrel_short",  100,  0, "",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_m4"})
    HORDE:CreateItem("Attachment", "[M4A1] 300mm INT-SD Barrel",   "go_m4_barrel_sd",  100,  0, "",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_m4"})
    HORDE:CreateItem("Attachment", "[M4A1] 370mm Carbine Barrel",   "go_m4_barrel_med",  100,  0, "",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_m4"})
    HORDE:CreateItem("Attachment", "[AK47] 314mm Ukoro Barrel",   "go_ak_barrel_short",  100,  0, "",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_ak47"})
    HORDE:CreateItem("Attachment", "[AK47] 415mm Spetsnaz Barrel",   "go_ak_barrel_tac",  100,  0, "",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_ak47"})
    HORDE:CreateItem("Attachment", "[AK47] 590mm RPK Barrel",   "go_ak_barrel_long",  100,  0, "",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_ak47"})
    HORDE:CreateItem("Attachment", "[AUG] 420mm Para Barrel",   "go_aug_barrel_short",  100,  0, "",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_aug"})
    HORDE:CreateItem("Attachment", "[AUG] 620mm HBAR Barrel",   "go_aug_barrel_long",  100,  0, "",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_aug"})
    HORDE:CreateItem("Attachment", "[SG556] 390mm Compact Barrel",   "go_sg_barrel_short",  100,  0, "",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_sg556"})
    HORDE:CreateItem("Attachment", "[SG556] 650mm Sniper Barrel",   "go_sg_barrel_long",  100,  0, "",
    {Medic=false, Assault=true, Heavy=false, Demolition=false, Survivor=true, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_sg556"})

    HORDE:CreateItem("Attachment", "[SCAR] 250mm PDW Barrel",   "go_scar_barrel_stub",  100,  0, "",
    {Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=false, Ghost=true, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_scar"})
    HORDE:CreateItem("Attachment", "[SCAR] 330mm CQC Barrel",   "go_scar_barrel_short",  100,  0, "",
    {Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=false, Ghost=true, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_scar"})
    HORDE:CreateItem("Attachment", "[SCAR] 510mm SSR Barrel",   "go_scar_barrel_long",  100,  0, "",
    {Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=false, Ghost=true, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_scar"})
    HORDE:CreateItem("Attachment", "[G3] 315mm Kurz Barrel",   "go_g3_barrel_short",  100,  0, "",
    {Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=false, Ghost=true, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_g3"})
    HORDE:CreateItem("Attachment", "[G3] 640mm Whisper Barrel",   "go_scar_barrel_sd",  100,  0, "",
    {Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=false, Ghost=true, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_g3"})
    HORDE:CreateItem("Attachment", "[G3] 650mm SG1 Barrel",   "go_scar_barrel_long",  100,  0, "",
    {Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=false, Ghost=true, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_g3"})

    HORDE:CreateItem("Attachment", "[M249] 330mm Para Barrel",   "go_m249_barrel_short",  110,  0, "",
    {Medic=false, Assault=false, Heavy=true, Demolition=false, Survivor=false, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_m249para"})
    HORDE:CreateItem("Attachment", "[M249] 510mm SAW Barrel",   "go_m249_barrel_long",  110,  0, "",
    {Medic=false, Assault=false, Heavy=true, Demolition=false, Survivor=false, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_m249para"})
    HORDE:CreateItem("Attachment", "[Negev] 330mm SF Barrel",   "go_negev_barrel_short",  110,  0, "",
    {Medic=false, Assault=false, Heavy=true, Demolition=false, Survivor=false, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_negev"})
    HORDE:CreateItem("Attachment", "[Negev] 510mm Heavy Barrel",   "go_negev_barrel_long",  110,  0, "",
    {Medic=false, Assault=false, Heavy=true, Demolition=false, Survivor=false, Ghost=false, Engineer=false}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Barrel", arccw_attachment_wpn="arccw_go_negev"})

    -- Mag
    HORDE:CreateItem("Attachment", "[USP] 20-Round .45",   "go_usp_mag_20",  80,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_usp"})
    HORDE:CreateItem("Attachment", "[USP] 30-Round .45",   "go_usp_mag_30",  80,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_usp"})
    HORDE:CreateItem("Attachment", "[Glock] 31-Round 9mm",   "go_glock_mag_28",  80,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_glock"})
    HORDE:CreateItem("Attachment", "[P250] 21-Round .357",   "go_p250_mag_21",  80,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_p250"})
    HORDE:CreateItem("Attachment", "[M9] 24-Round 9mm",   "go_m9_mag_24",  80,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_m9"})
    HORDE:CreateItem("Attachment", "[P2000] 24-Round 9mm",   "go_p2000_mag_24",  80,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_m9"})
    HORDE:CreateItem("Attachment", "[CZ75] 30-Round 9mm",   "go_cz75_mag_30",  80,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_cz75"})
    HORDE:CreateItem("Attachment", "[Fiveseven] 30-Round 5.7mm",   "go_fiveseven_mag_30",  80,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_fiveseven"})
    HORDE:CreateItem("Attachment", "[Tec-9] 10-Round 9mm",   "go_tec9_mag_10",  80,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_tec9"})
    HORDE:CreateItem("Attachment", "[Tec-9] 32-Round 9mm",   "go_tec9_mag_32",  80,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_tec9"})
    
    HORDE:CreateItem("Attachment", "[MP9] 15-Round 9mm",   "go_mp9_mag_15",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_mp9"})
    HORDE:CreateItem("Attachment", "[MAC10] 16-Round .45 Ingram",   "go_mac10_mag_16",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_mac10"})
    HORDE:CreateItem("Attachment", "[MAC10] 48-Round .45 Grave",   "go_mac10_mag_48",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_mac10"})
    HORDE:CreateItem("Attachment", "[MP5] 15-Round 9mm",   "go_mp5_mag_15",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_mp5"})
    HORDE:CreateItem("Attachment", "[MP5] 40-Round 9mm",   "go_mp5_mag_40",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_mp5"})
    HORDE:CreateItem("Attachment", "[PP-Bizon] 47-Round 9mm",   "go_bizon_mag_47",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_bizon"})
    HORDE:CreateItem("Attachment", "[PP-Bizon] 82-Round 9mm",   "go_bizon_mag_82",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_bizon"})
    HORDE:CreateItem("Attachment", "[UMP] 12-Round .45",   "go_ump_mag_12",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_ump"})
    HORDE:CreateItem("Attachment", "[UMP] 30-Round 9mm",   "go_ump_mag_30_9mm",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_ump"})

    HORDE:CreateItem("Attachment", "[Nova] 8-Round 12-Gauge",   "go_nova_mag_8",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_nova"})
    HORDE:CreateItem("Attachment", "[Mag7] 3-Round 12-Gauge",   "go_mag7_mag_3",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_mag7"})
    HORDE:CreateItem("Attachment", "[Mag7] 7-Round 12-Gauge",   "go_mag7_mag_7",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_mag7"})
    HORDE:CreateItem("Attachment", "[M870] 4-Round",   "go_870_mag_4",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_870"})
    HORDE:CreateItem("Attachment", "[M870] 8-Round",   "go_870_mag_8",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_870"})
    HORDE:CreateItem("Attachment", "[M1014] 4-Round",   "go_m1014_mag_4",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_m1014"})
    HORDE:CreateItem("Attachment", "[M1014] 7-Round",   "go_m1014_mag_7",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_m1014"})

    HORDE:CreateItem("Attachment", "[Famas] 25-Round 5.56mm",   "go_famas_mag_25",  100,  0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_famas"})
    HORDE:CreateItem("Attachment", "[AK47] 10-Round 7.62mm Poly",   "go_ak_mag_10",  100,  0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_ak47"})
    HORDE:CreateItem("Attachment", "[AK47] 10-Round 7.62mm Steel",   "go_ak_mag_10_steel",  100,  0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_ak47"})
    HORDE:CreateItem("Attachment", "[AK47] 15-Round 5.45mm Poly",   "go_ak_mag_15_545",  100,  0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_ak47"})
    HORDE:CreateItem("Attachment", "[AK47] 30-Round 5.45mm Poly",   "go_ak_mag_30_545",  100,  0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_ak47"})
    HORDE:CreateItem("Attachment", "[AK47] 30-Round 7.62mm Poly",   "go_ak_mag_30",  100,  0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_ak47"})
    HORDE:CreateItem("Attachment", "[AK47] 40-Round 7.62mm Poly",   "go_ak_mag_40",  100,  0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_ak47"})
    HORDE:CreateItem("Attachment", "[AK47] 40-Round 7.62mm Steel",   "go_ak_mag_40_steel",  100,  0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_ak47"})
    HORDE:CreateItem("Attachment", "[AK47] 45-Round 5.45mm Poly",   "go_ak_mag_45_545",  100,  0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_ak47"})
    HORDE:CreateItem("Attachment", "[AK47] 60-Round 5.45mm Poly",   "go_ak_mag_60_545",  100,  0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_ak47"})
    HORDE:CreateItem("Attachment", "[M4A1] 10-Round .50 Beowulf",   "go_m4_mag_10_50",  100,  0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_m4"})
    HORDE:CreateItem("Attachment", "[M4A1] 20-Round 5.56mm",   "go_m4_mag_20",  100,  0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_m4"})
    HORDE:CreateItem("Attachment", "[M4A1] 21-Round 9mm",   "go_m4_mag_21_9mm",  100,  0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_m4"})
    HORDE:CreateItem("Attachment", "[M4A1] 30-Round 9mm",   "go_m4_mag_30_9mm",  100,  0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_m4"})
    HORDE:CreateItem("Attachment", "[SG556] 20-Round 5.56mm",   "go_sg_mag_20",  100,  0, "",
    {Assault=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_sg556"})

    HORDE:CreateItem("Attachment", "[SCAR] 10-Round 7.62mm",   "go_scar_mag_10",  100,  0, "",
    {Ghost=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_scar"})
    HORDE:CreateItem("Attachment", "[SCAR] 30-Round 7.62mm",   "go_scar_mag_30",  100,  0, "",
    {Ghost=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_scar"})
    HORDE:CreateItem("Attachment", "[G3] 10-Round 7.62mm Steel",   "go_g3_mag_10",  100,  0, "",
    {Ghost=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_horde_g3"})
    HORDE:CreateItem("Attachment", "[G3] 30-Round 5.56mm STANAG",   "go_g3_mag_30_556",  100,  0, "",
    {Ghost=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_horde_g3"})
    HORDE:CreateItem("Attachment", "[G3] 30-Round 7.62mm Steel",   "go_g3_mag_30",  100,  0, "",
    {Ghost=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_horde_g3"})

    HORDE:CreateItem("Attachment", "[Negev] 100-Round 5.56mm",   "go_negev_belt_100",  100,  0, "",
    {Heavy=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_negev"})
    HORDE:CreateItem("Attachment", "[M249] 45-Round 12 Gauge",   "go_m249_mag_12g_45",  100,  0, "",
    {Heavy=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_m249para"})
    HORDE:CreateItem("Attachment", "[M249] 200-Round 9mm",   "go_m249_mag_9_200",  50,  100, "",
    {Heavy=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Magazine", arccw_attachment_wpn="arccw_go_m249para"})

    -- Stock
    HORDE:CreateItem("Attachment", "BT-2 Pistol Stock",  "go_stock_pistol_bt",  50,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Stock"})
    HORDE:CreateItem("Attachment", "Basilisk Stock",     "go_stock_basilisk",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Stock"})
    HORDE:CreateItem("Attachment", "MOE Stock",           "go_stock_moe",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Stock"})
    HORDE:CreateItem("Attachment", "Contractor Stock",   "go_stock_contractor",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Stock"})
    HORDE:CreateItem("Attachment", "Ergonomic Stock",    "go_stock_ergo",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Stock"})
    HORDE:CreateItem("Attachment", "Collapsible Stock",    "go_g3_stock_collapsible",  110,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Stock"})
    HORDE:CreateItem("Attachment", "Sniper Stock",    "go_scar_stock_sniper",  110,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Stock"})

    -- Muzzle
    HORDE:CreateItem("Attachment", "Bayonet",  "go_muzz_bayonet",  200,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Muzzle"})
    HORDE:CreateItem("Attachment", "Flash Hider",  "go_muzz_flashhider",  90,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Muzzle"})
    HORDE:CreateItem("Attachment", "Muzzle Booster",  "go_muzz_booster",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Muzzle"})
    HORDE:CreateItem("Attachment", "Muzzle Brake",  "go_muzz_brake",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Muzzle"})
    HORDE:CreateItem("Attachment", "SSQ Suppressor",  "go_supp_ssq",  100,  0, "",
    {Ghost=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Muzzle"})
    HORDE:CreateItem("Attachment", "Rotor43 Suppressor",  "go_supp_rotor43",  100,  0, "",
    {Ghost=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Muzzle"})
    HORDE:CreateItem("Attachment", "PBS-4 Suppressor",  "go_supp_pbs4",  100,  0, "",
    {Ghost=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Muzzle"})
    HORDE:CreateItem("Attachment", "QDSS Suppressor",  "go_supp_qdss",  100,  0, "",
    {Ghost=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Muzzle"})
    HORDE:CreateItem("Attachment", "TGP-A Suppressor",  "go_supp_tgpa",  100,  0, "",
    {Ghost=true}, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Muzzle"})

    -- Ammo Type
    HORDE:CreateItem("Attachment", "Tracer Rounds",  "go_ammo_tr",  50,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Ammo Type"})
    HORDE:CreateItem("Attachment", "Match Rounds",  "go_ammo_match",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Ammo Type"})
    HORDE:CreateItem("Attachment", "JHP Rounds",  "go_ammo_jhp",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Ammo Type"})
    HORDE:CreateItem("Attachment", "AP/I Rounds",  "go_ammo_api",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Ammo Type"})
    HORDE:CreateItem("Attachment", "TMJ Rounds",  "go_ammo_tmj",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Ammo Type"})
    HORDE:CreateItem("Attachment", "Subsonic Rounds",  "go_ammo_sub",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Ammo Type"})
    HORDE:CreateItem("Attachment", "[Shotgun] Magnum Shells",  "go_ammo_sg_magnum",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Ammo Type"})
    HORDE:CreateItem("Attachment", "[Shotgun] Sabot Shells",  "go_ammo_sg_sabot",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Ammo Type"})
    HORDE:CreateItem("Attachment", "[Shotgun] Scattershot Shells",  "go_ammo_sg_scatter",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Ammo Type"})
    HORDE:CreateItem("Attachment", "[Shotgun] Slug Shells",  "go_ammo_sg_slug",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Ammo Type"})
    HORDE:CreateItem("Attachment", "[Shotgun] Triple-Hit Shells",  "go_ammo_sg_triple",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Ammo Type"})

    -- Perks
    HORDE:CreateItem("Attachment", "Full Auto",  "go_homemade_auto",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Perk"})
    HORDE:CreateItem("Attachment", "Enhanced Burst",  "go_perk_burst",  100,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Perk"})
    HORDE:CreateItem("Attachment", "Rapid Reload",  "go_perk_fastreload",  200,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Perk"})
    HORDE:CreateItem("Attachment", "Frantic Firing Frenzy",  "go_perk_rapidfire",  200,  0, "",
    nil, 10, -1, {type=HORDE.ENTITY_PROPERTY_GIVE, is_arccw_attachment=true, arccw_attachment_type="Perk"})
end

-- Startup
if SERVER then
    util.AddNetworkString("Horde_SetItemsData")

    if GetConVar("horde_external_lua_config"):GetString() and GetConVar("horde_external_lua_config"):GetString() ~= "" then
    else
        if GetConVarNumber("horde_default_item_config") == 0 then
            GetItemsData()
        else
            HORDE:GetDefaultItemsData()
            HORDE:SyncItems()
        end
    end


    net.Receive("Horde_SetItemsData", function (len, ply)
        if not ply:IsSuperAdmin() then return end
        local items_len = net.ReadUInt(32)
        local data = net.ReadData(items_len)
        local str = util.Decompress(data)
        HORDE.items = util.JSONToTable(str)
        HORDE.InvalidateHordeItemCache = 1
        HORDE:SetItemsData()
    end)
end