SPELL.PrintName      = "Solar Storm"
SPELL.Weapon         = {"horde_solar_seal"}
SPELL.Mind           = {5, 10, 20}

SPELL.ChargeTime     = {0, 0.5, 1}
SPELL.ChargeRelease  = nil
SPELL.Cooldown       = 1
SPELL.Slot           = HORDE.Spell_Slot_RMB
SPELL.DamageType     = {HORDE.DMG_LIGHTNING}
SPELL.Icon           = "spells/solar_storm.png"
SPELL.Type           = {HORDE.Spell_Type_Hitscan}
SPELL.Description    = [[Projects scattered lightning energy at the target. Charge for differnet effects.]]
SPELL.Fire           = function (ply, wpn, charge_stage)
    local function Hitscan(damage, spread, dir, src)
        wpn:FireBullets({
            Attacker = ply,
            Damage = damage,
            Tracer = 0,
            Distance = 800 + (charge_stage - 1) * 100,
            Dir = dir,
            Src = src,
            Spread = spread,
            IgnoreEntity = ply.Horde_Floating_Chaos,
            Callback = function(att, tr, dmg)
                dmg:SetDamageType(DMG_SHOCK)
                dmg:SetAttacker(ply)
                dmg:SetInflictor(wpn)
                local c = math.min(1, charge_stage)
                net.Start("Horde_SolarStormTracer")
                net.WriteUInt(c -1, 3)
                    net.WriteVector(src)
                    net.WriteVector(tr.HitPos)
                net.Broadcast()

                if c == 1 then
                    ply:EmitSound("horde/weapons/solar_seal/solar_storm_launch.ogg", 100, math.random(70, 90))
                    sound.Play("horde/weapons/solar_seal/solar_storm_hit.ogg", tr.HitPos, 80, math.random(70, 90))
                elseif c == 2 then
                    ply:EmitSound("horde/weapons/solar_seal/solar_storm_launch.ogg", 120, math.random(100, 120))
                    sound.Play("horde/weapons/solar_seal/solar_storm_hit.ogg", tr.HitPos, 120, math.random(100, 120))
                elseif c == 3 then
                    ply:EmitSound("horde/weapons/solar_seal/solar_storm_launch.ogg", 150, math.random(30, 50))
                    sound.Play("horde/weapons/solar_seal/solar_storm_hit.ogg", tr.HitPos, 150, math.random(30, 50))
                end

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
    
    local level = ply:Horde_GetSpellUpgrade("solar_storm")
    local bonus = {increase = 0, more = 1}
	hook.Run("Horde_OnPlayerSpellDamage", ply, bonus)
    local base_damage = math.floor((25 + 8.5 * math.pow(level, 1.1))) * bonus.more * (1 + bonus.increase)

    local dir = ply:GetAimVector()
    local src = ply:GetShootPos()
    if charge_stage == 1 then
        for i = 1, 4 do
            Hitscan(base_damage, Vector(0.25, 0.25, 0), dir, src)
        end
    elseif charge_stage == 2 then
        for i = 1, 6 do
            Hitscan(base_damage, Vector(0.15, 0.15, 0), dir, src)
        end
    elseif charge_stage == 3 then
        for i = 1, 4 do
            Hitscan(base_damage, Vector(0.05, 0.05, 0), dir, src)
            Hitscan(base_damage, Vector(0.1, 0.1, 0), dir, src)
        end
    end

    if ply.Horde_Floating_Chaos and ply.Horde_Floating_Chaos:IsValid() then
        local pos = ply.Horde_Floating_Chaos:GetPos()
        local max_targets = 5 + ply.Horde_Floating_Chaos.Horde_Spell_Level
        local d = 800 + (charge_stage - 1) * 100
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