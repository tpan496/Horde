SPELL.PrintName       = "Raise Hulk Spectre"
SPELL.Weapon          = {"horde_void_projector"}
SPELL.Mind            = {60}
SPELL.ChargeTime      = {1}
SPELL.ChargeRelease   = nil
SPELL.Cooldown        = 10
SPELL.Slot            = HORDE.Spell_Slot_Reload
SPELL.DamageType      = {HORDE.DMG_PHYSICAL}
SPELL.Type            = {HORDE.Spell_Type_Minion}
SPELL.Icon            = "spells/raise_shadow_hulk.png"
SPELL.Description    = [[Raises a hulk spectre created using dark matter. You can create at most 1 Hulk Spectre.]]
SPELL.Fire            = function (ply, wpn, charge_stage)
    return HORDE:RaiseSpectre(ply, {hulk_spectre=true})
end
SPELL.Price                      = 1500
SPELL.Upgrades                   = 3
SPELL.Upgrade_Description        = "Increases minion health and damage."
SPELL.Upgrade_Prices             = function (upgrade_level)
    return 800 + 100 * upgrade_level
end