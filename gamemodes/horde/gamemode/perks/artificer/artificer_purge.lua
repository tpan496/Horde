PERK.PrintName = "Purge"
PERK.Description =
[[{1} increased Shock buildup.
{2} increased headshot damage.]]
PERK.Icon = "materials/perks/artificer/purge.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
    [2] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("artificer_purge") then return end
    if hitgroup == HITGROUP_HEAD then
        bonus.increase = bonus.increase + 0.2
    end
end

PERK.Hooks.Horde_OnEnemyDebuffApply = function (npc, debuff, bonus, inflictor)
    if debuff == HORDE.Status_Shock and inflictor:Horde_GetPerk("artificer_purge") then
        bonus.increase = bonus.increase + 0.2
    end
end
