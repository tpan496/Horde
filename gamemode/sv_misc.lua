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

hook.Add("EntityTakeDamage", "ManhackContactDamage", function (target, dmginfo)
    local inflictor = dmginfo:GetInflictor()
    local ply = inflictor:GetNWEntity("HordeOwner")
    if ply:IsPlayer() and inflictor:GetClass() == "npc_manhack" then
        dmginfo:SetDamage(math.max(dmginfo:GetDamage(), inflictor:GetMaxHealth()))
        timer.Simple(0, function() if inflictor:IsValid() then inflictor:Remove() end end)
    end
end)

function HORDE:IsPlayerOrMinion(ent)
    return ent:IsPlayer() or ent:GetNWEntity("HordeOwner"):IsValid()
    
end

function HORDE:IsPlayerMinion(ent)
    return ent:GetNWEntity("HordeOwner"):IsValid()
end

function HORDE:SpawnManhack(ply, id)
    if CLIENT then return end
    if not ply:IsValid() then return end
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
    ent:SetMaxHealth(100)
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