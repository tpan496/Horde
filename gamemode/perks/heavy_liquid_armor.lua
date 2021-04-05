PERK.PrintName = "Liquid Armor"
PERK.Description = "While you have at least 5 armor:\n  75% increasaed Physical damage resistance."
PERK.Icon = "materials/perks/liquid_armor.png"

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("heavy_liquid_armor") then return end
    local dmgtype = dmginfo:GetDamageType()
    if ply:Armor() >= 5 and (dmgtype == DMG_BULLET or dmgtype == DMG_SLASH or dmgtype == DMG_CLUB or dmgtype == DMG_GENERIC or dmgtype == DMG_CRUSH or dmgtype == DMG_BUCKSHOT) then
        bonus.resistance = bonus.resistance + 0.75
    end
end
