AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/horde/gonome/gonome.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 9000
ENT.HullType = HULL_MEDIUM_TALL
ENT.FindEnemy_CanSeeThroughWalls = true

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {"vjseq_idle2"} -- Range Attack Animations
ENT.RangeAttackEntityToSpawn = "obj_vj_horde_breen_projectile" -- The entity that is spawned when range attacking
ENT.RangeDistance = 5000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.RangeUseAttachmentForPos = false -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "hand_right" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.TimeUntilRangeAttackProjectileRelease = 2 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 10 -- How much time until it can use a range attack?
ENT.NextAnyAttackTime_Range = 0.5 -- How much time until it can use any attack again? | Counted in Seconds
ENT.RangeAttackPos_Up = 50 -- Up/Down spawning position for range attack
ENT.RangeAttackPos_Forward = 0 -- Forward/Backward spawning position for range attack
ENT.RangeAttackPos_Right = 0 -- Right/Left spawning position for range attack

---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackExtraTimers = {1.0} -- Extra melee attack timers | it will run the damage code after the given amount of seconds
ENT.MeleeAttackDistance = 60 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 80 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.6 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 40
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.4 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 5 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 100 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 130 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 250 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 260 -- How far it will push you up | Second in math.random
-- ====== Projectile Spawn Position Variables ====== --
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "hand_right" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.RangeAttackPos_Up = 20 -- Up/Down spawning position for range attack
ENT.RangeAttackPos_Forward = 10 -- Forward/ Backward spawning position for range attack
ENT.RangeAttackPos_Right = 10 -- Right/Left spawning position for range attack
-- Miscellaneous ---------------------------------------------------------------------------------------------------------------------------------------------	
ENT.AnimTbl_IdleStand = {"Idle1","Idle2"} -- The idle animation when AI is enabled

	-- ====== Flinching Code ====== --
ENT.CanFlinch = 0 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {"Flinch"} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play


ENT.SoundTbl_BeforeRangeAttack = {"npc/attack_helicopter/aheli_charge_up.wav"}
ENT.SoundTbl_FootStep = {"horde/gonome/gonome_step1.ogg","horde/gonome/gonome_step2.ogg","horde/gonome/gonome_step3.ogg","horde/gonome/gonome_step4.ogg"}
ENT.SoundTbl_Idle = {"horde/gonome/gonome_idle1.ogg","horde/gonome/gonome_idle2.ogg", "vo/citadel/br_youneedme.wav", "vo/citadel/br_youfool.wav"}
ENT.SoundTbl_MeleeAttack = {"horde/gonome/gonome_melee1.ogg","horde/gonome/gonome_melee2.ogg"}
ENT.SoundTbl_MeleeAttackMiss = {"horde/gonome/gonome_melee1.ogg","horde/gonome/gonome_melee2.ogg"}
ENT.SoundTbl_Pain = {"horde/gonome/gonome_pain1.ogg","horde/gonome/gonome_pain2.ogg","horde/gonome/gonome_pain3.ogg","horde/gonome/gonome_pain4.ogg", "vo/citadel/br_no.wav"}
ENT.SoundTbl_Death = {"vo/citadel/br_no.wav"}
ENT.SoundTbl_SoundTrack = nil
ENT.NextBlastTime = CurTime()
ENT.NextBlastCooldown = 13
ENT.NextSummonTime = CurTime()
ENT.HaveSpawned = false

ENT.Breen_Cooldown = 0
ENT.DamageThreshold = 5000
ENT.DamageReceived = 0
ENT.Horde_NoRandAngle = true

ENT.GeneralSoundPitch1 = 50
ENT.GeneralSoundPitch2 = 50
local finishAttack = {
	[VJ_ATTACK_MELEE] = function(self, skipStopAttacks)
		if skipStopAttacks != true then
			timer.Create("timer_melee_finished"..self:EntIndex(), self:DecideAttackTimer(self.NextAnyAttackTime_Melee, self.NextAnyAttackTime_Melee_DoRand, self.TimeUntilMeleeAttackDamage, self.CurrentAttackAnimationDuration), 1, function()
				self:StopAttacks()
				self:DoChaseAnimation()
			end)
		end
		timer.Create("timer_melee_finished_abletomelee"..self:EntIndex(), self:DecideAttackTimer(self.NextMeleeAttackTime, self.NextMeleeAttackTime_DoRand), 1, function()
			self.IsAbleToMeleeAttack = true
		end)
	end,
	[VJ_ATTACK_RANGE] = function(self, skipStopAttacks)
		if skipStopAttacks != true then
			timer.Create("timer_range_finished"..self:EntIndex(), self:DecideAttackTimer(self.NextAnyAttackTime_Range, self.NextAnyAttackTime_Range_DoRand, self.TimeUntilRangeAttackProjectileRelease, self.CurrentAttackAnimationDuration), 1, function()
				self:StopAttacks()
				self:DoChaseAnimation()
			end)
		end
		timer.Create("timer_range_finished_abletorange"..self:EntIndex(), self:DecideAttackTimer(self.NextRangeAttackTime, self.NextRangeAttackTime_DoRand), 1, function()
			self.IsAbleToRangeAttack = true
		end)
	end,
	[VJ_ATTACK_LEAP] = function(self, skipStopAttacks)
		if skipStopAttacks != true then
			timer.Create("timer_leap_finished"..self:EntIndex(), self:DecideAttackTimer(self.NextAnyAttackTime_Leap, self.NextAnyAttackTime_Leap_DoRand, self.TimeUntilLeapAttackDamage, self.CurrentAttackAnimationDuration), 1, function()
				self:StopAttacks()
				self:DoChaseAnimation()
			end)
		end
		timer.Create("timer_leap_finished_abletoleap"..self:EntIndex(), self:DecideAttackTimer(self.NextLeapAttackTime, self.NextLeapAttackTime_DoRand), 1, function()
			self.IsAbleToLeapAttack = true
		end)
	end
}

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self.Critical then
	end

	if self.DamageReceived >= self.DamageThreshold and CurTime() > self.NextBlastTime then
		if self:GetEnemy() then
			local EnemyDistance = self.NearestPointToEnemyDistance
			if EnemyDistance < 350 then
				sound.Play("weapons/physcannon/physcannon_charge.wav", self:GetPos())
				self:VJ_ACT_PLAYACTIVITY("big_flinch", true, 3, false)
				timer.Simple(3, function()
					if not self:IsValid() then return end
					local blast = ents.Create("prop_combine_ball")
					blast:SetPos(self:GetPos())
					blast:SetParent(self)
					blast:Spawn()
					blast:Fire("explode","",0)
					local dmg = DamageInfo()
					dmg:SetAttacker(self)
					dmg:SetInflictor(self)
					dmg:SetDamageType(DMG_CRUSH)
					dmg:SetDamage(75)
					util.BlastDamageInfo(dmg, self:GetPos(), 500)

					for _, ent in pairs(ents.FindInSphere(self:GetPos(), 450)) do
						if ent:IsPlayer() then
							ent:Horde_AddHemorrhage(self)
							ent:Horde_AddDebuffBuildup(HORDE.Status_Shock, 30)
						end
					end
				end)
				self.NextBlastTime = CurTime() + self.NextBlastCooldown
				self.DamageReceived = 0
				finishAttack[VJ_ATTACK_RANGE](self)
			end
		else
			sound.Play("weapons/physcannon/physcannon_charge.wav", self:GetPos())
			self:VJ_ACT_PLAYACTIVITY("big_flinch", true, 2.5, false)
			timer.Simple(2.5, function()
				if not self:IsValid() then return end
				local blast = ents.Create("prop_combine_ball")
				blast:SetPos(self:GetPos())
				blast:SetParent(self)
				blast:Spawn()
				blast:Fire("explode","",0)
				local dmg = DamageInfo()
				dmg:SetAttacker(self)
				dmg:SetInflictor(self)
				dmg:SetDamageType(DMG_CRUSH)
				dmg:SetDamage(75)
				util.BlastDamageInfo(dmg, self:GetPos(), 500)

				for _, ent in pairs(ents.FindInSphere(self:GetPos(), 450)) do
					if ent:IsPlayer() then
						ent:Horde_AddDebuffBuildup(HORDE.Status_Bleeding, 60)
						ent:Horde_AddDebuffBuildup(HORDE.Status_Shock, 30)
					end
				end
			end)
			self.NextBlastTime = CurTime() + self.NextBlastCooldown
			finishAttack[VJ_ATTACK_RANGE](self)
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetColor(Color(148,0,211))
	self:SetCollisionBounds(Vector(25, 25, 90), Vector(-25, -25, 0))
	self:SetModelScale(1.25)
	timer.Simple(1, function() self.DamageThreshold = self:GetMaxHealth() * 0.05 end)

	local pos = Vector()
	local ang = Angle()

	local bone_id = self:LookupBone("Bone01")

	pos, ang = self:GetBonePosition(bone_id)
    pos.x = pos.x
    pos.z = pos.z - 90
    pos.y = pos.y + 4

    ang.x = ang.x + 30
    ang.z = ang.z - 50
    ang.y = ang.y + 150
	self.breen = ents.Create("prop_dynamic")
	self.breen:SetModel("models/player/breen.mdl")
	self.breen:Activate()
	self.breen:DeleteOnRemove(self);
	self.breen:SetPos(pos)
	self.breen:SetAngles(ang)
    self.breen:Spawn()
	self.breen:SetColor(Color(255,100,100))
    self.breen:FollowBone(self, bone_id)
	self.breen:SetSequence("zombie_cidle_01")

	bone_id = self:LookupBone("Bone01")
	pos, ang = self:GetBonePosition(bone_id)
    pos.x = pos.x - 17
    pos.z = pos.z - 53
    pos.y = pos.y - 30

	ang.x = ang.x + 30
	ang.z = ang.z - 40

	self.model = ents.Create("prop_dynamic")
	self.model:SetModel("models/weapons/w_rocket_launcher.mdl")
	self.model:Activate()
	self.model:DeleteOnRemove(self);
	self.model:SetPos(pos)
	self.model:SetAngles(ang)
    self.model:Spawn()
    self.model:FollowBone(self, bone_id)
	self.model:SetModelScale(2)

	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end

function ENT:RangeAttackCode()
	if self.Dead == true or self.vACT_StopAttacks == true or self.Flinching == true or self.MeleeAttacking == true then return end
	if IsValid(self:GetEnemy()) then
		self.RangeAttacking = true
		self:PlaySoundSystem("RangeAttack")
		if self.RangeAttackAnimationStopMovement == true then self:StopMoving() end
		if self.RangeAttackAnimationFaceEnemy == true then self:FaceCertainEntity(self:GetEnemy(), true) end
		self:CustomRangeAttackCode()
		-- Default projectile code
		local projectile = ents.Create(self.RangeAttackEntityToSpawn)
		projectile:SetPos(self.model:GetPos())
		projectile:SetAngles((self:GetEnemy():GetPos() - projectile:GetPos()):Angle())
		self:CustomRangeAttackCode_BeforeProjectileSpawn(projectile)
		projectile:SetOwner(self)
		projectile:SetPhysicsAttacker(self)
		projectile:Spawn()
		projectile:Activate()
		local phys = projectile:GetPhysicsObject()
		if IsValid(phys) then
			phys:Wake()
			local vel = (self:GetEnemy():GetPos() - self.model:GetPos())*2
			phys:SetVelocity(vel)
			self.model:MuzzleFlash()
			--projectile:SetAngles(vel:GetNormal():Angle())
		end
		if self.Critical then
			projectile.OwnerCritical = true
		end
		self:CustomRangeAttackCode_AfterProjectileSpawn(projectile)
	end
	if self.AlreadyDoneRangeAttackFirstProjectile == false && self.TimeUntilRangeAttackProjectileRelease != false then
		self:RangeAttackCode_DoFinishTimers()
	end
	self.AlreadyDoneRangeAttackFirstProjectile = true
	finishAttack[VJ_ATTACK_RANGE](self)
end


function ENT:MultipleMeleeAttacks()
	local EnemyDistance = self:VJ_GetNearestPointToEntityDistance(self:GetEnemy(),self:GetPos():Distance(self:GetEnemy():GetPos()))
	if EnemyDistance < 100 then
		self.MeleeAttackDistance = 35
		self.TimeUntilMeleeAttackDamage = 0.6
		self.MeleeAttackAnimationFaceEnemy = false
		self.AnimTbl_MeleeAttack = {"vjseq_attack1"}
		self.MeleeAttackExtraTimers = {1.0}
		self.MeleeAttackDamage = 30
		self.MeleeAttackDamageDistance = 120
		self.MeleeAttackDamageType = DMG_SLASH
			
		if self.Breen_Cooldown <= CurTime() then
			sound.Play("vo/Citadel/br_laugh01.wav", self:GetPos(), 100, 50)
			self.Breen_Cooldown = CurTime() + math.random(30,60)
		end
	end
end

function ENT:CustomOnMeleeAttack_AfterChecks(TheHitEntity)
	ParticleEffect("vomit_barnacle",TheHitEntity:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)
	ParticleEffect("blood_impact_green_01",TheHitEntity:GetPos(),Angle(0,0,0),nil)
	ParticleEffect("antlion_gib_02_gas",TheHitEntity:GetPos(),Angle(0,0,0),nil)
	ParticleEffect("antlion_gib_02_gas",TheHitEntity:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)
	ParticleEffect("antlion_gib_02_juice",TheHitEntity:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)

	if TheHitEntity and IsValid(TheHitEntity) and TheHitEntity:IsPlayer() then
        TheHitEntity:Horde_AddHemorrhage(self)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
     return (self:GetEnemy():GetPos() - self:LocalToWorld(Vector(math.random(-10,20),math.random(-10,20),math.random(10,20))))*2 + self:GetUp()*200
end

ENT.Critical = false
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
    if not self.Critical and self:Health() < self:GetMaxHealth() / 2 then
        self.Critical = true
		self.AnimTbl_Walk = ACT_RUN
		self.AnimTbl_Run = ACT_RUN
		self.AnimationPlaybackRate = 1.25
    end
	self.DamageReceived = self.DamageReceived + dmginfo:GetDamage()
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if HORDE:IsPhysicalDamage(dmginfo) then
		dmginfo:ScaleDamage(0.75)
    elseif HORDE:IsPoisonDamage(dmginfo) then
        dmginfo:ScaleDamage(1.25)
    end
end

VJ.AddNPC("Wallace Breen","npc_vj_horde_breen", "Zombies")
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/