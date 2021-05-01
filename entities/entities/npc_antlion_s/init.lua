AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/antlion.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 150
ENT.HullType = HULL_MEDIUM
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
--ENT.CustomBlood_Particle = {"blood_impact_yellow_01"} -- Particles to spawn when it's damaged
--ENT.CustomBlood_Decal = {"yellowblood"} -- Decals to spawn when it's damaged
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Pool = {"vj_bleedout_yellow"} -- Blood pool types after it dies
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {"pounce1","pounce2"} -- Melee Attack Animations
ENT.MeleeAttackDistance = 60 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 125 -- How far does the damage go?
ENT.MeleeAttackDamage = 30
ENT.NextAnyAttackTime_Melee = 0.4 -- How much time until it can use a attack again? | Counted in SecondsENT.MeleeAttackDamage = 15
ENT.TimeUntilMeleeAttackDamage = 0.5 -- This counted in seconds | This calculates the time until it hits something
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.AnimTbl_CallForHelp = {"distract_arrived"} -- Call For Help Animations
ENT.Immune_AcidPoisonRadiation = false -- Immune to Acid, Poison and Radiation

ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.AnimTbl_LeapAttack = {"Jump_start"} -- Melee Attack Animations
ENT.LeapAttackDamage = GetConVarNumber("npc_alion_dmg_fly")
ENT.LeapAttackAnimationFaceEnemy = false
ENT.LeapAttackDamageType = DMG_SLASH
ENT.NextStrafeTime = CurTime()

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/antlion/foot1.wav","npc/antlion/foot2.wav","npc/antlion/foot3.wav","npc/antlion/foot4.wav"}
ENT.SoundTbl_Idle = {"npc/antlion/idle1.wav","npc/antlion/idle2.wav","npc/antlion/idle3.wav","npc/antlion/idle4.wav","npc/antlion/idle5.wav","snpc/halflife2betaxenians/betaantlion/growl1.wav","snpc/halflife2betaxenians/betaantlion/hiss1.wav","snpc/halflife2betaxenians/betaantlion/get_up1.wav","snpc/halflife2betaxenians/betaantlion/hiss2.wav","snpc/halflife2betaxenians/betaantlion/get_up1.wav"}
ENT.SoundTbl_Alert = {"npc/antlion/attack_double1.wav","npc/antlion/attack_double2.wav","npc/antlion/attack_double3.wav","snpc/halflife2betaxenians/betaantlion/charge1.wav","snpc/halflife2betaxenians/betaantlion/charge2.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/antlion/attack_single1.wav","npc/antlion/attack_single2.wav","npc/antlion/attack_single3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_alienswarm/drone/swipe01.wav","vj_alienswarm/drone/swipe02.wav","vj_alienswarm/drone/swipe03.wav"}
ENT.SoundTbl_Pain = {"npc/antlion/pain1.wav","npc/antlion/pain2.wav"}
ENT.SoundTbl_Death = {"npc/antlion/pain1.wav","npc/antlion/pain2.wav"}

ENT.FootStepSoundLevel = 55
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 90
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(25, 25, 70), Vector(-25, -25, 0))
	self:SetColor(Color(255, 100, 100 ))
	self:SetSkin(math.random(0,3))
	self:SetNoDraw(true)
	VJ_EmitSound(self,{"npc/antlion/digup1.wav"},100,math.random(100,100))
	timer.Simple(0.05,function() if IsValid(self) then self:VJ_ACT_PLAYACTIVITY("digout",true,false,true) end end)
	timer.Simple(0.2,function() if IsValid(self) then self:SetNoDraw(false) end end)
	self:SetVar("is_elite", true)
end

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnCallForHelp()
	timer.Simple(1,function()
		if IsValid(self) then
			ParticleEffectAttach("antlion_gib_02_gas",PATTACH_POINT_FOLLOW,self,6)
			ParticleEffectAttach("antlion_gib_02_floaters",PATTACH_POINT_FOLLOW,self,6)
		end
	end)
end
------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
local EnemyDistance = self:VJ_GetNearestPointToEntityDistance(self:GetEnemy(),self:GetPos():Distance(self:GetEnemy():GetPos()))
if EnemyDistance > 0 && EnemyDistance < 100 then
	local randattack_close = math.random(1,3)
		self.MeleeAttackDistance = 45
		if randattack_close == 1 then
			self.AnimTbl_MeleeAttack = {"pounce","pounce2"} -- Quick slash --
			self.MeleeAttackAngleRadius = 100 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
			self.MeleeAttackDamageAngleRadius = 100 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
			self.MeleeAttackDamageDistance = 55
			self.NextAnyAttackTime_Melee = 0.4
			self.MeleeAttackDamage = 4
			self.MeleeAttackDamageType = DMG_SLASH	
			self.SoundTbl_BeforeMeleeAttack = {"npc/antlion/attack_single1.wav","npc/antlion/attack_single2.wav","npc/antlion/attack_single3.wav"}

		elseif randattack_close == 2 then
			self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Charged slash --
			self.MeleeAttackAngleRadius = 100 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
			self.MeleeAttackDamageAngleRadius = 100 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
			self.MeleeAttackDamageDistance = 60
			self.NextAnyAttackTime_Melee = 0.4
			self.MeleeAttackDamage = 6
			self.MeleeAttackDamageType = DMG_SLASH	
			self.SoundTbl_BeforeMeleeAttack = {"npc/antlion/attack_single1.wav","npc/antlion/attack_single2.wav","npc/antlion/attack_single3.wav"}

		elseif randattack_close == 3 then 
			self.AnimTbl_MeleeAttack = {"Attack6","Attack2"} -- Double slash --
			self.MeleeAttackAngleRadius = 100 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
			self.MeleeAttackDamageAngleRadius = 100 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
			self.MeleeAttackDamageDistance = 75
			self.NextAnyAttackTime_Melee = 0.4
			self.MeleeAttackDamage = 9
			self.MeleeAttackDamageType = DMG_SLASH	
			self.SoundTbl_BeforeMeleeAttack = {"npc/antlion/attack_double1.wav","npc/antlion/attack_double2.wav","npc/antlion/attack_double3.wav"}
		end
	end
end
------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(TheHitEntity)
if TheHitEntity:IsNPC() && TheHitEntity:GetClass() == "npc_combine_s" then
TheHitEntity:TakeDamage(60,self,self)
ParticleEffect("blood_impact_red_01",TheHitEntity:GetPos(),Angle(0,0,0),nil)
elseif TheHitEntity:IsNPC() then
TheHitEntity:TakeDamage(15,self,self)
end
end
------------------------------------------------------------------------
function ENT:CustomOnLeapAttack()
timer.Simple(0,function() if IsValid(self) then self:VJ_ACT_PLAYACTIVITY("jump_glide",true,1.1,false)
VJ_EmitSound(self,"vj_as_egg/pain1.wav",80,80)
end end)
timer.Simple(0.6,function() if IsValid(self) then self:VJ_ACT_PLAYACTIVITY("jump_glide",true,1.1,false)
end end)
end
-------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
ParticleEffect("blood_zombie_split_spray",self:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
if IsValid(self:GetEnemy()) then
local EnemyDistance = self:VJ_GetNearestPointToEntityDistance(self:GetEnemy(),self:GetPos():Distance(self:GetEnemy():GetPos()))
	if EnemyDistance > 1500 then
		self.LeapDistance = 1500 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
		self.LeapToMeleeDistance = math.random(100,300)
		self.LeapAttackDamageDistance = 200
		self.LeapAttackVelocityForward = 650
		self.LeapAttackVelocityUp = 550

elseif EnemyDistance > 450 && EnemyDistance < 1500 then
		self.LeapDistance = 1000 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
		self.LeapToMeleeDistance = math.random(100,300)
		self.LeapAttackDamageDistance = 200
		self.LeapAttackVelocityForward = 700
		self.LeapAttackVelocityUp = 400

elseif EnemyDistance < 450 then
		self.LeapDistance = 450 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
		self.LeapToMeleeDistance = math.random(100,300)
		self.LeapAttackDamageDistance = 200
		self.LeapAttackVelocityForward = 750
		self.LeapAttackVelocityUp = 240
		end
	end
end
------------------------------------------------------------------------
function ENT:VJ_TASK_GOTO_TARGET(MoveType,CustomCode)
	MoveType = MoveType or "TASK_RUN_PATH"
	local vsched = ai_vj_schedule.New("vj_goto_target")
	vsched:EngTask("TASK_GET_PATH_TO_ENEMY_LOS", 0)
	vsched:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
	vsched:EngTask("TASK_FACE_TARGET", 1)
	vsched:EngTask("TASK_FIND_COVER_FROM_ENEMY")
	vsched.IsMovingTask = true
	if MoveType == "TASK_RUN_PATH" then self:SetMovementActivity(VJ_PICKRANDOMTABLE(self.AnimTbl_Run)) vsched.IsMovingTask_Run = true else self:SetMovementActivity(VJ_PICKRANDOMTABLE(self.AnimTbl_Walk)) vsched.IsMovingTask_Walk = true end
	if (CustomCode) then CustomCode(vsched) end
	self:StartSchedule(vsched)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo,hitgroup)
	if dmginfo:GetDamageForce():Length() > 7500 then
	self.HasDeathRagdoll = false
	ParticleEffect("antliongib",self:GetPos(),Angle(0,0,0),nil)
	ParticleEffect("blood_zombie_split_spray",self:GetPos(),Angle(0,0,0),nil)
	ParticleEffect("blood_zombie_split",self:GetPos(),Angle(0,0,0),nil)
	end
end
------------------------------------------------------------------------
function ENT:StrafingMechanics()
local canstrafe = self:VJ_CheckAllFourSides(120)
if canstrafe.Right == true and canstrafe.Left == true then
local randstrafe = math.random(1,2)
if randstrafe == 1 then self:VJ_ACT_PLAYACTIVITY(ACT_TURN_LEFT,true,1.3,false) else self:VJ_ACT_PLAYACTIVITY(ACT_TURN_RIGHT,true,1.3,false) end
elseif canstrafe.Left == true and canstrafe.Right == false then
self:VJ_ACT_PLAYACTIVITY(ACT_TURN_LEFT,true,1.3,false)
elseif canstrafe.Right == true and canstrafe.Left == false then
self:VJ_ACT_PLAYACTIVITY(ACT_TURN_RIGHT,true,1.3,false)
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_OnBleed(dmginfo,hitgroup)
	if dmginfo:IsDamageType( DMG_PHYSGUN ) then
		self:VJ_ACT_PLAYACTIVITY("flip1",true,4,false)
		self.MovementType = VJ_MOVETYPE_STATIONARY
		self.CanTurnWhileStationary = false
		self.HasMeleeAttack = false
		timer.Simple(5,function() if IsValid(self) then
		self.HasMeleeAttack = true
		self.MovementType = VJ_MOVETYPE_GROUND
		end
	end)
end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/