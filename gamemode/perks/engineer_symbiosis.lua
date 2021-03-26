PERK.PrintName = "Aegis"
PERK.Description = "Minions have 15% increased health.\n5% less damage taken for each minion alive."
PERK.Icon = "materials/perks/symbiosis.png"

 = {}

PERK.Hooks = {}

hook.Add("Horde_ApplyAdditionalDamage", "Horde_PressurizedWarheadDamage", function (ply, npc, bonus, hitgroup)
    if not npc:GetVar("is_elite") then return end
    if not ply:Horde_GetPerk("demolition_pressurized_warhead") then return end
    bonus.increase = bonus.increase + 0.25
end)
