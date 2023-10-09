AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/horde/rocket_turret/rocket_turret.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 400
ENT.SightDistance = 8000
ENT.HullType = HULL_HUMAN
ENT.MovementType = VJ_MOVETYPE_STATIONARY 
ENT.SightAngle = 180 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.LastSeenEnemyTimeUntilReset = 60 -- Time until it resets its enemy if its current enemy is not visible
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_COMBINE"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Oil" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasBloodDecal = false
ENT.PlayerFriendly = true -- Makes the SNPC friendly to the player and HL2 Resistance
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
-- Miscellaneous ---------------------------------------------------------------------------------------------------------------------------------------------	
-- ====== Other Variables ====== --
ENT.RunAwayOnUnknownDamage = false -- Should run away on damage
ENT.HasRangeAttack = false -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = nil -- The entity that is spawned when range attacking
ENT.RangeAttackAngleRadius = 180
	-- ====== Animation Variables ====== --
ENT.AnimTbl_RangeAttack = {"fire"} -- Range Attack Animations
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "barrel" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.HasPoseParameterLooking = true -- Does it look at its enemy using poseparameters?
ENT.PoseParameterLooking_CanReset = true -- Should it reset its pose parameters if there is no enemies?
ENT.PoseParameterLooking_InvertPitch = false -- Inverts the pitch poseparameters (X)
ENT.PoseParameterLooking_InvertYaw = false -- Inverts the yaw poseparameters (Y)
ENT.PoseParameterLooking_InvertRoll = false -- Inverts the roll poseparameters (Z)
ENT.PoseParameterLooking_TurningSpeed = 10 -- How fast does the parameter turn?
-- ====== Distance Variables ====== --
ENT.TimeUntilRangeAttackProjectileRelease = 0.2 -- How much time until the projectile code is ran?
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.NextRangeAttackTime = 1 -- How much time until it can use a range attack?
ENT.HasFootStepSound = false
ENT.SoundTbl_FootStep = {}
ENT.CanTurnWhileStationary = false
ENT.HasOnPlayerSight = true
ENT.LastLaser = CurTime()

-- ====== Sounds ====== --
ENT.HasSounds = true
ENT.SoundTbl_CombatIdle = {

}
ENT.SoundTbl_Idle = {

}
ENT.SoundTbl_Pain = {

}

ENT.SoundTbl_Death = {

}

ENT.SoundTbl_Alert = {
	"horde/rocket_turret/turret_autosearch_1.ogg",
	"horde/rocket_turret/turret_autosearch_2.ogg",
	"horde/rocket_turret/turret_autosearch_3.ogg",
}
ENT.SoundTbl_RangeAttack = {
	"horde/rocket_turret/rocket_fire1.ogg"
}
ENT.SoundTbl_OnPlayerSight = {
	"horde/rocket_turret/turret_active_1.ogg",
	"horde/rocket_turret/turret_deploy_1.ogg",
	"horde/rocket_turret/turret_deploy_6.ogg"
}

ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, posion, radiation
ENT.Horde_Immune_Bleeding = true

function ENT:CustomOnInitialize()
	self:SetColor(Color(255, 255, 150))
	self:SetSkin(math.random(0,3))
	timer.Simple(0.1, function ()
		self:SetAngles(Angle(0,0,0))
		HORDE:DropTurret(self)
	end)
end

function ENT:DoPoseParameterLooking()
	local ent = self:GetEnemy()
	local p_enemy = 0 -- Pitch
	local y_enemy = 0 -- Yaw
	if IsValid(ent) then
		local enemy_pos = ent:GetPos() + ent:OBBCenter()
		local self_ang = self:GetAngles()
		local enemy_ang = (enemy_pos - (self:GetPos() + self:OBBCenter())):Angle()
		p_enemy = math.AngleDifference(enemy_ang.p, self_ang.p)
		y_enemy = math.AngleDifference(-enemy_ang.y - 90, self_ang.y)
	else
		return
	end
	self:SetPoseParameter("aim_pitch",  p_enemy)
	self:SetPoseParameter("aim_yaw",  y_enemy)
end

function ENT:DoRelationshipCheck(ent)
    if ent:IsPlayer() or ent:GetNWEntity("HordeOwner"):IsValid() then return false end
    return true
end

function ENT:CustomOnThink_AIEnabled()
	if self.Dead then return end
	local eneValid = IsValid(self:GetEnemy())
	if eneValid and self.LastLaser < CurTime() and self:GetEnemy():GetPos():DistToSqr(self:GetPos()) <= 640000 then
		local shootpos = self:GetAttachment(self:LookupAttachment(self.RangeUseAttachmentForPosID)).Pos

		local headPos = self:GetEnemy():GetAttachment(self:GetEnemy():LookupAttachment("eyes"))
		local targetpos = self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter()
		if headPos then
			targetpos = headPos.Pos
			targetpos.z = targetpos.z - 2
		end
		local effectdata = EffectData()
        effectdata:SetOrigin( targetpos )
        effectdata:SetStart( shootpos )
        effectdata:SetAttachment( 1 )
        effectdata:SetEntity( self.Weapon )
        util.Effect( "horde_laser_turret_laser", effectdata )

		local bullet = {}
		bullet.Num = 1
		bullet.Src = shootpos
		bullet.Dir = targetpos - shootpos
		bullet.Spread = Vector(0,0,0)
		bullet.Tracer = 0
		bullet.Force = 1
		bullet.Damage = 9
		bullet.AmmoType = "GaussEnergy"
		bullet.Distance = 1000
		bullet.Callback = function (ent, tr, dmginfo)
			dmginfo:SetDamageType(DMG_BLAST)
			util.Decal("Scorch", tr.StartPos, tr.HitPos - (tr.HitNormal * 16), self)
		end
		self:FireBullets( bullet )

		self.LastLaser = CurTime() + 0.1
	end
end

/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

VJ.AddNPC("Laser Turret","npc_vj_horde_laser_turret", "Horde")
ENT.Horde_TurretMinion = true


function ENT:Follow(ply)
	if self:GetNWEntity("HordeOwner") == ply then
		self:PhysicsInit(SOLID_VPHYSICS)
		local p = self:GetPos()
		p.z = ply:GetPos().z + 12
		self:SetPos(p)
        ply:PickupObject(self)
		self:GetPhysicsObject():EnableMotion(true)
		self.Horde_Pickedup = true
		timer.Simple(0.2, function ()
			if self:IsValid() then
				self.Horde_Pickedup = nil
			end
		end)
    end
end