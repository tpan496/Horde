PERK.PrintName = "Savagery"
PERK.Description = "25% increased blunt damage.\n20% increased maximum health."

PERK.Parameters = {}

PERK.Hooks = {}

hook.Add("Horde_ApplyAdditionalDamage", "Horde_SavageryDamage", function (ply, npc, bonus, hitgroup)
    if not ply:Horde_GetPerk("berserker_savagery")  then return end
    ply:Horde_SetDamageIncrease(DMG_CLUB, ply:Horde_GetDamageIncrease(DMG_CLUB) + 0.25)
end)