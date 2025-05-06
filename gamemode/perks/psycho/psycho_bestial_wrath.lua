PERK.PrintName = "Bestial Wrath"
PERK.Description = [[
{1} increased Critical Hit damage.
Melee hits deal {2} damage to surrounding targets.
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
            damage = dmginfo:GetDamage() / 4,
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

---------------- For cleaving weapons below ------------------
-- Splash damage now scales with damage increases
PERK.Hooks.Hook_PostBash = function (wep, info)
    if not SERVER then return end
    local ply = info.ply
    if not ply:Horde_GetPerk("psycho_bestial_wrath") then return end
    if not ply:IsValid() then return end
    if wep.splash_dmg_check == nil then return end
    local enemy_tr = info.tr.Entity
    local cleave = info.cleave
    local headshot = info.tr.HitGroup
    local dmg_type = info.dmgtype
    local splash_dmg = wep.splash_dmg_check * 0.25
    if cleave[1] ~= nil then
        for _, entities in ipairs(cleave) do
            entities.donthitmeagain = true
            local id = entities:GetCreationID()
            timer.Remove("Horde_donthitmeagain" .. id)
            timer.Create("Horde_donthitmeagain" .. id, 1, 1, function()
                --if not ent:IsValid() then return end
                entities.donthitmeagain = nil
            end)
            
            local ent = ents.Create("horde_splash_melee") 
            ent:SetPos(entities:GetPos())
            ent:SetOwner(ply)
            ent.Owner = ply
            ent.splash_dmg = splash_dmg
            ent. dmg_type = dmg_type
            ent:Spawn()
            ent:Activate()
        end
    end
end
