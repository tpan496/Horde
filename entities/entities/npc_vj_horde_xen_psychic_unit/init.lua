AddCSLuaFile("shared.lua")
include('shared.lua')


-- Core
ENT.Model = {"models/horde/kingpin/kingpin.mdl"}
ENT.StartHealth = 7000
ENT.HullType = HULL_MEDIUM_TALL

ENT.SightDistance = 10000 -- How far it can see
ENT.SightAngle = 360 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
-- AI
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
-- Damage/Injured
ENT.BloodColor = "Red"
ENT.Immune_Dissolve = true
ENT.Immune_Physics = true

-- Flinch
ENT.CanFlinch = 0 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.NextFlinchTime = 2
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS} -- If it uses normal based animation, use this

-- Melee
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {"attack1", "attack2"} -- Melee Attack Animations
ENT.MeleeAttackDistance = 60
ENT.MeleeAttackDamageDistance = 105
ENT.TimeUntilMeleeAttackDamage = 0.5 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 30

-- Ranged
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_horde_homing_lightning" -- The entity that is spawned when range attacking
ENT.RangeDistance = 3000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 180 -- How close does it have to be until it uses melee?
ENT.NextRangeAttackTime = VJ.SET(6, 8)
ENT.TimeUntilRangeAttackProjectileRelease = 0.1 -- How much time until the projectile code is ran?
ENT.RangeAttackPos_Up = 65
ENT.DisableDefaultRangeAttackCode = true
ENT.RangeAttackPos_Forward = 65

-- Knockback
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 100 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 100 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 50 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 50 -- How far it will push you up | Second in math.random
ENT.MeleeAttackKnockBack_Right1 = 0 -- How far it will push you right | First in math.random
ENT.MeleeAttackKnockBack_Right2 = 0 -- How far it will push you right | Second in math.random

ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
ENT.PushProps = true -- Should it push props when trying to move?

    -- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"horde/kingpin/kingpin_step01.ogg","horde/kingpin/kingpin_step02.ogg","horde/kingpin/kingpin_step03.ogg"}
ENT.SoundTbl_Breath = {"horde/kingpin/kingpin_breath01.mp3","horde/kingpin/kingpin_breath02.mp3"}
ENT.SoundTbl_Idle = {"horde/kingpin/kingpin_idle01.mp3","horde/kingpin/kingpin_idle02.mp3"}
ENT.SoundTbl_Alert = {"horde/kingpin/kingpin_alert.mp3"}
ENT.SoundTbl_BeforeMeleeAttack = {"horde/kingpin/kingpin_melee.ogg"}
ENT.SoundTbl_MeleeAttackMiss = {"horde/kingpin/kingpin_meleemiss01.ogg","horde/kingpin/kingpin_meleemiss02.ogg"}
ENT.SoundTbl_Pain = {"horde/kingpin/kingpin_injured01.mp3","horde/kingpin/kingpin_injured02.mp3","horde/kingpin/kingpin_injured03.mp3"}
ENT.SoundTbl_Death = {"horde/kingpin/kingpin_death01.ogg"}


ENT.NextChangeTime = CurTime() + 15
ENT.NextChangeCooldown = 15

-- Ranged Mode: Homing lightning plasma, lightning cannon
-- Melee Mode: Shield, increased movement speed
ENT.Combat_Mode = 0
---------------------------------------------------------------------------------------------------------------------------------------------

function ENT:MaintainAlertBehavior(alwaysChase) -- alwaysChase = Override to always make the NPC chase
	alwaysChase = true
	local curTime = CurTime()
	local selfData = self:GetTable()
	if selfData.NextChaseTime > curTime or selfData.Dead or selfData.VJ_IsBeingControlled or selfData.Flinching or self:GetState() == VJ_STATE_ONLY_ANIMATION_CONSTANT then return end
	local ene = self:GetEnemy()
	local moveType = selfData.MovementType
	if !IsValid(ene) or selfData.TakingCoverT > curTime or (selfData.AttackAnimTime > curTime && moveType != VJ_MOVETYPE_AERIAL && moveType != VJ_MOVETYPE_AQUATIC) then return end
	
	-- Not melee attacking yet but it is in range, so don't chase the enemy!
	local eneData = selfData.EnemyData
	if selfData.HasMeleeAttack && eneData.DistanceNearest < selfData.MeleeAttackDistance && eneData.Visible && (self:GetHeadDirection():Dot((ene:GetPos() - self:GetPos()):GetNormalized()) > math_cos(math_rad(selfData.MeleeAttackAngleRadius))) then
		if moveType == VJ_MOVETYPE_AERIAL or moveType == VJ_MOVETYPE_AQUATIC then
			self:AA_StopMoving()
		end
		self:SCHEDULE_IDLE_STAND()
		return
	end
	

	-- If the enemy is not reachable then wander around
	self:SCHEDULE_ALERT_CHASE()
	
	-- Set the next chase time
	if selfData.NextChaseTime > curTime then return end -- Don't set it if it's already set!
	selfData.NextChaseTime = curTime + 0.1 -- If the enemy is far, increase the delay!
end

function ENT:CustomOnInitialize()
    self:SetCollisionBounds(Vector(35, 35, 110),Vector(-35, -35, 0))
    self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
	local shield = ents.Create("prop_dynamic_override")
	shield:SetModel("models/horde/kingpin/kingpin_sphereshield.mdl")
	shield:SetModelScale(0.5)
	shield:SetPos(self:GetPos() + self:OBBCenter())
	shield:SetParent(self)
	shield:DrawShadow(false)
	shield:Spawn()
	shield:Activate()
	self.bShieldActive = true
	self.entShield = shield
	self:DisableShield()
	--self:SetShieldPower(100)
	--self:ActivateShield()
	self.NextChangeTime = CurTime() + 15
end

function ENT:DisableShield()
	if IsValid(self.entShield) then self.entShield:SetNoDraw(true); self.bShieldActive = false end
end

function ENT:EnableShield()
	if IsValid(self.entShield) then self.entShield:SetNoDraw(false); self.bShieldActive = true end
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Critical = nil
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
    if not self.Critical and (self:Health() < self:GetMaxHealth() * 0.6) then
        self.Critical = true
		self.NextRangeAttackTime = 4 -- How much time until it can use a range attack?
		self.NextRangeAttackTime_DoRand = 6 -- False = Don't use random time | Number = Picks a random number between the regular timer and this timertack
    end
end

function ENT:CustomRangeAttackCode_AfterProjectileSpawn(projectile)
	projectile:SetEntityOwner(self)
	projectile:SetScale(2)
	projectile.Target = self:GetEnemy()
end

function ENT:OnThinkActive()
	-- Ability to see through walls
	local selfData = self:GetTable()

	if CurTime() > self.NextChangeTime and self.Critical then
		self.Combat_Mode = self.Combat_Mode + 1
		if self.Combat_Mode > 1 then
			self.Combat_Mode = 0
		end
		
		if self.Combat_Mode == 0 then
			self:DisableShield()
			self.HasRangeAttack = true
		else
			self:EnableShield()
			self.HasRangeAttack = false
		end
		self.NextChangeTime = CurTime() + self.NextChangeCooldown
	end

	if self.Combat_Mode == 1 and self:IsOnGround() then
		self:SetLocalVelocity(self:GetMoveVelocity() * 6)
		self:SetPlaybackRate(1.25)
	end

	if self:IsOnFire() then
		self:Extinguish()
	end
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
    if self.bShieldActive then
		dmginfo:SubtractDamage(5)
        dmginfo:ScaleDamage(0.5)
    end
	if HORDE:IsFireDamage(dmginfo) or HORDE:IsLightningDamage(dmginfo) then
		dmginfo:ScaleDamage(0.75)
	elseif HORDE:IsColdDamage(dmginfo) then
		dmginfo:ScaleDamage(1.25)
	end
end

function ENT:CustomRangeAttackCode()
	local selfData = self:GetTable()
	-- Create projectile
	local p = math.random()
	if p <= 0.5 or self.Horde_Blasting then
		local projectile = ents.Create(selfData.RangeAttackEntityToSpawn)
		local target_pos = self:GetEnemy():GetPos()
		projectile:SetPos(self:GetPos() + self:GetUp()*selfData.RangeAttackPos_Up + self:GetForward()*selfData.RangeAttackPos_Forward)
		projectile:SetAngles((target_pos - projectile:GetPos()):Angle())
		projectile:SetOwner(self)
		projectile:SetPhysicsAttacker(self)
		projectile:Spawn()
		projectile:Activate()
		local phys = projectile:GetPhysicsObject()
		if IsValid(phys) then
			phys:Wake()
			local vel = (self:GetEnemy():GetPos() - projectile:GetPos())
			vel:Normalize()
			vel = vel * 200
			if self.Critical then
				timer.Simple(0.2, function ()
					if !IsValid(self) then return end
					local projectile2 = ents.Create("obj_vj_horde_homing_lightning")
					projectile2:SetPos(self:GetPos() + self:GetUp()*self.RangeAttackPos_Up + self:GetForward()*self.RangeAttackPos_Forward + self:GetRight()*self.RangeAttackPos_Right)
					projectile2:SetAngles((self:GetEnemy():GetPos() - projectile2:GetPos()):Angle())
					projectile2:SetOwner(self)
					projectile2:SetPhysicsAttacker(self)
					projectile2:Spawn()
					projectile2:Activate()
					local phys2 = projectile2:GetPhysicsObject()
					if IsValid(phys2) then
						phys2:Wake()
						local vel2 = (self:GetEnemy():GetPos() - projectile2:GetPos())
						vel2:Normalize()
						vel2 = vel2 * 200
						phys:SetVelocity(vel2)
					end
					self:CustomRangeAttackCode_AfterProjectileSpawn(projectile2)
				end)
			end
			phys:SetVelocity(vel)
			projectile:SetAngles(vel:GetNormal():Angle())
			self:CustomRangeAttackCode_AfterProjectileSpawn(projectile)
		end
	else
		-- Lightning blast
		--self.ChargeSound = VJ_CreateSound(self, "npc/strider/charging.wav")
		--self:VJ_ACT_PLAYACTIVITY("attack_beam_start1", true, 1, false)
		local pos = self:GetEnemy():GetPos()
		self.Horde_Blasting = true
		timer.Simple(0.5, function ()
			if !IsValid(self) or !IsValid(self:GetEnemy()) then return end
			local tr = util.TraceLine({
				start = self:GetPos() + self:GetUp() * 60,
				endpos = self:GetEnemy():GetPos(),
				filter = {self}
			})
			pos = tr.HitPos
			util.ParticleTracerEx("Weapon_Combine_Ion_Cannon", self:GetPos() + self:GetUp() * 60, pos, true, self:EntIndex(), -1)
			sound.Play("beams/beamstart5.wav", pos, 100, math.random(90, 110))

			timer.Simple(0.7, function ()
				if !IsValid(self) then return end
				local dmg = DamageInfo()
				dmg:SetDamage(70)
				dmg:SetDamageType(DMG_SHOCK)
				dmg:SetAttacker(self)
				dmg:SetInflictor(self)
				dmg:SetDamagePosition(pos)
				util.BlastDamageInfo(dmg, pos, 200)

				if self.Critical then
					local fire = ents.Create("horde_lightning_homing_fire")
					fire:SetOwner(self)
					fire:SetPos(pos)
					fire:Spawn()
				end

				HORDE:ApplyDebuffInRadius(HORDE.Status_Shock, pos, 200, 10, self)

				ParticleEffect("Weapon_Combine_Ion_Cannon_Explosion", pos, Angle(0,0,0), nil)
				sound.Play("ambient/explosions/explode_5.ogg", pos, 100, math.random(90, 110))
				self:VJ_ACT_PLAYACTIVITY("run")
				
				self.Horde_Blasting = nil
			end)
		end)
	end
end

VJ.AddNPC("Xen Psychic Unit","npc_vj_horde_xen_psychic_unit", "Zombies")