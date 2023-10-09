GADGET.PrintName = "Steroid"
GADGET.Description =
[[Amplifies your healing by 25%.]]
GADGET.Icon = "items/gadgets/steroid.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Active = false
GADGET.Params = {
    [1] = {value = 0.25, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerHeal = function(ply, healinfo)
    local healer = healinfo:GetHealer()
    if healer:IsPlayer() and healer:Horde_GetGadget() == "gadget_steroid" then
        healinfo:SetHealAmount(healinfo:GetHealAmount() * 1.25)
    end
end