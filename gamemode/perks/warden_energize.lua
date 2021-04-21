PERK.PrintName = "Energize"
PERK.Description = "Aura adds {1} base damage to attacks."
PERK.Icon = "materials/perks/energize.png"
PERK.Params = {
    [1] = {value = 8},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "warden_energize" then
        ply:Horde_SetEnableWardenAuraDamageBonus(true)
        ply:Horde_AddWardenAura()
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "warden_energize" then
        ply:Horde_SetEnableWardenAuraDamageBonus(nil)
        ply:Horde_AddWardenAura()
    end
end