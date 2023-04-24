PERK.PrintName = "Drain"
PERK.Description = "{1} increased headshot damage when on full health.\nRecover {2} health for each enemy you killed."
PERK.Icon = "materials/perks/drain.png"
PERK.Params = {
    [1] = {value = 0.15, percent = true},
    [2] = {value = 0.02, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
    if not killer:Horde_GetPerk("assault_drain")  then return end
    HORDE:SelfHeal(killer, killer:GetMaxHealth() * 0.02)
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup)
    if not hitgroup == HITGROUP_HEAD then return end
    if not ply:Horde_GetPerk("assault_drain")  then return end
    if ply:Health() >= ply:GetMaxHealth() then
        bonus.increase = bonus.increase + 0.15
    end
end