PERK.PrintName = "Manhack"
PERK.Description = "Your Sentries are replaced with Manhacks.\nManhack dies on impact, dealing its health as damage.\nManhack regenerates every 2 second."
PERK.Icon = "materials/perks/manhack.png"

PERK.Hooks = {}

local function SpawnManhack(ply)
    if CLIENT then return end
    if not ply:IsValid() or not ply:Horde_GetPerk("engineer_manhack") then return end
    local class = "npc_manhack"
    local drop_entities = ply:GetHordeDropEntities()
    if drop_entities[class] then
        if drop_entities[class] > 2 then
            return
        end
    end

    local ent = ents.Create(class)
    local pos = ply:GetPos()
    local drop_pos = pos + VectorRand()
    ent:SetPos(drop_pos)
    ply:Horde_AddDropEntity(ent:GetClass(), ent)
    ent:SetNWEntity("HordeOwner", ply)
    ent:Spawn()
    ent:SetMaxHealth(100)
    -- Minions have no player collsion
    ent:AddRelationship("player D_LI 99")
    ent:SetOwner(ply)
    -- Special case for turrets
    local id = ent:GetCreationID()
    ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
    timer.Create("Horde_MinionCollision" .. id, 1, 0, function ()
        if not ent:IsValid() then timer.Remove("Horde_MinionCollision" .. id) return end
        ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
    end)

    -- Count Minions
    ply:Horde_SetMinionCount(ply:Horde_GetMinionCount() + 1)
    ent:CallOnRemove("Horde_EntityRemoved", function()
        if ent:IsValid() and ply:IsValid() then
            timer.Remove("Horde_MinionCollision" .. ent:GetCreationID())
            ent:GetNWEntity("HordeOwner"):Horde_RemoveDropEntity(ent:GetClass(), ent:GetCreationID())
            ent:GetNWEntity("HordeOwner"):Horde_SyncEconomy()
            ply:Horde_SetMinionCount(ply:Horde_GetMinionCount() - 1)
        end
    end)
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "engineer_manhack" then
        local sentries = HORDE.player_drop_entities[ply:SteamID()]
        if sentries then
            for id, sentry in pairs(sentries) do
                if sentry:GetClass() == "npc_turret_floor" then
                    sentry:Remove()
                end
            end
        end
        local id = ply:SteamID()
        timer.Create("Horde_SpawnManhack" .. id, 5, 0, function()
            if not ply:IsValid() or not ply:Horde_GetPerk("engineer_manhack") then timer.Remove("Horde_SpawnManhack" .. id) return end
            SpawnManhack(ply)
        end)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "engineer_manhack" then
        if not ply:IsValid() then return end
        local manhacks = HORDE.player_drop_entities[ply:SteamID()]
        if not manhacks then return end
        for id, manhack in pairs(manhacks) do
            if manhack:GetClass() == "npc_manhack" then
                manhack:Remove()
            end
        end
        timer.Remove("Horde_SpawnManhack" .. ply:SteamID())
    end
end

PERK.Hooks.OnEntityCreated = function (ent)
    if CLIENT then return end
    timer.Simple(0, function()
        local owner = ent:GetNWEntity("HordeOwner")
        if owner:IsPlayer() and owner:Horde_GetPerk("engineer_manhack") then
            if ent:GetClass() == "npc_turret_floor" then
                ent:Remove()
            end
        end
    end)
end

PERK.Hooks.EntityTakeDamage = function (target, dmg)
    local attacker = dmg:GetAttacker()
    local inflictor = dmg:GetInflictor()
    if inflictor:GetNWEntity("HordeOwner"):IsPlayer() then
        if inflictor:GetClass() == "npc_manhack" then
            dmg:SetDamage(attacker:GetMaxHealth())
            inflictor:Remove()
        end
    end
end