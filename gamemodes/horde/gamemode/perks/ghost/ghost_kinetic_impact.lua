PERK.PrintName = "Kinetic Impact"
PERK.Description = "Increases Ballistic damage based on distance.\nIncreases {1} damage for each {2} units.\nIncrease caps at {3}."
PERK.Icon = "materials/perks/kinetic_impact.png"
PERK.Params = {
    [1] = {value = 0.08, percent = true},
    [2] = {value = 100},
    [3] = {value = 0.40, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("ghost_kinetic_impact") then return end
    local dmgtype = dmginfo:GetDamageType()
    if HORDE:IsBallisticDamage(dmginfo) then
        local hitPos = dmginfo:GetDamagePosition()
        local selfPos = ply:GetPos()
        local sqrDist = hitPos:DistToSqr(selfPos)
        if sqrDist < 10000 then
            return
        elseif sqrDist < 40000 then
            bonus.increase = bonus.increase + 0.08
        elseif sqrDist < 90000 then
            bonus.increase = bonus.increase + 0.16
        elseif sqrDist < 160000 then
            bonus.increase = bonus.increase + 0.24
        elseif sqrDist < 250000 then
            bonus.increase = bonus.increase + 0.32
        else
            bonus.increase = bonus.increase + 0.40
        end
    end
end
