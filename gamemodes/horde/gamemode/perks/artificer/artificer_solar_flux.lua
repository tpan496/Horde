PERK.PrintName = "Solar Flux"
PERK.Description =
[[Each time you use a different spell, increases spell damage by {1}, up to {2}.
Bonus is removed after you use a same spell.]]
PERK.Icon = "materials/perks/artificer/solar_flux.png"
PERK.Params = {
    [1] = {value = 0.05, percent = true},
    [2] = {value = 0.25, percent = true},
}
PERK.Hooks = {}
PERK.Hooks.Horde_OnSpellFire = function (ply, wpn, stage, spell)
    if ply:Horde_GetPerk("artificer_solar_flux") then
        if not ply.Horde_Last_Spell then
            ply.Horde_Last_Spell = spell.ClassName
            ply:Horde_AddSolarFluxStack()
        else
            if ply.Horde_Last_Spell ~= spell.ClassName then
                ply.Horde_Last_Spell = spell.ClassName
                ply:Horde_AddSolarFluxStack()
            else
                ply:Horde_RemoveAllSolarFluxStacks()
            end
        end
    end
end