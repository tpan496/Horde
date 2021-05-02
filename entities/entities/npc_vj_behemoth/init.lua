AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/horde/gonome_beast/gonome.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 8000
ENT.HullType = HULL_MEDIUM
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackExtraTimers = {1.0} -- Extra melee attack timers | it will run the damage code after the given amount of seconds
ENT.MeleeAttackDistance = 35 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 80 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.6 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 40
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.4 -- Next foot step sound when it is walking
ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, posion, radiation
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, posion, radiation
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 5 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = true -- Should the player bleed when attacked by melee
ENT.MeleeAttackBleedEnemyChance = 3 -- How chance there is that the play will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 4 -- How many reps?
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
ENT.FootStepPitch1 = 25
ENT.FootStepPitch2 = 25
ENT.BreathSoundPitch1 = 25
ENT.BreathSoundPitch2 = 25
ENT.IdleSoundPitch1 = 25
ENT.IdleSoundPitch2 = 25
ENT.CombatIdleSoundPitch1 = 25
ENT.CombatIdleSoundPitch2 = 25
ENT.OnReceiveOrderSoundPitch1 = 50
ENT.OnReceiveOrderSoundPitch2 = 50
ENT.FollowPlayerPitch1 = 50
ENT.FollowPlayerPitch2 = 50
ENT.UnFollowPlayerPitch1 = 50
ENT.UnFollowPlayerPitch2 = 50
ENT.BeforeHealSoundPitch1 = 50
ENT.BeforeHealSoundPitch2 = 50
ENT.AfterHealSoundPitch1 = 50
ENT.AfterHealSoundPitch2 = 50
ENT.OnPlayerSightSoundPitch1 = 50
ENT.OnPlayerSightSoundPitch2 = 50
ENT.AlertSoundPitch1 = 50
ENT.AlertSoundPitch2 = 50
ENT.CallForHelpSoundPitch1 = 50
ENT.CallForHelpSoundPitch2 = 50
ENT.BecomeEnemyToPlayerPitch1 = 50
ENT.BecomeEnemyToPlayerPitch2 = 50
ENT.BeforeMeleeAttackSoundPitch1 = 50
ENT.BeforeMeleeAttackSoundPitch2 = 50
ENT.MeleeAttackSoundPitch1 = 25
ENT.MeleeAttackSoundPitch2 = 25
ENT.ExtraMeleeSoundPitch1 = 25
ENT.ExtraMeleeSoundPitch2 = 25
ENT.MeleeAttackMissSoundPitch1 = 25
ENT.MeleeAttackMissSoundPitch2 = 25
ENT.BeforeRangeAttackPitch1 = 50
ENT.BeforeRangeAttackPitch2 = 50
ENT.RangeAttackPitch1 = 50
ENT.RangeAttackPitch2 = 50
ENT.BeforeLeapAttackSoundPitch1 = 50
ENT.BeforeLeapAttackSoundPitch2 = 50
ENT.LeapAttackJumpSoundPitch1 = 50
ENT.LeapAttackJumpSoundPitch2 = 50
ENT.LeapAttackDamageSoundPitch1 = 50
ENT.LeapAttackDamageSoundPitch2 = 50
ENT.LeapAttackDamageMissSoundPitch1 = 50
ENT.LeapAttackDamageMissSoundPitch2 = 50
ENT.OnKilledEnemySoundPitch1 = 50
ENT.OnKilledEnemySoundPitch2 = 50
ENT.PainSoundPitch1 = 25
ENT.PainSoundPitch2 = 25
ENT.ImpactSoundPitch1 = 25
ENT.ImpactSoundPitch2 = 25
ENT.DamageByPlayerPitch1 = 25
ENT.DamageByPlayerPitch2 = 25
ENT.DeathSoundPitch1 = 25
ENT.DeathSoundPitch2 = 25

ENT.SoundTbl_BeforeRangeAttack = nil
ENT.SoundTbl_FootStep = {"horde/gonome/gonome_step1.wav","horde/gonome/gonome_step2.wav","horde/gonome/gonome_step3.wav","horde/gonome/gonome_step4.wav"}
ENT.SoundTbl_Idle = {"horde/gonome/gonome_idle1.wav","horde/gonome/gonome_idle2.wav"}
ENT.SoundTbl_MeleeAttack = {"horde/gonome/gonome_melee1.wav","horde/gonome/gonome_melee2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"horde/gonome/gonome_melee1.wav","horde/gonome/gonome_melee2.wav"}
ENT.SoundTbl_Pain = {"horde/gonome/gonome_pain1.wav","horde/gonome/gonome_pain2.wav","horde/gonome/gonome_pain3.wav","horde/gonome/gonome_pain4.wav"}
ENT.SoundTbl_Death = {"horde/gonome/gonome_death.wav"}
ENT.SoundTbl_SoundTrack = nil
ENT.NextBlastTime = CurTime()
ENT.NextBlastCooldown = 5
ENT.NextSummonTime = CurTime()
ENT.HaveSpawned = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self:SetLocalVelocity(self:GetMoveVelocity() * 1.5)

	if CurTime() > self.NextSummonTime then
		if (!IsValid(self.drone) or !IsValid(self.anotherone) or !IsValid(self.drone1) or !IsValid(self.drone2)) && self.HaveSpawned == false then
			self.HaveSpawned = true
			self:VJ_ACT_PLAYACTIVITY("big_flinch",true,1.5,false)
			self.resurrect = CreateSound(self, Sound("ambient/creatures/town_zombie_call1.wav")) self.resurrect:SetSoundLevel(100)
			self.resurrect:PlayEx(1,100)

			if !IsValid(self.drone) then
				self.drone = ents.Create("npc_vj_vomitter")
				self.drone:SetPos(self:GetPos() +self:GetRight()*85)
				self.drone:SetAngles(self:GetAngles())
				self.drone:Spawn()
				self.drone:SetNoDraw(true)
				timer.Simple(0.3,function() if IsValid(self.drone) then self.drone:SetNoDraw(false) end end)
				self.drone:SetOwner(self)
			end
			
			if !IsValid(self.anotherone) then
				self.anotherone = ents.Create("npc_vj_lurker")
				self.anotherone:SetPos(self:GetPos() +self:GetRight()*-85)
				self.anotherone:SetAngles(self:GetAngles())
				self.anotherone:Spawn()
				self.anotherone:SetNoDraw(true)
				timer.Simple(0.3,function() if IsValid(self.anotherone) then self.anotherone:SetNoDraw(false) end end)
				self.anotherone:SetOwner(self)
			end

			if !IsValid(self.drone1) then
				self.drone1 = ents.Create("npc_fastzombie")
				self.drone1:SetPos(self:GetPos() -self:GetForward()*85)
				self.drone1:SetAngles(self:GetAngles())
				self.drone1:Spawn()
				self.drone1:SetNoDraw(true)
				timer.Simple(0.3,function() if IsValid(self.drone1) then self.drone1:SetNoDraw(false) end end)
				self.drone1:SetOwner(self)
			end

			if !IsValid(self.drone2) then
				self.drone2 = ents.Create("npc_vj_zss_zp1")
				self.drone2:SetPos(self:GetPos() +self:GetForward()*85)
				self.drone2:SetAngles(self:GetAngles())
				self.drone2:Spawn()
				self.drone2:SetNoDraw(true)
				timer.Simple(0.3,function() if IsValid(self.drone2) then self.drone2:SetNoDraw(false) end end)
				self.drone2:SetOwner(self)
			end
			
			self.HaveSpawned = false
			self.NextSummonTime = CurTime() + 10
		end
	elseif self.Critical and CurTime() > self.NextBlastTime then
		sound.Play("weapons/physcannon/physcannon_charge.wav", self:GetPos())
		self:VJ_ACT_PLAYACTIVITY("big_flinch", true, 1.5, false)
		timer.Simple(1.5, function()
			local blast = ents.Create("prop_combine_ball")
			blast:SetPos(self:GetPos())
			blast:SetParent(self)
			blast:Spawn()
			blast:Fire("explode","",0)
			local dmg = DamageInfo()
			dmg:SetAttacker(self)
			dmg:SetInflictor(self)
			dmg:SetDamageType(DMG_CRUSH)
			dmg:SetDamage(45)
			util.BlastDamageInfo(dmg, self:GetPos(), 400)
		end)
		self.NextBlastTime = CurTime() + self.NextBlastCooldown
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(25, 25, 90), Vector(-25, -25, 0))
	self:SetModelScale(1.25)
	self:SetColor(100, 50, 50)
	self:SetRenderMode(RENDERMODE_TRANSCOLOR)
end


function ENT:MultipleMeleeAttacks()
	local EnemyDistance = self:VJ_GetNearestPointToEntityDistance(self:GetEnemy(),self:GetPos():Distance(self:GetEnemy():GetPos()))
	if EnemyDistance < 100 then
		local randattack = math.random(1,2)
		if randattack == 1 then
			self.MeleeAttackDistance = 35
			self.TimeUntilMeleeAttackDamage = 0.6
			self.MeleeAttackAnimationFaceEnemy = false
			self.AnimTbl_MeleeAttack = {"vjseq_attack1"}
			self.MeleeAttackExtraTimers = {1.0}
			self.MeleeAttackDamage = 30
			self.MeleeAttackDamageDistance = 120
			self.MeleeAttackDamageType = DMG_SLASH
			
		elseif randattack == 2 then
			self.MeleeAttackDistance = 35
			self.TimeUntilMeleeAttackDamage = 0.7
			self.MeleeAttackAnimationFaceEnemy = false
			self.AnimTbl_MeleeAttack = {"vjseq_attack2"}
			self.MeleeAttackExtraTimers = {0.9,1.2,1.4}
			self.MeleeAttackDamage = 40
			self.MeleeAttackDamageDistance = 100
			self.MeleeAttackDamageType = DMG_SLASH
		end
	end
end

function ENT:CustomOnMeleeAttack_AfterChecks(TheHitEntity)
	ParticleEffect("vomit_barnacle",TheHitEntity:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)
	ParticleEffect("blood_impact_green_01",TheHitEntity:GetPos(),Angle(0,0,0),nil)
	ParticleEffect("antlion_gib_02_gas",TheHitEntity:GetPos(),Angle(0,0,0),nil)
	ParticleEffect("antlion_gib_02_gas",TheHitEntity:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)
	ParticleEffect("antlion_gib_02_juice",TheHitEntity:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
     return (self:GetEnemy():GetPos() - self:LocalToWorld(Vector(math.random(-10,20),math.random(-10,20),math.random(10,20))))*2 + self:GetUp()*200
end

ENT.Critical = false
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
    if not self.Critical and self:Health() < self:GetMaxHealth() / 2 then
        self.Critical = true
    end
end

VJ.AddNPC("Behemoth","npc_vj_behemoth", "Zombies")
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/