PERK.PrintName = "Sniper"
PERK.Description = "{1} increased Ballistic damage while crouching."
PERK.Icon = "materials/perks/sniper.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("ghost_sniper") or not ply:Crouching() then return end
    local dmgtype = dmginfo:GetDamageType()
    if dmgtype == DMG_BULLET or dmgtype == DMG_SNIPER or dmgtype == DMG_BUCKSHOT then
        bonus.increase = bonus.increase + 0.25
    end
end
