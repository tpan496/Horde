SPELL.PrintName       = "Enlighten"
SPELL.Mind            = {10}
SPELL.Price           = 0
SPELL.ChargeTime      = {0}
SPELL.ChargeRelease   = true
SPELL.Cooldown        = 5
SPELL.Slot            = HORDE.Spell_Slot_Utility
SPELL.DamageType      = nil
SPELL.Icon            = "spells/enlighten.png"
SPELL.Type            = {HORDE.Spell_Type_Utility}
SPELL.Description     = [[Increases the damage of your next spell by 15%.]]
SPELL.Fire            = function (ply, wpn, charge_stage)
    ply:EmitSound("horde/spells/enlighten.ogg")
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Enlighten, 8)
        net.WriteUInt(1, 8)
    net.Send(ply)
    ply.Horde_Enlighten = true
end
SPELL.Hooks = {}
SPELL.Hooks.Horde_OnPlayerSpellDamage = function (ply, bonus)
    if ply.Horde_Enlighten then
        bonus.increase = bonus.increase + 0.15
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Enlighten, 8)
            net.WriteUInt(0, 8)
        net.Send(ply)
        ply.Horde_Enlighten = nil
    end
end
SPELL.Hooks.PlayerDeath = function (ply, bonus)
    ply.Horde_Enlighten = nil
end
SPELL.Price = 500