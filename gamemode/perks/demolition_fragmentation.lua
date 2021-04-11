PERK.PrintName = "Fragmentation"
PERK.Description = "{1} increased Blast damage against enemies on full health."
PERK.Icon = "materials/perks/fragmentation.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("demolition_fragmentation")  then return end
    if npc:Health() == npc:GetMaxHealth() and (dmginfo:GetDamageType() == DMG_BLAST or dmginfo:IsExplosionDamage()) then
        bonus.increase = bonus.increase + 0.25
    end
end