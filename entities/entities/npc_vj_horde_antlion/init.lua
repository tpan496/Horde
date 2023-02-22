AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/antlion.mdl"
ENT.StartHealth = 125
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_LARGE

ENT.SightDistance = 10000 -- How far it can see
ENT.SightAngle = 180 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians

---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY", "CLASS_COMBINE"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.CustomBlood_Particle = {"striderbuster_smoke"} -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = {"YellowBlood"} -- Leave blank for none | Commonly used: Red = Blood, Yellow Blood = YellowBlood
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack =  {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 100 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 120 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.8 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = false -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = 30
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage

ENT.NextAnyAttackTime_Range = 0.6 -- How much time until it can use a attack again? | Counted in Seconds
ENT.Immune_CombineBall = false
ENT.HasDeathAnimation = false -- Does it play an animation when it dies?
ENT.HasExtraMeleeAttackSounds = true-- Set to true to use the extra melee attack sounds
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 50 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 70 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 10
ENT.FootStepTimeRun = 0.2
ENT.FootStepTimeWalk = 0.4
ENT.HasLeapAttack = false
ENT.AnimTbl_LeapAttack = {ACT_JUMP}
ENT.StopLeapAttackAfterFirstHit = true
ENT.LeapAttackAnimationDelay = 0 
ENT.LeapDistance = 2000 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 10 -- How close does it have to be until it uses melee?
ENT.TimeUntilLeapAttackDamage = 1 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 5 -- How much time until it can use a leap attack?
ENT.NextAnyAttackTime_Leap = 0
ENT.LeapAttackAnimationDecreaseLengthAmount = 0
ENT.LeapAttackDamageDistance = 100 -- How far does the damage go?
ENT.LeapAttackDamageType = DMG_SLASH
ENT.LeapAttackDamage = 35
ENT.LeapAttackVelocityForward = 100 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 300 -- How much upward force should it apply?
ENT.LeapAttackVelocityRight = 0 -- How much right force should it apply?
ENT.IsGuard = false

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {"vjseq_charge_end"} -- Range Attack Animations
ENT.RangeAttackEntityToSpawn = "projectile_horde_antlion_bile" -- The entity that is spawned when range attacking
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 100 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = 0.3 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 3 -- How much time until it can use a range attack?
ENT.NextAnyAttackTime_Range = 0.4 -- How much time until it can use a attack again? | Counted in Seconds
ENT.RangeAttackPos_Up = 75 -- Up/Down spawning position for range attack

-- ====== Flinching Code ====== --
ENT.CanFlinch = 0
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/antlion/foot1.wav","npc/antlion/foot2.wav","npc/antlion/foot3.wav","npc/antlion/foot4.wav"}
ENT.SoundTbl_Idle = {"npc/antlion/idle1.wav","npc/antlion/idle2.wav","npc/antlion/idle3.wav","npc/antlion/idle4.wav","npc/antlion/idle5.wav"}
ENT.SoundTbl_Alert = {"npc/antlion/attack_double1.wav","npc/antlion/attack_double2.wav","npc/antlion/attack_double3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {""}
ENT.SoundTbl_MeleeAttack = {"npc/antlion/attack_double1.wav"}
ENT.SoundTbl_Pain = {"npc/antlion/pain1.wav"}
ENT.SoundTbl_Death = {"npc/antlion/pain1.wav","npc/antlion/pain2.wav"}
ENT.SoundTbl_LeapAttack = {"npc/antlion/fly.wav"}
ENT.SoundTbl_Impact = {"npc/antlion/shell_impact1.wav","npc/antlion/shell_impact2.wav","npc/antlion/shell_impact3.wav","npc/antlion/shell_impact4.wav"}
ENT.PulseInterval = 5
ENT.LastPulse = CurTime()

ENT.FollowMinDistance = 50
ENT.NextFollowUpdateTime = 0.2
ENT.FollowPlayer = true
ENT.TurningSpeed = 40

ENT.AnimTbl_Walk = {ACT_RUN} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
ENT.AnimTbl_Run = {ACT_RUN}
ENT.Evolve_Stage = 1
ENT.Base_Health = 100
ENT.Evolve_Health = 0
ENT.Evolve_Health_Max = 100

ENT.LastEvolve = CurTime()

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetSkin(0)
	self.NextRangeAttackTime = 2
	self.LastPulse = CurTime()
	self.Owner = self:GetNWEntity("HordeOwner")
	self:Follow(self.Owner)
	self.level = self.properties.level 
	self:SetMaxHealth(self.Base_Health + self.level * 5)
	self:SetModelScale(0.5)
	self:SetHealth(self:GetMaxHealth())
	self.MeleeAttackDamage = 30 + self.level * 2
	self.RangeAttackDamage = 25 + self.level
	hook.Run("Horde_OnRaiseAntlion", self.Owner, self)
	self:AddRelationship("npc_turret_floor D_LI 99")
	self:AddRelationship("npc_vj_horde_combat_bot D_LI 99")
	self:AddRelationship("npc_manhack D_LI 99")
	self:AddRelationship("npc_vj_horde_vortigaunt D_LI 99")
	self:AddRelationship("npc_vj_horde_rocket_turret D_LI 99")
	self:AddRelationship("npc_vj_horde_spectre D_LI 99")
	self:SetCollisionBounds(Vector(0, 0, 0), Vector(0, 0, 0))
end

function ENT:UpgradeReset()
	self.level = self.properties.level
	if self.Evolve_Stage == 2 then
		self:SetSkin(1)
		self:SetMaxHealth(self.Base_Health * 1.5 + self.level * 9)
		self:SetHealth(self:GetMaxHealth())
		self:SetModelScale(0.75)
		self.MeleeAttackDamage = 45 + self.level * 6
		self.RangeAttackDamage = 35 + self.level * 4
		self.NextRangeAttackTime = 2
	elseif self.Evolve_Stage == 3 then
		self:SetSkin(3)
		self:SetMaxHealth(self.Base_Health * 2 + self.level * 25)
		self:SetHealth(self:GetMaxHealth())
		self:SetModelScale(1)
		self.MeleeAttackDamage = 60 + self.level * 10
		self.RangeAttackDamage = 45 + self.level * 8
		self.NextRangeAttackTime = 1
		self.Horde_Immune_Break = true
	elseif self.Evolve_Stage == 4 then
		self:SetSkin(0)
		self:SetModelScale(1)
		self.Model = "models/antlion_guard.mdl"
		self:SetModel(self.Model)
		self:SetMaxHealth(self.Base_Health * 4 + self.level * 50)
		self:SetHealth(self:GetMaxHealth())
		self.MeleeAttackDamage = 70 + self.level * 15
		self.RangeAttackDamage = 45 + self.level * 8
		self.Horde_Immune_Status_All = true
		self.NextRangeAttackTime = 1
		if self.Owner then
			self:PlaySoundSystem("UnFollowPlayer")
			self:CustomOnUnFollowPlayer(self.Owner)
		end
		self:StopMoving()
		self.NextWanderTime = CurTime() + 2
		if !self:BusyWithActivity() then
			self:VJ_TASK_FACE_X("TASK_FACE_TARGET")
		end
		self:FollowReset()
		self:Activate()

		self.SoundTbl_Idle = {"npc/antlion_guard/growl_idle.wav"}
		self.SoundTbl_Alert = {"npc/antlion_guard/angry1.wav","npc/antlion_guard/angry2.wav","npc/antlion_guard/angry3.wav"}
		self.SoundTbl_MeleeAttack = {"npc/antlion_guard/shove1.wav"}
		self.SoundTbl_MeleeAttackMiss = {""}
		self.SoundTbl_RangeAttack = {"npc/antlion_guard/angry1.wav"}
		self.SoundTbl_Pain = {""}
		self.SoundTbl_Death = {"npc/antlion_guard/antlion_guard_die1.wav","npc/antlion_guard/antlion_guard_die2.wav"}
		self.SoundTbl_FootStep = {"npc/antlion_guard/foot_heavy1.wav","npc/antlion_guard/foot_heavy2.wav"}
	end
	self:SetHealth(self:GetMaxHealth())
end

function ENT:Horde_Evolve(health)
	self.Evolve_Health = self.Evolve_Health + health
	if self.Evolve_Health < self.Evolve_Health_Max then return end
	local max_stage = 3
	if self.Owner:IsValid() and self.Owner:Horde_GetPerk("hatcher_metamorphosis") then
		max_stage = 4
	end
	self.Evolve_Stage = math.min(max_stage, self.Evolve_Stage + 1)
	if self.Evolve_Stage == 2 then
		self:SetSkin(1)
		self:SetMaxHealth(self.Base_Health * 1.5 + self.level * 9)
		self:SetHealth(self:GetMaxHealth())
		self:SetModelScale(0.75)
		self.MeleeAttackDamage = 45 + self.level * 6
		self.RangeAttackDamage = 35 + self.level * 4
		self.NextRangeAttackTime = 2
	elseif self.Evolve_Stage == 3 then
		self:SetSkin(3)
		self:SetMaxHealth(self.Base_Health * 2 + self.level * 25)
		self:SetHealth(self:GetMaxHealth())
		self:SetModelScale(1)
		self.MeleeAttackDamage = 60 + self.level * 10
		self.RangeAttackDamage = 45 + self.level * 8
		self.Horde_Immune_Break = true
		self.NextRangeAttackTime = 1
	elseif self.Evolve_Stage == 4 then
		self:SetSkin(0)
		self:SetModelScale(1)
		self.Model = "models/antlion_guard.mdl"
		self:SetModel(self.Model)
		self:SetMaxHealth(self.Base_Health * 3 + self.level * 50)
		self:SetHealth(self:GetMaxHealth())
		self.MeleeAttackDamage = 70 + self.level * 15
		self.RangeAttackDamage = 45 + self.level * 8
		self.NextRangeAttackTime = 1
		self.Horde_Immune_Status_All = true
		if self.Owner then
			self:PlaySoundSystem("UnFollowPlayer")
			self:CustomOnUnFollowPlayer(self.Owner)
		end
		self:StopMoving()
		self.NextWanderTime = CurTime() + 2
		if !self:BusyWithActivity() then
			self:VJ_TASK_FACE_X("TASK_FACE_TARGET")
		end
		self:FollowReset()
		self:Activate()

		self.SoundTbl_Idle = {"npc/antlion_guard/growl_idle.wav"}
		self.SoundTbl_Alert = {"npc/antlion_guard/angry1.wav","npc/antlion_guard/angry2.wav","npc/antlion_guard/angry3.wav"}
		self.SoundTbl_MeleeAttack = {"npc/antlion_guard/shove1.wav"}
		self.SoundTbl_MeleeAttackMiss = {""}
		self.SoundTbl_RangeAttack = {"npc/antlion_guard/angry1.wav"}
		self.SoundTbl_Pain = {""}
		self.SoundTbl_Death = {"npc/antlion_guard/antlion_guard_die1.wav","npc/antlion_guard/antlion_guard_die2.wav"}
		self.SoundTbl_FootStep = {"npc/antlion_guard/foot_heavy1.wav","npc/antlion_guard/foot_heavy2.wav"}
	end
	self.Evolve_Health = 0
end

function ENT:Horde_IsStage(x)
	return self.Evolve_Stage >= x
end
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
function ENT:OnTakeDamage(dmginfo)
	--self:MeleeAttackCode(false, self.MeleeAttackDistance)
	--self:SetPlaybackRate(1)
	timer.Simple(2, function ()
		if self:IsValid() then
			finishAttack[VJ_ATTACK_MELEE](self)
		end
	end)
	local hitgroup = self:GetLastDamageHitGroup()
	self:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if dmginfo:GetDamage() <= 0 then return 0 end
	self.SavedDmgInfo = {
		dmginfo = dmginfo, -- The actual CTakeDamageInfo object | WARNING: Can be corrupted after a tick, recommended not to use this!
		attacker = dmginfo:GetAttacker(),
		inflictor = dmginfo:GetInflictor(),
		amount = dmginfo:GetDamage(),
		pos = dmginfo:GetDamagePosition(),
		type = dmginfo:GetDamageType(),
		force = dmginfo:GetDamageForce(),
		ammoType = dmginfo:GetAmmoType(),
		hitgroup = hitgroup,
	}
	self:SetHealth(self:Health() - dmginfo:GetDamage())
	local stillAlive = self:Health() > 0
	if stillAlive then self:PlaySoundSystem("Pain") end
	if self:Health() <= 0 && !self.Dead then
		self:RemoveEFlags(EFL_NO_DISSOLVE)
		if (dmginfo:IsDamageType(DMG_DISSOLVE)) or (IsValid(dmgInflictor) && dmgInflictor:GetClass() == "prop_combine_ball") then
			local dissolve = DamageInfo()
			dissolve:SetDamage(self:Health())
			dissolve:SetAttacker(dmgAttacker)
			dissolve:SetDamageType(DMG_DISSOLVE)
			self:TakeDamageInfo(dissolve)
		end
		self:PriorToKilled(dmginfo, hitgroup)
	end
	return 1
end

function ENT:Follow(ent, stopIfFollowing)
	if !IsValid(ent) or self.Dead or GetConVar("ai_disabled"):GetInt() == 1 or self == ent then return false end
	local isPly = ent:IsPlayer()
	local isLiving = isPly or ent:IsNPC() -- Is it a living entity?
	if VJ_IsAlive(ent) && ((isPly && !VJ_CVAR_IGNOREPLAYERS) or (!isPly)) then
		local followData = self.FollowData
		if !self.IsFollowing then
			if isPly then
				if self.AllowPrintingInChat then
					ent:PrintMessage(HUD_PRINTTALK, self:GetName().." is now following you.")
				end
				self.GuardingPosition = nil -- Reset the guarding position
				self.GuardingFacePosition = nil
				self.FollowingPlayer = true
				self:PlaySoundSystem("FollowPlayer")
			end
			followData.Ent = ent
			followData.MinDist = self.FollowMinDistance + (self:OBBMaxs().y * 3)
			followData.IsLiving = isLiving
			self.IsFollowing = true
			self:SetTarget(ent)
			if !self:BusyWithActivity() then -- Face the entity and then move to it
				self:StopMoving()
				self:VJ_TASK_FACE_X("TASK_FACE_TARGET", function(x)
					x.RunCode_OnFinish = function()
						if IsValid(self.FollowData.Ent) then
							self:VJ_TASK_GOTO_TARGET(((self:GetPos():Distance(self.FollowData.Ent:GetPos()) < (followData.MinDist * 1.25)) and "TASK_WALK_PATH") or "TASK_RUN_PATH", function(y) y.CanShootWhenMoving = true y.ConstantlyFaceEnemy = true end)
						end
					end
				end)
			end
			return true
		end
	end
	return false
end

function ENT:BugPulse()
	local r = {190, 190 * 1.5, 190 * 2, 190 * 2}
	for _, ent in pairs(ents.FindInSphere(self:GetPos(), r[self.Evolve_Stage])) do
		if ent:IsPlayer() then
			local healer = self.Owner
			if not healer then
				healer = self
			else
				hook.Run("Horde_OnAntlionPulse", healer, self, ent)
			end
			local healinfo = HealInfo:New({amount=ent:GetMaxHealth() * 0.05, healer=healer})
			HORDE:OnPlayerHeal(ent, healinfo)
			self:SetHealth(math.min(self:GetMaxHealth(), self:Health() + self:GetMaxHealth() * 0.05))
		end
	end

	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetRadius(r[self.Evolve_Stage])
	util.Effect("horde_antlion_pulse", effectdata)
	self:EmitSound("horde/weapons/spore_launcher/splauncher_impact.ogg", SNDLVL_NORM, 150, VOL_NORM, CHAN_ITEM)
end

function ENT:CustomOnMeleeAttack_BeforeChecks()
	timer.Simple(2, function ()
		if self:IsValid() then
			finishAttack[VJ_ATTACK_MELEE](self)
		end
	end)
end
function ENT:CustomOnThink()
	if self.LastPulse <= CurTime() then
		local d = self:GetPos():DistToSqr(self.Owner:GetPos())
		if d >= 640000 then
			local v = VectorRand() * 20
			v.z = 0
			self:SetPos(self.Owner:GetPos() + v)
		end
		self:BugPulse()
		local t = 5
		if self.Evolve_Stage == 2 then
			t = 4
		elseif self.Evolve_Stage == 3 then
			t = 3
		end
		self.LastPulse = CurTime() + t
	end

	if self.LastEvolve <= CurTime() then
		self.LastEvolve = CurTime() + 1
		local bonus = {increase = 0}
		hook.Run("Horde_OnAntlionSelfEvolve", self.Owner, self, bonus)
		self:Horde_Evolve(10 * (1 + bonus.increase))
	end
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
    if HORDE:IsPoisonDamage(dmginfo) then
		if self.Evolve_Stage == 2 then
			dmginfo:SetDamage(dmginfo:GetDamage() * 0.5)
		elseif self.Evolve_Stage >= 3 then
			dmginfo:SetDamage(0)
		end
    end
end

function ENT:RangeAttackLocation(pos)
	if self.Evolve_Stage == 4 then return end
	local seed = CurTime(); self.CurAttackSeed = seed
	self.CurrentAttackAnimation = VJ_PICK(self.AnimTbl_RangeAttack)
	self.CurrentAttackAnimationDuration = self:DecideAnimationLength(self.CurrentAttackAnimation, false, self.RangeAttackAnimationDecreaseLengthAmount)
	self.PlayingAttackAnimation = true
	timer.Create("timer_act_playingattack"..self:EntIndex(), self.CurrentAttackAnimationDuration, 1, function() self.PlayingAttackAnimation = false end)
	self:VJ_ACT_PLAYACTIVITY(self.CurrentAttackAnimation, false, 0, false, self.RangeAttackAnimationDelay, {SequenceDuration=self.CurrentAttackAnimationDuration})
	if self.TimeUntilRangeAttackProjectileRelease == false then
		finishAttack[VJ_ATTACK_RANGE](self)
	else -- If it's not event based...
		timer.Create("timer_range_start"..self:EntIndex(), self.TimeUntilRangeAttackProjectileRelease / self:GetPlaybackRate(), self.RangeAttackReps, function() if self.CurAttackSeed == seed then self:RangeAttackP(pos) end end)
	end
end

function ENT:CustomRangeAttackCode_BeforeProjectileSpawn(projectile)
	projectile.Owner = self
	projectile.BaseDamage = self.RangeAttackDamage
end

function ENT:RangeAttackP(pos)
	if self.Dead == true or self.vACT_StopAttacks == true or self.Flinching == true or self.MeleeAttacking == true then return end
	self.RangeAttacking = true
	self:PlaySoundSystem("RangeAttack")
	if self.RangeAttackAnimationStopMovement == true then self:StopMoving() end
	if self.RangeAttackAnimationFaceEnemy == true then self:FaceCertainEntity(self:GetEnemy(), true) end
	-- Default projectile code
	local projectile = ents.Create(self.RangeAttackEntityToSpawn)
	local target_pos = pos + Vector(0, 10, 0)
	self:CustomRangeAttackCode_BeforeProjectileSpawn(projectile)
	projectile:SetPos(self:GetPos() + self:GetUp()*self.RangeAttackPos_Up + self:GetForward()*self.RangeAttackPos_Forward + self:GetRight()*self.RangeAttackPos_Right)
	projectile:SetAngles((target_pos - projectile:GetPos()):Angle())
	projectile:SetOwner(self)
	projectile:SetPhysicsAttacker(self)
	projectile:Spawn()
	projectile:Activate()
	local phys = projectile:GetPhysicsObject()
	if IsValid(phys) then
		local vel = (pos - self:LocalToWorld(Vector(0, 0, 0)))*2 + self:GetUp()*1
		phys:SetVelocity(vel)
		--projectile:SetAngles(vel:GetNormal():Angle())
	end
	self.AlreadyDoneRangeAttackFirstProjectile = true
	if self.AttackStatus < VJ_ATTACK_STATUS_EXECUTED then
		self.AttackStatus = VJ_ATTACK_STATUS_EXECUTED
		if self.TimeUntilRangeAttackProjectileRelease != false then
			finishAttack[VJ_ATTACK_RANGE](self)
		end
	end
end

/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/