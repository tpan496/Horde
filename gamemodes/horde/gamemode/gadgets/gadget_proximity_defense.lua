GADGET.PrintName = "Proximity Defense"
GADGET.Description = "Triggers an explosion that Stuns nearby enemies."
GADGET.Icon = "items/gadgets/proximity_defense.png"
GADGET.Duration = 0
GADGET.Cooldown = 20
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_proximity_defense" then return end
    local effectdata = EffectData()
    effectdata:SetOrigin(ply:GetPos())
    util.Effect("Explosion", effectdata)
    ply:EmitSound("phx/kaboom.wav", 125, 100, 1, CHAN_AUTO)

    for _, ent in pairs(ents.FindInSphere(ply:GetPos(), 225)) do
        if ent:IsNPC() then
            ent:Horde_AddDebuffBuildup(HORDE.Status_Stun, 100, ply, ent:GetPos())
        end
    end
end