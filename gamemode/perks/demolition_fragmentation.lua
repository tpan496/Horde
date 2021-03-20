PERK.PrintName = "Fragmentation"
PERK.Description = "25% increased damage against enemies on full health."

PERK.Parameters = {}

PERK.Hooks = {}

hook.Add("Horde_ApplyAdditionalDamage", "Horde_FragmentationDamage", function (ply, npc, bonus, hitgroup)
    if not ply:Horde_GetPerk("demolition_fragmentation")  then return end
    if npc:Health() == npc:GetMaxHealth() then
        bonus.increase = bonus.increase + 0.25
    end
end)