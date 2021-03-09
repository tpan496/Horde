AddCSLuaFile()

ENT.Type = "anim"

function ENT:Initialize()
    timer.Simple(2, function()
        if IsValid(self) then self:Arm() end
    end)
    if CLIENT then
        hook.Add("PostDrawTranslucentRenderables", self, self.DrawLaser)
        return
    end

    self:SetModel("models/weapons/w_slam.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetCollisionGroup(COLLISION_GROUP_WORLD)
    self:SetUseType(SIMPLE_USE)
    self:SetBodygroup(0, 1)
end

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "Triggered")    -- sadly desyncs sometimes without that
    --self:NetworkVar("Entity", 0, "HordeOwner")    -- cuz NWEntity "HordeOwner" blocks all incoming damage from owner >:c
end

function ENT:GetHordeOwner()    -- Actually this shouldn't be networked anyway
    return self.HordeOwner
end

function ENT:Arm()
    self.TraceStart = self:GetAttachment(self:LookupAttachment("beam_attach")).Pos
    self.TraceData = {start = self.TraceStart, endpos = self.TraceStart + self:GetUp()*200}
    self.Armed = true
end

function ENT:Think()
    if not self.Armed or self:GetTriggered() then return end
    self.TraceData.filter = player.GetAll()
    local tr = util.TraceLine(self.TraceData)
    self.TraceEnd = tr.HitPos
    if SERVER then
        local ent = tr.Entity
        if IsValid(ent) and ent:IsNPC() and not IsValid(ent:GetNWEntity("HordeOwner")) then
            self:Trigger()
        end
    end
    self:NextThink(CurTime()+0.1)
    return true
end