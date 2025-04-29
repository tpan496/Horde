AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2
ENT.TouchedEntities = {}
ENT.Removing = nil

ENT.Spawnable = false

function ENT:Horde_SetAuraRadius(radius)
    self.Area_of_Effect_Radius = radius or 205
    self:SetCircleRadius(radius)
end

function ENT:Initialize()
    self:SetNoDraw(true)
    self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
    if self:GetParent():IsPlayer() then
        self:SetIsDisplayingCircleRadius(1)
    end
end

function ENT:GetPlayerOwner()
    -- Get player for Think timer so multiple aura from same owner don't stack
    local ply_owner = self:GetParent().Horde_WardenAura
    if self:GetParent():GetNWEntity("HordeOwner"):IsPlayer() then
        ply_owner = self:GetParent():GetNWEntity("HordeOwner").Horde_WardenAura
    elseif self:GetParent():GetOwner():IsPlayer() then
        ply_owner = self:GetParent():GetOwner().Horde_WardenAura
    end
    return ply_owner
end

function ENT:GetPlayerParent()
    -- Get player for aura buff calculations
    local ply_parent = self:GetParent()
    if self:GetParent():GetNWEntity("HordeOwner"):IsPlayer() then
        ply_parent = self:GetParent():GetNWEntity("HordeOwner")
    elseif self:GetParent():GetOwner():IsPlayer() then
        ply_parent = self:GetParent():GetOwner()
    end
    return ply_parent
end

-- In seconds
function ENT:GetDelayInterval()
    return 1
end

function ENT:GetLingeringDuration()
    local linger = 0.1
    return linger
end

function ENT:OnEntityEnter(ent)
    if(!self:CheckCD(ent)) then return end
    local ply = self:GetPlayerParent()
    if HORDE:IsEnemy(ent) then
        -- Dank
    elseif ent:IsPlayer() then
        ent:Horde_AddWardenAuraEffects(ply)
    end
end

function ENT:OnEntityStay(ent)
    local ply = self:GetPlayerParent()
    if HORDE:IsEnemy(ent) then
        -- Dank
    elseif ent:IsPlayer() then
        ent:Horde_AddWardenAuraEffects(ply)
    end
end

function ENT:OnEntityExit(ent)
    --if(!self:CheckCD(ent)) then return end
    if HORDE:IsEnemy(ent) then
        -- Dank
    elseif ent:IsPlayer() then
        ent:Horde_RemoveWardenAuraEffects()
    end
end

function ENT:LoSCheckType(ent)
    local owner = self:GetParent()
    local sData = {
        checkmode = 2,
        originVector = owner:EyePos(),
        targetEntity = ent,
        advancedCheck = true,
        }
    return (!HORDE.IsInSight(sData))
end

ENT.Entities = {}
function ENT:CheckCD(ent)
    local ply = self:GetPlayerOwner()
    local cd = ply.Entities[ent:EntIndex()]
    if(!cd) then
        return true
    else
        return cd < CurTime()
    end
end

ENT.Entitieslingering = {}
function ENT:CheckLingeringDuration(ent)
    local ply = self:GetPlayerOwner()
    local dur = ply.Entitieslingering[ent:EntIndex()]
    if(!dur) then
        return true
    else
        return dur < CurTime()
    end
end

ENT.EntitiesInside = {}
ENT.OnEntityStayInterval = 0
function ENT:Think()
    local tick = engine.TickCount()
    local ply = self:GetPlayerOwner()
    
    local radius = self.Area_of_Effect_Radius
    for _, ent in ipairs(ents.FindInSphere(self:GetPos(), radius)) do
    if self:LoSCheckType(ent) then continue end
        if HORDE:IsEnemy(ent) or ent:IsPlayer() then
            if(!ply.EntitiesInside[ent:EntIndex()]) and self:CheckCD(ent) then
                self:OnEntityEnter(ent)
                ply.Entities[ent:EntIndex()] = CurTime() + self:GetDelayInterval()
            end
            ply.EntitiesInside[ent:EntIndex()] = tick
            if self:GetLingeringDuration() > 0 then
                ply.Entitieslingering[ent:EntIndex()] = CurTime() + self:GetLingeringDuration()
            end
            if self:CheckCD(ent) then
                ply.Entities[ent:EntIndex()] = CurTime() + self:GetDelayInterval()
                self:OnEntityStay(ent)
            end
        end
    end
    for entindex, tickcount in pairs(ply.EntitiesInside) do
        local entity = Entity(entindex)
        if(!IsValid(entity)) then
            ply.EntitiesInside[entindex] = nil
            continue
        end
        if(tickcount != tick) and self:CheckLingeringDuration(entity) then
            ply.EntitiesInside[entindex] = nil
            self:OnEntityExit(entity)
        end
    end
    for entindex, tickcount in pairs(ply.Entitieslingering) do
        local entity = Entity(entindex)
        if(!IsValid(entity)) then
            ply.Entitieslingering[entindex] = nil
            continue
        end
        if self:CheckCD(entity) and (tickcount != tick) then
            ply.Entities[entindex] = CurTime() + self:GetDelayInterval()
            self:OnEntityStay(entity)
        end
        if self:CheckLingeringDuration(entity) then
            ply.Entitieslingering[entindex] = nil
        end
    end
    for entindex, tickcount in pairs(ply.Entities) do
        local entity = Entity(entindex)
        if(!IsValid(entity)) then
            ply.Entities[entindex] = nil
        end
    end
    
    self:NextThink(CurTime())
    return true
end

--[[
function ENT:OnRemove()

end
]]



--[[-- Keep the oldge one just in case
function ENT:Initialize()
    self:PhysicsInitSphere(self.Horde_AuraRadius)
	self:SetCollisionBounds(Vector(-self.Horde_AuraRadius, -self.Horde_AuraRadius, -self.Horde_AuraRadius), Vector(self.Horde_AuraRadius, self.Horde_AuraRadius, self.Horde_AuraRadius))
    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_PLAYER)
    self:SetTrigger(true)
    self:UseTriggerBounds(true, 4)
    self:PhysWake()
    self:SetRenderMode(RENDERMODE_ENVIROMENTAL)
    self:SetColor(Color(0, 0, 0, 0))
end

function ENT:Touch(ent)
    if SERVER then
        if self.Removing then return end
        if not ent:IsPlayer() then return end
        if self.TouchedEntities[ent:GetCreationID()] and ent.Horde_WardenAuraProvider then return end
        self.TouchedEntities[ent:GetCreationID()] = ent
        ent:Horde_AddWardenAuraEffects(self:GetParent())
    end
end

function ENT:EndTouch(ent)
    if SERVER then
        if self.Removing then return end
        if not ent:IsPlayer() or not ent:IsValid() then return end
        self.TouchedEntities[ent:GetCreationID()] = nil
        ent:Horde_RemoveWardenAuraEffects()
        if ent.Horde_WardenAura then
            ent:Horde_AddWardenAura()
        end
    end
end

function ENT:OnRemove()
    self.Removing = true
    if not self.TouchedEntities then return end
    for _, ent in pairs(self.TouchedEntities) do
        ent:Horde_RemoveWardenAuraEffects()
    end
end
]]
