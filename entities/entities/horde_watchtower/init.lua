AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2

function ENT:Initialize()
    self:SetModel("models/props_combine/combine_light001a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_WORLD)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:EnableGravity(true)
        phys:SetMass(10)
    end

    self.Horde_Ammobox = nil
    self.Horde_NextThink = CurTime()
    self.Horde_Owner = self:GetNWEntity("HordeOwner")
    self.Horde_ThinkInterval = 30
    self.Horde_EnableShockwave = nil
    self.Horde_NextShockWave = CurTime()
    self.Horde_ShockwaveInterval = 2
    self.Horde_WatchTower = true

    local ply = self.Horde_Owner
    if ply:Horde_GetPerk("warden_restock") then
        self.Horde_ThinkInterval = 15
    end
    
    if ply:Horde_GetPerk("warden_rejection_pulse") then
        self.Horde_EnableShockwave = true
    end
    
    if ply:Horde_GetPerk("warden_ex_machina") then
        timer.Simple(0.1, function()
            self:Horde_AddWardenAura()
        end)
    end
end

function ENT:Think()
    if self.Horde_Owner:Horde_GetCurrentSubclass() == "Overlord" then return end
    if CurTime() >= self.Horde_NextThink + self.Horde_ThinkInterval then
        if self.Horde_Ammobox and self.Horde_Ammobox:IsValid() then
            self.Horde_Ammobox:Remove()
        end
        self.Horde_Ammobox = ents.Create("horde_ammobox")
        self.Horde_Ammobox:SetPos(self:GetPos() - self:GetAngles():Forward() * 30)
        self.Horde_Ammobox:Spawn()
        if SERVER then
            if self.Horde_Owner:IsPlayer() then
                hook.Run("Horde_WardenWatchtower", self.Horde_Owner, self)
            end
        end
        self.Horde_NextThink = CurTime()
    end

    if self.Horde_EnableShockwave then
        if CurTime() >= self.Horde_NextShockWave + self.Horde_ShockwaveInterval then
            local dmg = DamageInfo()
            dmg:SetAttacker(self.Horde_Owner)
            dmg:SetInflictor(self)
            dmg:SetDamageType(DMG_SHOCK)
            dmg:SetDamage(50)
            local e = EffectData()
            e:SetOrigin(self:GetPos())
            util.Effect("explosion_shock", e, true, true)
            util.BlastDamageInfo(dmg, self:GetPos(), 160)
            self.Horde_NextShockWave = CurTime()
        end
    end
end

hook.Add("PlayerUse", "PickUpWatchtower", function(ply, ent)
    if HORDE:IsWatchTower(ent) and ent:GetNWEntity("HordeOwner"):IsValid() and ent:GetNWEntity("HordeOwner") == ply then
        if not ent.Horde_WatchtowerPickupCd then
            ent.Horde_WatchtowerPickupCd = CurTime() + 0.5
        else
            if ent.Horde_WatchtowerPickupCd > CurTime() then
                return
            else
                if ent.Horde_WatchtowerPickedUp then
                    ply:DropObject(ent)
                    ent.Horde_WatchtowerPickupCd = CurTime() + 0.5
                    ent.Horde_WatchtowerPickedUp = nil
                    return
                end
            end
        end
        
        if not ply.Horde_WatchTowers_PickedUp_Recently then
            ply.Horde_WatchTowers_PickedUp_Recently = {}
        end
        
        local p = ent:GetPos()
        p.z = ply:GetPos().z + 50
        ent:SetPos(p)
        local a = ply:GetAngles()
        ent:SetAngles(Angle(0, a.y, 0))
        
        if ply:Horde_GetPerk("warden_ex_machina") then
            local id = ent:GetCreationID()
            timer.Remove("Horde_DisplayWardenAuraCircle" .. id)
            ent.Horde_WardenAura:SetIsDisplayingCircleRadius(1)
            ply.Horde_WardenAura:SetIsDisplayingCircleRadius(0)
            ply.Horde_WatchTowers_PickedUp_Recently[ent] = true
        end
        
        ent:GetPhysicsObject():EnableMotion(true)
        ply:PickupObject(ent)
        
        ent.Horde_WatchtowerPickedUp = ply
        ent.Horde_WatchtowerPickupCd = CurTime() + 0.5
    end
end)

hook.Add("OnPlayerPhysicsDrop", "Horde_WatchTowerDrop", function (ply, ent, thrown)
    if HORDE:IsWatchTower(ent) and ent:GetNWEntity("HordeOwner"):IsValid() and ent:GetNWEntity("HordeOwner") == ply then
        local a = ent:GetAngles()
        ent:SetAngles(Angle(0, a.y, 0))
        
        ent:DropToFloor()
        HORDE:DropTurret(ent)
        
        if ply:Horde_GetPerk("warden_ex_machina") then
            local id = ent:GetCreationID()
            timer.Create("Horde_DisplayWardenAuraCircle" .. id, 4, 1, function()
                if not ply.Horde_WardenAura or not ent.Horde_WardenAura then ply.Horde_WatchTowers_PickedUp_Recently = {} return end
                ent.Horde_WardenAura:SetIsDisplayingCircleRadius(0)
                
                ply.Horde_WatchTowers_PickedUp_Recently[ent] = nil
                if next(ply.Horde_WatchTowers_PickedUp_Recently) == nil then
                    ply.Horde_WardenAura:SetIsDisplayingCircleRadius(1)
                end
                PrintTable(ply.Horde_WatchTowers_PickedUp_Recently)
            end)
        end
    end
end)
