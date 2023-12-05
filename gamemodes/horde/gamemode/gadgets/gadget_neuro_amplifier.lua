GADGET.PrintName = "Neuro Amplifier"
GADGET.Description =
[[Gain 6% evasion per Adrenaline stack.]]
GADGET.Icon = "items/gadgets/neuro_amplifier.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Active = false
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmg, bonus)
    if SERVER and ply:Horde_GetAdrenalineStack() > 0 and ply:Horde_GetGadget() == "gadget_neuro_amplifier" then
        bonus.evasion = bonus.evasion + ply:Horde_GetAdrenalineStack() * 0.06
    end
end
