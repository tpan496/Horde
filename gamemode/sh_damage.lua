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

HORDE.DMG_COLOR = {
    [HORDE.DMG_FIRE] = Color(255,51,51),
    [HORDE.DMG_COLD] = Color(0,191,255),
    [HORDE.DMG_LIGHTNING] = Color(255,215,0),
    [HORDE.DMG_POISON] = Color(255, 0, 255),
    [HORDE.DMG_BLAST] = Color(255,140,0),
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
    return dmginfo:IsDamageType(DMG_BULLET) or dmginfo:IsDamageType(DMG_SNIPER) or dmginfo:IsDamageType(DMG_BUCKSHOT)
end

function HORDE:IsBluntDamage(dmginfo)
    return dmginfo:IsDamageType(DMG_CLUB)
end

function HORDE:IsSlashDamage(dmginfo)
    return dmginfo:IsDamageType(DMG_SLASH)
end

function HORDE:IsPhysicalDamage(dmginfo)
    return HORDE:IsBallisticDamage(dmginfo) or HORDE:IsBluntDamage(dmginfo) or HORDE:IsSlashDamage(dmginfo) or dmginfo:IsDamageType(DMG_GENERIC) or dmginfo:IsDamageType(DMG_CRUSH) or dmginfo:IsDamageType(DMG_SONIC)
end

function HORDE:IsFireDamage(dmginfo)
    return dmginfo:IsDamageType(DMG_BURN) or dmginfo:IsDamageType(DMG_SLOWBURN) or dmginfo:IsDamageType(DMG_PLASMA)
end

function HORDE:IsColdDamage(dmginfo)
    return dmginfo:IsDamageType(DMG_REMOVENORAGDOLL)
end

function HORDE:IsLightningDamage(dmginfo)
    return dmginfo:IsDamageType(DMG_SHOCK) or dmginfo:IsDamageType(DMG_ENERGYBEAM)
end

function HORDE:IsPoisonDamage(dmginfo)
    return dmginfo:IsDamageType(DMG_NERVEGAS) or dmginfo:IsDamageType(DMG_ACID) or dmginfo:IsDamageType(DMG_POISON) or dmginfo:IsDamageType(DMG_PARALYZE)
end

function HORDE:IsBlastDamage(dmginfo)
    return dmginfo:IsDamageType(DMG_BLAST) or dmginfo:IsDamageType(DMG_MISSILEDEFENSE)
end

function HORDE:GetStats()
if CLIENT and LocalPlayer():Alive() then
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
    local bonus = {apply = 1}
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

    local bonus_run = {walkspd = 1, sprintspd = 1}
    hook.Run("Horde_PlayerMoveBonus", ply, bonus_run)
    stats["speed"] = math.max(bonus_run.walkspd, bonus_run.sprintspd)

    HORDE:CalcImmunity(ply, stats, HORDE.Status_Bleeding)
    HORDE:CalcImmunity(ply, stats, HORDE.Status_Ignite)
    HORDE:CalcImmunity(ply, stats, HORDE.Status_Frostbite)
    HORDE:CalcImmunity(ply, stats, HORDE.Status_Shock)
    HORDE:CalcImmunity(ply, stats, HORDE.Status_Break)

    net.Start("Horde_GiveStats")
        net.WriteTable(stats)
    net.Send(ply)
end)
end

if CLIENT then
net.Receive("Horde_GiveStats", function ()
    LocalPlayer().Horde_Stats = net.ReadTable()
end)

function HORDE:GetStat(stat)
    if not LocalPlayer().Horde_Stats then return 0 end
    return LocalPlayer().Horde_Stats[stat]
end
end