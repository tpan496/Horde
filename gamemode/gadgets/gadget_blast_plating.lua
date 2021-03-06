GADGET.PrintName = "Blast Plating"
GADGET.Description = "20% increased Blast and Sonic damage resistance."
GADGET.Icon = "items/gadgets/blast_plating.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetGadget() ~= "gadget_blast_plating" then return end
    if dmginfo:GetDamageType() == DMG_BLAST or dmginfo:GetDamageType() == DMG_SONIC then
        bonus.resistance = bonus.resistance + 0.20
    end
end