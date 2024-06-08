AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local schdIdle = ai_schedule.New("Projection_idle")
schdIdle:AddTask("FindRandomSpot")
schdIdle:EngTask("TASK_GET_PATH_TO_LASTPOSITION", 0)
schdIdle:EngTask("TASK_FACE_PATH", 0)
schdIdle:EngTask("TASK_RUN_PATH", 0)
schdIdle:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)

local schdChase = ai_schedule.New("Projection_chase")
-- Run away randomly (first objective in task)
-- Find an enemy and run to it (second objectives in task)
schdChase:EngTask("TASK_RESET_SEQUENCE", ACT_RUN)
schdChase:AddTask("GetCloseToEnemy", { radius = 512 })
schdChase:EngTask("TASK_GET_PATH_TO_LASTPOSITION", 	0)
schdChase:EngTask("TASK_FACE_PATH", 0)
schdChase:EngTask("TASK_RUN_PATH_WITHIN_DIST", 100)
schdChase:EngTask("TASK_FACE_ENEMY", 0)

-- Shoot it (third objective in task)
local schdShoot = ai_schedule.New("Projection_shoot")
schdShoot:EngTask("TASK_RANGE_ATTACK1", 0)


local schReload = ai_schedule.New("Projection_reload")
schReload:AddTask("Reload", 0)

local function isEnemyViable(ent)
    return IsValid(ent) && !(ent:IsNPC() && ent:GetNPCState() == NPC_STATE_DEAD) && ent:Health() > 0 && !(ent:IsPlayer() && GetConVar("ai_ignoreplayers"):GetBool())
end

function ENT:CanSeeEntity(ent)
    local toent = ent:GetPos() - self:GetPos()
    toent:Normalize()

    if(toent:Dot(self:GetForward()) > -0.1) then
        return self:LOSToEntity(ent)
    end

    return false
end

function ENT:LOSToEntity(ent)
    local tr = util.TraceLine({
        start = self:EyePos(),
        endpos = ent:GetPos() + ent:OBBCenter(),
        filter = self,
    })

    local range = self.Range or 65535

    return (tr.Entity == ent || (tr.Entity:IsVehicle() && ent:IsPlayer() && ent:GetVehicle() == tr.Entity)) && range*range > ent:GetPos():DistToSqr(self:GetPos())
end

function ENT:Initialize()
    -- Some default calls to make the NPC function
    self:SetModel("models/combine_soldier.mdl")
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetSolid(SOLID_BBOX)
    self:SetMoveType(MOVETYPE_STEP)
    self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND, CAP_OPEN_DOORS, CAP_ANIMATEDFACE, CAP_SQUAD, CAP_USE_WEAPONS, CAP_DUCK,
        CAP_MOVE_SHOOT, CAP_TURN_HEAD, CAP_USE_SHOT_REGULATOR, CAP_AIM_GUN, CAP_WEAPON_RANGE_ATTACK1))
    self.LastSeenEnemyAt = Vector(0, 0, 0)
    self.SearchEnemyTime = 0
    self.SequenceTime = 0
    self.Reloading = nil
    self.CurrentSched = nil
    self.SchedElapsedTime = 0

    self:SetHealth(100)
end

function ENT:OnTakeDamage(dmg)
    self:SetHealth(self:Health() - dmg:GetDamage())
    if self:Health() <= 0 then
        self:SetNPCState(NPC_STATE_DEAD)
        self:Remove()
    end
end

function ENT:SelectSchedule()
    if not self.Reloading and self:GetActiveWeapon():IsValid() and self:GetActiveWeapon():Clip1() == 0 then
        self:StartSchedule(schReload)
        self.Reloading = true
        self.CurrentSched = "Sch_Reload"
        return
    end
        
    if(!IsValid(self:GetEnemy())) or (self:GetEnemy():Health() <= 0) then
        self:StartSchedule(schdIdle)
        self.CurrentSched = "Sch_Idle"
    else
        local enemy = self:GetEnemy()

        if(self:LOSToEntity(enemy)) and enemy:GetPos():DistToSqr(self:GetPos()) < 512*512 then
            self:StartSchedule(schdShoot)
            self.CurrentSched = "Sch_Shoot"
        else
            self:UpdateEnemyMemory(enemy, enemy:GetPos())
            self:StartSchedule(schdChase)
            self.CurrentSched = "Sch_Chase"
        end
    end
end

function ENT:TaskStart_Reload(data)    
end

function ENT:Task_Reload(data)
    self:SetActivity(ACT_RELOAD)
    timer.Simple(2, function ()
        if not IsValid(self) then return end
        self:GetActiveWeapon():SetClip1(self:GetActiveWeapon():GetMaxClip1())
        self.Reloading = nil
        self:TaskComplete()
        self:SelectSchedule()
    end)
end

function ENT:TaskStart_PLAY_ANIM(data)
    if(self.SequenceTime > CurTime()) then self:TaskComplete() return end

    self:SetNPCState(NPC_STATE_SCRIPT)
    self:DoSequence(data)
end

function ENT:Task_PLAY_ANIM(data)
    if(self.SequenceTime < CurTime()) then
        self:SetNPCState(NPC_STATE_NONE)
        self:TaskComplete()
    end
end

function ENT:TaskStart_FindRandomSpot(data)
    local vec = VectorRand() * 512 * Vector(1, 1, 0.2)
    local tr = util.TraceHull({
        start = self:EyePos(),
        endpos = self:GetPos() + vec,
        maxs = self:OBBMaxs(),
        mins = self:OBBMins(),
        filter = self
    })

    if(tr.Hit) then
        self:SetLastPosition(tr.HitPos)
    else
        self:SetLastPosition(self:GetPos() + vec)
    end

    self:TaskComplete()
end

function ENT:Task_FindRandomSpot(data)

end

function ENT:TaskStart_GetCloseToEnemy(data)
    if(!IsValid(self:GetEnemy())) then self:TaskComplete() return end
    local enemy = self:GetEnemy()
    local pos

    data = data or {}

    if(self:LOSToEntity(enemy) || enemy:GetPos():DistToSqr(self:GetPos()) < 512 * 512) then
        pos = enemy:GetPos()
    else
        pos = self.LastSeenEnemyAt
    end

    local vec = ((pos - self:GetPos()):GetNormalized() + VectorRand() * Vector(1,1,0)) * (data.radius or 512)
    local tr = util.TraceHull({
        start = pos + self:OBBCenter() + Vector(0, 0, 10),
        endpos = pos + vec,
        maxs = self:OBBMaxs(),
        mins = self:OBBMins(),
        filter = self,
        mask = MASK_NPCWORLDSTATIC
    })

    if(tr.Hit) then
        self:SetLastPosition(tr.HitPos)
    else
        self:SetLastPosition(pos - vec)
    end

    self:TaskComplete()
end

function ENT:Task_GetCloseToEnemy(data)
end

function ENT:SearchEnemy(radius)
    local potentialEnemas = ents.FindInSphere(self:GetPos(), radius)
    local nearest = radius * radius + 100
    local ent = nil
    for k, v in pairs(potentialEnemas) do
        local dist = v:GetPos():DistToSqr(self:GetPos())
        if v:IsNPC() and v:IsValid() and v:Health() > 0 and nearest > dist and v:GetClass() ~= self:GetClass() and (self:CanSeeEntity(v)) then
            if HORDE:IsPlayerOrMinion(v) then continue end
            nearest = dist
            ent = v
        end
    end

    if (IsValid(ent)) then
        self:SetEnemy(ent, false)
        return true
    end

    return false
end

function ENT:Think()
    if(IsValid(self:GetEnemy())) then
        local enemy = self:GetEnemy()
    end

    if(self.SearchEnemyTime < CurTime()) then
        self.SearchEnemyTime = CurTime() + 0.5

        if(!isEnemyViable(self:GetEnemy())) then
            self:SetEnemy(NULL)
        end
        if(self:SearchEnemy(1024) == true) then
            //self:SetNPCState(NPC_STATE_ALERT)
            if(self:LOSToEntity(self:GetEnemy())) then
                self:UpdateEnemyMemory(self:GetEnemy(), self:GetEnemy():GetPos())
                self.LastSeenEnemyAt = self:GetEnemy():GetPos()
            end
        end
    end
    if self.CurrentSched and self.CurrentSched ~= "Sch_Reload" and self.CurrentSched ~= "Sch_Shoot" then
        if self.SchedElapsedTime + 3.0 < CurTime() then
            -- What the fuck is going on
            self:ClearSchedule()
            self:SelectSchedule()
            self.SchedElapsedTime = CurTime()
        end
    end
end
