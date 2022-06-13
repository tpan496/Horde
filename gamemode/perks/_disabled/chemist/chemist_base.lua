PERK.PrintName = "Chemist Base"
PERK.Description = [[
Complexity: MEDIUM

Convert 100% of your Ballistic damage into Poison damage.
Inflicts Break buildup by {1} of base Poison damage. ({2} + {3} per level, up to {4}).
{4} increased Poison damage resistance. ({5} + {6} per level, up to {7}).]]

PERK.Params = {
    [1] = {percent = true, base = 0.1, level = 0.008, max = 0.30, classname = "Chemist"},
    [2] = {value = 0.008, percent = true},
    [3] = {value = 0.20, percent = true},
    [4] = {value = 0.20, percent = true},
    [5] = {percent = true, base = 0.5, level = 0.01, max = 0.75, classname = "Chemist"},
    [6] = {value = 0.5, percent = true},
    [7] = {value = 0.01, percent = true},
    [8] = {value = 0.75, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamagePre = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("chemist_base") then return end
    if HORDE:IsBallisticDamage(dmginfo) then
        dmginfo:SetDamageType(DMG_NERVEGAS)
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("chemist_base") then return end
    if HORDE:IsPoisonDamage(dmginfo) then
        npc:Horde_AddDebuffBuildup(HORDE.Status_Break, dmginfo:GetDamage() * ply:Horde_GetPerkLevelBonus("chemist_base"), ply, dmginfo:GetDamagePosition())
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("chemist_base") then return end
    if HORDE:IsPoisonDamage(dmginfo) then
        bonus.resistance = bonus.resistance + ply:Horde_GetPerkLevelBonus("chemist_base_2")
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("chemist_base", math.min(0.3, 0.1 + 0.008 * ply:Horde_GetLevel("Chemist")))
        ply:Horde_SetPerkLevelBonus("chemist_base_2", math.min(0.75, 0.5 + 0.01 * ply:Horde_GetLevel("Chemist")))
    end
end