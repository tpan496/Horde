GADGET.PrintName = "Assassin Optics"
GADGET.Description =
[[Increases your next Ballistic damage by 25%.
The effect expires after damaging the enemy.]]
GADGET.Icon = "items/gadgets/assassin_optics.png"
GADGET.Duration = 0
GADGET.Cooldown = 3
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 0.25, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_assassin_optics" then return end
    ply:Horde_SyncStatus(HORDE.Status_Assassin_Optics, 1)
    ply.Horde_Has_Assassin_Optics = true
end

GADGET.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply.Horde_Has_Assassin_Optics and HORDE:IsBallisticDamage(dmginfo) then
        bonus.increase = bonus.increase + 0.25
        ply.Horde_Has_Assassin_Optics = nil
        ply:Horde_SyncStatus(HORDE.Status_Assassin_Optics, 0)
    end
end
