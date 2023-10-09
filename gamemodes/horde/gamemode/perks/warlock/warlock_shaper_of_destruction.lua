PERK.PrintName = "Shaper of Destruction"
PERK.Description =
[[{1} increased maximum mind.
+1 level to your Ultimate spells.
Reduce Ultimate spell cooldown by {2}.]]
PERK.Icon = "materials/perks/warlock/shaper_of_destruction.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.2, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetMaxMind = function (ply, bonus)
    if ply:Horde_GetPerk("warlock_shaper_of_destruction") then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnSpellLevel = function (ply, bonus, spell)
    if ply:Horde_GetPerk("warlock_shaper_of_destruction") and spell.Slot == HORDE.Spell_Slot_Reload then
        bonus.add = bonus.add + 1
    end
end

PERK.Hooks.Horde_OnSpellCooldown = function(ply, bonus, spell)
    if ply:Horde_GetPerk("warlock_shaper_of_destruction") and spell.Slot == HORDE.Spell_Slot_Reload then
        bonus.less = bonus.less * 0.8
    end
end