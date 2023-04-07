AddCSLuaFile("shared.lua")
include('shared.lua')

-- Core
ENT.Model = {"models/horde/gonome/gonome.mdl"}
ENT.StartHealth = 7500
ENT.HullType = HULL_MEDIUM_TALL

ENT.SightDistance = 10000 -- How far it can see
ENT.SightAngle = 100 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.TurningSpeed = 40 -- How fast it can turn
ENT.MaxJumpLegalDistance = VJ_Set(400, 550) -- The max distance the NPC can jump (Usually from one node to another) | ( UP, DOWN )

-- AI
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"}
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
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 35 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 90 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.6 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.8 -- How much time until it can use any attack again? | Counted in Seconds
ENT.MeleeAttackDamage = 40
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.MeleeAttackWorldShakeOnMiss = true
ENT.MeleeAttackWorldShakeOnMissAmplitude = 8

-- Ranged
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.RangeAttackEntityToSpawn = "obj_vj_horde_gonome_acid" -- The entity that is spawned when range attacking
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.RangeUseAttachmentForPos = false -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "Mouth" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.TimeUntilRangeAttackProjectileRelease = 1.5 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 5 -- How much time until it can use a range attack?
ENT.NextAnyAttackTime_Range = 0.5 -- How much time until it can use any attack again? | Counted in Seconds

-- Leap
ENT.HasLeapAttack = false
ENT.AnimTbl_LeapAttack = {ACT_RANGE_ATTACK2}
ENT.LeapAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.NextLeapAttackTime = 15
ENT.LeapAttackVelocityForward = 400
ENT.LeapAttackVelocityUp = 0
ENT.LeapAttackDamageDistance = 150

-- Knockback
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 100 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 100 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 10 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 10 -- How far it will push you up | Second in math.random
ENT.MeleeAttackKnockBack_Right1 = 0 -- How far it will push you right | First in math.random
ENT.MeleeAttackKnockBack_Right2 = 0 -- How far it will push you right | Second in math.random

ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
ENT.PushProps = true -- Should it push props when trying to move?
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
ENT.MeleeAttackSoundPitch1 = "UseGeneralPitch"
ENT.MeleeAttackSoundPitch2 = "UseGeneralPitch"
ENT.ExtraMeleeSoundPitch1 = 100
ENT.ExtraMeleeSoundPitch2 = 100
ENT.MeleeAttackMissSoundPitch1 = 100
ENT.MeleeAttackMissSoundPitch2 = 100
ENT.BeforeRangeAttackPitch1 = "UseGeneralPitch"
ENT.BeforeRangeAttackPitch2 = "UseGeneralPitch"
ENT.RangeAttackPitch1 = "UseGeneralPitch"
ENT.RangeAttackPitch2 = "UseGeneralPitch"
ENT.BeforeLeapAttackSoundPitch1 = "UseGeneralPitch"
ENT.BeforeLeapAttackSoundPitch2 = "UseGeneralPitch"
ENT.LeapAttackJumpSoundPitch1 = "UseGeneralPitch"
ENT.LeapAttackJumpSoundPitch2 = "UseGeneralPitch"
ENT.LeapAttackDamageSoundPitch1 = "UseGeneralPitch"
ENT.LeapAttackDamageSoundPitch2 = "UseGeneralPitch"
ENT.LeapAttackDamageMissSoundPitch1 = "UseGeneralPitch"
ENT.LeapAttackDamageMissSoundPitch2 = "UseGeneralPitch"
ENT.OnKilledEnemySoundPitch1 = "UseGeneralPitch"
ENT.OnKilledEnemySoundPitch2 = "UseGeneralPitch"
ENT.PainSoundPitch1 = "UseGeneralPitch"
ENT.PainSoundPitch2 = "UseGeneralPitch"
ENT.ImpactSoundPitch1 = 100
ENT.ImpactSoundPitch2 = 100
ENT.DamageByPlayerPitch1 = "UseGeneralPitch"
ENT.DamageByPlayerPitch2 = "UseGeneralPitch"
ENT.DeathSoundPitch1 = "UseGeneralPitch"
ENT.DeathSoundPitch2 = "UseGeneralPitch"

    -- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"horde/gonome/gonome_step1.ogg","horde/gonome/gonome_step2.ogg","horde/gonome/gonome_step3.ogg","horde/gonome/gonome_step4.ogg"}
ENT.SoundTbl_Idle = {"horde/gonome/gonome_idle1.ogg","horde/gonome/gonome_idle2.ogg"}
ENT.SoundTbl_MeleeAttack = {"horde/gonome/gonome_melee1.ogg","horde/gonome/gonome_melee2.ogg"}
ENT.SoundTbl_MeleeAttackMiss = {"horde/gonome/gonome_melee1.ogg","horde/gonome/gonome_melee2.ogg"}
ENT.SoundTbl_BeforeLeapAttack = nil
ENT.SoundTbl_LeapAttackJump = {"horde/gonome/gonome_jumpattack.ogg"}
ENT.SoundTbl_Pain = {"horde/gonome/gonome_pain1.ogg","horde/gonome/gonome_pain2.ogg","horde/gonome/gonome_pain3.ogg","horde/gonome/gonome_pain4.ogg"}
ENT.SoundTbl_Death = {"horde/gonome/gonome_death.ogg"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
    self:SetCollisionBounds(Vector(20, 20, 85), Vector(-20, -20, 0))
    self:SetSkin(1)
    self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
    return (self:GetEnemy():GetPos() - self:LocalToWorld(Vector(math.random(-30,30),math.random(-30,30),math.random(20,30))))*2 + self:GetUp()*300
end
function ENT:CustomOnThink()
	if self.Critical and self:IsOnGround() then
		self:SetLocalVelocity(self:GetMoveVelocity() * 1.5)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Critical = nil
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
    if not self.Critical and self:Health() < self:GetMaxHealth() / 2 then
        self.Critical = true
        self.HasRangeAttack = false
        self.HasLeapAttack = true
        self.AnimationPlaybackRate = 1.75
        self:SetColor(Color(255,0,0))
        self:SetRenderMode(RENDERMODE_TRANSCOLOR)
    end
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if HORDE:IsPoisonDamage(dmginfo) then
		dmginfo:ScaleDamage(0.75)
    elseif HORDE:IsLightningDamage(dmginfo) then
        dmginfo:ScaleDamage(1.25)
    end
end

VJ.AddNPC("Alpha Gonome","npc_vj_alpha_gonome", "Zombies")