PERK.PrintName = "Draconic Reckoning"
PERK.Description =
[[{1} more Lightning damage.
Your Fire damage also inflicts Shock.
Your Fire spells deals Lightning splash damage.]]
PERK.Icon = "materials/perks/artificer/draconic_reckoning.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("artificer_draconic_reckoning") then return end
    if HORDE:IsFireDamage(dmginfo) then
        npc:Horde_AddDebuffBuildup(HORDE.Status_Shock, dmginfo:GetDamage() * (0.1 + ply:Horde_GetPerkLevelBonus("artificer_base")), ply, dmginfo:GetDamagePosition())
    elseif HORDE:IsLightningDamage(dmginfo) then
        bonus.more = bonus.more * 1.2
    end
end

PERK.Hooks.Horde_OnDraconicCheck = function (ply, projectile)
    if not ply:Horde_GetPerk("artificer_draconic_reckoning") then return end
    projectile.Draconic = true
end