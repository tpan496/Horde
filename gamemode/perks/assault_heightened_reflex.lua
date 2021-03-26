PERK.PrintName = "Heightened Reflex"
PERK.Description = "15% increased headshot damage.\n20% increased global damage resistance on full health."
PERK.Icon = "materials/perks/heightened_reflex.png"

 = {}

PERK.Hooks = {}

PERK.Hooks.Horde_ApplyAdditionalDamage = function (ply, npc, bonus, hitgroup)
    if not hitgroup == HITGROUP_HEAD then return end
    if not ply:Horde_GetPerk("assault_heightened_reflex")  then return end
    bonus.increase = bonus.increase + 0.15
end

PERK.Hooks.Horde_ApplyAdditionalDamageTaken = function(ply, dmg, resistance)
    if not ply:Horde_GetPerk("assault_heightened_reflex")  then return end
    if ply:Health() == ply:GetMaxHealth() then
        resistance.resistance = resistance.resistance + 0.2
    end
end