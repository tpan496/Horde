PERK.PrintName = "Direct Hit"
PERK.Description = [[{1} increased Blast damage against enemies close to explosions.
{2} increased Blunt damage.]]
PERK.Icon = "materials/perks/direct_hit.png"
PERK.Params = {
    [1] = {value = 0.2, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("demolition_direct_hit") then return end
    local inflictor = dmginfo:GetInflictor()
    if inflictor:IsPlayer() then return end
    if HORDE:IsBlastDamage(dmginfo) and inflictor then
        if hitgroup == HITGROUP_HEAD then
            bonus.increase = bonus.increase + 0.2
            return
        end
        local inflictorPos = dmginfo:GetDamagePosition()
        local vel = npc:GetPos() + npc:OBBCenter() - inflictorPos
        vel:Normalize()
        local tr = util.TraceLine( {
            start = inflictorPos,
            endpos = inflictorPos + vel * 70,
            filter = inflictor,
            mask = MASK_SHOT_HULL,
        })
        if !tr.Hit then return end

        if tr.HitPos:DistToSqr(inflictorPos) <= 4900 then
            bonus.increase = bonus.increase + 0.2
        end
    elseif HORDE:IsBluntDamage(dmginfo) then
        bonus.increase = bonus.increase + 0.2
    end
end