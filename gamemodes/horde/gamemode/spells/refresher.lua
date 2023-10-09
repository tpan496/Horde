SPELL.PrintName       = "Refresher"
SPELL.Weapon          = {"horde_astral_relic"}
SPELL.Mind            = {40}
SPELL.Price           = 0
SPELL.ChargeTime      = {0}
SPELL.ChargeRelease   = true
SPELL.Cooldown        = 90
SPELL.Slot            = HORDE.Spell_Slot_Utility
SPELL.DamageType      = nil
SPELL.Icon            = "spells/refresher.png"
SPELL.Type            = {HORDE.Spell_Type_Utility}
SPELL.Description     = [[Resets the cooldown of your spells.]]
SPELL.Fire            = function (ply, wpn, charge_stage)
    ply:EmitSound("horde/spells/refresher.ogg")
    wpn:SetNextPrimaryFire(CurTime())
    wpn:SetNextSecondaryFire(CurTime())
    wpn:SetNextUltimateFire(CurTime())
    wpn:SetNextUtilityFire(CurTime())
end
SPELL.Price = 750