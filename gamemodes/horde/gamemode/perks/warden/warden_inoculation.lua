PERK.PrintName = "Inoculation"
PERK.Description = "Aura reduces {1} buildups from Ignite, Frostbite, and Shock."
PERK.Icon = "materials/perks/inoculation.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "warden_inoculation" then
        ply:Horde_SetEnableWardenAuraInoculation(true)
        ply:Horde_AddWardenAura()
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "warden_inoculation" then
        ply:Horde_SetEnableWardenAuraInoculation(nil)
        if ply:Horde_GetPerk("warden_base") then
            ply:Horde_AddWardenAura()
        else
            ply:Horde_RemoveWardenAura()
        end
    end
end