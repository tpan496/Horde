PERK.PrintName = "Deatheater"
PERK.Description = [[+2 Fear stack.
{1} less debuff buildups.
Immune to Necrosis.]]
PERK.Icon = "materials/perks/overlord/deatheater.png"
PERK.Params = {
    [1] = { value = 0.2, percent = true },
}
PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "overlord_deatheater" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() + 2)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "overlord_deatheater" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() - 2)
    end
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function(ply, debuff, bonus)
    if ply:Horde_GetPerk("overlord_deatheater") then
        if debuff == HORDE.Status_Necrosis then
            bonus.apply = 0
            return true
        else
            bonus.less = bonus.less * 0.8
        end
    end
end
