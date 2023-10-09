GADGET.PrintName = "Projectile Launcher (Blast)"
GADGET.Description = "Shoots an explosive projectile.\nProjectile deals 100 Blast damage.\nGenerates 3 extra explosions after a short delay."
GADGET.Icon = "items/gadgets/projectile_launcher_blast.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 100},
    [2] = {value = 3},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_projectile_launcher_blast" then return end

    local rocket = ents.Create("projectile_launcher_blast_round")
    local vel = 2000
    local ang = ply:EyeAngles()

    local src = ply:GetPos() + Vector(0,0,50) + ply:GetEyeTrace().Normal * 5

    if !rocket:IsValid() then print("!!! INVALID ROUND " .. rocket) return end

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
    if !rocket.NoPhys and rocket:GetPhysicsObject():IsValid() then
        rocket:SetCollisionGroup(rocket.CollisionGroup or COLLISION_GROUP_DEBRIS)
        rocket:GetPhysicsObject():SetVelocityInstantaneous(RealVelocity)
    end

    if rocket.Launch and rocket.SetState then
        rocket:SetState(1)
        rocket:Launch()
    end

    sound.Play("weapons/physcannon/superphys_launch1.wav", ply:GetPos())
end