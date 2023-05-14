if SERVER then
util.AddNetworkString("Horde_GetStats")
util.AddNetworkString("Horde_GiveStats")
end

HORDE.DMG_PURE = 0

HORDE.DMG_PHYSICAL = 1
HORDE.DMG_BALLISTIC = 2
HORDE.DMG_BLUNT = 3
HORDE.DMG_SLASH = 4

HORDE.DMG_FIRE = 5
HORDE.DMG_COLD = 6
HORDE.DMG_LIGHTNING = 7
HORDE.DMG_POISON = 8
HORDE.DMG_BLAST = 9

HORDE.DMG_TYPE_STRING = {
    [HORDE.DMG_PHYSICAL] = "Other Physical",
    [HORDE.DMG_BALLISTIC] =  "Ballistic",
    [HORDE.DMG_BLUNT] =  "Blunt",
    [HORDE.DMG_SLASH] =  "Slashing",
    [HORDE.DMG_FIRE] = "Fire",
    [HORDE.DMG_COLD] = "Cold",
    [HORDE.DMG_LIGHTNING] = "Lightning",
    [HORDE.DMG_POISON] = "Poison",
    [HORDE.DMG_BLAST] = "Blast",
    [HORDE.DMG_PURE] = "Pure",
}

HORDE.DMG_TYPE_ICON = {
    [HORDE.DMG_PHYSICAL] = "materials/damagetype/physical.png",
    [HORDE.DMG_SLASH] =  "materials/damagetype/slash.png",
    [HORDE.DMG_BLUNT] =  "materials/damagetype/blunt.png",
    [HORDE.DMG_BALLISTIC] =  "materials/damagetype/ballistic.png",
    [HORDE.DMG_FIRE] = "materials/damagetype/fire.png",
    [HORDE.DMG_COLD] = "materials/damagetype/cold.png",
    [HORDE.DMG_LIGHTNING] = "materials/damagetype/lightning.png",
    [HORDE.DMG_POISON] = "materials/damagetype/poison.png",
    [HORDE.DMG_BLAST] = "materials/damagetype/blast.png",
    [HORDE.DMG_PURE] = "materials/damagetype/physical.png",
}

HORDE.DMG_COLOR = {
    [HORDE.DMG_PHYSICAL] = Color(255, 255, 255),
    [HORDE.DMG_SLASH] =  Color(255, 255, 255),
    [HORDE.DMG_BLUNT] =  Color(255, 255, 255),
    [HORDE.DMG_BALLISTIC] =  Color(255, 255, 255),
    [HORDE.DMG_FIRE] = Color(255,51,51),
    [HORDE.DMG_COLD] = Color(0,191,255),
    [HORDE.DMG_LIGHTNING] = Color(255,215,0),
    [HORDE.DMG_POISON] = Color(255, 0, 255),
    [HORDE.DMG_BLAST] = Color(255,140,0),
    [HORDE.DMG_PURE] = Color(255,255,255),
}

HORDE.STATUS_COLOR = {
    [HORDE.Status_Decay] = Color(50, 150, 50),
    [HORDE.Status_Necrosis] = Color(204, 204, 255),
    [HORDE.Status_Bleeding] = HORDE.color_crimson_violet,
    [HORDE.Status_Freeze] = HORDE.DMG_COLOR[HORDE.DMG_COLD],
    [HORDE.Status_Frostbite] = HORDE.DMG_COLOR[HORDE.DMG_COLD],
    [HORDE.Status_Shock] = HORDE.DMG_COLOR[HORDE.DMG_LIGHTNING],
    [HORDE.Status_Stun] = Color(255, 255, 0),
    [HORDE.Status_Break] = HORDE.DMG_COLOR[HORDE.DMG_POISON],
}

function HORDE:GetDamageType(dmginfo)
    if HORDE:IsPhysicalDamage(dmginfo) then
        if HORDE:IsBallisticDamage(dmginfo) then return HORDE.DMG_BALLISTIC end
        if HORDE:IsSlashDamage(dmginfo) then return HORDE.DMG_SLASH end
        if HORDE:IsBluntDamage(dmginfo) then return HORDE.DMG_BLUNT end
        return HORDE.DMG_PHYSICAL
    else
        if HORDE:IsFireDamage(dmginfo) then return HORDE.DMG_FIRE end
        if HORDE:IsColdDamage(dmginfo) then return HORDE.DMG_COLD end
        if HORDE:IsLightningDamage(dmginfo) then return HORDE.DMG_LIGHTNING end
        if HORDE:IsPoisonDamage(dmginfo) then return HORDE.DMG_POISON end
        if HORDE:IsBlastDamage(dmginfo) then return HORDE.DMG_BLAST end
        return HORDE.DMG_PURE
    end
end

function HORDE:IsBallisticDamage(dmginfo)
    return dmginfo:IsDamageType(DMG_BULLET + DMG_SNIPER + DMG_BUCKSHOT)
end

function HORDE:IsBluntDamage(dmginfo)
    return dmginfo:IsDamageType(DMG_CLUB)
end

function HORDE:IsSlashDamage(dmginfo)
    return dmginfo:IsDamageType(DMG_SLASH)
end

function HORDE:IsMeleeDamage(dmginfo)
    return dmginfo:IsDamageType(DMG_SLASH) or dmginfo:IsDamageType(DMG_CLUB)
end

function HORDE:IsPhysicalDamage(dmginfo)
    return HORDE:IsBallisticDamage(dmginfo) or HORDE:IsBluntDamage(dmginfo) or HORDE:IsSlashDamage(dmginfo) or dmginfo:IsDamageType(DMG_GENERIC) or dmginfo:IsDamageType(DMG_CRUSH) or dmginfo:IsDamageType(DMG_SONIC)
end

function HORDE:IsFireDamage(dmginfo)
    return dmginfo:IsDamageType(DMG_BURN + DMG_SLOWBURN + DMG_PLASMA)
end

function HORDE:IsColdDamage(dmginfo)
    return dmginfo:IsDamageType(DMG_REMOVENORAGDOLL)
end

function HORDE:IsLightningDamage(dmginfo)
    return dmginfo:IsDamageType(DMG_SHOCK + DMG_ENERGYBEAM)
end

function HORDE:IsPoisonDamage(dmginfo)
    return dmginfo:IsDamageType(DMG_NERVEGAS + DMG_ACID + DMG_POISON + DMG_PARALYZE)
end

function HORDE:IsBlastDamage(dmginfo)
    return dmginfo:IsDamageType(DMG_BLAST)
end

-- Weapon types
function HORDE:IsCurrentWeapon(dmginfo, category)
    local class = HORDE:GetCurrentWeapon(dmginfo:GetInflictor()):GetClass()
    local item = HORDE.items[class]
    if item then
        return item.category == category
    else
        return false
    end
end

function HORDE:GetStats()
if CLIENT and MySelf:Alive() then
    net.Start("Horde_GetStats")
    net.SendToServer()
end
end

if SERVER then
function HORDE:CalcResistance(ply, stats, dmgtype, horde_dmgtype)
    local dmg = DamageInfo()
    dmg:SetDamageType(dmgtype)
    local bonus = {resistance=0, less=1, evasion=0, block=0}
    hook.Run("Horde_OnPlayerDamageTaken", ply, dmg, bonus, true)
    stats[horde_dmgtype] = 1 - bonus.less * (1 - bonus.resistance)
end

function HORDE:CalcImmunity(ply, stats, debuff)
    local bonus = {apply = 1, less = 1}
    hook.Run("Horde_OnPlayerDebuffApply", ply, debuff, bonus)
    stats[debuff] = 1 - bonus.apply
end

net.Receive("Horde_GetStats", function (len, ply)
    local stats = {}
    local dmg = DamageInfo()
    dmg:SetDamageType(DMG_GENERIC)
    local bonus = {resistance=0, less=1, evasion=0, block=0}
    hook.Run("Horde_OnPlayerDamageTaken", ply, dmg, bonus, true)
    stats["evasion"] = bonus.evasion
    stats["block"] = bonus.block
    stats[HORDE.DMG_PHYSICAL] = 1 - bonus.less * (1 - bonus.resistance)

    HORDE:CalcResistance(ply, stats, DMG_BURN, HORDE.DMG_FIRE)
    HORDE:CalcResistance(ply, stats, DMG_REMOVENORAGDOLL, HORDE.DMG_COLD)
    HORDE:CalcResistance(ply, stats, DMG_SHOCK, HORDE.DMG_LIGHTNING)
    HORDE:CalcResistance(ply, stats, DMG_POISON, HORDE.DMG_POISON)
    HORDE:CalcResistance(ply, stats, DMG_BLAST, HORDE.DMG_BLAST)
    HORDE:CalcResistance(ply, stats, DMG_CLUB, HORDE.DMG_BLUNT)
    HORDE:CalcResistance(ply, stats, DMG_SLASH, HORDE.DMG_SLASH)
    HORDE:CalcResistance(ply, stats, DMG_BULLET, HORDE.DMG_BALLISTIC)

    local bonus_walk = {increase = 0, more = 1}
    local bonus_run = {increase = 0, more = 1}
    hook.Run("Horde_PlayerMoveBonus", ply, bonus_walk, bonus_run)
    stats["speed"] = math.max(bonus_walk.more + bonus_walk.increase, bonus_run.more + bonus_walk.increase)

    HORDE:CalcImmunity(ply, stats, HORDE.Status_Bleeding)
    HORDE:CalcImmunity(ply, stats, HORDE.Status_Ignite)
    HORDE:CalcImmunity(ply, stats, HORDE.Status_Frostbite)
    HORDE:CalcImmunity(ply, stats, HORDE.Status_Shock)
    HORDE:CalcImmunity(ply, stats, HORDE.Status_Break)
    HORDE:CalcImmunity(ply, stats, HORDE.Status_Necrosis)

    net.Start("Horde_GiveStats")
        net.WriteTable(stats)
    net.Send(ply)
end)
end

if CLIENT then
net.Receive("Horde_GiveStats", function ()
    MySelf.Horde_Stats = net.ReadTable()
end)

function HORDE:GetStat(stat)
    if not MySelf.Horde_Stats then return 0 end
    return MySelf.Horde_Stats[stat]
end
end