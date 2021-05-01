AddCSLuaFile( "shared.lua" )
include('shared.lua')
/*-----------------------------------------------
	*** Made by Homeless_Performer. --A bloated Drone that charges to enemies and goes kaboom, leaving behind small bombs. They can also shoot a stream of bile.
-----------------------------------------------*/
ENT.Model = "models/antlion.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 300
ENT.SightDistance = 30000
ENT.HullType = HULL_MEDIUM
ENT.AnimTbl_IdleStand = {ACT_IDLE}
--ENT.CustomBlood_Particle = {"blood_impact_yellow_01"} -- Particles to spawn when it's damaged
--ENT.CustomBlood_Decal = {"YellowBlood"} -- Decals to spawn when it's damaged -- Blood pool types after it dies
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"}
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage

ENT.NextAnyAttackTime_Melee = 2 -- How much time until it can use a attack again? | Counted in SecondsENT.MeleeAttackDamage = 15
ENT.TimeUntilMeleeAttackDamage = 0.7 -- This counted in seconds | This calculates the time until it hits something
ENT.HasExtraMeleeAttackSounds = false
ENT.MeleeAttackDamage = 15
ENT.MoveOrHideOnDamageByEnemy = true -- Should the SNPC move or hide when being damaged by an enemy?
ENT.MeleeAttackDistance = 40 -- How close does it have to be until it attacks?
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events

ENT.UsesBoneAngle = false -- This can be used to stop the corpse glitching or flying on death
ENT.HasDeathRagdoll = true
ENT.UsesDamageForceOnDeath = true -- Disables the damage force on death | Useful for SNPCs with Death Animations
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events

ENT.PushProps = true -- Should it push props when trying to move?
ENT.AttackProps = true -- Should it attack props when trying to move?

ENT.BringFriendsOnDeath = true -- Should the SNPC's friends come to its position before it dies?
ENT.BringFriendsOnDeathDistance = 10000 -- How far away does the signal go? | Counted in World Units
ENT.BringFriendsOnDeathUseCertainAmount = true -- Should the SNPC only call certain amount of people?
ENT.BringFriendsOnDeathUseCertainAmountNumber = 5 -- How many people should it call if certain amount is enabled?
ENT.AlertFriendsOnDeath = true -- Should the SNPCs allies get alerted when it dies? | Its allies will also need to have this variable set to true!
ENT.AlertFriendsOnDeathDistance = 10000 -- How far away does the signal go? | Counted in World Units
ENT.AlertFriendsOnDeathUseCertainAmountNumber = 50 -- How many people should it alert?
ENT.AnimTbl_AlertFriendsOnDeath = {"distract"}

ENT.CallForHelp = true -- Does the SNPC call for help?
ENT.CallForHelpDistance = 10000 -- -- How far away the SNPC's call for help goes | Counted in World Units
ENT.NextCallForHelpTime = 4 -- Time until it calls for help again
ENT.HasCallForHelpAnimation = true -- if true, it will play the call for help animation
ENT.AnimTbl_CallForHelp = {"distract"} -- Call For Help Animations
ENT.CallForHelpAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.CallForHelpAnimationPlayBackRate = 1.1 -- How fast should the animation play? | Currently only for gestures!
ENT.CallForHelpStopAnimations = true -- Should it stop attacks for a certain amount of time?
ENT.HasCallForHelpSounds = true -- If set to false, it won't play any sounds when it calls for help
ENT.TimeUntilLeapAttackDamage = 0.4 -- How much time until it runs the leap damage code?
ENT.OnlyDoKillEnemyWhenClear = true -- If set to true, it will only play the OnKilledEnemy sound when there isn't any other enemies

ENT.IsMedicSNPC = true -- Is this SNPC a medic? Does it heal other friendly friendly SNPCs, and players(If friendly)
ENT.AnimTbl_Medic_GiveHealth = {"Spit"} -- Animations is plays when giving health to an ally
ENT.Medic_CheckDistance = 100000 -- How far does it check for allies that are hurt? | World units
ENT.Medic_HealDistance = 100 -- How close does it have to be until it stops moving and heals its ally?
ENT.Medic_HealthAmount = 25 -- How health does it give?
ENT.Medic_NextHealTime1 = 5 -- How much time until it can give health to an ally again | First number in the math.random
ENT.Medic_NextHealTime2 = 10 -- How much time until it can give health to an ally again | Second number in the math.random
ENT.Medic_SpawnPropOnHeal = true -- Should it spawn a prop, such as small health vial at a attachment when healing an ally?
ENT.Medic_SpawnPropOnHealModel = "models/spitball_large.mdl" -- The model that it spawns

ENT.SlowPlayerOnMeleeAttack = true
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 120 
ENT.SlowPlayerOnMeleeAttackTime = 0.75 
ENT.BileAtk = false --- Do not touch. Checks if bug is vomiting
ENT.Stampede = false --- Do not touch. Checks if the bug is currently stampeding.

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_poisonball" -- The entity that is spawned when range attacking
ENT.AnimTbl_RangeAttack = {ACT_MELEE_ATTACK1} -- Range Attack Animations
ENT.RangeDistance = 3000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 250 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = 0.6 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 4 -- How much time until it can use a range attack?
ENT.NextAnyAttackTime_Range = 0.2 -- How much time until it can use a attack again? | Counted in Seconds

-----custom
ENT.move = true
ENT.move2 = false
ENT.move3 = false
ENT.Regen = false
ENT.Health1 = false
ENT.spotted = false
ENT.NextStrafeTime = CurTime()

	-- Sounds --
ENT.SoundTbl_FootStep = {"vj_alienswarm/drone/footstep1a.wav","vj_alienswarm/drone/footstep1b.wav"}
ENT.SoundTbl_LeapAttackDamage = {
"weapons/alien/alien_clawhit_flesh_tp_1.mp3",
"weapons/alien/alien_clawhit_flesh_tp_2.mp3",
"weapons/alien/alien_clawhit_flesh_tp_3.mp3",
"weapons/alien/alien_clawhit_flesh_tp_4.mp3",
"weapons/alien/alien_clawhit_flesh_tp_5.mp3"
}

ENT.SoundTbl_FootStep = {"npc/antlion/foot1.wav","npc/antlion/foot2.wav","npc/antlion/foot3.wav","npc/antlion/foot4.wav"}
ENT.SoundTbl_Idle = {"npc/headcrab_poison/ph_warning2.wav","npc/headcrab_poison/ph_warning3.wav","npc/headcrab_poison/ph_warning1.wav"}
ENT.SoundTbl_Alert = {"npc/headcrab_poison/ph_scream2.wav","npc/headcrab_poison/ph_scream3.wav","npc/headcrab_poison/ph_scream1.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/antlion/attack_single1.wav","npc/antlion/attack_single2.wav","npc/antlion/attack_single3.wav"}
--ENT.SoundTbl_MeleeAttackMiss = {"vj_alienswarm/drone/swipe01.wav","vj_alienswarm/drone/swipe02.wav","vj_alienswarm/drone/swipe03.wav"}
ENT.SoundTbl_Pain = {"npc/headcrab_poison/ph_pain1.wav","npc/headcrab_poison/ph_pain2.wav","npc/headcrab_poison/ph_pain3.wav"}
ENT.SoundTbl_Death = {"npc/headcrab_poison/ph_rattle2.wav","npc/headcrab_poison/ph_rattle1.wav","npc/headcrab_poison/ph_rattle3.wav"}

ENT.FootStepSoundLevel = 75
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnCallForHelp()
	timer.Simple(1,function()
		if IsValid(self) then
			ParticleEffectAttach("blood_impact_antlion_worker_01",PATTACH_POINT_FOLLOW,self,6)
			ParticleEffectAttach("antlion_spit_02",PATTACH_POINT_FOLLOW,self,6)
		end
	end)
end
-------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	timer.Simple(1.2,function() ParticleEffectAttach("blood_impact_antlion_worker_01",PATTACH_POINT_FOLLOW,GetCorpse,0) end)
	timer.Simple(1.6,function() ParticleEffectAttach("blood_impact_green_01",PATTACH_POINT_FOLLOW,GetCorpse,0) end)
	timer.Simple(2.4,function() ParticleEffectAttach("blood_impact_green_01",PATTACH_POINT_FOLLOW,GetCorpse,0) end)
	timer.Simple(3,function() ParticleEffectAttach("blood_impact_antlion_worker_01",PATTACH_POINT_FOLLOW,GetCorpse,0) end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_JUMP))
	self:CapabilitiesAdd(bit.bor(CAP_OPEN_DOORS))
	self:SetModelScale(0.85, 0)
	self.NextMoveAroundTime = 0
	self.NextBlockTime = 0
	self.onfire = false
	self.UsingMagic = false
	self:SetColor(Color(75, 0, 130))
	self:SetVar("is_elite", true)
end
----------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_BeforeStartTimer()
	if self.BileAtk == true then
			self.SoundTbl_MeleeAttackMiss = {""}
			self.SoundTbl_BeforeMeleeAttack = {"npc/antlion/attack_single1.wav","npc/antlion/attack_single2.wav","npc/antlion/attack_single3.wav"}
			--self.SoundTbl_MeleeAttack = {"roach/Roach_AttackImpactRanged1.wav","roach/Roach_AttackImpactRanged2.wav","roach/Roach_AttackImpactRanged3.wav"}
			timer.Simple(0.1,function() if IsValid(self) then
			local bile = "blood_impact_green_01"
			local vomit = "blood_zombie_split"
			local splat = "blood_impact_yellow_01"
			local pos1 = self:GetPos() + self:GetUp()*50 + self:GetForward()*40
			local pos2 = self:GetPos() + self:GetUp()*50 + self:GetForward()*110
			local pos3 = self:GetPos() + self:GetUp()*50 + self:GetForward()*140
			local pos4 = self:GetPos() + self:GetUp()*50 + self:GetForward()*160
			local pos5 = self:GetPos() + self:GetUp()*50 + self:GetForward()*200
			local pos6 = self:GetPos() + self:GetUp()*50 + self:GetForward()*220
			local pos7 = self:GetPos() + self:GetUp()*50 + self:GetForward()*260
			local pos8 = self:GetPos() + self:GetUp()*50 + self:GetForward()*300
			local pos9 = self:GetPos() + self:GetUp()*50 + self:GetForward()*320
			local pos10 = self:GetPos() + self:GetUp()*50 + self:GetForward()*345
			local pos11 = self:GetPos() + self:GetUp()*50 + self:GetForward()*365
			local pos12 = self:GetPos() + self:GetUp()*50 + self:GetForward()*380
			timer.Simple(0.2,function() if IsValid(self) then
				ParticleEffect(vomit,pos1,Angle(0,0,0),nil)
			end end)
			timer.Simple(0.23,function() if IsValid(self) then
				ParticleEffect(bile,pos2,Angle(0,0,0),nil)
			end end)
			timer.Simple(0.28,function() if IsValid(self) then
				ParticleEffect(bile,pos3,Angle(0,0,0),nil)
			end end)
			timer.Simple(0.33,function() if IsValid(self) then
				ParticleEffect(bile,pos4,Angle(0,0,0),nil)
			end end)
			timer.Simple(0.38,function() if IsValid(self) then
				ParticleEffect(bile,pos5,Angle(0,0,0),nil)
			end end)
			timer.Simple(0.43,function() if IsValid(self) then
				ParticleEffect(bile,pos6,Angle(0,0,0),nil)
			end end)
			timer.Simple(0.48,function() if IsValid(self) then
				ParticleEffect(bile,pos7,Angle(0,0,0),nil)
			end end)
			timer.Simple(0.53,function() if IsValid(self) then
				ParticleEffect(bile,pos8,Angle(0,0,0),nil)
			end end)
			timer.Simple(0.58,function() if IsValid(self) then
				ParticleEffect(bile,pos9,Angle(0,0,0),nil)
			end end)
			timer.Simple(0.63,function() if IsValid(self) then
				ParticleEffect(bile,pos10,Angle(0,0,0),nil)
			end end)
			timer.Simple(0.68,function() if IsValid(self) then
				ParticleEffect(bile,pos11,Angle(0,0,0),nil)
			end end)
			timer.Simple(0.73,function() if IsValid(self) then
				ParticleEffect(splat,pos12,Angle(0,0,0),nil)
			end end)
		end end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
    local randattack = math.random(1,2)

		if randattack == 1 then
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.MeleeAttackAngleRadius = 100 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
		self.MeleeAttackDamageAngleRadius = 100 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
		self.MeleeAttackDamageDistance = 40
		self.NextAnyAttackTime_Melee = 0.8
		self.MeleeAttackDamage = 14
		self.MeleeAttackDamageType = DMG_RADIATION	
		self.MeleeAttackKnockBack_Forward1 = 100 -- How far it will push you forward | First in math.random
		self.MeleeAttackKnockBack_Forward2 = 50 -- How far it will push you forward | Second in math.random
		self.MeleeAttackKnockBack_Up1 = 200 -- How far it will push you up | First in math.random
		self.MeleeAttackKnockBack_Up2 = 200 -- How far it will push you up | Second in math.random
		self.MeleeAttackKnockBack_Right1 = 0 -- How far it will push you right | First in math.random
		self.MeleeAttackKnockBack_Right2 = 0 -- How far it will push you right | Second in math.random
		self.BileAtk = true
			
		elseif randattack == 2 then
		self.AnimTbl_MeleeAttack = {"spit"}
		self.MeleeAttackAngleRadius = 100 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
		self.MeleeAttackDamageAngleRadius = 100 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
		self.MeleeAttackDamageDistance = 95
		self.NextAnyAttackTime_Melee = 1.2
		self.MeleeAttackDamage = 7
		self.BileAtk = true
		self.MeleeAttackDamageType = DMG_RADIATION
end 
end
-----------------------------------------
function ENT:CustomOnKilled(dmginfo,hitgroup,GetCorpse)
util.VJ_SphereDamage(self,self,self:GetPos(),130,10,DMG_POISON,true,true)
ParticleEffectAttach("blood_impact_antlion_worker_01",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("mouth"))
ParticleEffect("antlion_gib_02_gas",self:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)
ParticleEffect("antlion_gib_02_juice",self:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)
ParticleEffect("antlion_gib_02_floaters",self:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)
if dmginfo:GetAttacker():GetClass() == "npc_barnacle" && dmginfo:GetAttacker():IsNPC() then
dmginfo:GetAttacker():TakeDamage(60,self,self)
self.HasDeathRagdoll = false
end
end
------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(TheHitEntity)
if TheHitEntity:IsNPC() && TheHitEntity:GetClass() == "npc_combine_s" then
TheHitEntity:TakeDamage(50,self,self)
ParticleEffectAttach("blood_zombie_split",PATTACH_POINT_FOLLOW,TheHitEntity,0)
ParticleEffectAttach("vomit_barnacle",PATTACH_POINT_FOLLOW,TheHitEntity,0)
elseif TheHitEntity:IsNPC() then
TheHitEntity:TakeDamage(20,self,self)
ParticleEffectAttach("blood_zombie_split",PATTACH_POINT_FOLLOW,TheHitEntity,0)
ParticleEffectAttach("vomit_barnacle",PATTACH_POINT_FOLLOW,TheHitEntity,0)
end
end
------------------------------------------------------------------------
function ENT:VJ_TASK_GOTO_TARGET(MoveType,CustomCode)
	MoveType = MoveType or "TASK_RUN_PATH"
	local vsched = ai_vj_schedule.New("vj_goto_target")
	vsched:EngTask("TASK_GET_PATH_TO_ENEMY_LOS", 0)
	vsched:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
	--vsched:EngTask("TASK_FACE_TARGET", 1)
	--vsched:EngTask("TASK_FIND_COVER_FROM_ENEMY")
	vsched.IsMovingTask = true
	if MoveType == "TASK_RUN_PATH" then self:SetMovementActivity(VJ_PICKRANDOMTABLE(self.AnimTbl_Run)) vsched.IsMovingTask_Run = true else self:SetMovementActivity(VJ_PICKRANDOMTABLE(self.AnimTbl_Walk)) vsched.IsMovingTask_Walk = true end
	if (CustomCode) then CustomCode(vsched) end
	self:StartSchedule(vsched)
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
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
return (self:GetEnemy():GetPos() - self:LocalToWorld(Vector(-20,20):GetNormalized()))*2 +self:GetRight()+self:GetUp()*200 + self:GetEnemy():GetVelocity()*0.85
end
/*-----------------------------------------------
	*** Coded by Homeless_Performer.jpg. None of this code is to be taken and/or modified and uploaded elsewhere without permission. ***

-----------------------------------------------*/