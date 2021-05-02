PERK.PrintName = "Firestorm"
PERK.Description = "{1} increased Fire damage.\nEnemies you killed have {2} chance to explode,\ndealing {3} Fire damage."
PERK.Icon = "materials/perks/firestorm.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
    [2] = {value = 0.25, percent = true},
    [3] = {value = 85},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("cremator_firestorm")  then return end
    if dmginfo:GetDamageType() == DMG_BURN or dmginfo:GetDamageType() == DMG_SLOWBURN then
        bonus.increase = bonus.increase + 0.20
    end
end

PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, inflictor)
    if not victim:IsValid() or not victim:IsNPC() or not killer:IsPlayer() then return end
    if not killer:Horde_GetPerk("cremator_firestorm") then return end
    if inflictor:IsNPC() then return end -- Prevent infinite chains
    local p = math.random()
    if p <= 0.25 then
        local dmginfo = DamageInfo()
        dmginfo:SetInflictor(victim)
		dmginfo:SetAttacker(killer)
		dmginfo:SetDamageType(DMG_BURN)
		dmginfo:SetDamage(100)
        util.BlastDamageInfo(dmginfo, victim:GetPos(), 150)
        local e = EffectData()
        e:SetOrigin(victim:GetPos())
        util.Effect("Explosion", e)
    end
end