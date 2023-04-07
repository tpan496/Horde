AddCSLuaFile("shared.lua")
include('shared.lua')


-- Core
ENT.Model = {"models/horde/gonarch/gonarch.mdl"}
ENT.StartHealth = 7000
ENT.HullType = HULL_LARGE

ENT.SightDistance = 10000 -- How far it can see
ENT.SightAngle = 100 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.TurningSpeed = 40 -- How fast it can turn
ENT.MaxJumpLegalDistance = VJ_Set(400, 550) -- The max distance the NPC can jump (Usually from one node to another) | ( UP, DOWN )
ENT.EntitiesToNoCollide = {"npc_vj_horde_baby_headcrab", "npc_headcrab"}

-- AI
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.ConstantlyFaceEnemy = true -- Should it face the enemy constantly?
ENT.ConstantlyFaceEnemy_IfAttacking = true -- Should it face the enemy when attacking?
ENT.ConstantlyFaceEnemy_Postures = "Standing" -- "Both" = Moving or standing | "Moving" = Only when moving | "Standing" = Only when standing
ENT.ConstantlyFaceEnemyDistance = 2000 -- How close does it have to be until it starts to face the enemy?
ENT.NoChaseAfterCertainRange = false -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = "UseRangeDistance" -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = "UseRangeDistance" -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "OnlyRange" -- "Regular" = Default behavior | "OnlyRange" = Only does it if it's able to range attack
ENT.InvestigateSoundDistance = 100 -- How far away can the SNPC hear sounds? | This number is timed by the calculated volume of the detectable sound.

ENT.AttackProps = true -- Should it attack props when trying to move?
ENT.PushProps = true -- Should it push props when trying to move?
ENT.PropAP_MaxSize = 2 -- This is a scale number for the max size it can attack/push | x < 1  = Smaller props & x > 1  = Larger props | Default base value: 1
ENT.FindEnemy_CanSeeThroughWalls = true -- Should it be able to see through walls and objects? | Can be useful if you want to make it know where the enemy is at all times

-- Damage/Injured
ENT.BloodColor = "Red"
ENT.Immune_Dissolve = true
ENT.Immune_Physics = true

-- Flinch
ENT.CanFlinch = 0 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.NextFlinchTime = 2
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS} -- If it uses normal based animation, use this
ENT.RunAwayOnUnknownDamage = false
ENT.CallForBackUpOnDamage = false

-- Melee
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {"claw", "claw_2", "claw_3"} -- Melee Attack Animations
ENT.MeleeAttackDistance = 60 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 150 -- How close does it have to be until it attacks?
ENT.TimeUntilMeleeAttackDamage = 0.5 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 30

-- Ranged
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_horde_gonarch_acid" -- The entity that is spawned when range attacking
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 500 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = 0.5 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 0.1 -- How much time until it can use a range attack?
ENT.NextRangeAttackTime_DoRand = 4 -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.RangeAttackPos_Up = 180 -- Up/Down spawning position for range attack

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
ENT.SoundTbl_FootStep = {"horde/gonarch/gon_step1.ogg","horde/gonarch/gon_step2.ogg","horde/gonarch/gon_step3.ogg"}
--ENT.SoundTbl_Idle = {"horde/gonarch/gon_sack1.ogg","horde/gonarch/gon_sack2.ogg","horde/gonarch/gon_sack3.ogg"}
ENT.SoundTbl_Alert = {"horde/gonarch/gon_alert1.ogg","horde/gonarch/gon_alert2.ogg","horde/gonarch/gon_alert3.ogg"}
ENT.SoundTbl_BeforeMeleeAttack = {"horde/gonarch/gon_attack1.ogg","horde/gonarch/gon_attack2.ogg","horde/gonarch/gon_attack3.ogg"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_BeforeRangeAttack = {"horde/gonarch/gon_attack1.ogg","horde/gonarch/gon_attack2.ogg","horde/gonarch/gon_attack3.ogg"}
ENT.SoundTbl_RangeAttack = {"horde/gonarch/gon_sack1.ogg","horde/gonarch/gon_sack2.ogg","horde/gonarch/gon_sack3.ogg"}
ENT.SoundTbl_Pain = {"horde/gonarch/gon_pain1.ogg","horde/gonarch/gon_pain2.ogg","horde/gonarch/gon_pain3.ogg"}
ENT.SoundTbl_Death = {"horde/gonarch/gon_die1.ogg"}
local sdBirth = {"horde/gonarch/gon_birth1.ogg", "horde/gonarch/gon_birth2.ogg", "horde/gonarch/gon_birth3.ogg"}
local sdBabyDeath = {"horde/gonarch/gon_childdie1.ogg", "horde/gonarch/gon_childdie2.ogg", "horde/gonarch/gonarch/gon_childdie3.ogg"}

ENT.Gonarch_NumBabies = 0
ENT.Gonarch_BabyLimit = 20
ENT.Gonarch_NextBirthT = 0
ENT.Gonarch_NextDeadBirthT = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
    self:SetCollisionBounds(Vector(80,80,180),Vector(-80,-80,0))
	self:SetModelScale(0.75)
    self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")

	self.Gonarch_NextBirthT = CurTime() + 3
	self.Gonarch_NumBabies = 0
end

---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Critical = nil
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
    if not self.Critical and (self:Health() < self:GetMaxHealth() * 0.6) then
        self.Critical = true
    end
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if HORDE:IsPhysicalDamage(dmginfo) then
		dmginfo:ScaleDamage(0.75)
	elseif HORDE:IsPoisonDamage(dmginfo) then
		dmginfo:ScaleDamage(0.5)
	elseif HORDE:IsBlastDamage(dmginfo) then
		dmginfo:ScaleDamage(1.25)
	end
end

function ENT:Gonarch_BabyDeath()
	-- Play a sound when one of the babies dies!
	self.Gonarch_NumBabies = self.Gonarch_NumBabies - 1
	if CurTime() > self.Gonarch_NextDeadBirthT then
		self.AllyDeathSoundT = 0
		self:PlaySoundSystem("AllyDeath", sdBabyDeath)
		self.Gonarch_NextDeadBirthT = CurTime() + 10
	end
end

function ENT:CustomOnThink_AIEnabled()
	-- Create baby headcrabs
	if self.Critical and self.Dead == false && IsValid(self:GetEnemy()) && self.PlayingAttackAnimation == false && CurTime() > self.Gonarch_NextBirthT && self.Gonarch_NumBabies < self.Gonarch_BabyLimit then
		self:VJ_ACT_PLAYACTIVITY(ACT_SPECIAL_ATTACK1, true, false, true)

		for i = 1, 3 do
			local bCrab = ents.Create("npc_vj_horde_headcrab_baby")
			if i == 1 then
				bCrab:SetPos(self:GetPos() + self:GetUp()*20)
			elseif i == 2 then
				bCrab:SetPos(self:GetPos() + self:GetUp()*20 + self:GetRight()*25)
			elseif i == 3 then
				bCrab:SetPos(self:GetPos() + self:GetUp()*20 + self:GetRight()*-25)
			end
			bCrab:SetAngles(self:GetAngles())
			bCrab.BabH_Mother = self
			bCrab.VJ_NPC_Class = self.VJ_NPC_Class
			bCrab:Spawn()
			bCrab:Activate()
			bCrab:SetOwner(self)
			self.Gonarch_NumBabies = self.Gonarch_NumBabies + 1
		end
		

		self.Gonarch_NextBirthT = CurTime() + 15
	end
end

function ENT:RangeAttackCode_GetShootPos(projectile)
	return (self:GetEnemy():GetPos() - self:GetPos()) *0.45 + self:GetUp() *600
end

VJ.AddNPC("Xen Host Unit","npc_vj_horde_xen_host_unit", "Zombies")