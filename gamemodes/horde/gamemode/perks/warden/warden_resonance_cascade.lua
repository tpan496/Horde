PERK.PrintName = "Resonance Cascade"
PERK.Description = "Aura effect increased by {1}.\nAura radius increased by {2}."
PERK.Icon = "materials/perks/resonance_cascade.png"
PERK.Params = {
    [1] = {value = 0.5, percent = true},
    [2] = {value = 0.5, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "warden_resonance_cascade" then
        ply:Horde_SetEnableWardenAuraBuffBonus(true)
        ply:Horde_SetWardenAuraRadius(ply:Horde_GetWardenAuraRadius() * 1.5)
        ply:Horde_AddWardenAura()
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "warden_resonance_cascade" then
        ply:Horde_SetEnableWardenAuraBuffBonus(nil)
        ply:Horde_SetWardenAuraRadius(ply:Horde_GetWardenAuraRadius() / 1.5)
        if ply:Horde_GetPerk("warden_base") then
            ply:Horde_AddWardenAura()
        else
            ply:Horde_RemoveWardenAura()
        end
    end
end