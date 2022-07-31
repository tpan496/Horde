PERK.PrintName = "Manhack"
PERK.Description = "Your have Manhacks instead of Turrets.\nManhack dies on impact and regenerates automatically.\nManhack deals its health as damage."
PERK.Icon = "materials/perks/manhack.png"

PERK.Hooks = {}

local function SpawnManhack(ply)
    if CLIENT then return end
    if not ply:IsValid() or not ply:Horde_GetPerk("engineer_manhack") then return end
    local class = "npc_manhack"
    local drop_entities = ply:Horde_GetDropEntities()
    if drop_entities[class] then
        if drop_entities[class] > 2 then
            return
        end
    end

    local ent = ents.Create(class)
    local pos = ply:GetPos()
    local dis = VectorRand()
    dis.z = math.max(8, dis.z)
    local drop_pos = pos + dis
    ent:SetPos(drop_pos)
    ply:Horde_AddDropEntity(ent:GetClass(), ent)
    ent:SetNWEntity("HordeOwner", ply)
    ent:Spawn()
    ent:SetMaxHealth(150)
    -- Minions have no player collsion
    ent:AddRelationship("player D_LI 99")
    ent:SetOwner(ply)
    -- Special case for turrets
    local id = ent:GetCreationID()
    timer.Simple(0, function() ent:SetCollisionGroup(COLLISION_GROUP_WORLD) end)

    -- Count Minions
    ply:Horde_SetMinionCount(ply:Horde_GetMinionCount() + 1)
    ent:CallOnRemove("Horde_EntityRemoved", function()
        timer.Remove("Horde_ManhackRepos" .. id)
        if ent:IsValid() and ply:IsValid() then
            ent:GetNWEntity("HordeOwner"):Horde_RemoveDropEntity(ent:GetClass(), ent:GetCreationID())
            ent:GetNWEntity("HordeOwner"):Horde_SyncEconomy()
            ply:Horde_SetMinionCount(ply:Horde_GetMinionCount() - 1)
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
        timer.Create("Horde_SpawnManhack" .. id, 4, 0, function()
            if not ply:IsValid() or not ply:Horde_GetPerk("engineer_manhack") then timer.Remove("Horde_SpawnManhack" .. id) return end
            if ply:Alive() then
                SpawnManhack(ply)
            end
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
            if ent:GetClass() == "npc_turret_floor" and (not ent.Horde_Is_Mini_Sentry) then
                ent:Remove()
            end
        end
    end)
end

PERK.Hooks.EntityTakeDamage = function (target, dmginfo)
    local inflictor = dmginfo:GetInflictor()
    local ply = inflictor:GetNWEntity("HordeOwner")
    if ply:IsPlayer() and ply:Horde_GetPerk("engineer_manhack") and inflictor:GetClass() == "npc_manhack" then
        dmginfo:SetDamage(math.max(dmginfo:GetDamage(), inflictor:GetMaxHealth()))
        timer.Simple(0, function() if inflictor:IsValid() then inflictor:Remove() end end)
    end
end