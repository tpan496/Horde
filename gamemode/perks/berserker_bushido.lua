PERK.PrintName = "Bushido"
PERK.Description = "25% increased slashing damage.\n20% increased movement speed."

PERK.Parameters = {}

PERK.Hooks = {}

hook.Add("Horde_ApplyAdditionalDamage", "Horde_BushidoDamage", function (ply, npc, bonus, hitgroup)
    if not ply:Horde_GetPerk("berserker_bushido")  then return end
    ply:Horde_SetDamageIncrease(DMG_SLASH, ply:Horde_GetDamageIncrease(DMG_SLASH) + 0.25)
end)