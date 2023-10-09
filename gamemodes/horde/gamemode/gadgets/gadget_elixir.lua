GADGET.PrintName = "Elixir"
GADGET.Description = [[Recovers 100% of your health.
Removes all status effects.]]
GADGET.Icon = "items/gadgets/elixir.png"
GADGET.Droppable = true
GADGET.Active = true
GADGET.Once = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_elixir" then return end
    sound.Play("items/medshot4.wav", ply:GetPos())
    local healinfo = HealInfo:New({amount=ply:GetMaxHealth(), healer=ply})
    HORDE:OnPlayerHeal(ply, healinfo)

    for debuff, buildup in pairs(ply.Horde_Debuff_Buildup) do
        ply:Horde_RemoveDebuff(debuff)
        ply:Horde_ReduceDebuffBuildup(debuff, buildup)
    end
end