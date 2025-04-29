PERK.PrintName = "Bestial Wrath"
PERK.Description = [[
{1} increased Critical Hit damage.
Melee weapons that don’t cleave deal {2} damage to surrounding targets.
{3} slower health decay in Frenzy Mode.]]
PERK.Icon = "materials/perks/psycho/bestial_wrath.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.25, percent = true},
    [3] = {value = 0.5, percent = true},
}
PERK.Hooks = {}
-- Frenzy Mode slower health decay in Psycho base
PERK.Hooks.Horde_OnPlayerCritical = function (ply, npc, bonus, hitgroup, dmginfo, crit_bonus)
    if ply:Horde_GetPerk("psycho_bestial_wrath") then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("psycho_bestial_wrath") then return end
    if ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon().IsHordeMelee then return end --This skill doesn't work with cleaving so return end
    if ply.Horde_In_Frenzy_Mode and (HORDE:IsMeleeDamage(dmginfo) or HORDE:IsCurrentWeapon(dmginfo, "Melee") == true) then
        --[[
        local dmg = DamageInfo()
        dmg:SetAttacker(ply)
        dmg:SetInflictor(npc)
        dmg:SetDamageType(dmginfo:GetDamageType())
        dmg:SetDamage(dmginfo:GetDamage() / 2)
        dmg:SetDamageForce(Vector(0,0,0))
        dmg:SetDamageCustom(HORDE.DMG_SPLASH)
        util.BlastDamageInfo(dmg, npc:GetPos(), 150)
        ]]
        HORDE.RadiusDamageExtra({
            attacker = ply,
            inflictor = npc,
            radius = 150,
            falloffradius = 50,
            falloff_cap = 0,
            damage = dmginfo:GetDamage() / 2,
            basedamagemul = 0,
            fallofftype = "linear",
            falloff_speed = 1,
            ignoreattacker = true,
            origin = npc:GetPos(),
            damagetype = dmginfo:GetDamageType(),
            damagecustomtype = HORDE.DMG_SPLASH,
        })
    end
end