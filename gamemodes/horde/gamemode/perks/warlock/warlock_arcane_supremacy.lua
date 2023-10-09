PERK.PrintName = "Arcane Supremacy"
PERK.Description =
[[{1} increased maximum mind.
{2} increased Ultimate spell charging speed.]]
PERK.Icon = "materials/perks/warlock/arcane_supremacy.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.3, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetMaxMind = function (ply, bonus)
    if ply:Horde_GetPerk("warlock_arcane_supremacy") then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnSpellCharge = function (ply, bonus, spell)
    if ply:Horde_GetPerk("warlock_arcane_supremacy") and spell.Slot == HORDE.Spell_Slot_Reload then
        bonus.increase = bonus.increase + 0.3
    end
end
