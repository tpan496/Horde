GADGET.PrintName = "Cleansing Shard"
GADGET.Description = "Recover {1} health.\nRemoves all status effects."
GADGET.Icon = "items/gadgets/cleansing_shard.png"
GADGET.Droppable = true
GADGET.Once = true
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 10},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_cleansing_shard" then return end
    sound.Play("items/medshot4.wav", ply:GetPos())
    local healinfo = HealInfo:New({amount=10, healer=ply})
    HORDE:OnPlayerHeal(ply, healinfo)

    for debuff, buildup in pairs(ply.Horde_Debuff_Buildup) do
        ply:Horde_RemoveDebuff(debuff)
        ply:Horde_ReduceDebuffBuildup(debuff, buildup)
    end
end