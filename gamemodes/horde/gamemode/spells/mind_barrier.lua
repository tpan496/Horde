SPELL.PrintName      = "Mind Barrier"
SPELL.Mind           = {10}
SPELL.ChargeTime     = {0}
SPELL.ChargeRelease  = nil
SPELL.Cooldown       = 10
SPELL.Slot           = HORDE.Spell_Slot_Utility
SPELL.Icon           = "spells/barrier.png"
SPELL.Type           = {HORDE.Spell_Type_Utility}
SPELL.Description    = [[Grants 20 Barrier to the user.]]
SPELL.Fire           = function (ply, wpn, charge_stage)
    ply:Horde_AddBarrierStack(20)
end
SPELL.Price          = 600
SPELL.Levels          = {Artificer=5, Warlock=5, Necromancer=5}