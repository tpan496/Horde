local plymeta = FindMetaTable("Player")

HORDE.DMG_CALCULATED = 1
HORDE.DMG_SPLASH = 2
HORDE.DMG_FRIENDLY = 3
HORDE.DMG_PARASITE = 4

-- Player damage.
function HORDE:ApplyDamage(npc, hitgroup, dmginfo)
    if dmginfo:GetDamageCustom() > 0 then return end
    if dmginfo:GetDamage() <= 0 then return end
    if not npc:IsValid() then return end

    local attacker = dmginfo:GetAttacker()
    if not IsValid(attacker) then return end

    if attacker:GetNWEntity("HordeOwner"):IsPlayer() then
        dmginfo:SetInflictor(attacker)
        dmginfo:SetAttacker(attacker:GetNWEntity("HordeOwner"))
    end

    if IsValid(attacker:GetOwner()) and attacker:GetOwner():IsPlayer() then
        dmginfo:SetAttacker(attacker:GetOwner())
    end

    local ply = dmginfo:GetAttacker()
    if not ply:IsPlayer() then return end

    local increase = 0
    local more = 1
    local base_add = 0
    local post_add = 0

    -- Apply bonus
    local bonus = {increase=increase, more=more, base_add=base_add, post_add=post_add}
    hook.Run("Horde_OnPlayerDamage", ply, npc, bonus, hitgroup, dmginfo)
    if dmginfo:GetInflictor():GetNWEntity("HordeOwner"):IsPlayer() then
        hook.Run("Horde_OnPlayerMinionDamage", ply, npc, bonus, dmginfo)
    end

    -- DMG_BURN for some reason does not apply, convert this to something else
    if dmginfo:GetInflictor():GetClass() == "entityflame" then
        dmginfo:SetDamagePosition(npc:GetPos())
        dmginfo:SetDamage(npc:Horde_GetIgniteDamageTaken())
    else
        if dmginfo:GetDamageType() == DMG_BURN then
            dmginfo:SetDamageType(DMG_SLOWBURN)
            npc:Horde_SetMostRecentFireAttacker(ply, dmginfo)
            npc:Ignite(ply:Horde_GetApplyIgniteDuration(), ply:Horde_GetApplyIgniteRadius())
        elseif ply:Horde_GetApplyIgniteChance() > 0 then
            local ignite = math.random()
            if ignite <= ply:Horde_GetApplyIgniteChance() then
                npc:Horde_SetMostRecentFireAttacker(ply, dmginfo)
                npc:Ignite(ply:Horde_GetApplyIgniteDuration(), ply:Horde_GetApplyIgniteRadius())
            end
        end
    end

    dmginfo:AddDamage(bonus.base_add)
    dmginfo:ScaleDamage(bonus.more * (1 + bonus.increase))
    dmginfo:AddDamage(bonus.post_add)
    dmginfo:SetDamageCustom(HORDE.DMG_CALCULATED)

    -- Vortigaunt damage
    if (dmginfo:GetDamageType() == DMG_SHOCK) and dmginfo:GetInflictor():GetClass() == "npc_vortigaunt" then
        -- Splash damaage
        local dmg = DamageInfo()
        dmg:SetAttacker(dmginfo:GetAttacker())
        dmg:SetInflictor(dmginfo:GetInflictor())
        dmg:SetDamageType(DMG_PLASMA)
        dmg:SetDamage(dmginfo:GetDamage())
        dmg:SetDamageCustom(HORDE.DMG_SPLASH)
        util.BlastDamageInfo(dmg, dmginfo:GetDamagePosition(), 250)
    end

    -- Play sound
    if hitgroup == HITGROUP_HEAD then
        sound.Play("horde/player/headshot.ogg", npc:GetPos())
    end
end

hook.Add("EntityTakeDamage", "Horde_DamageRedirection", function (target, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if not target:IsNPC() then return end
    if not IsValid(attacker) then return end

    if attacker:GetNWEntity("HordeOwner"):IsPlayer() then
        dmginfo:SetInflictor(attacker)
        dmginfo:SetAttacker(attacker:GetNWEntity("HordeOwner"))
    end

    if IsValid(attacker:GetOwner()) and attacker:GetOwner():IsPlayer() then
        dmginfo:SetAttacker(attacker:GetOwner())
    end

    if target:IsNPC() and (not target:GetNWEntity("HordeOwner"):IsPlayer()) then
        if attacker:GetClass() == "entityflame" then
            if target:Horde_GetMostRecentFireAttacker() then
                dmginfo:SetAttacker(target:Horde_GetMostRecentFireAttacker())
            end
        end
        if dmginfo:GetAttacker():IsPlayer() then
            HORDE:ApplyDamage(target, HITGROUP_GENERIC, dmginfo)
        end
    end
end)

-- Seems like ScaleNPCDamage is called before EntityTakeDamage.
hook.Add("ScaleNPCDamage", "Horde_ApplyDamage", function (npc, hitgroup, dmginfo)
    HORDE:ApplyDamage(npc, hitgroup, dmginfo)
end)

-- Player damage taken
hook.Add("EntityTakeDamage", "Horde_ApplyDamageTaken", function (target, dmg)
    if not target:IsValid() or not target:IsPlayer() then return end
    local ply = target

    if dmg:GetAttacker():IsPlayer() and (dmg:GetInflictor() == dmg:GetAttacker()) then return true end

    -- Prevent damage from skill explosions (e.g. Rip and Tear, Chain Reaction, Kamikaze)
    if dmg:GetInflictor():IsNPC() and dmg:GetAttacker():IsPlayer() then return true end
    
    -- Prevent minion from damaging players
    if dmg:GetInflictor():GetNWEntity("HordeOwner"):IsPlayer() then return true end
    
    if dmg:GetDamage() <= 0.5 then return true end

    -- Apply bonus
    local bonus = {resistance=0, less=1, evasion=0, block=0}
    hook.Run("Horde_OnPlayerDamageTaken", ply, dmg, bonus)

    if bonus.evasion > 0 then
        local evade = math.random()
        if evade <= bonus.evasion then
            ply:EmitSound("horde/player/evade.ogg", 125, 100, 1, CHAN_AUTO)
            hook.Run("Horde_OnPlayerEvade", ply, dmg)
            return true
        end
    end
    if bonus.resistance >= 1.0 then return true end

    if ply.Horde_Special_Armor then
        local armor = ply.Horde_Special_Armor
        local dmgtype = dmg:GetDamageType()
        if armor == "armor_assault" then
            if HORDE:IsBallisticDamage(dmg) then
                bonus.resistance = bonus.resistance + 0.08
            end
        elseif armor == "armor_heavy" then
        elseif armor == "armor_medic" then
            if HORDE:IsPoisonDamage(dmg) then
                bonus.resistance = bonus.resistance + 0.08
            end
        elseif armor == "armor_demolition" then
            if HORDE:IsBlastDamage(dmg) then
                bonus.resistance = bonus.resistance + 0.08
            end
        elseif armor == "armor_ghost" then
            bonus.evasion = bonus.evasion + 0.05
        elseif armor == "armor_engineer" then
            bonus.resistance = bonus.resistance + 0.05
        elseif armor == "armor_warden" then
            if HORDE:IsLightningDamage(dmg) then
                bonus.resistance = bonus.resistance + 0.08
            end
        elseif armor == "armor_cremator" then
            if HORDE:IsFireDamage(dmg) then
                bonus.resistance = bonus.resistance + 0.08
            end
        elseif armor == "armor_berserker" then
            if dmgtype == DMG_SLASH or dmgtype == DMG_CLUB then
                bonus.resistance = bonus.resistance + 0.08
            end
        elseif armor == "armor_survivor" then
            bonus.resistance = bonus.resistance + 0.05
        end
    end

    dmg:ScaleDamage(bonus.less * (1 - bonus.resistance))
    dmg:SubtractDamage(bonus.block)

    if dmg:GetDamage() <= 0.5 then return true end

    bonus = {apply = 1, more = 1}
    local debuff = nil
    if dmg:GetDamage() > 0 then
        if HORDE:IsPoisonDamage(dmg) then
            debuff = HORDE.Status_Break
            bonus.more = 2
        elseif HORDE:IsFireDamage(dmg) then
            debuff = HORDE.Status_Ignite
            bonus.more = 2
        elseif HORDE:IsLightningDamage(dmg) then
            debuff = HORDE.Status_Shock
            bonus.more = 2
        elseif HORDE:IsColdDamage(dmg) then
            debuff = HORDE.Status_Frostbite
            bonus.more = 2
            local effectdata = EffectData()
                effectdata:SetOrigin(ply:GetPos() + ply:GetUp() * 50)
                effectdata:SetScale(10)
                effectdata:SetMagnitude(10)
		    util.Effect("GlassImpact", effectdata, true, true)
		    util.Effect("GlassImpact", effectdata, true, true)
        end

        if not debuff then return end
        hook.Run("Horde_OnPlayerDebuffApply", ply, debuff, bonus, dmg:GetAttacker())

        if bonus.apply == 1 then
            local buildup = dmg:GetDamage() * bonus.more
            local class = dmg:GetAttacker():GetClass()
            if class == "npc_headcrab_poison" or class == "npc_headcrab_black" then
                dmg:SetDamage(1)
                if debuff == HORDE.Status_Break then
                    buildup = ply:Health() * 2
                end
            else
                buildup = math.min(85, buildup)
            end
            ply:Horde_AddDebuffBuildup(debuff, buildup)
        end
    end
end)

hook.Add("EntityTakeDamage", "Horde_ApplyMinionDamageTaken", function (target, dmg)
    if not target:IsValid() or not target:IsNPC() then return end
    if not target:GetNWEntity("HordeOwner"):IsPlayer() then return end
    if dmg:GetAttacker():IsPlayer() and (dmg:GetInflictor() == dmg:GetAttacker()) then return true end
    hook.Run("Horde_OnMinionDamageTaken", target, dmg)
    if dmg:GetDamage() <= 0.5 then return true end
end)

-- Enemy damage.
hook.Add("EntityTakeDamage", "Horde_MutationDamage", function (target, dmg)
    if target:IsValid() and target:IsNPC() and dmg:GetInflictor():IsWorld() and dmg:GetAttacker():IsNPC() then
        return true
    end
end)

-- Main target does not take splash damage
hook.Add("EntityTakeDamage", "Horde_SplashDamage", function (target, dmg)
    if target:IsValid() and target:IsNPC() and dmg:GetInflictor() == target and dmg:GetAttacker():IsPlayer() and dmg:GetDamageCustom() == HORDE.DMG_SPLASH then
        return true
    end
end)

-- Boss headshot multiplier reduction
hook.Add("ScaleNPCDamage", "Horde_BossHeadshotDamage", function (npc, hitgroup, dmg)
    if npc:IsValid() and npc:Horde_GetBossProperties() and hitgroup == HITGROUP_HEAD then
        dmg:ScaleDamage(0.70)
    end
end)