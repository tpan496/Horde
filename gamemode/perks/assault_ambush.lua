PERK.PrintName = "Ambush"
PERK.Description = "15% increased headshot damage."

PERK.Parameters = {}

PERK.Hooks = {}

hook.Add("Horde_ApplyAdditionalDamage", "Horde_AssaultAmbushDamage", function (ply, npc, bonus, hitgroup)
    if not hitgroup == HITGROUP_HEAD then return end
    if not ply:Horde_GetPerk("assault_ambush")  then return end
    bonus.increase = bonus.increase + 0.15
end)