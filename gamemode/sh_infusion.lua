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
HORDE.Infusion_Ash = 13


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
    [HORDE.Infusion_Quicksilver] = color_white,
    [HORDE.Infusion_Siphoning] = Color(255, 74, 95),
    [HORDE.Infusion_Titanium] = color_white,
}

HORDE.Infusion_Description = {
[HORDE.Infusion_None] = "No effect.",
[HORDE.Infusion_Hemo] = [[
Convert 75% weapon damage into Slashing damage.

Weapon deals no non-Slashing damage.

Weapon damage increases Bleeding buildup. 
]],
[HORDE.Infusion_Concussive] = [[
Convert 75% weapon damage into Blunt damage.

Weapon deals no non-Blunt damage.

Weapon damage increases Stun buildup. 
]],
[HORDE.Infusion_Septic] = [[
Convert 75% weapon damage into Poison damage.

Weapon deals no non-Poison damage.

Weapon damage increases Break buildup. 
]],
[HORDE.Infusion_Flaming] = [[
Convert 75% weapon damage into Fire damage.

Weapon deals no non-Fire damage.

Weapon ignites enemies on hit.
]],
[HORDE.Infusion_Ash] = [[
Fire damage weapons 
]],
[HORDE.Infusion_Arctic] = [[
Convert 75% weapon damage into Cold damage.

Weapon deals no non-Cold damage.

Weapon damage increases Frostbite buildup. 
]],
[HORDE.Infusion_Galvanizing] = [[
Convert 75% weapon damage into Lightning damage.

Weapon deals no non-Lightning damage.

Weapon damage increases Shock buildup. 
]],
[HORDE.Infusion_Quality] = [[
20% increased weapon damage.

Weapon damage is unaffected by perks or gadgets.
]],
[HORDE.Infusion_Impaling] = [[
25% increased weapon headshot damage.

25% less weapon non-headshot damage.
]],
[HORDE.Infusion_Rejuvenating] = [[
Amplifies weapon healing/leeching by 25%.

25% less weapon damage.
]],
[HORDE.Infusion_Quicksilver] = [[
Increases weapon damage based on player's available weight.

>=90% weight -> 30% increase
>=75% weight -> 25% increase
>=60% weight -> 15% increase
<60% weight -> no increase
]],
[HORDE.Infusion_Titanium] = [[
Reduces player damage taken based on weapon weight.

Decrease 1% damage taken for every 1 weight on the weapon.
]],
[HORDE.Infusion_Siphoning] = [[
+1 health when you kill enemy on headshot.

20% less weapon damage.
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
    LocalPlayer().Horde_Infusions = net.ReadTable()
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
    end
end

local function hemo_damage(ply, npc, bonus, hitgroup, dmginfo)
    if not HORDE:IsSlashDamage(dmginfo) then
        bonus.more = bonus.more * 0.75
        dmginfo:SetDamageType(DMG_SLASH)
    end
end

local function concussive_damage(ply, npc, bonus, hitgroup, dmginfo)
    if not HORDE:IsBluntDamage(dmginfo) then
        bonus.more = bonus.more * 0.75
        dmginfo:SetDamageType(DMG_CLUB)
    end
end

local function flaming_damage(ply, npc, bonus, hitgroup, dmginfo)
    if not HORDE:IsFireDamage(dmginfo) then
        bonus.more = bonus.more * 0.75
        dmginfo:SetDamageType(DMG_BURN)
    end
end

local function arctic_damage(ply, npc, bonus, hitgroup, dmginfo)
    if not HORDE:IsColdDamage(dmginfo) then
        bonus.more = bonus.more * 0.75
        dmginfo:SetDamageType(DMG_REMOVENORAGDOLL)
    end
end

local function septic_damage(ply, npc, bonus, hitgroup, dmginfo)
    if not HORDE:IsPoisonDamage(dmginfo) then
        bonus.more = bonus.more * 0.75
        dmginfo:SetDamageType(DMG_NERVEGAS)
    end
end

local function galvanizing_damage(ply, npc, bonus, hitgroup, dmginfo)
    if not HORDE:IsLightningDamage(dmginfo) then
        bonus.more = bonus.more * 0.75
        dmginfo:SetDamageType(DMG_SHOCK)
    end
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
    bonus.more = bonus.more * 0.75
end

local function siphoning_damage(ply, npc, bonus, hitgroup, dmginfo)
    bonus.more = bonus.more * 0.80
end

local function quicksilver_damage(ply, npc, bonus, hitgroup, dmginfo)
    local percent = ply:Horde_GetWeight() / ply:Horde_GetMaxWeight()
    if percent >= 0.9 then
        bonus.increase = bonus.increase + 0.3
    elseif percent >= 0.75 then
        bonus.increase = bonus.increase + 0.25
    elseif percent >= 0.6 then
        bonus.increase = bonus.increase + 0.15
    end
end

local function titanium_damage(ply, npc, bonus, hitgroup, dmginfo)
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
    [HORDE.Infusion_Titanium] = titanium_damage,
    --[HORDE.Infusion_Void] = void_damage,
}

local function GetCurrentWeapon(inflictor)
    local curr_weapon = inflictor
    if inflictor:IsPlayer() then
        curr_weapon = inflictor:GetActiveWeapon()
    end
    return curr_weapon
end

hook.Add("Horde_OnPlayerDamage", "Horde_ApplyFusion", function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply.Horde_Infusions then return end
    local inflictor = dmginfo:GetInflictor()
    local curr_weapon = GetCurrentWeapon(inflictor)
    local infusion = ply.Horde_Infusions[curr_weapon:GetClass()]
    if not infusion then return end
    npc.hitgroup = hitgroup
    local res = infusion_fns[infusion](ply, npc, bonus, hitgroup, dmginfo)
    if res == true then return res end
end)

hook.Add("Horde_OnPlayerDamageTaken", "Horde_ApplyFusionDamageTaken", function (ply, dmg, bonus)
    if not ply.Horde_Infusions then return end
    local curr_weapon = GetCurrentWeapon(ply)
    local infusion = ply.Horde_Infusions[curr_weapon:GetClass()]
    if not infusion then return end
    if infusion == HORDE.Infusion_Titanium then
        bonus.less = bonus.less * (1 - 0.01 * HORDE.items[curr_weapon:GetClass()].weight)
    end
end)

hook.Add("PostEntityTakeDamage", "Horde_ApplyFusionPost", function (ent, dmginfo, took)
    local attacker = dmginfo:GetAttacker()
    if took and ent:IsNPC() and attacker:IsPlayer() then
        local ply = attacker
        if not ply.Horde_Infusions then return end
        local inflictor = dmginfo:GetInflictor()
        local curr_weapon = GetCurrentWeapon(inflictor)
        local infusion = ply.Horde_Infusions[curr_weapon:GetClass()]
        if not infusion then return end
        local hitgroup = ent.hitgroup
        if infusion >= HORDE.Infusion_Hemo and infusion <= HORDE.Infusion_Galvanizing then
            ent:Horde_AddDebuffBuildup(debuffs[ply.Horde_Infusions[curr_weapon:GetClass()]], dmginfo:GetDamage() * 0.35, ply, dmginfo:GetDamagePosition())
        elseif infusion == HORDE.Infusion_Siphoning and hitgroup == HITGROUP_HEAD then
            if ent:Health() <= 0 then
                local healinfo = HealInfo:New({amount=1, healer=ply})
                HORDE:OnPlayerHeal(ply, healinfo)
            end
        end
    end
end)

net.Receive("Horde_BuyInfusion", function (len, ply)
    if not ply:IsValid() or not ply:Alive() then return end
    local class = net.ReadString()
    local infusion = net.ReadUInt(5)
    local price = HORDE.items[class].price / 5
    if ply:Horde_GetMoney() >= price then
        ply:Horde_AddMoney(-price)
        HORDE:InfuseWeapon(ply, class, infusion)
        net.Start("Horde_SyncInfusion")
            net.WriteTable(ply.Horde_Infusions)
        net.Send(ply)
        ply:Horde_SyncEconomy()
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
end