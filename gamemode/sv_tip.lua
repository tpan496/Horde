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
            AddTip("Some Heavy Machine Guns can overheat.")
            AddTip("RPG-7 has a large blast radius.")
            AddTip("LAW has higher damage than RPG, but a smaller blast radius.")
            AddTip("Turrets can be used to distract enemies.")
            AddTip("SSG08 Medic Rifle can heal temmates from afar.")
            AddTip("Stun Grenade can paralyze enemies for a short time.")
        end

        if GetConVar("horde_default_enemy_config"):GetInt() == 1 and GetConVar("horde_external_lua_config"):GetString() == "" then
            AddTip("Exploder's head has little health.")
            AddTip("Exploders do not explode when killed on headshots.")
            AddTip("Bosses have increased headshot resistance.")
            AddTip("Some enemies have additional mutations.")
            AddTip("Screecher's shockwave deals Lightning damage.")
            AddTip("Screecher's shockwave increases Shock buildup.")
            AddTip("Weeper's shockwave deals Cold damage.")
            AddTip("Weeper's shockwave increases Frostbite buildup.")
            AddTip("Yeti's frost cloud deals Cold damage.")
            AddTip("Yetis releases frost clouds when on half health.")
            AddTip("Hulks will enter a rage when on half health.")
            AddTip("Zombines will self-destruct on low health.")
            AddTip("Vomitter's spit deals Slashing damage.")
            AddTip("Vomitter's spit increases Bleeding buildup.")
            AddTip("Burning enemies can increase Ignite buildup when they hit you.")
            AddTip("Lesions will calm down after striking a player.")
            AddTip("Lesions will enrage when provoked.")
            AddTip("Lesions will enrage when left alone for too long.")
            AddTip("Poison Headcrabs increase Break buildup based on your health.")
            AddTip("Plague Elite can resummon his minions.")
            AddTip("Plague Elite can fire particle projectiles that deal lethal damage.")
            AddTip("Scorchers sometimes use flamethrower attacks in close range.")
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
            AddTip("DEMOLITION has innate Blast damage resistance.")
            AddTip("BERSERKER is specialized in close-quarter combat.")
            AddTip("BERSERKER has increased damage resistance.")
            AddTip("ENGINEER is specialized in minions.")
            AddTip("MEDIC is specialized in healing and buffing players.")
            AddTip("MEDIC regenerates health automatically.")
            AddTip("CREMATOR is specialized in manipulating Fire damage.")
            AddTip("CREMATOR has innate Fire damage resistance.")
            AddTip("WARDEN is specialized in buff auras and watchtowers.")
            AddTip("WARDEN's aura affects nearby players.")
            AddTip("SURVIVOR perks are a combination of other classes.")
            AddTip("SURVIVOR has the largest weapon pool.")
            AddTip("Choose your Perks depending on the situation.")
        end

        AddTip("Fire damage increases Ignite buildup.")
        AddTip("Ignite effect causes players to receive Fire damage over time.")
        AddTip("Cold damage increases Frosbite buildup.")
        AddTip("Frostbite effect reduces players' movement speed.")
        AddTip("Lightning damage increases Shock buildup.")
        AddTip("Shock effect increases damage taken by players.")
        AddTip("Poison damage increases Break buildup.")
        AddTip("Break effect removes players' health that will recover in time.")
        AddTip("Certain enemies and mutations can increase your Bleeding buildup.")
        AddTip("Bleeding effect removes player health over time.")
        AddTip("Certain enemies and mutations can increase your Decay buildup.")
        AddTip("Decay effect blocks health recovery.")
    end

    HORDE.tips = shuffle(HORDE.tips)
end

GetTipsData()