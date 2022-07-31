PERK.PrintName = "Vitality"
PERK.Description = "Aura provides {1} health regeneration per second."
PERK.Icon = "materials/perks/vitality.png"
PERK.Params = {
    [1] = {value = 1},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "warden_vitality" then
        ply:Horde_SetEnableWardenAuraHealthRegen(true)
        ply:Horde_AddWardenAura()
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "warden_vitality" then
        ply:Horde_SetEnableWardenAuraHealthRegen(nil)
        if ply:Horde_GetPerk("warden_base") then
            ply:Horde_AddWardenAura()
        else
            ply:Horde_RemoveWardenAura()
        end
    end
end