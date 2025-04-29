PERK.PrintName = "Rip and Tear"
PERK.Description = [[
{1} more melee damage.
Melee weapons that don’t cleave deal {2} damage to surrounding targets.]]

PERK.Icon = "materials/perks/rip_and_tear.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.25, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("berserker_rip_and_tear") then return end
    if HORDE:IsMeleeDamage(dmginfo) or HORDE:IsCurrentWeapon(dmginfo, "Melee") == true then
        bonus.more = bonus.more * 1.25
    end
end

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("berserker_rip_and_tear") then return end
    if ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon().IsHordeMelee then return end --This skill doesn't work with cleaving so return end
    if (HORDE:IsMeleeDamage(dmginfo) or HORDE:IsCurrentWeapon(dmginfo, "Melee") == true) and not ply.Horde_In_Flash then
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