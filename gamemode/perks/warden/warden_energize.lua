PERK.PrintName = "Energize"
PERK.Description = [[Aura adds {1} base damage to attacks.
Only applies to base damage that is at least {1}.]]
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
        if ply:Horde_GetPerk("warden_base") then
            ply:Horde_AddWardenAura()
        else
            ply:Horde_RemoveWardenAura()
        end
    end
end