GADGET.PrintName = "E-Parasite"
GADGET.Description =
[[Projects an E-Parasite capsule that infects enemies on contact.
E-Parasite counts as a minion.
E-Parasite deals continuous damage to enemies.
You leech health from damage dealt by E-Parasite.
Enemies killed while infected by E-Parasite explode on death.]]
GADGET.Icon = "items/gadgets/e_parasite.png"
GADGET.Duration = 10
GADGET.Cooldown = 20
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_e_parasite" then return end

    local rocket = ents.Create("projectile_parasite")
    local vel = 1000
    local ang = ply:EyeAngles()

    local src = ply:GetPos() + Vector(0,0,50) + ply:GetEyeTrace().Normal * 5

    if !rocket:IsValid() then print("!!! INVALID ROUND " .. rocket) return end

    local rocketAng = Angle(ang.p, ang.y, ang.r)

    rocket:SetAngles(rocketAng)
    rocket:SetPos(src)

    rocket:SetOwner(ply)
    rocket.Owner = ply
    rocket.Inflictor = rocket

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

    sound.Play("weapons/bugbait/bugbait_squeeze1.wav", ply:GetPos())
end

GADGET.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
    if victim.Horde_Has_Parasite then
        local rad = 250
        local e = EffectData()
        e:SetOrigin(victim:GetPos())
        e:SetScale(100)
        util.Effect("parasite_explosion", e)
        local dmginfo = DamageInfo()
        dmginfo:SetAttacker(killer)
        dmginfo:SetInflictor(victim)
        dmginfo:SetDamagePosition(victim:GetPos())
        dmginfo:SetDamage(victim:GetMaxHealth() + 50)
        if killer:Horde_GetPerk("engineer_symbiosis") then
            dmginfo:ScaleDamage(1.25)
        end
        if killer:Horde_GetPerk("engineer_tinkerer") then
            dmginfo:ScaleDamage(1.25)
        end
        dmginfo:SetDamageType(DMG_CLUB)
        util.BlastDamageInfo(dmginfo, victim:GetPos(), rad)
    end
end