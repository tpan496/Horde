PERK.PrintName = "Drain"
PERK.Description = "{1} increased headshot damage when on full health.\nRecover {2} health for each enemy you killed."
PERK.Icon = "materials/perks/drain.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
    [2] = {value = 0.02, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.OnNPCKilled = function(victim, killer, wpn)
    if not killer:IsPlayer() or not killer:Horde_GetPerk("assault_drain")  then return end
    if not victim:IsValid() or not victim:IsNPC() or not killer:IsPlayer() then return end
    killer:SetHealth(math.min(killer:GetMaxHealth(), killer:Health() + killer:GetMaxHealth() * 0.02))
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup)
    if not hitgroup == HITGROUP_HEAD then return end
    if not ply:Horde_GetPerk("assault_drain")  then return end
    if ply:Health() >= ply:GetMaxHealth() then
        bonus.increase = bonus.increase + 0.15
    end
end