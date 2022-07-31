PERK.PrintName = "Direct Hit"
PERK.Description = "{1} increased Blast damage against enemies close to explosions."
PERK.Icon = "materials/perks/direct_hit.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("demolition_direct_hit") then return end
    local inflictor = dmginfo:GetInflictor()
    if HORDE:IsBlastDamage(dmginfo) and inflictor then
        local npcPos = npc:GetPos()
        local inflictorPos = inflictor:GetPos()
        local sqrDist = npcPos:DistToSqr(inflictorPos)
        if sqrDist <= 6400 then
            bonus.increase = bonus.increase + 0.2
        end
    end
end