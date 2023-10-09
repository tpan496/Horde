PERK.PrintName = "Heightened Reflex"
PERK.Description = "{1} increased headshot damage.\n{2} increased Global damage resistance on maximum Adrenaline."
PERK.Icon = "materials/perks/heightened_reflex.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
    [2] = {value = 0.20, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup)
    if not hitgroup == HITGROUP_HEAD then return end
    if not ply:Horde_GetPerk("assault_heightened_reflex")  then return end
    bonus.increase = bonus.increase + 0.20
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("assault_heightened_reflex")  then return end
    if ply:Horde_GetAdrenalineStack() >= ply:Horde_GetMaxAdrenalineStack() then
        bonus.resistance = bonus.resistance + 0.20
    end
end