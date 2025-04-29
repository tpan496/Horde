GADGET.PrintName = "Twinned Underbarrel"
GADGET.Description = [[Active Gadget:
Fires a Lesser Combine energy ball in front of you.

Inherits properties from Dark Energy Blast perk skill.
Deals {1} less damage if you have Dark Energy Blast perk skill.
Cooldown is fixed.]]
GADGET.Icon = "materials/perks/overlord/twinned_underbarrel.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 0.5, percent = true},
}
GADGET.Hooks = {}
--[[
GADGET.Hooks.Horde_OnSetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_twinned_underbarrel" then return end

end

GADGET.Hooks.Horde_OnUnsetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_twinned_underbarrel" then return end

end
]]
GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_twinned_underbarrel" then return end

    local rocket = ents.Create("projectile_horde_hyperblast_projectile")
    local vel = 1500
    local ang = ply:EyeAngles()

    local src = ply:GetPos() + Vector(0, 0, 50) + ply:GetEyeTrace().Normal * 5

    if !rocket:IsValid() then print("!!! INVALID ROUND " .. rocket) return end

    local rocketAng = Angle(ang.p, ang.y, ang.r)

    rocket:SetAngles(rocketAng)
    rocket:SetPos(src)

    rocket:SetOwner(ply)
    rocket.Owner = ply
    rocket.Inflictor = rocket

    rocket.Is_Twinned_Underbarrel = true

    local RealVelocity = (ply:GetAbsVelocity() or Vector(0, 0, 0)) + ang:Forward() * vel / 0.0254
    rocket.CurVel = RealVelocity -- for non-physical projectiles that move themselves

    rocket:Spawn()
    rocket:Activate()
    if !rocket.NoPhys and rocket:GetPhysicsObject():IsValid() then
        rocket:SetCollisionGroup(rocket.CollisionGroup or COLLISION_GROUP_DEBRIS)
        timer.Simple(0.1, function()
            if !rocket:IsValid() then return end
            rocket:GetPhysicsObject():SetVelocityInstantaneous(RealVelocity)
        end)
    end

    if rocket.Launch and rocket.SetState then
        rocket:SetState(1)
        rocket:Launch()
    end

    sound.Play("weapons/ar2/ar2_altfire.wav", ply:GetPos())
end
