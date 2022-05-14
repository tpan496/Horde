PERK.PrintName = "Necromancer Base"
PERK.Description = [[
Your Cold damage increases enemy Frostbite buildup.
{1} increased Cold damage. ({2} per level, up to {3}).
{1} increased Cold damage resistance. ({2} per level, up to {3}).

Equipped with Void Projector. Upgradable through shop.
LMB: Void Spear (5/10/20 Energy)
Releases a projectile that deals Cold damage.
Hold for different effects.

RMB: Raise Spectre (40 Energy)
Conjures a Spectre minion.
The Spectre minion deals Physical damage and applies Frostbite buildup.]]
PERK.Icon = "materials/subclasses/necromancer.png"
PERK.Params = {
    [1] = {percent = true, base = 0, level = 0.01, max = 0.25, classname = HORDE.Class_Engineer},
    [2] = {value = 0.01, percent = true},
    [3] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("necromancer_base")  then return end
    if HORDE:IsColdDamage(dmginfo) then
        bonus.resistance = bonus.resistance + ply:Horde_GetPerkLevelBonus("cremator_base") - 0.25
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("necromancer_base") then return end
    if HORDE:IsColdDamage(dmginfo) then
        npc:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, dmginfo:GetDamage() / 3, ply, dmginfo:GetDamagePosition())
    end
end