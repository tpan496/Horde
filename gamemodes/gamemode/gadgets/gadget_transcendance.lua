GADGET.PrintName = "Transcendance"
GADGET.Description =
[[Immune to damage.
Converts all your damage taken to Necrosis buildup.]]
GADGET.Icon = "items/gadgets/transcendance.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Active = false
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTakenPost = function (ply, dmginfo, bonus)
    if ply:Horde_GetGadget() ~= "gadget_transcendance"  then return end
    ply:Horde_AddDebuffBuildup(HORDE.Status_Necrosis, dmginfo:GetDamage() * 1.25, dmginfo:GetAttacker())
    dmginfo:SetDamage(0)
end