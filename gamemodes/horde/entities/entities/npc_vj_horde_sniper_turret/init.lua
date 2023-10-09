AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/combine_turrets/ground_turret.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
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
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackAngleRadius = 75
-- ====== Animation Variables ====== --
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.DisableDefaultRangeAttackCode = true -- When true, it won't spawn the range attack entity, allowing you to make your own
ENT.DisableRangeAttackAnimation = true -- if true, it will disable the animation code
ENT.RangeAttackReps = 1 -- How many times does it run the projectile code?
ENT.NextRangeAttackTime = 0 -- How much time until it can use a range attack?
ENT.NextAnyAttackTime_Range = 0.01 -- How much time until it can use any attack again? | Counted in Seconds
-- ====== Distance Variables ====== --
ENT.TimeUntilRangeAttackProjectileRelease = 0.2 -- How much time until the projectile code is ran?
ENT.RangeDistance = 4000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.NextRangeAttackTime = 0.9 -- How much time until it can use a range attack?
ENT.HasFootStepSound = false
ENT.SoundTbl_FootStep = {}
ENT.CanTurnWhileStationary = false
ENT.HasOnPlayerSight = true

-- Custom
ENT.Sentry_MuzzleAttach = "eyes" -- The bullet attachment
ENT.Sentry_AlarmAttach = "light" -- Attachment that the alarm sprite spawns
ENT.Sentry_Type = 0 -- 0 = Regular Ground Sentry | 1 = Big Ceiling/Ground Turret | 2 = Mini Ceiling/Ground Turret
ENT.Sentry_OrientationType = 0 -- 0 = Ground | 1 = Ceiling
ENT.Sentry_GroundType = 0 -- 0 = Regular Ground Sentry | 1 = Decay Ground Sentry

ENT.Sentry_HasLOS = false -- Has line of sight
ENT.Sentry_StandDown = true
ENT.Sentry_SpunUp = false
ENT.Sentry_CurrentParameter = 0
ENT.Sentry_NextAlarmT = 0
ENT.Sentry_ControllerStatus = 0 -- Current status of the controller, 0 = Idle | 1 = Alerted

-- ====== Sounds ====== --
ENT.HasSounds = true
ENT.SoundTbl_CombatIdle = {
	"npc/turret_floor/ping.wav"
}
ENT.SoundTbl_Idle = {
	"npc/turret_floor/ping.wav"
}
ENT.SoundTbl_Pain = {

}

ENT.SoundTbl_Death = {
	"npc/turret_floor/die.wav"
}

ENT.SoundTbl_Alert = {
	"npc/turret_floor/deploy.wav"
}
ENT.SoundTbl_RangeAttack = {
	"npc/sniper/sniper1.wav"
}

ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, posion, radiation

function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(13, 13, 60), Vector(-13, -13, 0))
	timer.Simple(0.1, function ()
		self:SetAngles(Angle(0,0,180))
		self:SetModelScale(1.5)
		HORDE:DropTurret(self)
	end)
end

function ENT:CustomRangeAttackCode()
	local gunPos = self:GetAttachment(self:LookupAttachment(self.Sentry_MuzzleAttach)).Pos
	local bullet = {}
	local v = self:GetEnemy():OBBMaxs().z - self:GetEnemy():OBBMins().z
	if v < 60 then v = 0 end
	bullet.Num = 1
	bullet.Src = gunPos
	local pos = self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter()
	bullet.Dir = pos - gunPos
	bullet.Spread = Vector(math.random(-5, 5), math.random(-5, 5), math.random(-5, 5))
	bullet.Tracer = 1
	bullet.TracerName = "HelicopterTracer"
	bullet.Force = 10
	bullet.Damage = 160
	bullet.AmmoType = "SniperRound"
	bullet.Callback = function (ent, tr)
		util.ParticleTracerEx("HelicopterTracer", gunPos, tr.HitPos, true, self:EntIndex(), -1)
	end
	self:FireBullets(bullet)
	
	VJ_EmitSound(self, {"npc/sniper/sniper1.wav"}, 90, self:VJ_DecideSoundPitch(100, 110))
	VJ_EmitSound(self, {"npc/sniper/sniper1.wav"}, 140, self:VJ_DecideSoundPitch(100, 110))
	
	local muz = ents.Create("env_sprite_oriented")
	muz:SetKeyValue("model","vj_hl/sprites/muzzleflash3.vmt")
	if self.Sentry_Type == 1 then
		muz:SetKeyValue("scale",""..math.Rand(0.8, 1))
	else
		muz:SetKeyValue("scale",""..math.Rand(0.3, 0.5))
	end
	muz:SetKeyValue("GlowProxySize","2.0") -- Size of the glow to be rendered for visibility testing.
	muz:SetKeyValue("HDRColorScale","1.0")
	muz:SetKeyValue("renderfx","14")
	muz:SetKeyValue("rendermode","3") -- Set the render mode to "3" (Glow)
	muz:SetKeyValue("renderamt","255") -- Transparency
	muz:SetKeyValue("disablereceiveshadows","0") -- Disable receiving shadows
	muz:SetKeyValue("framerate","10.0") -- Rate at which the sprite should animate, if at all.
	muz:SetKeyValue("spawnflags","0")
	muz:SetParent(self)
	muz:Fire("SetParentAttachment", self.Sentry_MuzzleAttach)
	muz:SetAngles(Angle(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100)))
	muz:Spawn()
	muz:Activate()
	muz:Fire("Kill","",0.08)
	
	local muzzleLight = ents.Create("light_dynamic")
	muzzleLight:SetKeyValue("brightness", "4")
	muzzleLight:SetKeyValue("distance", "120")
	muzzleLight:SetPos(gunPos)
	muzzleLight:SetLocalAngles(self:GetAngles())
	muzzleLight:Fire("Color", "255 150 60")
	muzzleLight:SetParent(self)
	muzzleLight:Spawn()
	muzzleLight:Activate()
	muzzleLight:Fire("TurnOn","",0)
	muzzleLight:Fire("Kill","",0.07)
	self:DeleteOnRemove(muzzleLight)
end

/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

VJ.AddNPC("Sniper Turret","npc_vj_horde_sniper_turret", "Horde")
ENT.Horde_TurretMinion = true

function ENT:Follow(ply)
	if self:GetNWEntity("HordeOwner") == ply then
		--local p = self:GetPos()
		--p.z = ply:GetPos().z
		local a = self:GetAngles()
		self:SetAngles(Angle(a.x,a.y,180))
		--self:SetPos(p)
		self:PhysicsInit(SOLID_VPHYSICS)
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