GADGET.PrintName = "Hydrogen Burner"
GADGET.Description = "Blue flame.\n25% more Fire damage.\nYour Fire damage no longer Ignites."
GADGET.Icon = "items/gadgets/hydrogen_burner.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Active = nil
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetGadget() ~= "gadget_hydrogen_burner" then return end
    if HORDE:IsFireDamage(dmginfo) then
        bonus.more = bonus.more * 1.25
    end
end
