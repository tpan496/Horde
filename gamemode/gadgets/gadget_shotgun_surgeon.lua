GADGET.PrintName = "Shotgun Surgeon"
GADGET.Description = [[Active Gadget:
Throw a healing vial in front of you.
Healing vial restores {1} health.
Healing vial expires after {2} seconds.

Passive Effect:
Dark Energy Blast restores {3} health to you and your allies in its blast radius.
Dark Energy Blast also detonates on allies and minions.

While you have a Projection Clone active:
You and your allies restore {4} of their own maximum health per second while in your presence.]]
GADGET.Icon = "materials/perks/overlord/shotgun_surgeon.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 10},
    [2] = {value = 5},
    [3] = {value = 10},
    [4] = {value = 0.01, percent = true},
}
-- Effect is in overlord_base.lua, npc_vj_horde_overlord_projection/init.lua, and projectile_horde_hyperblast_projectile/shared.lua
GADGET.Hooks = {}
--[[
GADGET.Hooks.Horde_OnSetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_shotgun_surgeon" then return end

end

GADGET.Hooks.Horde_OnUnsetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_shotgun_surgeon" then return end

end
]]
GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_shotgun_surgeon" then return end

    local rocket = ents.Create("item_healthvial")
    local vel = 20
    local ang = ply:EyeAngles()

    local src = ply:GetPos() + Vector(0, 0, 50) + ply:GetEyeTrace().Normal * 50

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
    
    local spin = rocket:GetPhysicsObject()
    spin:AddAngleVelocity(Vector(0, -750, 0))
    
    if !rocket.NoPhys and rocket:GetPhysicsObject():IsValid() then
        rocket:SetCollisionGroup(rocket.CollisionGroup or COLLISION_GROUP_DEBRIS)
        rocket:GetPhysicsObject():SetVelocityInstantaneous(RealVelocity)
    end

    if rocket.Launch and rocket.SetState then
        rocket:SetState(1)
        rocket:Launch()
    end

    sound.Play("weapons/ar2/ar2_altfire.wav", ply:GetPos())
    
    timer.Simple(5, function()
        if not rocket:IsValid() then return end
        rocket:Remove()
    end)
end
