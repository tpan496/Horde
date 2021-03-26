PERK.PrintName = "Sniper"
PERK.Description = "25% increased Ballistic damage while crouching."
PERK.Icon = "materials/perks/sniper.png"

PERK.Hooks = {}
PERK.Hooks.Horde_ApplyAdditionalDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("ghost_sniper") or not ply:Crouching() then return end
    if dmginfo:GetDamageType() == DMG_BULLET or dmginfo:GetDamageType() == DMG_SNIPER or dmginfo:GetDamageType() == DMG_BUCKSHOT then
        bonus.increase = bonus.increase + 0.25
    end
end
