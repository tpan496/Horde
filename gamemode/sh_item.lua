-- Economy variables
HORDE.items = {}

HORDE.ENTITY_PROPERTY_WPN = 0
HORDE.ENTITY_PROPERTY_GIVE = 1
HORDE.ENTITY_PROPERTY_BUILD = 2

HORDE.CreateItem = function (category, name, class, price, weight, description, whitelist, ammo_price, secondary_ammo_price, entity_properties)
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
    if entity_properties then
        item.entity_properties = entity_properties
    else
        item.entity_properties = {type=HORDE.ENTITY_PROPERTY_WPN}
    end
    HORDE.items[item.class] = item
    HORDE.SetItemsData()
end

HORDE.SyncItems = function ()
    if player then
        for _, ply in pairs(player.GetAll()) do
            net.Start("Horde_SyncItems")
            net.WriteTable(HORDE.items)
            net.Send(ply)
        end
    end
end

HORDE.SetItemsData = function()
    if SERVER then
        if GetConVarNumber("horde_default_item_config") == 1 then return end
        if not file.IsDir("horde", "DATA") then
            file.CreateDir("horde")
        end

        file.Write("horde/items.txt", util.TableToJSON(HORDE.items))

        HORDE.SyncItems()
    end
end

function GetItemsData()
    if SERVER then
        if not file.IsDir("horde", "DATA") then
            file.CreateDir("horde")
            return
        end

        if file.Read("horde/items.txt", "DATA") then
            local t = util.JSONToTable(file.Read("horde/items.txt", "DATA"))

            for _, item in pairs(t) do
                if item.name == "" or item.class == "" or item.name == nil or item.category == nil or item.class == nil or item.whitelist == nil or item.ammo_price == nil or item.secondary_ammo_price == nil then
                    notification.AddLegacy("Item config file validation failed! Please update your file or delete it.", NOTIFY_ERROR, 5)
                    notification.AddLegacy("Falling back to default config.", NOTIFY_ERROR, 5)
                    return
                end
            end
            HORDE.items = t

            print("[HORDE] - Loaded custom item config.")
        end

        HORDE.SyncItems()
    end
end

HORDE.GetDefaultItemsData = function()
    HORDE.CreateItem("Melee",      "Stunstick",      "weapon_stunstick",     100,  1, "Electric baton.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true, Engineer=true}, 10, -1)
    HORDE.CreateItem("Melee",      "Crowbar",        "weapon_crowbar",       100,  0, "A rusty crowbar.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true, Engineer=true}, 10, -1)
    HORDE.CreateItem("Melee",      "Combat Knife",   "arccw_go_melee_knife", 500,  2, "A reliable bayonet.\nRMB to deal a heavy slash.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true, Engineer=true}, 10, -1)

    HORDE.CreateItem("Pistol",     "9mm",            "weapon_pistol",     200,  0, "Combine standard sidearm.",
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
    HORDE.CreateItem("SMG",        "Vector",         "arccw_mw2_vector",  2000, 6, "KRISS Vector Gen I.\nUses an unconventional delayed blowback system.",
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
    HORDE.CreateItem("Rifle",      "Tavor",          "arccw_mw2_tavor",   2250, 7, "IWI Tavor-21.\nDesigned to maximize reliability, durability, and simplicity.",
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

    HORDE.CreateItem("Explosive",  "Frag Grenade",   "weapon_frag",        100,   0, "A standard grenade.\nDoes its job well.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true, Engineer=true}, 100, -1)
    HORDE.CreateItem("Explosive",  "Incendiary Grenade",   "arccw_go_nade_incendiary",        1500,   1, "Generates a pool of fire after some delay.\nSets everything on fire within its effect.",
    {Medic=false, Assault=false, Heavy=false, Demolition=true, Survivor=true, Ghost=false, Engineer=true}, 100, -1)
    HORDE.CreateItem("Explosive",  "Resistance RPG", "weapon_rpg",         2000, 7, "Laser-guided rocket propulsion device.",
    {Medic=false, Assault=false, Heavy=false, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 10, -1)
    HORDE.CreateItem("Explosive",  "SLAM",           "weapon_slam",        500,  2, "Selectable Lightweight Attack Munition.\nRMB to detonate.",
    {Medic=false, Assault=false, Heavy=false, Demolition=true, Survivor=true, Ghost=false, Engineer=false}, 0, 100)

    HORDE.CreateItem("Special",    "Heat Crossbow",  "weapon_crossbow",    1250, 5, "Improvised sniper weapon.\nShoots scorching rebars.",
    {Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=false, Ghost=true, Engineer=true}, 10, -1)
    HORDE.CreateItem("Special",    "Gravity Gun",  "weapon_physcannon",    1500, 5, "Zero Point Energy Field Manipulator.\nPinnacle of theoretical physics.",
    {Medic=false, Assault=false, Heavy=false, Demolition=false, Survivor=false, Ghost=false, Engineer=true}, 10, -1)

    HORDE.CreateItem("Equipment",  "Medkit",         "weapon_medkit",      50,   1, "Rechargeble medkit.\nRMB to self-heal, LMB to heal others.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true, Engineer=true}, 10, -1)
    
    print("[HORDE] - Loaded default item config.")
end

HORDE.GetSpecialItems = function ()
    -- Some built-in special items
    HORDE.CreateItem("Equipment", "Kevlar Armor", "armor", 1000, 0, "Full kevlar armor set.\nFills up 100% of your armor bar.",
    {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true, Engineer=true}, 10, -1)
end

-- Startup
if SERVER then
    util.AddNetworkString("Horde_SetItemsData")

    if GetConVarNumber("horde_default_item_config") == 0 then
        GetItemsData()
        HORDE.GetSpecialItems()
    else
        HORDE.GetDefaultItemsData()
        HORDE.GetSpecialItems()
        HORDE.SyncItems()
    end


    net.Receive("Horde_SetItemsData", function ()
        HORDE.items = net.ReadTable()
        HORDE.SetItemsData()
    end)

end

HORDE.max_weight = 15
HORDE.default_ammo_price = 10