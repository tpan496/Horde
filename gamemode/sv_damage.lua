local plymeta = FindMetaTable("Player")

-- Player damage.
hook.Add("ScaleNPCDamage", "Horde_ApplyDamage", function (npc, hitgroup, dmginfo)
    local ply = dmginfo:GetAttacker()
    if not npc:IsValid() or not ply:IsPlayer() then return end

    local increase = 0
    local more = 1

    -- Apply bonus
    local bonus = {increase=increase, more=more}
    hook.Run("Horde_OnPlayerDamage", ply, npc, bonus, hitgroup, dmginfo:GetDamageType())
    
    dmginfo:ScaleDamage(bonus.more * (1 + bonus.increase))
end)

-- Redirect Minion damage
hook.Add("EntityTakeDamage", "Horde_MinionDamage", function (target, dmginfo)
    if target:IsNPC() and dmginfo:GetAttacker():GetNWEntity("HordeOwner"):IsPlayer() then
        dmginfo:SetInflictor(dmginfo:GetAttacker())
        dmginfo:SetAttacker(dmginfo:GetAttacker():GetNWEntity("HordeOwner"))
    end
end)

-- Player damage taken
hook.Add("EntityTakeDamage", "Horde_ApplyDamageTaken", function (target, dmg)
    if not target:IsValid() or not target:IsPlayer() then return end
    local ply = target

    -- Prevent damage from skill explosions (e.g. Chain Reaction, Kamikaze)
    if dmg:GetInflictor():IsNPC() and dmg:GetAttacker():IsPlayer() then return true end
    
    -- Prevent minion from damaging players
    if dmg:GetAttacker():GetNWEntity("HordeOwner"):IsPlayer() then return true end

    -- Apply bonus
    local bonus = {resistance=0, reduce=1, evasion=0}
    hook.Run("Horde_OnPlayerDamageTaken", ply, dmg, bonus)

    if bonus.evasion > 0 then
        local evade = math.random()
        if evade <= bonus.evasion then
            sound.Play("horde/player/evade.mp3", ply:GetPos())
            hook.Run("Horde_OnPlayerEvade", ply, dmg)
            return true
        end
    end

    dmg:ScaleDamage(bonus.reduce * (1 - bonus.resistance))
end)

-- Enemy damage.
hook.Add("EntityTakeDamage", "Horde_MutationDamage", function (target, dmg)
    if target:IsValid() and target:IsNPC() and dmg:GetInflictor():IsNPC() and dmg:GetAttacker():IsNPC() then
        if target:GetNWEntity("HordeOwner"):IsPlayer() or dmg:GetInflictor():GetNWEntity("HordeOwner"):IsPlayer() then return end
        return true
    end
end)

-- Hulk hitbox fix
hook.Add("ScaleNPCDamage", "Horde_HulkDamage", function (npc, hitgroup, dmg)
    if npc:IsValid() and npc:GetClass() == "npc_vj_zss_zhulk" then
        if hitgroup == HITGROUP_GENERIC then
            dmg:ScaleDamage(1.5)
        end
    end
end)

-- Hulk hitbox fix
hook.Add("ScaleNPCDamage", "Horde_MutatedHulkDamage", function (npc, hitgroup, dmg)
    if npc:IsValid() and npc:GetClass() == "npc_vj_mutated_hulk" then
        if hitgroup == HITGROUP_GENERIC then
            dmg:ScaleDamage(1.5)
        end
    end
end)

-- Gonome headshot multiplier reduction
hook.Add("ScaleNPCDamage", "Horde_GonomeDamage", function (npc, hitgroup, dmg)
    if npc:IsValid() and npc:GetClass() == "npc_vj_alpha_gonome" then
        if hitgroup == HITGROUP_HEAD then
            dmg:ScaleDamage(0.5)
        end
    end
end)