util.AddNetworkString("Horde_SyncTip")

HORDE.tips = {}
local order = nil

local function shuffle(tbl)
    for i = #tbl, 2, -1 do
      local j = math.random(i)
      tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
  end

function HORDE:GetTip()
    if table.IsEmpty(HORDE.tips) then return nil end
    if not order then
        order = math.random(1, table.Count(HORDE.tips))
    else
        order = (order + 1) % table.Count(HORDE.tips) + 1
    end

    return HORDE.tips[order]
end

local function AddTip(tip)
    table.insert(HORDE.tips, tip)
end

local function GetTipsData()
    if not file.IsDir("horde", "DATA") then
        file.CreateDir("horde")
    end

    if file.Read("horde/tips.txt", "DATA") then
        local f = file.Open("horde/tips.txt", "r", "DATA")
        while (not f:EndOfFile()) do
            table.insert(HORDE.tips, f:ReadLine())
        end
    end

    if table.IsEmpty(HORDE.tips) then
        AddTip("An elite enemy's health scales with player counts.")
        AddTip("Share money with your teammates by pressing V.")
        AddTip("Perks are unlocked as waves progress.")
        AddTip("Your weapons are dropped upon death.")
        AddTip("You can only change class once per wave.")
        AddTip("Remember to refill ammo.")
        AddTip("Mutated enemies have special particle effects.")
        AddTip("Headshot deals 2x base damage.")


        if GetConVar("horde_default_item_config"):GetInt() == 1 and GetConVar("horde_external_lua_config"):GetString() == "" then
            AddTip("Buy a Medkit to heal yourself.")
            AddTip("Buy Armor for extra protection.")
            AddTip("Medic Grenade damages enemies and heals players.")
            AddTip("Barret AMR has the highest single-shot damage.")
            AddTip("Heavy Machine Guns can overheat.")
            AddTip("RPG-7 has a large blast radius.")
            AddTip("Turrets are quite durable.")
        end

        if GetConVar("horde_default_enemy_config"):GetInt() == 1 and GetConVar("horde_external_lua_config"):GetString() == "" then
            AddTip("Colored enemies have higher health and damage.")
            AddTip("Bosses have increased headshot resistance.")
            AddTip("Some enemies have additional mutations.")
            AddTip("Corruptor has a damaging aura.")
            AddTip("Hulk can kill you in 2-3 hits.")
            AddTip("Zombines will self-destruct on low health.")
            AddTip("Vomitter's spit does radial damage.")
            AddTip("Scorcher's ranged attack has strong knockback.")
            AddTip("Black Crabless Fasties are extremely dangerous.")
            AddTip("Poison Headcrabs are extremely danagerous.")
        end

        if GetConVar("horde_default_class_config"):GetInt() == 1 then
            AddTip("ASSAULT is specialized in auto-rifles.")
            AddTip("ADRENALINE increases speed and damage per stack.")
            AddTip("HEAVY is specialized in heavy machine guns.")
            AddTip("HEAVY regenerates armor automatically.")
            AddTip("GHOST is specialized in sniper rifles.")
            AddTip("GHOST can deal huge amounts of headshot damage.")
            AddTip("CAMOUFLAGE grants various benefits while active.")
            AddTip("DEMOLITION is specialized in explosives.")
            AddTip("DEMOLITION has innate explosive resistance.")
            AddTip("BERSERKER is specialized in close-quarter combat.")
            AddTip("BERSERKER has increased damage resistance.")
            AddTip("ENGINEER is specialized in minions.")
            AddTip("MEDIC is specialized in healing and buffing players.")
            AddTip("MEDIC regenerates health automatically.")
            AddTip("SURVIVOR perks are a combination of other classes.")
            AddTip("SURVIVOR has the largest weapon pool.")
            AddTip("Choose your Perks depending on the situation.")
        end
    end

    HORDE.tips = shuffle(HORDE.tips)
end

GetTipsData()