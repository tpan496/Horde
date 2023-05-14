PERK.PrintName = "Ballistic Shock"
PERK.Description = "{1} increased Ballistic damage.\nDebuffs you apply have {2} increased effect."
PERK.Icon = "materials/perks/ballistic_shock.png"
PERK.Params = {
    [1] = {value = 0.15, percent = true},
    [2] = {value = 0.5, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "heavy_ballistic_shock" then
        ply:Horde_SetApplyDebuffMore(1.5)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "heavy_ballistic_shock" then
        ply:Horde_SetApplyDebuffMore(1)
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function(ply, npc, bonus, hitgroup, dmg)
    if not ply:Horde_GetPerk("heavy_ballistic_shock") then return end
    if HORDE:IsBallisticDamage(dmg) then
        bonus.increase = bonus.increase + 0.15
    end
end