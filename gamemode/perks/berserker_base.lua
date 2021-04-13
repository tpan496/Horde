PERK.PrintName = "Berserker Base"
PERK.Description = "The Berserker class is a melee-centered class that can be played both offensively and defensively.\nComplexity: HIGH\n\n{1} increased Global damage resistance.\n{2} increased Poison damage resistance."
PERK.Params = {
    [1] = {value = 0.20, percent = true},
    [2] = {value = 0.25, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "berserker_base" then
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "berserker_base" then
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("berserker_base")  then return end
    bonus.resistance = bonus.resistance + 0.20
    if dmginfo:GetDamageType() == DMG_POISON or dmginfo:GetDamageType() == DMG_ACID or dmginfo:GetDamageType() == DMG_NERVEGAS then
        bonus.resistance = bonus.resistance + 0.25
    end
end