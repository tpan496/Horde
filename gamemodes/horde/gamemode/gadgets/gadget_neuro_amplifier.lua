GADGET.PrintName = "Neuro Amplifier"
GADGET.Description =
[[Gain 50% evasion.]]
GADGET.Icon = "items/gadgets/neuro_amplifier.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Active = false
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmg, bonus)
    if ply:Horde_GetGadget() == "gadget_neuro_amplifier" then
        bonus.evasion = bonus.evasion + 0.5
    end
end