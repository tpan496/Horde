PERK.PrintName = "Sniper"
PERK.Description = "25% increased damage while crouching."
PERK.Icon = "materials/perks/sniper.png"

PERK.Parameters = {}

PERK.Hooks = {}

hook.Add("Horde_ApplyAdditionalDamage", "Horde_SniperDamage", function (ply, npc, bonus, hitgroup)
    if not ply:Horde_GetPerk("ghost_sniper") or not ply:Crouching() then return end
    bonus.increase = bonus.increase + 0.25
end)
