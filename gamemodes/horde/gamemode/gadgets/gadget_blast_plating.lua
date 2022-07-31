GADGET.PrintName = "Blast Plating"
GADGET.Description = "20% increased Blast damage resistance."
GADGET.Icon = "items/gadgets/blast_plating.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Params = {
    [1] = {value = 0.20, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if ply:Horde_GetGadget() ~= "gadget_blast_plating" then return end
    if HORDE:IsBlastDamage(dmginfo) then
        bonus.resistance = bonus.resistance + 0.20
    end
end