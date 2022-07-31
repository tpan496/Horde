GADGET.PrintName = "Nitrous Propellor"
GADGET.Description =
[[Propells you forward and upward with a chemical explosion.]]
GADGET.Icon = "items/gadgets/nitrous_propellor.png"
GADGET.Duration = 0
GADGET.Cooldown = 8
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_nitrous_propellor" then return end
    local effectdata = EffectData()
    effectdata:SetOrigin(ply:GetPos())
    util.Effect("Explosion", effectdata)
    ply:EmitSound("phx/kaboom.wav", 125, 100, 1, CHAN_AUTO)

    local dir = 0.6 * ply:GetForward() + 0.4 * Vector(0,0,1)
    dir:Normalize()
    local vel = dir * 650
    ply:SetLocalVelocity(vel)
end