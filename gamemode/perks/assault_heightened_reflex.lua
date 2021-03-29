PERK.PrintName = "Heightened Reflex"
PERK.Description = "20% increased headshot damage.\n20% increased global damage resistance on full health."
PERK.Icon = "materials/perks/heightened_reflex.png"

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup)
    if not hitgroup == HITGROUP_HEAD then return end
    if not ply:Horde_GetPerk("assault_heightened_reflex")  then return end
    bonus.increase = bonus.increase + 0.20
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmg, bonus)
    if not ply:Horde_GetPerk("assault_heightened_reflex")  then return end
    if ply:Health() == ply:GetMaxHealth() then
        bonus.resistance = bonus.resistance + 0.20
    end
end