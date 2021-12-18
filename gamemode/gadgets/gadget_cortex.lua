GADGET.PrintName = "Cortex"
GADGET.Description = "For each enemy near you, gain 1 Adrenaline stack.\nElite enemies grant 2 stacks.\nRemoves all debuffs on you."
GADGET.Icon = "items/gadgets/cortex.png"
GADGET.Duration = 0
GADGET.Cooldown = 20
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_cortex" then return end
    sound.Play("HL1/ambience/particle_suck1.wav", ply:GetPos())
    local npcs = ents.FindInSphere(ply:GetPos(), 200)
    if not npcs then return end
    for _, ent in pairs(npcs) do
        if ent:IsNPC() and (not ent:GetNWEntity("HordeOwner"):IsPlayer()) then
            ply:Horde_AddAdrenalineStack()
            if ent:GetVar("is_elite") then ply:Horde_AddAdrenalineStack() end
        end
    end
end