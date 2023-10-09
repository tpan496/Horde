SPELL.PrintName      = "Solar Bolt"
SPELL.Weapon         = {"horde_solar_seal"}
SPELL.Mind           = {5, 10, 20}
SPELL.ChargeTime     = {0, 0.5, 1}
SPELL.ChargeRelease  = nil
SPELL.Cooldown       = 1
SPELL.Upgrades         = 5
SPELL.Slot           = HORDE.Spell_Slot_RMB
SPELL.DamageType     = {HORDE.DMG_LIGHTNING}
SPELL.Icon           = "spells/solar_bolt.png"
SPELL.Type           = {HORDE.Spell_Type_Hitscan}
SPELL.Description    = [[Surgically strikes the target with lightning. Charge to increase damage and range.]]
SPELL.Fire           = function (ply, wpn, charge_stage)
    local function Hitscan(damage, spread, dir, src, level)
        local d = 1000 + (charge_stage - 1) * 250
        local tr = util.TraceLine({
            start = src,
            endpos = src + dir * d,
            filter = {ply, ply.Horde_Floating_Chaos},
        })
        net.Start("Horde_SolarStormTracer")
            net.WriteUInt(charge_stage - 1, 3)
            net.WriteVector(src)
            net.WriteVector(tr.HitPos)
        net.Broadcast()

        if charge_stage == 1 then
            ply:EmitSound("horde/weapons/solar_seal/solar_storm_launch.ogg", 100, math.random(70, 90))
            sound.Play("horde/weapons/solar_seal/solar_storm_hit.ogg", tr.HitPos, 80, math.random(70, 90))
        elseif charge_stage == 2 then
            ply:EmitSound("horde/weapons/solar_seal/solar_storm_launch.ogg", 120, math.random(100, 120))
            sound.Play("horde/weapons/solar_seal/solar_storm_hit.ogg", tr.HitPos, 120, math.random(100, 120))
        elseif charge_stage == 3 then
            ply:EmitSound("horde/weapons/solar_seal/solar_storm_launch.ogg", 150, math.random(30, 50))
            sound.Play("horde/weapons/solar_seal/solar_storm_hit.ogg", tr.HitPos, 150, math.random(30, 50))
        end
        if tr.Hit ~= true then return end
        wpn:FireBullets({
            Attacker = ply,
            Damage = damage,
            Tracer = 0,
            Distance = 1000 + (charge_stage - 1) * 250,
            Dir = dir,
            Src = src,
            Spread = spread,
            IgnoreEntity = ply.Horde_Floating_Chaos,
            Callback = function(att, tr, dmg)
                dmg:SetDamageType(DMG_SHOCK)
                dmg:SetAttacker(ply)
                dmg:SetInflictor(wpn)

                local param = {}
                hook.Run("Horde_OnGodSlayerCheck", ply, param)

                if param.godslayer == true then
                    timer.Simple(0, function ()
                        local cloud = ents.Create("horde_solar_orb_fire")
                        cloud.BaseDamage = damage / 2
                        cloud:SetRadiusScale(0.66 + 0.34 * (charge_stage - 1))

                        if !IsValid(cloud) then return end

                        local vel = Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1)) * 1500

                        cloud:SetPos(tr.HitPos)
                        cloud:SetAbsVelocity(vel + wpn:GetVelocity())
                        cloud:SetOwner(ply)
                        cloud:Spawn()

                        timer.Simple(0.5 * (charge_stage), function ()
                            if cloud:IsValid() then cloud:Remove() end
                        end)
                    end)
                end
            end
        })
    end
    
    local level = ply:Horde_GetSpellUpgrade("solar_bolt")
    local bonus = {increase = 0, more = 1}
	hook.Run("Horde_OnPlayerSpellDamage", ply, bonus)
    local base_damage = math.floor(25 + 15 * math.pow(level, 1.1)) * bonus.more * (1 + bonus.increase) * 1.25

    local dir = ply:GetAimVector()
    local src = ply:GetShootPos()
    if charge_stage == 1 then
        Hitscan(base_damage, nil, dir, src, level)
    elseif charge_stage == 2 then
        Hitscan(base_damage * 1.5, nil, dir, src, level)
    elseif charge_stage == 3 then
        Hitscan(base_damage * 2.5, nil, dir, src, level)
    end

    if ply.Horde_Floating_Chaos and ply.Horde_Floating_Chaos:IsValid() then
        local pos = ply.Horde_Floating_Chaos:GetPos()
        local max_targets = 3 + ply.Horde_Floating_Chaos.Horde_Spell_Level
        local d = 1000 + (charge_stage - 1) * 250
        for _, target in pairs(ents.FindInSphere(ply.Horde_Floating_Chaos:GetPos(), d - 50)) do
            if HORDE:IsEnemy(target) and max_targets > 0 then
                local target_pos = target:GetPos() + target:OBBCenter()
                local d2 = target_pos - pos
                d2:Normalize()
                Hitscan(base_damage, nil, d2, pos)
                max_targets = max_targets - 1
            end
        end
    end
end
SPELL.Price                      = 50
SPELL.Upgrades                   = 5
SPELL.Upgrade_Description        = "Increases damage."
SPELL.Upgrade_Prices             = function (upgrade_level)
    return 550 + 50 * upgrade_level
end