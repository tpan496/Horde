GADGET.PrintName = "Reinforcements"
GADGET.Description = [[Active Gadget:
Summons a lesser Projection Clone with a pump shotgun.

Inherits properties from Juxtaposition perk skill.
Lesser Projection Clone has {1} less health.]]
GADGET.Icon = "materials/perks/overlord/reinforcements.png"
GADGET.Duration = 15
GADGET.Cooldown = 15
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 0.5, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if not SERVER then return end
    if ply:Horde_GetGadget() ~= "gadget_reinforcements" then return end
    if IsValid(ply.Horde_overlord_reinforcements) then return true end
    
    sound.Play("horde/player/overlord/projection.mp3", ply:GetPos(), 100, math.random(80, 120))
    
    ply.Horde_overlord_reinforcements = ents.Create("npc_vj_horde_overlord_projection")
    ply.Horde_overlord_reinforcements:SetPos(ply:GetPos() + ply:GetRight() * -45 + ply:GetForward() * 45 + Vector(0, 0, 20))
    ply.Horde_overlord_reinforcements:SetAngles(ply:GetAngles())
    ply.Horde_overlord_reinforcements:SetNWEntity("HordeOwner", ply)
    ply.Horde_overlord_reinforcements:SetOwner(ply)
    ply.Horde_overlord_reinforcements.Is_Reinforcements = true
    ply.Horde_overlord_reinforcements:Spawn()
end
