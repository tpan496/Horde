PERK.PrintName = "Napalm"
PERK.Description = "25% increased fire damage.\n75% reduced fire damage taken."

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.Horde_ApplyAdditionalDamage = function (ply, npc, bonus, hitgroup)
    if not ply:Horde_GetPerk("demolition_napalm")  then return end
    ply:Horde_SetDamageIncrease(DMG_FIRE, ply:Horde_GetDamageIncrease(DMG_FIRE) + 0.25)
    ply:Horde_SetDamageIncrease(DMG_BURN, ply:Horde_GetDamageIncrease(DMG_BURN) + 0.25)
end

PERK.Hooks.Horde_ApplyAdditionalDamageTaken = function (ply, dmg, resistance)
    if not ply:Horde_GetPerk("demolition_napalm")  then return end
    if dmg:GetDamageType() == DMG_FIRE or dmg:GetDamageType() == DMG_BURN then
        resistance.resistance = resistance.resistance + 0.75
    end
end