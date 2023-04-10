-- Turret spread fix
-- https://github.com/ValveSoftware/source-sdk-2013/blob/master/sp/src/game/server/hl2/npc_turret_floor.cpp
local VECTOR_CONE_10DEGREES	= Vector(87.16, 87.16, 0)
hook.Add("EntityFireBullets", "Horde_ModifyTurretBullet", function(ent, data)
    if ent:GetClass() == "npc_turret_floor" then
        data.TracerName = "Tracer"  -- less annoying tracer
        local enemy, owner = ent:GetEnemy(), ent:GetNWEntity("HordeOwner")
        if IsValid(enemy) and owner:IsPlayer() then
            data.Dir = enemy:BodyTarget(data.Src) - data.Src
            data.Spread = VECTOR_CONE_10DEGREES * GetConVar("horde_turret_spread"):GetFloat()
            data.IgnoreEntity = owner   -- Well, why not?
            --data.Damage = owner:GetMinionDamageOverride() -- Btw you can override bullet damage here too instead of modifying CTakeDamageInfo
        end
        return true
    end
end)

function VJ_AddSpeed(ent, speed)
    if ent:IsPlayer() then
        return
    end
    ent:SetMoveVelocity(ent:GetMoveVelocity() * speed)
end

function HORDE:GetAntlionMinionsCount(ply)
    local count = 0
    if not HORDE.player_drop_entities[ply:SteamID()] then return 0 end
    for id, ent in pairs(HORDE.player_drop_entities[ply:SteamID()]) do
        if ent:IsNPC() and ent:GetClass() == "npc_vj_horde_antlion" then
            count = count + 1
        end
    end
    return count
end

hook.Add("EntityTakeDamage", "ManhackContactDamage", function (target, dmginfo)
    local inflictor = dmginfo:GetInflictor()
    local ply = inflictor:GetNWEntity("HordeOwner")
    if ply:IsPlayer() and inflictor:GetClass() == "npc_manhack" then
        dmginfo:SetDamage(math.max(dmginfo:GetDamage(), inflictor:GetMaxHealth()))
        timer.Simple(0, function() if inflictor:IsValid() then
            if inflictor.Horde_Has_Antimatter_Shield then
                local effectdata = EffectData()
                effectdata:SetOrigin(inflictor:GetPos())
                util.Effect("antimatter_explosion", effectdata)
                if target:GetNWEntity("HordeOwner"):IsValid() then
                    local dd = DamageInfo()
                        dd:SetAttacker(inflictor:GetNWEntity("HordeOwner"))
                        dd:SetInflictor(inflictor:GetNWEntity("HordeOwner"))
                        dd:SetDamageType(DMG_CRUSH)
                        dd:SetDamage(inflictor.Horde_Has_Antimatter_Shield)
                    util.BlastDamageInfo(dd, inflictor:GetPos(), 200)
                end
            end
            if inflictor.Horde_Has_Void_Shield then
                local effectdata = EffectData()
                effectdata:SetOrigin(inflictor:GetPos())
                util.Effect("antimatter_explosion", effectdata)
                if target:GetNWEntity("HordeOwner"):IsValid() then
                    local dd = DamageInfo()
                        dd:SetAttacker(inflictor:GetNWEntity("HordeOwner"))
                        dd:SetInflictor(inflictor:GetNWEntity("HordeOwner"))
                        dd:SetDamageType(DMG_CRUSH)
                        dd:SetDamage(inflictor.Horde_Has_Void_Shield)
                    util.BlastDamageInfo(dd, inflictor:GetPos(), 200)
                end
            end
            inflictor:Remove() end
        end)
    end
end)

function HORDE:IsPlayerOrMinion(ent)
    return ent:IsPlayer() or ent:GetNWEntity("HordeOwner"):IsValid()
end

function HORDE:IsPlayerMinion(ent)
    return ent:GetNWEntity("HordeOwner"):IsValid()
end

function HORDE:IsEnemy(ent)
    return ent:IsNPC() and (not ent:IsPlayer()) and (not ent:GetNWEntity("HordeOwner"):IsValid())
end

function HORDE:SpawnManhack(ply, id)
    if CLIENT then return end
    if not ply:IsValid() or not ply:Alive() then return end
    local class = "npc_manhack"
    local item = HORDE.items[class]
    if ply:Horde_GetWeight() - item.weight < 0 then return end
    if not ply:Alive() then
        timer.Remove("Horde_ManhackRespawn" .. id)
        local drop_ents = ply:Horde_GetDropEntities()
        if not drop_ents then
            return
        end
        if not item.whitelist[ply:Horde_GetClass().name] then return end
        local count = drop_ents[class]
        if (!count) or (count and count <= item.entity_properties.limit) then
            timer.Create("Horde_ManhackRespawn" .. id, 4, 1, function ()
                if ply:IsValid() then
                    HORDE:SpawnManhack(ply, id)
                end
            end)
        end
    end
    if not item.whitelist[ply:Horde_GetClass().name] then return end
    local ent = ents.Create(class)
    local pos = ply:GetPos()
    local dis = VectorRand()
    dis.z = math.max(8, dis.z)
    local drop_pos = pos + dis
    ent:SetPos(drop_pos)
    ply:Horde_AddDropEntity(ent:GetClass(), ent)
    ply:Horde_AddWeight(-item.weight)
    ent:SetNWEntity("HordeOwner", ply)
    ent:Spawn()
    ent:SetMaxHealth(150)
    ply:Horde_SyncEconomy()
    -- Minions have no player collsion
    timer.Simple(0.1, function ()
        if not ent:IsValid() then return end
        ent:AddRelationship("player D_LI 99")
        ent:AddRelationship("ally D_LI 99")
        ent:AddRelationship("npc_vj_horde_vortigaunt D_LI 99")
        ent:AddRelationship("npc_vj_horde_combat_bot D_LI 99")
        ent:AddRelationship("npc_turret_floor D_LI 99")
        ent.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
    end)
    ent:SetOwner(ply)
    ent.Horde_Minion_Respawn = true
    local id = ent:GetCreationID()
    timer.Simple(0, function() ent:SetCollisionGroup(COLLISION_GROUP_WORLD) end)
    -- Count Minions
    ply:Horde_SetMinionCount(ply:Horde_GetMinionCount() + 1)
    ent:CallOnRemove("Horde_EntityRemoved", function()
        timer.Remove("Horde_ManhackRepos" .. id)
        timer.Remove("Horde_MinionCollision" .. id)
        if ent:IsValid() and ply:IsValid() then
            ply:Horde_RemoveDropEntity(ent:GetClass(), ent:GetCreationID())
            ply:Horde_SyncEconomy()
            ply:Horde_SetMinionCount(ply:Horde_GetMinionCount() - 1)
        end
        if ent.Horde_Minion_Respawn and ply:IsValid() then
            timer.Remove("Horde_ManhackRespawn" .. id)
            local drop_ents = ply:Horde_GetDropEntities()
            if not drop_ents then
                return
            end
            if not item.whitelist[ply:Horde_GetClass().name] then return end
            local count = drop_ents[class]
            if (!count) or (count and count <= item.entity_properties.limit) then
                timer.Create("Horde_ManhackRespawn" .. id, 4, 1, function ()
                    if ply:IsValid() then
                        HORDE:SpawnManhack(ply, id)
                    end
                end)
            end
        end
    end)

    -- Reset manhack position if it has been alive for too long
    timer.Create("Horde_ManhackRepos" .. id, 30, 0, function ()
        if ent:IsValid() and ply:Alive() then
            ent:SetPos(ply:GetPos() + VectorRand())
        else
            timer.Remove("Horde_ManhackRepos" .. id)
        end
    end)

    ply:Horde_SyncEconomy()
end

function HORDE:CheckDemonStompCharges(ply)
    timer.Simple(0.5, function ()
        if not ply:IsValid() or not ply:Horde_GetPerk("samurai_base") then return end
        local max_charges = 1
        if ply:Horde_GetPerk("samurai_focus_slash") then
            max_charges = max_charges + 1
        end
        if ply:Horde_GetPerk("samurai_demon_stomp") then
            max_charges = max_charges + 1
        end
        if ply:Horde_GetPerk("samurai_blade_dance") then
            max_charges = max_charges + 1
        end
        if ply:Horde_GetPerk("samurai_foresight") then
            max_charges = max_charges + 1
        end
        ply:Horde_SetPerkCharges(max_charges)
    end)
end

hook.Add("PlayerTick", "Horde_Misc", function(ply, mv)
    if !ply:IsOnGround() then return end
    local tr = util.TraceHull({
        start = ply:GetPos(),
        endpos = ply:GetPos() + Vector(0,0,-1) * 50,
        filter = ply,
        mins = Vector(-8, -8, -8),
        maxs = Vector(8, 8, 8),
    })
    if tr.Entity and HORDE:IsEnemy(tr.Entity) and tr.Entity:Health() > 0 then
        local vrand = VectorRand()
        vrand.z = 0
        vrand = vrand * 200
        ply:SetVelocity(vrand)
    end
end)

function HORDE:CreateTimer(identifier, delay, repitition, fn)
    timer.Create("Horde_" .. identifier, delay, repitition, fn)
end

function HORDE:RemoveTimer(identifier)
    timer.Remove("Horde_" .. identifier)
end

function HORDE:SendNotification(text, type, ply)
    net.Start("Horde_SideNotification")
    net.WriteString(text)
    net.WriteInt(type,2)
    if ply == nil then
        net.Broadcast()
    else
        net.Send(ply)
    end
end

function HORDE:SendNotificationDebuff(debuff, ply)
    net.Start("Horde_SideNotificationDebuff")
    net.WriteUInt(debuff, 32)
    net.Send(ply)
end

function HORDE:SendNotificationDenyAccess(ply)
    net.Start("Horde_SideNotification")
    net.WriteString("You do not have access to this command.")
    net.WriteInt(1,2)
    net.Send(ply)
end

function HORDE:SendNotificationSandboxOnly(ply)
    net.Start("Horde_SideNotification")
    net.WriteString("Command only available in sandbox mode.")
    net.WriteInt(1,2)
    net.Send(ply)
end

function HORDE:SendNotificationObjective(objective, str, ply)
    net.Start("Horde_SideNotificationObjective")
    net.WriteUInt(objective, 4)
    if str then
        net.WriteString(str)
    else
        net.WriteString("Objective")
    end
    if ply then
        net.Send(ply)
    else
        net.Broadcast()
    end
end

hook.Add("PlayerSwitchFlashlight", "Horde_BlockFlashlightForMages", function (ply, switchOn)
    if (ply:Horde_GetMaxMind() > 0) then return false end
end)

function HORDE:SimpleParticleSystem(particle_name, pos, angles, parent)
    local p = ents.Create("info_particle_system")
    p:SetKeyValue("effect_name", particle_name)
    p:SetPos(pos)
    p:SetAngles(angles)
    p:SetParent(parent)
    p:Spawn()
    p:Activate()
    p:Fire( "start", "", 0 )
    return p
end