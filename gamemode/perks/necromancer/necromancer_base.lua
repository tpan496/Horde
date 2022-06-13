PERK.PrintName = "Necromancer Base"
PERK.Description = [[
COMPLEXITY: MEDIUM

Inflicts Frostbite buildup by {1} of base Cold damage. ({2} + {3} per level, up to {4}).
{5} increased Cold damage resistance. ({6} per level, up to {7}).

Equipped with Void Projector. Upgradable through shop.

LMB: Void Spear (5/10/20 Energy)
Releases a projectile that deals Cold damage and applies Frostbite buildup.
HOLD LMB for different effects.

RMB: Raise Spectre (40 Energy)
Conjures a Spectre minion.
The Spectre minion deals Physical damage and applies Frostbite buildup.
HOLD RMB to recall Spectres to your side.]]
PERK.Icon = "materials/subclasses/necromancer.png"
PERK.Params = {
    [1] = {percent = true, base = 0.1, level = 0.01, max = 0.35, classname = "Necromancer"},
    [2] = {value = 0.1, percent = true},
    [3] = {value = 0.01, percent = true},
    [4] = {value = 0.35, percent = true},
    [5] = {percent = true, base = 0, level = 0.01, max = 0.25, classname = "Necromancer"},
    [6] = {value = 0.01, percent = true},
    [7] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("necromancer_base")  then return end
    if HORDE:IsColdDamage(dmginfo) then
        bonus.resistance = bonus.resistance + ply:Horde_GetPerkLevelBonus("necromancer_base")
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("necromancer_base") then return end
    if HORDE:IsColdDamage(dmginfo) then
        npc:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, dmginfo:GetDamage() * (0.1 + ply:Horde_GetPerkLevelBonus("necromancer_base")), ply, dmginfo:GetDamagePosition())
    end
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "necromancer_base" then
        if ply:HasWeapon("horde_void_projector") == true then return end
        ply:StripWeapons()
        timer.Simple(0, function() ply:Give("horde_void_projector") end)
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("necromancer_base", math.min(0.25, 0.01 * ply:Horde_GetLevel("Necromancer")))
    end
end