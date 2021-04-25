PERK.PrintName = "Cremator Base"
PERK.Description = "The Cremator builds its offense and defense around Fire damage.\n\n85% increased Fire damage resistance.\nAttacks have 15% chance to Ignite enemies."
PERK.Params = {
    [2] = {value = 0.85, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "cremator_base" then
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "cremator_base" then
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("cremator_base")  then return end
    if dmginfo:GetDamageType() == DMG_BURN or dmginfo:GetDamageType() == DMG_SLOWBURN then
        bonus.resistance = bonus.resistance + 0.85
    end
end