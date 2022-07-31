PERK.PrintName = "Smokescreen"
PERK.Description = [[
Press Shift+E to deploy a smokescreen.
{1} increased evasion for players affected smokescreen.
Effect lasts for {2} seconds.]]
PERK.Icon = "materials/perks/specops/smokescreen.png"
PERK.Params = {
    [1] = {value = 0.5, percent = true},
    [2] = {value = 3},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "specops_smokescreen" then
        if ply:Horde_GetPerk("specops_peace_walker") then
            ply:Horde_SetPerkCooldown(7)
        else
            ply:Horde_SetPerkCooldown(10)
        end

        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Smokescreen, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "specops_smokescreen" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Smokescreen, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_UseActivePerk = function (ply)
    if not ply:Horde_GetPerk("specops_smokescreen") then return end

    local rocket = ents.Create("projectile_horde_smokescreen")
    local vel = 10
    local ang = ply:EyeAngles()

    local src = ply:GetPos() + Vector(0,0,50) + ply:GetEyeTrace().Normal * 5

    if !rocket:IsValid() then print("!!! INVALID ROUND " .. rocket) return end

    local rocketAng = Angle(ang.p, ang.y, ang.r)

    rocket:SetAngles(rocketAng)
    rocket:SetPos(src)

    rocket:SetOwner(ply)
    rocket.Owner = ply
    rocket.Inflictor = rocket

    local RealVelocity = ang:Forward() * vel / 0.0254
    rocket.CurVel = RealVelocity -- for non-physical projectiles that move themselves

    rocket:Spawn()
    rocket:Activate()
    if !rocket.NoPhys and rocket:GetPhysicsObject():IsValid() then
        rocket:SetCollisionGroup(rocket.CollisionGroup or COLLISION_GROUP_DEBRIS)
        rocket:GetPhysicsObject():SetVelocityInstantaneous(RealVelocity)
    end

    if rocket.Launch and rocket.SetState then
        rocket:SetState(1)
        rocket:Launch()
    end

    --sound.Play("weapons/physcannon/superphys_launch1.wav", ply:GetPos())
end
