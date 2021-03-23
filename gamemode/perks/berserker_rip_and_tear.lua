PERK.PrintName = "Rip and Tear"
PERK.Description = "40% more melee damage.\n10% increased damage taken."

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.Horde_ApplyAdditionalDamage = function (ply, npc, bonus, hitgroup, dmgtype)
    if not ply:Horde_GetPerk("rip_and_tear") then return end
    if dmgtype == DMG_SLASH or dmgtype == DMG_CLUB then
        bonus.more = bonus.more + 0.4
    end
end

PERK.Hooks.Horde_ApplyAdditionalDamageTaken = function (ply, dmg, resistance)
    if not ply:Horde_GetPerk("rip_and_tear") then return end
    resistance.resistance = resistance.resistance - 0.1
end