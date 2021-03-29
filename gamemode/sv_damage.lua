local plymeta = FindMetaTable("Player")

-- Player damage.
hook.Add("EntityTakeDamage", "Horde_MinionDamageRedirection", function (target, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if attacker:GetNWEntity("HordeOwner"):IsPlayer() then
        dmginfo:SetInflictor(attacker)
        dmginfo:SetAttacker(attacker:GetNWEntity("HordeOwner"))
    end
end)

hook.Add("ScaleNPCDamage", "Horde_ApplyDamage", function (npc, hitgroup, dmginfo)
    if not npc:IsValid() then return end

    local attacker = dmginfo:GetAttacker()
    if attacker:GetNWEntity("HordeOwner"):IsPlayer() then
        dmginfo:SetInflictor(attacker)
        dmginfo:SetAttacker(attacker:GetNWEntity("HordeOwner"))
    end

    local ply = dmginfo:GetAttacker()
    if not ply:IsPlayer() then return end

    local increase = 0
    local more = 1

    -- Apply bonus
    local bonus = {increase=increase, more=more}
    hook.Run("Horde_OnPlayerDamage", ply, npc, bonus, hitgroup, dmginfo)
    if dmginfo:GetInflictor():GetNWEntity("HordeOwner"):IsPlayer() then
        hook.Run("Horde_OnPlayerMinionDamage", ply, npc, bonus, dmginfo)
    end

    dmginfo:ScaleDamage(bonus.more * (1 + bonus.increase))
end)

-- Player damage taken
hook.Add("EntityTakeDamage", "Horde_ApplyDamageTaken", function (target, dmg)
    if not target:IsValid() or not target:IsPlayer() then return end
    local ply = target

    -- Prevent damage from skill explosions (e.g. Chain Reaction, Kamikaze)
    if dmg:GetInflictor():IsNPC() and dmg:GetAttacker():IsPlayer() then return true end
    
    -- Prevent minion from damaging players
    if dmg:GetInflictor():GetNWEntity("HordeOwner"):IsPlayer() then return true end

    -- Apply bonus
    local bonus = {resistance=0, reduce=1, evasion=0}
    hook.Run("Horde_OnPlayerDamageTaken", ply, dmg, bonus)

    if bonus.evasion > 0 then
        local evade = math.random()
        if evade <= bonus.evasion then
            sound.Play("horde/player/evade.ogg", ply:GetPos())
            hook.Run("Horde_OnPlayerEvade", ply, dmg)
            return true
        end
    end

    dmg:ScaleDamage(bonus.reduce * (1 - bonus.resistance))
end)

-- Enemy damage.
hook.Add("EntityTakeDamage", "Horde_MutationDamage", function (target, dmg)
    if target:IsValid() and target:IsNPC() and dmg:GetInflictor():IsWorld() and dmg:GetAttacker():IsNPC() then
        return true
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