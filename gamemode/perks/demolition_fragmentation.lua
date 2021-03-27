PERK.PrintName = "Fragmentation"
PERK.Description = "25% increased damage against enemies on full health."
PERK.Icon = "materials/perks/fragmentation.png"

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup)
    if not ply:Horde_GetPerk("demolition_fragmentation")  then return end
    if npc:Health() == npc:GetMaxHealth() then
        bonus.increase = bonus.increase + 0.25
    end
end