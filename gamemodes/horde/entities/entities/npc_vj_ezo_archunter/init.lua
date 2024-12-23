AddCSLuaFile("shared.lua")
include('shared.lua')

--[[-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
-- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.Model = {"models/hunterarc.mdl"}

ENT.StartHealth = 100
ENT.HullType = HULL_MEDIUM_TALL

---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}

ENT.FriendsWithAllPlayerAllies = false -- Should this SNPC be friends with all other player allies that are running on VJ Base?
ENT.HasBloodPool = true
ENT.BloodColor = "white" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.InvestigateSoundDistance = 240 -- How far away can the SNPC hear sounds? | This number is timed by the calculated volume of the detectable sound.

-- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
ENT.AnimTbl_IdleStand = {ACT_IDLE}

-- Set the walking animations | Put multiple to let the base pick a random animation when it moves
ENT.AnimTbl_Walk = {ACT_WALK}

-- Set the running animations | Put multiple to let the base pick a random animation when it moves
ENT.AnimTbl_Run = {ACT_RUN}

ENT.HasDeathAnimation = true

ENT.AnimTbl_Death = {"death_stagger_e", "death_stagger_s", "death_stagger_se", "death_stagger_sw", "death_stagger_w"}

---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?

-- Melee Attack Animations
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1, "meleert"}

ENT.MeleeAttackDistance = 75 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 80 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.5 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 10
ENT.MeleeAttackDamageType = DMG_SLASH
ENT.PushProps = true
ENT.AttackProps = true -- Should it attack props when trying to move?

-- Damages that it gibs from | "UseDefault" = Uses default damage types | "All" = Gib from any damage
ENT.GibOnDeathDamagesTable = {"UseDefault"}

ENT.CanOpenDoors = true -- Can it open doors?
ENT.MaxJumpLegalDistance = VJ_Set(300, 1000)
ENT.HasMeleeAttackKnockBack = false -- If true, it will cause a knockback to its enemy
ENT.VJ_IsHugeMonster = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.AlertFriendsOnDeath = true
ENT.AlertFriendsOnDeathDistance = 1000 -- How far away does the signal go? | Counted in World Units
ENT.AlertFriendsOnDeathLimit = 1 -- How many people should it alert?
ENT.CallForHelp = true -- Does the SNPC call for help?
ENT.CallForHelpDistance = 2500 -- How far away the SNPC's call for help goes | Counted in World Units
ENT.CallForBackUpOnDamageUseCertainAmount = false -- Should the SNPC only call certain amount of people
ENT.HasCallForHelpAnimation = true -- if true, it will play the call for help animation

-- Call For Help Animations
ENT.AnimTbl_CallForHelp = {"hunter_call_1", "hunter_respond_1", "hunter_respond_3"}

---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.NextRangeAttackTime = 6
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "minigunbase" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.RangeAttackEntityToSpawn = "obj_vj_flechette_z" -- The entity that is spawned when range attacking
ENT.TimeUntilRangeAttackProjectileRelease = 1.5
ENT.RangeDistance = 5000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 60 -- How close does it have to be until it uses melee?

ENT.RangeAttackExtraTimers = {1.5, 1.6, 1.7, 1.8, 1.9, 2}

---------------------------------------------------------------------------------------------------------------------------------------------
ENT.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
---------------------------------------------------------------------------------------------------------------------------------------------
-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 2 -- Chance of it flinching from 1 to x | 1 will make it always flinch

-- If it uses normal based animation, use this
ENT.AnimTbl_Flinch = {"vjges_flinch_e", "vjges_flinch_s", "vjges_flinch_n", "vjges_flinch_w"}

ENT.HasSoundTrack = false -- Does the SNPC have a sound track?
ENT.SoundTrackVolume = 1
ENT.SoundTrackChance = 1

---------------------------------------------------------------------------------------------------------------------------------------------
-- ====== Sound File Paths ====== --
ENT.SoundTbl_FootStep = {"snpc/hunterarc/ministrider_footstep1.wav", "snpc/hunterarc/ministrider_footstep2.wav", "snpc/hunterarc/ministrider_footstep3.wav", "snpc/hunterarc/ministrider_footstep4.wav", "snpc/hunterarc/ministrider_footstep5.wav"}

ENT.SoundTbl_Idle = {"snpc/hunterarc/hunter_angry1.wav", "snpc/hunterarc/hunter_angry2.wav", "snpc/hunterarc/hunter_angry3.wav", "snpc/hunterarc/hunter_idle1.wav", "snpc/hunterarc/hunter_idle2.wav", "snpc/hunterarc/hunter_idle3.wav"}

ENT.SoundTbl_Alert = {"snpc/hunterarc/hunter_foundenemy1.wav", "snpc/hunterarc/hunter_foundenemy2.wav", "snpc/hunterarc/hunter_foundenemy3.wav", "snpc/hunterarc/hunter_foundenemy_ack1.wav", "snpc/hunterarc/hunter_foundenemy_ack2.wav", "snpc/hunterarc/hunter_foundenemy_ack3.wav", "snpc/hunterarc/hunter_alert1.wav", "snpc/hunterarc/hunter_alert2.wav", "snpc/hunterarc/hunter_alert3.wav",}

ENT.SoundTbl_BeforeRangeAttack = {"snpc/hunterarc/hunter_prestrike1.wav"}

ENT.SoundTbl_Investigate = {"snpc/hunterarc/hunter_scan1.wav", "snpc/hunterarc/hunter_scan2.wav", "snpc/hunterarc/hunter_scan3.wav", "snpc/hunterarc/hunter_scan4.wav",}

ENT.SoundTbl_LostEnemy = {"snpc/hunterarc/hunter_scan1.wav", "snpc/hunterarc/hunter_scan2.wav", "snpc/hunterarc/hunter_scan3.wav", "snpc/hunterarc/hunter_scan4.wav",}

ENT.SoundTbl_CombatIdle = {"snpc/hunterarc/hunter_defendstrider1.wav", "snpc/hunterarc/hunter_defendstrider2.wav", "snpc/hunterarc/hunter_defendstrider3.wav", "snpc/hunterarc/hunter_foundenemy1.wav", "snpc/hunterarc/hunter_foundenemy2.wav", "snpc/hunterarc/hunter_foundenemy3.wav",}

ENT.SoundTbl_Pain = {"snpc/hunterarc/hunter_pain2.wav", "snpc/hunterarc/hunter_pain4.wav"}

ENT.Charging = false
ENT.hit = false
ENT.NextCharge = 0
ENT.NextDodging = 0
ENT.Dodging = false

ENT.ChargeSd = {"snpc/hunterarc/hunter_charge3.wav", "snpc/hunterarc/hunter_charge4.wav"}

ENT.SoundTbl_Death = {"snpc/hunterarc/hunter_die2.wav", "snpc/hunterarc/hunter_die3.wav",}

ENT.SoundTbl_BeforeMeleeAttack = {"snpc/hunterarc/hunter_prestrike1.wav"}

ENT.SoundTbl_MeleeAttack = {"snpc/hunterarc/flechette_flesh_impact1.wav", "snpc/hunterarc/flechette_flesh_impact2.wav", "snpc/hunterarc/flechette_flesh_impact3.wav", "snpc/hunterarc/flechette_flesh_impact4.wav"}

ENT.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav", "npc/zombie/claw_miss2.wav"}

ENT.SoundTbl_SoundTrack = {"snpc/hunterarc/penultimatum.mp3"}

ENT.CanShake = true
ENT.HasDeathRagdoll = false
ENT.NextChangeDir = 0

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
	self.NextCharge = CurTime() + 1
end

function ENT:CustomOnFlinch_BeforeFlinch(dmginfo, hitgroup)
	if dmginfo:GetDamage() < 35 then
		local vec = (dmginfo:GetInflictor():GetPos() - self:GetPos()):GetNormal():Angle().y
		local targetAngle = self:EyeAngles().y

		if targetAngle > 360 then
			targetAngle = targetAngle - 360
		end

		if targetAngle < 0 then
			targetAngle = targetAngle + 360
		end

		local angleAround = vec - targetAngle

		if angleAround > 360 then
			angleAround = angleAround - 360
		end

		if angleAround < 0 then
			angleAround = angleAround + 360
		end

		if angleAround <= 45 or angleAround > 315 then
			self.AnimTbl_Flinch = {"vjges_flinch_s"}
		end

		if angleAround > 45 and angleAround <= 135 then
			self.AnimTbl_Flinch = {"vjges_flinch_e"}
		end

		if angleAround > 135 and angleAround <= 225 then
			self.AnimTbl_Flinch = {"vjges_flinch_n"}
		end

		if angleAround > 225 and angleAround <= 315 then
			self.AnimTbl_Flinch = {"vjges_flinch_w"}
		end
	end

	if dmginfo:GetDamage() > 35 then
		local vec = (dmginfo:GetInflictor():GetPos() - self:GetPos()):GetNormal():Angle().y
		local targetAngle = self:EyeAngles().y

		if targetAngle > 360 then
			targetAngle = targetAngle - 360
		end

		if targetAngle < 0 then
			targetAngle = targetAngle + 360
		end

		local angleAround = vec - targetAngle

		if angleAround > 360 then
			angleAround = angleAround - 360
		end

		if angleAround < 0 then
			angleAround = angleAround + 360
		end

		if angleAround <= 45 or angleAround > 315 then
			self.AnimTbl_Flinch = {"staggers"}
		end

		if angleAround > 45 and angleAround <= 135 then
			self.AnimTbl_Flinch = {"staggere"}
		end

		if angleAround > 135 and angleAround <= 225 then
			self.AnimTbl_Flinch = {"staggern"}
		end

		if angleAround > 225 and angleAround <= 315 then
			self.AnimTbl_Flinch = {"staggerw"}
		end

		-- Code to make hunter stop charging on take big damage
		if IsValid(self) and self.Charging and self.Dead == false then
			self.HasMeleeAttack = true
			self.HasRangeAttack = true
			self.MovementType = VJ_MOVETYPE_GROUND
			self.Charging = false
			self.hit = true

			self.AnimTbl_Run = {ACT_RUN}

			self.NextCharge = CurTime() + math.Rand(10, 15)
			VJ_EmitSound(self, self.SoundTbl_BeforeMeleeAttack, 100, math.random(80, 100))

			timer.Simple(1, function()
				if IsValid(self) then
					self.hit = false
				end
			end)
		end
	end
end

function ENT:MultipleMeleeAttacks()

		if self.RangeAttacking == false and self.MeleeAttacking == false and self.Alerting == false and self:Visible(self:GetEnemy()) and self.Dodging == false and self.NearestPointToEnemyDistance > 400 and self.NearestPointToEnemyDistance < 1100 and CurTime() > self.NextCharge then
			VJ_EmitSound(self, self.ChargeSd, 100, math.random(80, 100))
			self:VJ_ACT_PLAYACTIVITY("charge_start", true, false, true)

			timer.Simple(1.5, function()
				if IsValid(self) then
					self:Charge()
				end
			end)
		end
	

	local randAttack = math.random(1, 3)

	if randAttack == 1 and self.NearestPointToEnemyDistance < 500 then
		self.AnimTbl_MeleeAttack = {"melee_02"}

		self.TimeUntilMeleeAttackDamage = 0.6
		self.MeleeAttackDamage = 25
	end

	if randAttack == 2 and self.NearestPointToEnemyDistance < 500 then
		self.AnimTbl_MeleeAttack = {"meleert"}

		self.TimeUntilMeleeAttackDamage = 0.5
		self.MeleeAttackDamage = 25
	end

	if randAttack == 3 and self.NearestPointToEnemyDistance < 500 then
		self.AnimTbl_MeleeAttack = {"meleeleft"}

		self.TimeUntilMeleeAttackDamage = 0.5
		self.MeleeAttackDamage = 25
	end
end

function ENT:Charge()
	if self.Dead == false then
		self.HasMeleeAttack = false
		self.Charging = true
		self.HullType = HULL_WIDE_HUMAN
		self:FaceCertainEntity(self:GetEnemy(), true)
		self:CapabilitiesRemove(CAP_MOVE_JUMP)
		self.HasRangeAttack = false

		self.AnimTbl_Run = {VJ_SequenceToActivity(self, "charge_loop")}
	end
end

function ENT:ChargeHit()
	if IsValid(self) and self.Charging and self.Dead == false then
		self:VJ_ACT_PLAYACTIVITY("charge_miss_slide", true, false, true)
		self.HasMeleeAttack = true
		self.MovementType = VJ_MOVETYPE_GROUND
		self.Charging = false
		self.HullType = HULL_MEDIUM_TALL
		self.HasRangeAttack = true
		self.hit = true
		self.NextCharge = CurTime() + math.Rand(15, 30)
		VJ_EmitSound(self, self.SoundTbl_MeleeAttack, 100, math.random(80, 100))

		self.AnimTbl_Run = {ACT_RUN}

		timer.Simple(1, function()
			if IsValid(self) then
				self.hit = false
			end
		end)
	end
end

function ENT:StopCharge()
	if IsValid(self) and self.Charging and self.Dead == false then
		self:VJ_ACT_PLAYACTIVITY("charge_miss_slide", true, false, true)
		self.HasMeleeAttack = true
		self.HasRangeAttack = true
		self.MovementType = VJ_MOVETYPE_GROUND
		self.HullType = HULL_MEDIUM_TALL
		self.Charging = false
		self.hit = true

		self.AnimTbl_Run = {ACT_RUN}

		self.NextCharge = CurTime() + math.Rand(5, 10)
		VJ_EmitSound(self, self.SoundTbl_BeforeMeleeAttack, 100, math.random(80, 100))

		timer.Simple(1, function()
			if IsValid(self) then
				self.hit = false
			end
		end)
	end
end

function ENT:ChargeCrash()
	if IsValid(self) and self.Charging and self.Dead == false then
		self:VJ_ACT_PLAYACTIVITY("charge_crash", true, false, true)
		self.HasMeleeAttack = true
		self.HasRangeAttack = true
		self.MovementType = VJ_MOVETYPE_GROUND
		self.HullType = HULL_MEDIUM_TALL
		self.Charging = false
		self.hit = true

		self.AnimTbl_Run = {ACT_RUN}

		self.NextCharge = CurTime() + math.Rand(15, 20)
		self:SetPos(self:GetPos() + self:GetForward() * -1 + self:GetUp() * 0)
		util.ScreenShake(self:GetPos(), 44, 300, 1, 2000)
		VJ_EmitSound(self, self.BodySd, 100, math.random(80, 100))

		timer.Simple(1, function()
			if IsValid(self) then
				self.hit = false
			end
		end)
	end
end

function ENT:CustomRangeAttackCode_BeforeProjectileSpawn(projectile)
	local bloodeffect = ents.Create("info_particle_system")
	bloodeffect:SetKeyValue("effect_name", "hunter_muzzle_flash")
	bloodeffect:SetPos(self:GetAttachment(self:LookupAttachment("minigunbase")).Pos)
	bloodeffect:SetAngles(self:GetAttachment(self:LookupAttachment("minigunbase")).Ang)
	bloodeffect:Fire("SetParentAttachment", "minigunbase")
	bloodeffect:SetParent(self)
	bloodeffect:Spawn()
	bloodeffect:Activate()
	self:EmitSound("snpc/hunterarc/ministrider_fire1.wav", 110, math.random(90, 110), 0.66, CHAN_WEAPON)
end

function ENT:RangeAttackCode_GetShootPos(projectile)
	local startPos = projectile:GetPos()
	return self:CalculateProjectile("Line", startPos, self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(), 2000)
end

function ENT:CustomOnThink()
	-- Dodge
		if self.Alerting == false and IsValid(self:GetEnemy()) and not self.Dead and CurTime() > self.NextDodging and self:GetPos():Distance(self:GetEnemy():GetPos()) < 4500 and self.RangeAttacking == false and self.Charging == false and self.MeleeAttacking == false then
			local dodge_dirs = {}
			local dir2 = nil

			for dir, path_clear in pairs(self:VJ_CheckAllFourSides()) do
				if path_clear then
					if (not self:GetEnemy():IsPlayer()) or (self:GetEnemy():IsPlayer() and ((not IsValid(self:GetEnemy():GetEyeTrace().Entity)) or self:GetEnemy():GetEyeTrace().Entity ~= self)) then
						dir2 = "n"
					elseif dir == "Back" then
						dir2 = "s"
					elseif dir == "Left" then
						dir2 = "w"
					elseif dir == "Right" then
						dir2 = "e"
					end

					table.insert(dodge_dirs, dir2)
				end
			end

			if not table.IsEmpty(dodge_dirs) then
				local dodge_dir = string.lower(table.Random(dodge_dirs))
				local anim = nil
				self:VJ_ACT_PLAYACTIVITY("dodge_" .. dodge_dir, true, 0.75, false)
				self.NextDodging = CurTime() + math.Rand(5, 10)
			end
		end

	-- Charge Code
    if self.Charging and self:GetEnemy() == nil then
        self:StopCharge()
    end

	if self.Charging == true then
		local tr = util.TraceHull({
			start = self:GetPos() + self:OBBCenter(),
			endpos = self:GetPos() + self:OBBCenter() + self:GetForward() * 80,
			filter = {self, self.GrabbedEntity},
			mins = self:OBBMins(),
			maxs = self:OBBMaxs(),
		})

		local trMove = util.TraceLine({
			start = self:GetPos() + self:OBBCenter(),
			endpos = self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(),
			filter = self
		})

		if CurTime() > self.NextChangeDir then
			self:SetLastPosition(trMove.HitPos + trMove.HitNormal * self:OBBMaxs().y)
			self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")
			self.NextChangeDir = CurTime() + 0.5
		end

		if tr.Hit and tr.HitWorld then
			self:ChargeCrash()
		end

		for k, v in pairs(ents.FindInSphere(self:GetPos() + self:GetForward() * 50, 80)) do
			-- Crash If Hit Map
			if tr.Hit and not self:Visible(v) then
				self:ChargeCrash()
			end

			timer.Simple(6, function()
				-- Crash If Hit Wall
				if not tr.Hit and self.hit == false and self.Charging == true and IsValid(self) then
					self:StopCharge()
				end
			end)
		end

		if self.Charging == true then
			for k, v in pairs(ents.FindInSphere(self:GetPos() + self:GetForward() * 50, 80)) do
				if self:DoRelationshipCheck(v) == true and self:Visible(v) and IsValid(self) and self.Dead == false then
					VJ_EmitSound(self, self.SoundTbl_MeleeAttack, 100, math.random(80, 100))
			--		v:TakeDamage(math.random(15, 30), self, self)
					
					local d = DamageInfo()			
					d:SetDamage( 30 )
					d:SetAttacker( self )
					d:SetDamageType( DMG_CLUB )
					d:SetInflictor( self )
					v:TakeDamageInfo( d )
					
					v:SetVelocity(self:GetForward() * 300 + self:GetUp() * 200)
					self:ChargeHit()
				end
			end
		end
	end
end

function ENT:CustomOnAlert(ent)
	self.Alerting = true

	self:VJ_ACT_PLAYACTIVITY({"hunter_angry", "hunter_angry2"}, true, 2, true)

	timer.Simple(3, function()
		if IsValid(self) then
			self.Alerting = false
		end
	end)
end

function ENT:CustomOnResetEnemy()
end

---------------------------------------------------------------------------------------------------------------------------------------------
-- ====== Sound Pitch ====== --
-- Higher number = Higher pitch | Lower number = Lower pitch
-- Highest number is 254
-- !!! Important variables !!! --
ENT.UseTheSameGeneralSoundPitch = true
-- If set to true, it will make the game decide a number when the SNPC is created and use it for all sound pitches set to "UseGeneralPitch"
-- It picks the number between the two variables below:
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
-- This two variables control any sound pitch variable that is set to "UseGeneralPitch"
-- To not use these variables for a certain sound pitch, just put the desired number in the specific sound pitch
ENT.FootStepPitch1 = 100
ENT.FootStepPitch2 = 100
ENT.BreathSoundPitch1 = 100
ENT.BreathSoundPitch2 = 100
ENT.IdleSoundPitch1 = "UseGeneralPitch"
ENT.IdleSoundPitch2 = "UseGeneralPitch"
ENT.CombatIdleSoundPitch1 = "UseGeneralPitch"
ENT.CombatIdleSoundPitch2 = "UseGeneralPitch"
ENT.OnReceiveOrderSoundPitch1 = "UseGeneralPitch"
ENT.OnReceiveOrderSoundPitch2 = "UseGeneralPitch"
ENT.FollowPlayerPitch1 = "UseGeneralPitch"
ENT.FollowPlayerPitch2 = "UseGeneralPitch"
ENT.UnFollowPlayerPitch1 = "UseGeneralPitch"
ENT.UnFollowPlayerPitch2 = "UseGeneralPitch"
ENT.BeforeHealSoundPitch1 = "UseGeneralPitch"
ENT.BeforeHealSoundPitch2 = "UseGeneralPitch"
ENT.AfterHealSoundPitch1 = 100
ENT.AfterHealSoundPitch2 = 100
ENT.OnPlayerSightSoundPitch1 = "UseGeneralPitch"
ENT.OnPlayerSightSoundPitch2 = "UseGeneralPitch"
ENT.AlertSoundPitch1 = "UseGeneralPitch"
ENT.AlertSoundPitch2 = "UseGeneralPitch"
ENT.CallForHelpSoundPitch1 = "UseGeneralPitch"
ENT.CallForHelpSoundPitch2 = "UseGeneralPitch"
ENT.BecomeEnemyToPlayerPitch1 = "UseGeneralPitch"
ENT.BecomeEnemyToPlayerPitch2 = "UseGeneralPitch"
ENT.BeforeMeleeAttackSoundPitch1 = "UseGeneralPitch"
ENT.BeforeMeleeAttackSoundPitch2 = "UseGeneralPitch"
ENT.MeleeAttackSoundPitch1 = 100
ENT.MeleeAttackSoundPitch2 = 100
ENT.ExtraMeleeSoundPitch1 = 100
ENT.ExtraMeleeSoundPitch2 = 100
ENT.MeleeAttackMissSoundPitch1 = 100
ENT.MeleeAttackMissSoundPitch2 = 100
ENT.SuppressingPitch1 = "UseGeneralPitch"
ENT.SuppressingPitch2 = "UseGeneralPitch"
ENT.WeaponReloadSoundPitch1 = "UseGeneralPitch"
ENT.WeaponReloadSoundPitch2 = "UseGeneralPitch"
ENT.GrenadeAttackSoundPitch1 = "UseGeneralPitch"
ENT.GrenadeAttackSoundPitch2 = "UseGeneralPitch"
ENT.OnGrenadeSightSoundPitch1 = "UseGeneralPitch"
ENT.OnGrenadeSightSoundPitch2 = "UseGeneralPitch"
ENT.PainSoundPitch1 = "UseGeneralPitch"
ENT.PainSoundPitch2 = "UseGeneralPitch"
ENT.ImpactSoundPitch1 = 100
ENT.ImpactSoundPitch2 = 100
ENT.DamageByPlayerPitch1 = "UseGeneralPitch"
ENT.DamageByPlayerPitch2 = "UseGeneralPitch"
ENT.DeathSoundPitch1 = "UseGeneralPitch"
ENT.DeathSoundPitch2 = "UseGeneralPitch"
ENT.RangeAttackSoundLevel = 100

function ENT:CustomAttackCheck_RangeAttack()
	self:SetState(VJ_STATE_ONLY_ANIMATION) -- For some reason hunter shoot only 1 projectile if he has range attack animation, so this is code to add this animation without problems

	self.AnimTbl_IdleStand = {"shoot_minigun"}

	timer.Simple(3, function()
		if IsValid(self) then
			self.AnimTbl_IdleStand = {ACT_IDLE}

			self:SetState()
		end
	end)

	return true
end

function ENT:CustomOnTakeDamage_BeforeImmuneChecks(dmginfo, hitgroup)
	local dmgtype = dmginfo:GetDamageType()

	if dmgtype == DMG_ENERGYBEAM then
		self:VJ_ACT_PLAYACTIVITY("body_poses", true, false, true)

		timer.Simple(0.5, function()
			if IsValid(self) then
				cys = ents.Create("npc_vj_ezo_vorthunter")
				cys:SetPos(self:GetPos(1))
				cys:SetAngles(self:GetAngles())
				cys:Spawn()
				cys:Activate()
				cys:SetOwner(self)
				self:Remove()
			end
		end)
	end
end

function ENT:CustomRangeAttackCode_AfterProjectileSpawn(projectile)
	local bloodeffect = ents.Create("info_particle_system")
	bloodeffect:SetKeyValue("effect_name", "hunter_muzzle_flash")
	bloodeffect:SetPos(self:GetAttachment(self:LookupAttachment("minigunbase")).Pos)
	bloodeffect:SetAngles(self:GetAttachment(self:LookupAttachment("minigunbase")).Ang)
	bloodeffect:Fire("SetParentAttachment", "minigunbase")
	bloodeffect:Fire("Start", "", 0.0)
	bloodeffect:Fire("Kill", "", 0.2)
	bloodeffect:SetParent(self)
	bloodeffect:Spawn()
	bloodeffect:Activate()
end

function ENT:RangeAttackCode_GetShootPos(projectile)
	local startPos = projectile:GetPos()
	ParticleEffect("", startPos + projectile:GetForward() * 30, self:GetForward():Angle(), projectile)

	return self:CalculateProjectile("Line", startPos, self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter() + self:GetEnemy():GetUp() * math.random(-40, 40) + self:GetEnemy():GetRight() * math.random(-25, 25), 2000)
end
--[[-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]