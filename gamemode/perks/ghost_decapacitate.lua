PERK.PrintName = "Decapacitate"
PERK.Description = "When you have Camoflague:\n  25% increased damage against elites.\n  50% increased headshot damage against elites."
PERK.Icon = "materials/perks/decapacitate.png"

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.Horde_ApplyAdditionalDamage = function (ply, npc, bonus, hitgroup)
    if not npc:GetVar("is_elite") then return end
    if not ply:Horde_GetPerk("ghost_decapacitate") then return end
    bonus.increase = bonus.increase + 0.25
    if hitgroup == HITGROUP_HEAD then
        bonus.increase = bonus.increase + 0.50
    end
end
