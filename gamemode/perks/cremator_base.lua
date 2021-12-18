PERK.PrintName = "Cremator Base"
PERK.Description = "The Cremator builds its offense and defense around Fire damage.\n\n{1} increased Fire damage resistance.\nImmune to Ignite.\nAttacks have {2} chance to Ignite enemies.\n\nIgnite base duration is {3}.\nIgnite deals {4} of most recent damage received over time.\nFire damage has {5} Ignite chance."
PERK.Params = {
    [1] = {value = 0.85, percent = true},
    [2] = {value = 0.15, percent = true},
    [3] = {value = 4},
    [4] = {value = 0.025, percent = true},
    [5] = {value = 1, percent = true}
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
        bonus.resistance = bonus.resistance + 0.85
    end
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
    if not ply:Horde_GetPerk("cremator_base")  then return end
    if debuff == HORDE.Status_Ignite then
        bonus.apply = 0
        return true
    end
end