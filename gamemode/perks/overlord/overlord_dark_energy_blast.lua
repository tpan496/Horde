PERK.PrintName = "Dark Energy Blast"
PERK.Description = [[+1 Fear stack.
Press SHIFT+E to fire an energy ball.
Deals damage proportional to number of Fear stacks.]]
PERK.Icon = "materials/perks/overlord/dark_energy_blast.png"

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "overlord_dark_energy_blast" then
        ply:Horde_SetPerkCooldown(10)
        ply:Horde_SetPerkInternalCooldown(0)
        net.Start("Horde_SyncActivePerk")
        net.WriteUInt(HORDE.Status_DarkEnergyBlast, 8)
        net.WriteUInt(1, 3)
        net.Send(ply)
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() + 1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "overlord_dark_energy_blast" then
        net.Start("Horde_SyncActivePerk")
        net.WriteUInt(HORDE.Status_DarkEnergyBlast, 8)
        net.WriteUInt(0, 3)
        net.Send(ply)
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() - 1)
    end
end

PERK.Hooks.Horde_UseActivePerk = function(ply)
    if not ply:Horde_GetPerk("overlord_dark_energy_blast") then return end
    local rocket = ents.Create("projectile_horde_hyperblast_projectile")
    local vel = 1500
    local ang = ply:EyeAngles()

    local src = ply:GetPos() + Vector(0, 0, 50) + ply:GetEyeTrace().Normal * 5

    if ! rocket:IsValid() then
        print("!!! INVALID ROUND " .. rocket)
        return
    end

    local rocketAng = Angle(ang.p, ang.y, ang.r)

    rocket:SetAngles(rocketAng)
    rocket:SetPos(src)

    rocket:SetOwner(ply)
    rocket.Owner = ply
    rocket.Inflictor = rocket

    rocket.Damage = 100
    rocket.BlastRadius = 150

    local RealVelocity = (ply:GetAbsVelocity() or Vector(0, 0, 0)) + ang:Forward() * vel / 0.0254
    rocket.CurVel = RealVelocity -- for non-physical projectiles that move themselves

    rocket:Spawn()
    rocket:Activate()
    if ! rocket.NoPhys and rocket:GetPhysicsObject():IsValid() then
        rocket:SetCollisionGroup(rocket.CollisionGroup or COLLISION_GROUP_DEBRIS)
        rocket:GetPhysicsObject():SetVelocityInstantaneous(RealVelocity)
    end

    if rocket.Launch and rocket.SetState then
        rocket:SetState(1)
        rocket:Launch()
    end

    sound.Play("weapons/ar2/ar2_altfire.wav", ply:GetPos())
end
