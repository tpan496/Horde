PERK.PrintName = "Cremator Base"
PERK.Description = [[
The Cremator builds its offense and defense around Fire damage.
Complexity: EASY

{1} increased Fire damage resistance. ({2} + {3} per level, up to {4}).
Attacks have {5} chance to Ignite enemies.

Ignite base duration is {6} and deals damage over time based on hit damage.
Fire damage has {7} Ignite chance.]]
PERK.Params = {
    [1] = {percent = true, base = 0.25, level = 0.01, max = 0.5, classname = HORDE.Class_Cremator},
    [2] = {value = 0.25, percent = true},
    [3] = {value = 0.01, percent = true},
    [4] = {value = 0.5, percent = true},
    [5] = {value = 0.15, percent = true},
    [6] = {value = 4},
    [7] = {value = 1, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "cremator_base" then
        ply:Horde_SetApplyIgniteChance(ply:Horde_GetApplyIgniteChance() + 0.15)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "cremator_base" then
        ply:Horde_SetApplyIgniteChance(ply:Horde_GetApplyIgniteChance() - 0.15)
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("cremator_base")  then return end
    if HORDE:IsFireDamage(dmginfo) then
        bonus.resistance = bonus.resistance + ply:Horde_GetPerkLevelBonus("cremator_base")
    end
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
    if not ply:Horde_GetPerk("cremator_base")  then return end
    if debuff == HORDE.Status_Ignite then
        bonus.apply = 0
        return true
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("cremator_base", math.min(0.5, 0.25 + 0.01 * ply:Horde_GetLevel(HORDE.Class_Cremator)))
    end
end