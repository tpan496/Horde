PERK.PrintName = "Savagery"
PERK.Description = "25% increased blunt damage.\n20% increased maximum health."
PERK.Icon = "materials/perks/savagery.png"

PERK.Parameters = {}

PERK.Hooks = {}

-- TODO: Hardcoded for now, since zerker only has 1 health skill this is fine.
PERK.Hooks.Horde_OnSetPerk = function(ply, perk, params)
    if SERVER and perk == "berserker_savagery" then
        ply:SetMaxHealth(120)
        ply:SetHealth(120)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk, params)
    if SERVER and perk == "berserker_savagery" then
        ply:SetMaxHealth(100)
        ply:SetHealth(100)
    end
end

PERK.Hooks.Horde_ApplyAdditionalDamage = function (ply, npc, bonus, hitgroup, dmgtype)
    if not ply:Horde_GetPerk("berserker_savagery")  then return end
    if dmgtype == DMG_CLUB then
        bonus.increase = bonus.increase + 0.25
    end
end