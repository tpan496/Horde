PERK.PrintName = "Inverse Filter"
PERK.Description = [[{1} less debuff buildup received.
Restores {2} health whenever you receive any debuff buildup.]]
PERK.Icon = "materials/perks/overlord/inverse_filter.png"
PERK.Params = {
    [1] = { value = 0.5, percent = true },
    [2] = { value = 3 },
    [3] = { value = 0.01, percent = true },
}
PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "overlord_inverse_filter" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() + 1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "overlord_inverse_filter" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() - 1)
    end
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function(ply, debuff, bonus, inflictor)
    if not ply:Horde_GetPerk("overlord_inverse_filter") then return end
    bonus.less = bonus.less * 0.5
    HORDE:SelfHeal(ply, 3)
end
