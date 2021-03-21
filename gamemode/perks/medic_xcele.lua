PERK.PrintName = "Accelerated Healing Factor"
PERK.Description = "100% increased health regeneration per second.\nBuffs you apply are 100% more effective."

PERK.Parameters = {}

PERK.Hooks = {}

hook.Add("Horde_ApplyAdditionalDamage", "Horde_SniperDamage", function (ply, npc, bonus, hitgroup)
    if not ply:Horde_GetPerk("ghost_sniper") or not ply:Crouching() then return end
    bonus.increase = bonus.increase + 0.25
end)
