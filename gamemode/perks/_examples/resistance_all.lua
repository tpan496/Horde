PERK.PrintName = "Tough (resistance)"
PERK.Description = "10% increased Global damage resistance."

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmg, bonus)
    if not ply:Horde_GetPerk("resistance_all") then return end
    bonus.resistance = bonus.resistance + 0.1
end