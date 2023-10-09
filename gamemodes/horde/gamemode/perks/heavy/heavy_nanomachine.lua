PERK.PrintName = "Nanomachine"
PERK.Description = "{1} increased armor regeneration rate."
PERK.Icon = "materials/perks/nanomachine.png"
PERK.Params = {
    [1] = {value = 1, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "heavy_nanomachine" then
        ply:Horde_SetArmorRegenAmount(2)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "heavy_nanomachine" then
        ply:Horde_SetArmorRegenAmount(1)
        ply:SetArmor(0)
    end
end
