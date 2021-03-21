PERK.PrintName = "Decapacitate"
PERK.Description = "25% increased damage against elite enemies when you have Camoflague.\n50% increased headshot damage against elite enemies when you have Camoflague."

PERK.Parameters = {}

PERK.Hooks = {}

hook.Add("Horde_ApplyAdditionalDamage", "Horde_DecapacitateDamage", function (ply, npc, bonus, hitgroup)
    if not npc:GetVar("is_elite") then return end
    if not ply:Horde_GetPerk("ghost_decapacitate") then return end
    bonus.increase = bonus.increase + 0.25
    if hitgroup == HITGROUP_HEAD then
        bonus.increase = bonus.increase + 0.50
    end
end)
