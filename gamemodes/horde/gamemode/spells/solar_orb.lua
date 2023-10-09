SPELL.PrintName      = "Solar Orb"
SPELL.Weapon         = {"horde_solar_seal"}
SPELL.Mind           = {5, 10, 20}
SPELL.ChargeTime     = {0, 0.5, 1}
SPELL.ChargeRelease  = nil
SPELL.Cooldown       = 1
SPELL.Upgrades         = 5
SPELL.Slot           = HORDE.Spell_Slot_LMB
SPELL.DamageType     = {HORDE.DMG_FIRE}
SPELL.Icon           = "spells/solar_orb.png"
SPELL.Type           = {HORDE.Spell_Type_Projectile, HORDE.Spell_Type_AOE}
SPELL.Description    = [[Conjures fireballs using solar energy. Charge for differnet effects.]]
SPELL.Fire           = function (ply, wpn, charge_stage)
    local function SpawnProjectile(pos, angles, dir, properties)
        local ent = ents.Create("projectile_horde_solar_orb")
        ent:SetOwner(ply)
        ent:SetCharged(charge_stage - 1)
        local level = ply:Horde_GetSpellUpgrade("solar_orb")
        ent:SetSpellLevel(level)
        ent:SetSpellBaseDamages({math.floor(25 + math.pow(level, 1.1) * 5.5), math.floor(10 + math.pow(level, 1.1) * 7)})
        ent:SetPos( pos )
        ent:SetAngles( angles )
        hook.Run("Horde_OnDraconicCheck", ply, ent)
        ent:Spawn()

        local phys = ent:GetPhysicsObject()
        if (!IsValid( phys )) then ent:Remove() return end
        local velocity = dir
        velocity:Normalize()
        velocity = velocity * 1000
        if charge_stage == 4 then
            velocity = velocity * 1.25
        end
        phys:ApplyForceCenter(velocity)
    end

    SpawnProjectile(ply:EyePos() + (ply:GetAimVector() * 16), ply:EyeAngles(), ply:GetAimVector(), p)

    if charge_stage <= 2 then
        ply:EmitSound("horde/weapons/solar_seal/solar_orb_launch.ogg", 100, math.random(90, 110))
    else
        ply:EmitSound("horde/weapons/solar_seal/solar_orb_charged_launch.ogg", 100, math.random(90, 110))
    end

    if ply.Horde_Floating_Chaos and ply.Horde_Floating_Chaos:IsValid() then
        local pos = ply.Horde_Floating_Chaos:GetPos()
        local fired
        local max_targets = 3 + ply.Horde_Floating_Chaos.Horde_Spell_Level
        if charge_stage > 1 then
            max_targets = 1
        end
        for _, target in pairs(ents.FindInSphere(ply.Horde_Floating_Chaos:GetPos(), 1000)) do
            if HORDE:IsEnemy(target) and max_targets > 0 then
                SpawnProjectile(pos, Angle(0,0,0),  target:GetPos() + target:OBBCenter() - pos, p)
                fired = true
                max_targets = max_targets - 1
            end
        end

        if not fired then
            SpawnProjectile(pos, Angle(0,0,0),  Vector(0,0,-1), p)
        end
    end
end
SPELL.Price                      = 50
SPELL.Upgrades                   = 5
SPELL.Upgrade_Description        = "Increases damage."
SPELL.Upgrade_Prices             = function (upgrade_level)
    return 550 + 50 * upgrade_level
end