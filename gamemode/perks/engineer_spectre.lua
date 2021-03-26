PERK.PrintName = "Spectre"
PERK.Description = "Minions leech 10% of damage dealt.\nMinions deal 15% increased damage on full health."
PERK.Icon = "materials/perks/spectre.png"

 = {}

PERK.Hooks = {}

hook.Add("Horde_ApplyAdditionalDamage", "Horde_PressurizedWarheadDamage", function (ply, npc, bonus, hitgroup)
    if not npc:GetVar("is_elite") then return end
    if not ply:Horde_GetPerk("demolition_pressurized_warhead") then return end
    bonus.increase = bonus.increase + 0.25
end)
