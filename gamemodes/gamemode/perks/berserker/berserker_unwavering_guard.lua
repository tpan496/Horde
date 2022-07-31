PERK.PrintName = "Unwavering Guard"
PERK.Description = [[On successful Aerial Parry:
    - {1} increased Physical damage for {3} seconds.
    - {2} less damage taken for {3} seconds.]]
PERK.Icon = "materials/perks/unwavering_guard.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.25, percent = true},
    [3] = {value = 5},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "berserker_unwavering_guard" then
        ply:Horde_SetUnwaveringGuardEnabled(true)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "berserker_unwavering_guard" then
        ply:Horde_SetUnwaveringGuardEnabled(nil)
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply.HasUnwaveringGuardBuff then
        bonus.increase = bonus.increase + 0.25
    end
end