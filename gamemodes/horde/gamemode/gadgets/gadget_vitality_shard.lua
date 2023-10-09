GADGET.PrintName = "Vitality Shard"
GADGET.Description = "Recover {1} health."
GADGET.Icon = "items/gadgets/vitality_shard.png"
GADGET.Droppable = true
GADGET.Once = true
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 25},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_vitality_shard" then return end
    sound.Play("items/medshot4.wav", ply:GetPos())
    local healinfo = HealInfo:New({amount=25, healer=ply})
    HORDE:OnPlayerHeal(ply, healinfo)
end