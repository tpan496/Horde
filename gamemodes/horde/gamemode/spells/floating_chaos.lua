SPELL.PrintName       = "Floating Chaos"
SPELL.Weapon          = {"horde_solar_seal"}
SPELL.Mind            = {40}
SPELL.Price           = 1500
SPELL.ChargeTime      = {1}
SPELL.ChargeRelease   = nil
SPELL.Cooldown        = 18
SPELL.Slot            = HORDE.Spell_Slot_Reload
SPELL.DamageType      = nil
SPELL.Icon            = "spells/floating_chaos.png"
SPELL.Type            = {HORDE.Spell_Type_Utility}
SPELL.Description     = [[Conjures an energy portal near you that reflects your spells. Only 1 Floating Chaos can exist.]]
SPELL.Fire            = function (ply, wpn, charge_stage)
    if ply.Horde_Floating_Chaos and IsValid(ply.Horde_Floating_Chaos) then
        ply.Horde_Floating_Chaos:Remove()
    end
    timer.Simple(0.1, function ()
        if not ply:IsValid() then return end
        ply:EmitSound("horde/weapons/solar_seal/floating_chaos_launch.ogg")
        local pos = ply:GetShootPos() + ply:GetAimVector() * 50
        pos.z = pos.z + 25
        local ent = ents.Create("projectile_horde_floating_chaos")
        ent:SetOwner(ply)
        ent:SetPos( pos )
        ent:SetAngles( ply:EyeAngles() )
        local level = ply:Horde_GetSpellUpgrade("floating_chaos")
        ent.Horde_Spell_Level = level
        ent:Spawn()

        local phys = ent:GetPhysicsObject()
        if (!IsValid( phys )) then ent:Remove() return end
        local velocity = Vector(0,0,1)
        velocity = velocity * 15
        phys:ApplyForceCenter(velocity)
    end)
end
SPELL.Price                      = 1500
SPELL.Upgrades                   = 3
SPELL.Upgrade_Description        = "Increases duration and number of spells echoed."
SPELL.Upgrade_Prices             = function (upgrade_level)
    return 800 + 100 * upgrade_level
end