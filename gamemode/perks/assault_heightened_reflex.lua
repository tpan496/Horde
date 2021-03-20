PERK.PrintName = "Heightened Reflex"
PERK.Description = "15% increased headshot damage.\n20% reduced damage taken on full health."

PERK.Parameters = {}

PERK.Hooks = {}

hook.Add("Horde_ApplyAdditionalDamage", "Horde_AssaultHeightenedReflexDamage", function (ply, npc, bonus, hitgroup)
    if not hitgroup == HITGROUP_HEAD then return end
    if not ply:Horde_GetPerk("assault_heightened_reflex")  then return end
    bonus.increase = bonus.increase + 0.15
end)

hook.Add("Horde_ApplyAdditionalDamageTaken", "Horde_AssaultHeightenedReflexDamageTaken", function(ply, dmg, resistance)
    if not ply:Horde_GetPerk("assault_heightened_reflex")  then return end
    if ply:Health() == ply:GetMaxHealth() then
        resistance.resistance = resistance.resistance + 0.2
    end
end)