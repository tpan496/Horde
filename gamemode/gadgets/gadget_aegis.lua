GADGET.PrintName = "Aegis"
GADGET.Description =
[[Aegis Modular Immunization System.
Use the active ability to switch between modes.
Your healing grants additional effects based on Aegis modes.
Biological Aegis provides Poison damage immunity.]]
GADGET.Icon = "items/gadgets/aerial_guard.png"
GADGET.Duration = 0
GADGET.Cooldown = 2
GADGET.Active = false
GADGET.Params = {
    [1] = {value = 0.5},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
end