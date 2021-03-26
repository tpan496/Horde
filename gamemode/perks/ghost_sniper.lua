PERK.PrintName = "Sniper"
PERK.Description = "25% increased damage while crouching."
PERK.Icon = "materials/perks/sniper.png"

PERK.Hooks = {}
PERK.Hooks.Horde_ApplyAdditionalDamage = function (ply, npc, bonus, hitgroup)
    if not ply:Horde_GetPerk("ghost_sniper") or not ply:Crouching() then return end
    bonus.increase = bonus.increase + 0.25
end
