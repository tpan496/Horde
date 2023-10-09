PERK.PrintName = "Sniper"
PERK.Description = "{1} increased Ballistic damage while crouching."
PERK.Icon = "materials/perks/sniper.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("ghost_sniper") or not ply:Crouching() then return end
    local dmgtype = dmginfo:GetDamageType()
    if HORDE:IsBallisticDamage(dmginfo) then
        bonus.increase = bonus.increase + 0.25
    end
end
