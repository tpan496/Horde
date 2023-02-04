GADGET.PrintName = "Quantum Tunnel"
GADGET.Description = "Allows you to quickly travel to your targeted minion's location."
GADGET.Icon = "items/gadgets/quantum_tunnel.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Params = {
}
GADGET.Hooks = {}
GADGET.Active = true

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_quantum_tunnel" then return end

    local ent = util.TraceLine(util.GetPlayerTrace(ply)).Entity

    if ent:IsValid() and not ent:IsWorld() then
        if ent:GetPos():DistToSqr(ply:GetPos()) > 250000 then
            return true
        end
        local owner = ent:GetNWEntity("HordeOwner")
        if owner:IsValid() and owner == ply then
            ply:SetPos(ent:GetPos())
        else
            return true
        end
    end

    sound.Play("weapons/physcannon/physcannon_drop.wav", ply:GetPos())
end