PERK.PrintName = "Berserker Base"
PERK.Description = "The Berserker is a melee-centered class that can be played both offensively and defensively.\nComplexity: HIGH\n\n{1} increased Global damage resistance.\n{2} increased Slashing and Blunt damage."
PERK.Params = {
    [1] = {value = 0.20, percent = true},
    [2] = {value = 0.15, percent = true},
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
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("berserker_base") then return end
    if HORDE:IsSlashDamage(dmginfo) or HORDE:IsBluntDamage(dmginfo) then
        bonus.increase = bonus.increase + 0.15
    end
end