-- Infuse weapon with interesting properties

if SERVER then
util.AddNetworkString("Horde_SyncInfusion")
util.AddNetworkString("Horde_BuyInfusion")
util.AddNetworkString("Horde_SellInfusion")
end

HORDE.Infusion_All = -1
HORDE.Infusion_None = 0
HORDE.Infusion_Hemo = 1
HORDE.Infusion_Concussive = 2
HORDE.Infusion_Septic = 3
HORDE.Infusion_Flaming = 4
HORDE.Infusion_Arctic = 5
HORDE.Infusion_Galvanizing = 6
HORDE.Infusion_Quality = 7
HORDE.Infusion_Impaling = 8
HORDE.Infusion_Rejuvenating = 9
HORDE.Infusion_Quicksilver = 10
HORDE.Infusion_Siphoning = 11
HORDE.Infusion_Titanium = 12
HORDE.Infusion_Chrono = 13
HORDE.Infusion_Ruination = 14


HORDE.Infusion_Names = {
    [HORDE.Infusion_None] = "None",
    [HORDE.Infusion_Hemo] = "Hemo",
    [HORDE.Infusion_Concussive] = "Concussive",
    [HORDE.Infusion_Septic] = "Septic",
    [HORDE.Infusion_Flaming] = "Flaming",
    [HORDE.Infusion_Arctic] = "Arctic",
    [HORDE.Infusion_Galvanizing] = "Galvanizing",
    [HORDE.Infusion_Quality] = "Quality",
    [HORDE.Infusion_Impaling] = "Impaling",
    [HORDE.Infusion_Rejuvenating] = "Rejuvenating",
    [HORDE.Infusion_Quicksilver] = "Quicksilver",
    [HORDE.Infusion_Siphoning] = "Siphoning",
    [HORDE.Infusion_Titanium] = "Titanium",
    [HORDE.Infusion_Chrono] = "Chrono",
    [HORDE.Infusion_Ruination] = "Ruination",
}

HORDE.Infusion_Icons = {
    [HORDE.Infusion_None] = "damagetype/physical.png",
    [HORDE.Infusion_Hemo] = "status/bleeding.png",
    [HORDE.Infusion_Concussive] = "damagetype/blunt.png",
    [HORDE.Infusion_Septic] = "damagetype/poison.png", 
    [HORDE.Infusion_Flaming] = "damagetype/fire.png",
    [HORDE.Infusion_Arctic] = "damagetype/cold.png",
    [HORDE.Infusion_Galvanizing] = "damagetype/lightning.png",
    [HORDE.Infusion_Quality] = "star.png",
    [HORDE.Infusion_Impaling] = "infusion/impaling.png",
    [HORDE.Infusion_Rejuvenating] = "infusion/rejuvenating.png",
    [HORDE.Infusion_Quicksilver] = "infusion/quicksilver.png",
    [HORDE.Infusion_Siphoning] = "infusion/siphoning.png",
    [HORDE.Infusion_Titanium] = "infusion/titanium.png",
    [HORDE.Infusion_Chrono] = "infusion/chrono.png",
    [HORDE.Infusion_Ruination] = "infusion/ruination.png",
    [HORDE.Infusion_Ruination] = "status/necrosis.png",
}

HORDE.Infusion_Colors = {
    [HORDE.Infusion_None] = color_white,
    [HORDE.Infusion_Hemo] = HORDE.STATUS_COLOR[HORDE.Status_Bleeding],
    [HORDE.Infusion_Concussive] = color_white,
    [HORDE.Infusion_Septic] = HORDE.DMG_COLOR[HORDE.DMG_POISON],
    [HORDE.Infusion_Flaming] = HORDE.DMG_COLOR[HORDE.DMG_FIRE],
    [HORDE.Infusion_Arctic] = HORDE.DMG_COLOR[HORDE.DMG_COLD],
    [HORDE.Infusion_Galvanizing] = HORDE.DMG_COLOR[HORDE.DMG_LIGHTNING],
    [HORDE.Infusion_Quality] = color_white,
    [HORDE.Infusion_Impaling] = color_white,
    [HORDE.Infusion_Rejuvenating] = Color(50,205,50),
    [HORDE.Infusion_Quicksilver] = Color(220, 220, 220),
    [HORDE.Infusion_Siphoning] = Color(255, 74, 95),
    [HORDE.Infusion_Titanium] = Color(192, 192, 192),
    [HORDE.Infusion_Chrono] = Color(0,139,139),
    [HORDE.Infusion_Ruination] = Color(0,0,0),
}

HORDE.Infusion_Description = {
[HORDE.Infusion_None] = "No effect.",
[HORDE.Infusion_Hemo] = [[
Weapon damage increases Bleeding buildup. 

25% less weapon damage.
]],
[HORDE.Infusion_Concussive] = [[
Weapon damage increases Stun buildup. 

25% less weapon damage.
]],
[HORDE.Infusion_Septic] = [[
Convert 75% non-Poison damage into Poison damage.

Weapon deals only Poison damage.
Weapon damage increases Break buildup. 
]],
[HORDE.Infusion_Flaming] = [[
Convert 75% non-Fire damage into Fire damage.

Weapon deals only Fire damage.
Weapon ignites enemies on hit.
]],
[HORDE.Infusion_Arctic] = [[
Convert 75% non-Cold damage into Cold damage.

Weapon deals only Cold damage.
Weapon damage increases Frostbite buildup. 
]],
[HORDE.Infusion_Galvanizing] = [[
Convert 75% non-Lightning damage into Lightning damage.

Weapon deals only Lightning damage.
Weapon damage increases Shock buildup. 
]],
[HORDE.Infusion_Quality] = [[
20% increased weapon damage.

Weapon damage is no longer affected by perks or gadgets.
(i.e. Your perks become useless for this weapon)
]],
[HORDE.Infusion_Impaling] = [[
25% increased weapon headshot damage.

25% less weapon non-headshot damage.
]],
[HORDE.Infusion_Rejuvenating] = [[
Amplifies weapon healing/leeching by 25%.

20% less weapon damage.
]],
[HORDE.Infusion_Quicksilver] = [[
Increases/decreases weapon damage based on player's available weight.

<= 15% weight -> 30% damage increase
<= 30% weight -> 25% damage increase 
<= 40% weight -> 15% damage increase 
>40% weight -> 25% damage decrease
]],
[HORDE.Infusion_Titanium] = [[
Reduces player damage taken based on weapon weight.

Decrease 1% damage taken for every 1 weight on the weapon.

20% less weapon damage.
]],
[HORDE.Infusion_Siphoning] = [[
25% increased leeching.

20% less weapon damage.
]],
[HORDE.Infusion_Chrono] = [[
Increases weapon damage the longer the weapon is being held by the user.

6% damage increase per wave held by the user.
Increase caps at 50%.

20% decreased weapon damage.
]],
[HORDE.Infusion_Ruination] = [[
Increases weapon damage based on your current Necrosis buildup.
5% damage increase per 10 Necrosis buildup, up to 25%.

Gain 10 Necrosis buildup per second while holding this weapon.
]]
}

local debuffs = {
    [HORDE.Infusion_Hemo] = HORDE.Status_Bleeding,
    [HORDE.Infusion_Septic] = HORDE.Status_Break,
    [HORDE.Infusion_Flaming] = HORDE.Status_Ignite,
    [HORDE.Infusion_Arctic] = HORDE.Status_Frostbite,
    [HORDE.Infusion_Galvanizing] = HORDE.Status_Shock,
    [HORDE.Infusion_Concussive] = HORDE.Status_Stun,
}

local plymeta = FindMetaTable("Player")

function plymeta:Horde_GetInfusion(class)
    if not self.Horde_Infusions then return HORDE.Infusion_None end
    if not self.Horde_Infusions[class] then return HORDE.Infusion_None end
    return self.Horde_Infusions[class]
end

function plymeta:Horde_HasInfusion(class, infusion)
    if not self.Horde_Infusions then return end
    if not self.Horde_Infusions[class] then return end
    return self.Horde_Infusions[class] == infusion
end

if CLIENT then
net.Receive("Horde_SyncInfusion", function(len, ply)
    MySelf.Horde_Infusions = net.ReadTable()
end)
end

if SERVER then
function HORDE:InfuseWeapon(ply, class, infusion)
    if not ply.Horde_Infusions then ply.Horde_Infusions = {} end
    if not ply.Horde_Infusions[class] then ply.Horde_Infusions[class] = {} end
    if infusion == HORDE.Infusion_None then
        ply.Horde_Infusions[class] = nil
    else
        ply.Horde_Infusions[class] = infusion
        if infusion == HORDE.Infusion_Chrono then
            if not ply.Horde_Infusion_Chrono_Wave then ply.Horde_Infusion_Chrono_Wave = {} end
            if not ply.Horde_Infusion_Chrono_Wave[class] then
                ply.Horde_Infusion_Chrono_Wave = {}
            end
            ply.Horde_Infusion_Chrono_Wave[class] = HORDE.current_wave
        else
            ply.Horde_Infusion_Chrono_Wave = {}
        end
    end
end

local function hemo_damage(ply, npc, bonus, hitgroup, dmginfo)
    bonus.more = bonus.more * 0.75
    npc:Horde_AddDebuffBuildup(HORDE.Status_Bleeding, dmginfo:GetDamage() * 0.25, ply, dmginfo:GetDamagePosition())
end

local function concussive_damage(ply, npc, bonus, hitgroup, dmginfo)
    bonus.more = bonus.more * 0.75
    npc:Horde_AddDebuffBuildup(HORDE.Status_Stun, dmginfo:GetDamage() * 0.25, ply, dmginfo:GetDamagePosition())
end

local function flaming_damage(ply, npc, bonus, hitgroup, dmginfo)
    if !HORDE:IsFireDamage(dmginfo) then
        bonus.more = bonus.more * 0.75
        dmginfo:SetDamageType(DMG_BURN)
    end
end

local function arctic_damage(ply, npc, bonus, hitgroup, dmginfo)
    if !HORDE:IsColdDamage(dmginfo) then
        bonus.more = bonus.more * 0.75
        dmginfo:SetDamageType(DMG_REMOVENORAGDOLL)
    end
    npc:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, dmginfo:GetDamage() * 0.25, ply, dmginfo:GetDamagePosition())
end

local function septic_damage(ply, npc, bonus, hitgroup, dmginfo)
    if !HORDE:IsPoisonDamage(dmginfo) then
        bonus.more = bonus.more * 0.75
        dmginfo:SetDamageType(DMG_NERVEGAS)
    end
    npc:Horde_AddDebuffBuildup(HORDE.Status_Break, dmginfo:GetDamage() * 0.25, ply, dmginfo:GetDamagePosition())
end

local function galvanizing_damage(ply, npc, bonus, hitgroup, dmginfo)
    if !HORDE:IsLightningDamage(dmginfo) then
        bonus.more = bonus.more * 0.75
        dmginfo:SetDamageType(DMG_SHOCK)
    end
    npc:Horde_AddDebuffBuildup(HORDE.Status_Shock, dmginfo:GetDamage() * 0.25, ply, dmginfo:GetDamagePosition())
end

local function quality_damage(ply, npc, bonus, hitgroup, dmginfo)
    bonus.increase = 0.20
    bonus.more = 1
    return true
end

local function impaling_damage(ply, npc, bonus, hitgroup, dmginfo)
    if hitgroup == HITGROUP_HEAD then
        bonus.increase = bonus.increase + 0.25
    else
        bonus.more = bonus.more * 0.75
    end
end

local function rejuvenating_damage(ply, npc, bonus, hitgroup, dmginfo)
    bonus.more = bonus.more * 0.8
end

local function siphoning_damage(ply, npc, bonus, hitgroup, dmginfo)
    bonus.more = bonus.more * 0.8
end

local function quicksilver_damage(ply, npc, bonus, hitgroup, dmginfo)
    local percent = ply:Horde_GetWeight() / ply:Horde_GetMaxWeight()
    if percent >= 0.85 then
        bonus.increase = bonus.increase + 0.3
    elseif percent >= 0.7 then
        bonus.increase = bonus.increase + 0.25
    elseif percent >= 0.6 then
        bonus.increase = bonus.increase + 0.15
    else
        bonus.increase = bonus.increase - 0.25
    end
end

local function chrono_damage(ply, npc, bonus, hitgroup, dmginfo)
    local curr_weapon = HORDE:GetCurrentWeapon(dmginfo:GetInflictor())
    if !IsValid(curr_weapon) then return end
    bonus.increase = math.min(0.30, bonus.increase - 0.20 + (HORDE.current_wave - ply.Horde_Infusion_Chrono_Wave[curr_weapon:GetClass()]) * 0.06)
end

local function ruination_damage(ply, npc, bonus, hitgroup, dmginfo)
    local curr_weapon = HORDE:GetCurrentWeapon(dmginfo:GetInflictor())
    if !IsValid(curr_weapon) then return end
    bonus.increase = math.min(0.25, bonus.increase + ply:Horde_GetDebuffBuildup(HORDE.Status_Necrosis) / 200)
end

local infusion_fns = {
    [HORDE.Infusion_None] = function () end,
    [HORDE.Infusion_Hemo] = hemo_damage,
    [HORDE.Infusion_Concussive] = concussive_damage,
    [HORDE.Infusion_Septic] = septic_damage,
    [HORDE.Infusion_Flaming] = flaming_damage,
    [HORDE.Infusion_Arctic] = arctic_damage,
    [HORDE.Infusion_Galvanizing] = galvanizing_damage,
    [HORDE.Infusion_Quality] = quality_damage,
    [HORDE.Infusion_Impaling] = impaling_damage,
    [HORDE.Infusion_Rejuvenating] = rejuvenating_damage,
    [HORDE.Infusion_Siphoning] = siphoning_damage,
    [HORDE.Infusion_Quicksilver] = quicksilver_damage,
    [HORDE.Infusion_Titanium] = siphoning_damage,
    [HORDE.Infusion_Chrono] = chrono_damage,
    [HORDE.Infusion_Ruination] = ruination_damage,
}

function HORDE:GetCurrentWeapon(inflictor)
    local curr_weapon = inflictor
    if inflictor:IsPlayer() then
        curr_weapon = inflictor:GetActiveWeapon()
    end
    return curr_weapon
end

hook.Add("Horde_OnPlayerDamagePre", "Horde_ApplyFusion", function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply.Horde_Infusions then return end
    local inflictor = dmginfo:GetInflictor()
    local curr_weapon = HORDE:GetCurrentWeapon(inflictor)
    local infusion = ply.Horde_Infusions[curr_weapon:GetClass()]
    if not infusion then return end
    npc.hitgroup = hitgroup
    local res = infusion_fns[infusion](ply, npc, bonus, hitgroup, dmginfo)
    if res == true then return res end
end)

hook.Add("Horde_OnPlayerDamageTaken", "Horde_ApplyFusionDamageTaken", function (ply, dmg, bonus)
    if not ply.Horde_Infusions then return end
    local curr_weapon = HORDE:GetCurrentWeapon(ply)
    if !curr_weapon:IsValid() then return end
    local infusion = ply.Horde_Infusions[curr_weapon:GetClass()]
    if not infusion then return end
    if infusion == HORDE.Infusion_Titanium then
        bonus.less = bonus.less * (1 - 0.01 * HORDE.items[curr_weapon:GetClass()].weight)
    end
end)
--[[
hook.Add("Horde_OnEnemyKilled", "Horde_ApplyFusionOnKill", function (victim, ply, wpn)
    if not ply.Horde_Infusions then return end
    local curr_weapon = HORDE:GetCurrentWeapon(ply)
    if not curr_weapon:IsValid() then return end
    local infusion = ply.Horde_Infusions[curr_weapon:GetClass()]
    if infusion == HORDE.Infusion_Siphoning then
        local healinfo = HealInfo:New({amount=1, healer=ply})
        HORDE:OnPlayerHeal(ply, healinfo)
    end
end)]]--

net.Receive("Horde_BuyInfusion", function (len, ply)
    if not ply:IsValid() or not ply:Alive() then return end
    local class = net.ReadString()
    local infusion = net.ReadUInt(5)
    if HORDE.items[class]
    and HORDE.items[class].infusions
    and !table.IsEmpty(HORDE.items[class].infusions)
    and table.HasValue(HORDE.items[class].infusions, infusion) then
        local price = 100 + HORDE.items[class].price / 5
        if ply:Horde_GetMoney() >= price then
            ply:Horde_AddMoney(-price)
            HORDE:InfuseWeapon(ply, class, infusion)
            net.Start("Horde_SyncInfusion")
                net.WriteTable(ply.Horde_Infusions)
            net.Send(ply)
            ply:Horde_SyncEconomy()
        end

        if infusion == HORDE.Infusion_Ruination then
            ply.Horde_Last_Ruination_Check = CurTime()
        end
    end
end)

net.Receive("Horde_SellInfusion", function (len, ply)
    if not ply:IsValid() or not ply:Alive() then return end
    local class = net.ReadString()
    local ret_price = HORDE.items[class].price / 20
    ply:Horde_AddMoney(ret_price)
    HORDE:InfuseWeapon(ply, class, HORDE.Infusion_None)
    net.Start("Horde_SyncInfusion")
        net.WriteTable(ply.Horde_Infusions)
    net.Send(ply)
    ply:Horde_SyncEconomy()
end)

hook.Add("PlayerTick", "Horde_Ruination", function(ply, mv)
    if !ply.Horde_Last_Ruination_Check then return end
    if ply.Horde_Last_Ruination_Check >= CurTime() then return end
    ply.Horde_Last_Ruination_Check = CurTime() + 1
    if not ply.Horde_Infusions then return end
    local curr_weapon = HORDE:GetCurrentWeapon(ply)
    if not curr_weapon:IsValid() then return end
    local infusion = ply.Horde_Infusions[curr_weapon:GetClass()]
    if infusion == HORDE.Infusion_Ruination then
        ply:Horde_AddDebuffBuildup(HORDE.Status_Necrosis, 10)
    end
end)

--[[
hook.Add("WeaponEquip", "Horde_Ruination_Equip", function (wpn, ply)
    if wpn:IsValid() then
        local id = ply:SteamID()
        if not ply.Horde_Infusions then return end
        local infusion = ply.Horde_Infusions[wpn:GetClass()]
        if infusion == HORDE.Infusion_Ruination then
            timer.Create("Horde_Ruination_Check" .. id, 1, 0, function ()
                ply:Horde_AddDebuffBuildup(HORDE.Status_Necrosis, 10)
            end)
        else
            timer.Remove("Horde_Ruination_Check" .. id)
        end
    end
end)

hook.Add("PlayerDroppedWeapon", "Horde_Ruination_Equip", function (ply, wpn)
    if wpn:IsValid() then
        local id = ply:SteamID()
        if not ply.Horde_Infusions then return end
        local infusion = ply.Horde_Infusions[wpn:GetClass()]
        if infusion == HORDE.Infusion_Ruination then
            timer.Remove("Horde_Ruination_Check" .. id)
        end
    end
end)]]--
end