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

function HORDE:SpawnManhack(ply)
    if CLIENT then return end
    if not ply:IsValid() then return end
    local class = "npc_manhack"
    local item = HORDE.items[class]
    if not item.whitelist[ply:Horde_GetClass().name] then return end
    local ent = ents.Create(class)
    local pos = ply:GetPos()
    local dis = VectorRand()
    dis.z = math.max(8, dis.z)
    local drop_pos = pos + dis
    ent:SetPos(drop_pos)
    ply:Horde_AddDropEntity(ent:GetClass(), ent)
    ent:SetNWEntity("HordeOwner", ply)
    ent:Spawn()
    ent:SetMaxHealth(100)
    -- Minions have no player collsion
    timer.Simple(0.1, function ()
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
            if ent.Horde_Minion_Respawn then
                ply:Horde_RemoveManhackEntity(ent:GetClass(), ent:GetCreationID())
            else
                ply:Horde_RemoveDropEntity(ent:GetClass(), ent:GetCreationID())
            end
            ply:Horde_SyncEconomy()
            ply:Horde_SetMinionCount(ply:Horde_GetMinionCount() - 1)
        end
        if ent.Horde_Minion_Respawn then
            timer.Remove("Horde_ManhackRespawn" .. id)
            local drop_ents = ply:Horde_GetDropEntities()
            if not drop_pos then
                return
            end
            if not item.whitelist[ply:Horde_GetClass().name] then return end
            local count = drop_ents[class]
            if (!count) or (count and count <= item.entity_properties.limit) then
                timer.Create("Horde_ManhackRespawn" .. id, 4, 1, function ()
                    if ply:IsValid() and ply:Alive() then
                        HORDE:SpawnManhack(ply)
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
            if ent:IsValid() then ent:Remove() end
        end
    end)

    ply:Horde_SyncEconomy()
end

local plymeta = FindMetaTable("Player")

function plymeta:Horde_RemoveManhackEntity(class, entity_creation_id)
    if not self:IsValid() then return end
    if self.Horde_drop_entities and self.Horde_drop_entities[class] then
        self.Horde_drop_entities[class] = self.Horde_drop_entities[class] - 1
        if self.Horde_drop_entities[class] == 0 then
            self.Horde_drop_entities[class] = nil
        end
    end
    if HORDE.player_drop_entities[self:SteamID()] then
        HORDE.player_drop_entities[self:SteamID()][entity_creation_id] = nil
    end
end