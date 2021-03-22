PERK.PrintName = "Golem"
PERK.Description = "Minions regenerate 2% health per second.\nMinion attacks have increased knockback."

PERK.Parameters = {}

PERK.Hooks = {}

hook.Add("Horde_ApplyAdditionalDamage", "Horde_PressurizedWarheadDamage", function (ply, npc, bonus, hitgroup)
    if not npc:GetVar("is_elite") then return end
    if not ply:Horde_GetPerk("demolition_pressurized_warhead") then return end
    bonus.increase = bonus.increase + 0.25
end)
