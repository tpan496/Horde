GADGET.PrintName = "IV Injection"
GADGET.Description = "Recover 25 health."
GADGET.Icon = "items/gadgets/iv_injection.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_iv_injection" then return end
    sound.Play("horde/gadgets/injection.ogg", ply:GetPos())
    sound.Play("items/medshot4.wav", ply:GetPos())
    local healinfo = HealInfo:New({amount=25, healer=ply})
    HORDE:OnPlayerHeal(ply, healinfo)
end