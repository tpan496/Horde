SPELL.PrintName       = "Void Maw"
SPELL.Weapon          = {"horde_void_projector"}
SPELL.Mind            = {10}
SPELL.Price           = 1500
SPELL.ChargeTime      = {0}
SPELL.ChargeRelease   = true
SPELL.Cooldown        = 7
SPELL.Slot            = HORDE.Spell_Slot_Utility
SPELL.DamageType      = {HORDE.DMG_COLD}
SPELL.Icon            = "spells/void_maw.png"
SPELL.Type            = {HORDE.Spell_Type_AOE}
SPELL.Description     = [[Applies Cold damage in an area. Leeches health for each enemy hit.]]
SPELL.Fire            = function (ply, wpn, charge_stage)
    ply:EmitSound("horde/spells/void_maw.ogg")
    local tr = ply:GetEyeTrace()
    if not tr.Hit then return end
    local pos = tr.HitPos

    local ed = EffectData()
        ed:SetOrigin(pos)
    util.Effect("horde_void_maw", ed, true, true)

    timer.Simple(0.5, function ()
        if not ply:IsValid() then return end
        local dmginfo = HORDE:DamageInfo(50, DMG_REMOVENORAGDOLL, ply, wpn)
        
        local hit = nil
        HORDE:ApplyDamageInRadius(pos, 300, dmginfo, function (ent)
            HORDE:SelfHeal(ply, 5)

            local ed2 = EffectData()
                ed2:SetOrigin(ent:GetPos() + ent:OBBCenter())
            util.Effect("horde_maw_smoke", ed2, true, true)
            hit = true
        end)

        if hit then
            sound.Play("horde/status/cold_explosion.ogg", pos, 100, math.random(90, 110))
        end
    end)
end
SPELL.Price = 750