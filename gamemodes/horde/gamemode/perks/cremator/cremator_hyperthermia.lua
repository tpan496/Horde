PERK.PrintName = "Hyperthermia"
PERK.Description = [[Increase Fire damage based on proximity to you.
Increase caps at {1}.]]
PERK.Icon = "materials/perks/hyperthermia.png"
PERK.Params = {
    [1] = {value = 0.30, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("cremator_hyperthermia") then return end
    if HORDE:IsFireDamage(dmginfo) then
        local hitPos = dmginfo:GetDamagePosition()
        local selfPos = ply:GetPos()
        local sqrDist = hitPos:DistToSqr(selfPos)
        if sqrDist < 10000 then
            bonus.increase = bonus.increase + 0.30
        elseif sqrDist < 22500 then
            bonus.increase = bonus.increase + 0.20
        elseif sqrDist < 40000 then
            bonus.increase = bonus.increase + 0.10
        end
    end
end
