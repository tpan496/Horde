AddCSLuaFile( "shared.lua" )
include('shared.lua')
/*-----------------------------------------------
	*** Made by Homeless_Performer. --The Griever. A beast made only be bring grief in the hearts of those who encounter it. A creature of nightmares.
-----------------------------------------------*/
ENT.Model = "models/antlion.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 7500
ENT.SightDistance = 30000
ENT.HullType = HULL_MEDIUM
ENT.AnimTbl_IdleStand = {ACT_IDLE}
--ENT.CustomBlood_Particle = {"vj_impact1_green"} -- Particles to spawn when it's damaged
--ENT.CustomBlood_Decal = {"YellowBlood"} -- Decals to spawn when it's damaged -- Blood pool types after it dies
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"}
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
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 90 
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 105 
ENT.SlowPlayerOnMeleeAttackTime = 2 
ENT.BileAtk = false --- Do not touch. Checks if bug is vomiting
ENT.Stampede = false --- Do not touch. Checks if the bug is currently stampeding.

-----custom
ENT.spotted = false
ENT.NextStrafeTime = CurTime()
ENT.GasBlast = false
ENT.Dead = false
ENT.NextSummonTime = 2
ENT.HaveSpawned = false

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
ENT.SoundTbl_Idle = {"asw2k/drone/breath_1.wav","asw2k/drone/breath_2.wav","asw2k/drone/breath_3.wav","asw2k/drone/breath_4.wav","asw2k/drone/breath_5.wav","asw2k/drone/breath_6.wav"}
ENT.SoundTbl_Alert = {"asw2k/drone/imp_sight_1.wav","asw2k/drone/imp_sight_2.wav","asw2k/drone/imp_sight_3.wav","asw2k/drone/imp_sight_4.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/antlion/attack_single1.wav","npc/antlion/attack_single2.wav","npc/antlion/attack_single3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_alienswarm/drone/swipe01.wav","vj_alienswarm/drone/swipe02.wav","vj_alienswarm/drone/swipe03.wav"}
ENT.SoundTbl_Pain = {"asw2k/drone/pain_1.wav","asw2k/drone/pain_2.wav","asw2k/drone/pain_3.wav"}
ENT.SoundTbl_Death = {"asw2k/drone/imp_death_1.wav","asw2k/drone/imp_death_2.wav","asw2k/drone/imp_death_3.wav","asw2k/drone/imp_death_4.wav"}

ENT.GeneralSoundPitch1 = 110
ENT.GeneralSoundPitch2 = 90
ENT.FootStepSoundLevel = 75
ENT.Critical = nil
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
    if not self.Critical and self:Health() < self:GetMaxHealth() / 2 then
        self.Critical = true
		self.drone:Remove()
		self.anotherone:Remove()
    end
end
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
	self:SetModelScale(2)
	ParticleEffectAttach("antlion_gib_02_gas",PATTACH_POINT_FOLLOW,self,6)
	ParticleEffectAttach("antlion_gib_02_floaters",PATTACH_POINT_FOLLOW,self,6)
	self.NextMoveAroundTime = 0
	self.NextBlockTime = 0
	self.onfire = false
	self:SetColor(Color(255, 100, 100 ))
	self.UsingMagic = false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
local EnemyDistance = self:VJ_GetNearestPointToEntityDistance(self:GetEnemy(),self:GetPos():Distance(self:GetEnemy():GetPos()))
if EnemyDistance > 0 && EnemyDistance < 100 then
	local randattack_close = math.random(1,4)
		if randattack_close == 1 then
			self.AnimTbl_MeleeAttack = {"pounce","pounce2"} -- Quick slash --
			self.MeleeAttackAngleRadius = 100 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
			self.MeleeAttackDamageAngleRadius = 100 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
			self.MeleeAttackDamageDistance = 55
			self.NextAnyAttackTime_Melee = 0.4
			self.MeleeAttackDamage = 10
			self.MeleeAttackDistance = 45
			self.MeleeAttackDamageType = DMG_SLASH	
			self.SoundTbl_BeforeMeleeAttack = {"npc/antlion/attack_single1.wav","npc/antlion/attack_single2.wav","npc/antlion/attack_single3.wav"}

		elseif randattack_close == 2 then
			self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Charged slash --
			self.MeleeAttackAngleRadius = 100 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
			self.MeleeAttackDamageAngleRadius = 100 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
			self.MeleeAttackDamageDistance = 60
			self.NextAnyAttackTime_Melee = 0.4
			self.MeleeAttackDamage = 17
			self.MeleeAttackDistance = 45
			self.MeleeAttackDamageType = DMG_SLASH	
			self.SoundTbl_BeforeMeleeAttack = {"npc/antlion/attack_single1.wav","npc/antlion/attack_single2.wav","npc/antlion/attack_single3.wav"}

		elseif randattack_close == 3 then 
			self.AnimTbl_MeleeAttack = {"Attack6","Attack2"} -- Double slash --
			self.MeleeAttackAngleRadius = 100 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
			self.MeleeAttackDamageAngleRadius = 100 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
			self.MeleeAttackDamageDistance = 75
			self.NextAnyAttackTime_Melee = 0.4
			self.MeleeAttackDamage = 20
			self.MeleeAttackDistance = 45
			self.MeleeAttackDamageType = DMG_SLASH	
			self.SoundTbl_BeforeMeleeAttack = {"npc/antlion/attack_double1.wav","npc/antlion/attack_double2.wav","npc/antlion/attack_double3.wav"}

		elseif randattack_close == 4 then 
			self.AnimTbl_MeleeAttack = {"Distract"} -- Gas blast --
			self.MeleeAttackAngleRadius = 180 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
			self.MeleeAttackDamageAngleRadius = 180 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
			self.MeleeAttackDamageDistance = 250
			self.NextAnyAttackTime_Melee = 2
			self.MeleeAttackDistance = 220
			self.MeleeAttackDamage = 150
			self.TimeUntilMeleeAttackDamage = 1
			self.MeleeAttackDamageType = DMG_BLAST	
			self.SoundTbl_BeforeMeleeAttack = {"npc/antlion/attack_double1.wav","npc/antlion/attack_double2.wav","npc/antlion/attack_double3.wav"}
		end

		if self.Critical then
			self.GasBlast = true
		else
			self.GasBlast = false
		end
	end
end
------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(TheHitEntity)
if TheHitEntity:IsNPC() && TheHitEntity:GetClass() == "npc_combine_s" or TheHitEntity:GetClass() == "npc_hunter" then
TheHitEntity:TakeDamage(200,self,self)
ParticleEffect("vomit_barnacle",TheHitEntity:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)
ParticleEffect("blood_impact_green_01",TheHitEntity:GetPos(),Angle(0,0,0),nil)
ParticleEffect("antlion_gib_02_gas",TheHitEntity:GetPos(),Angle(0,0,0),nil)
ParticleEffect("antlion_gib_02_gas",TheHitEntity:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)
ParticleEffect("antlion_gib_02_juice",TheHitEntity:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)
end
if self.GasBlast == true then
	local blast = ents.Create("prop_combine_ball")
	blast:SetPos(self:GetPos())
	blast:SetParent(self)
	blast:Spawn()
	blast:Fire("explode","",0)
	util.VJ_SphereDamage(self,self,self:GetPos(),400,25,self.MeleeAttackDamageType,true,true,{DisableVisibilityCheck=true,Force=150})
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
function ENT:CustomOnThink()
	ParticleEffectAttach("antlion_gib_02_gas",PATTACH_POINT_FOLLOW,self,6)
	ParticleEffectAttach("antlion_gib_02_floaters",PATTACH_POINT_FOLLOW,self,6)
	if IsValid(self:GetEnemy()) && CurTime() > self.NextSummonTime then
		if (!IsValid(self.drone) or !IsValid(self.anotherone)) && self.HaveSpawned == false && ((self.VJ_IsBeingControlled == false) or (self.VJ_IsBeingControlled == true && self.VJ_TheController:KeyDown(IN_JUMP))) then
			self.HaveSpawned = true
			self:VJ_ACT_PLAYACTIVITY("distract",true,1.5,false)
			ParticleEffect("antlion_gib_02_gas",self:GetPos(),Angle(0,0,0),nil)
			ParticleEffect("antlion_gib_02_floaters",self:GetPos(),Angle(0,0,0),nil)
			self.resurrect = CreateSound(self, Sound("ambient/creatures/town_zombie_call1.wav")) self.resurrect:SetSoundLevel(100)
			self.resurrect:PlayEx(1,100)

			if not self.Critical then
				if !IsValid(self.drone) then
					self.drone = ents.Create("npc_antlion_s")
					self.drone:SetPos(self:GetPos() +self:GetRight()*85)
					self.drone:SetAngles(self:GetAngles())
					self.drone:Spawn()
					self.drone:SetNoDraw(true)
					timer.Simple(0.3,function() if IsValid(self.drone) then self.drone:SetNoDraw(false) end end)
					self.drone:VJ_ACT_PLAYACTIVITY("digout",true,0.6,true,0,{SequenceDuration=0.6})
					self.drone:SetOwner(self)
				end

				if !IsValid(self.anotherone) then
					self.anotherone = ents.Create("npc_antlion_s")
					self.anotherone:SetPos(self:GetPos() +self:GetRight()*-85)
					self.anotherone:SetAngles(self:GetAngles())
					self.anotherone:Spawn()
					self.anotherone:SetNoDraw(true)
					timer.Simple(0.3,function() if IsValid(self.anotherone) then self.anotherone:SetNoDraw(false) end end)
					self.anotherone:VJ_ACT_PLAYACTIVITY("digout",true,0.6,true,0,{SequenceDuration=0.6})
					self.anotherone:SetOwner(self)
				end

				if !IsValid(self.drone1) then
					self.drone1 = ents.Create("npc_antlion_s")
					self.drone1:SetPos(self:GetPos() + self:GetForward()*85)
					self.drone1:SetAngles(self:GetAngles())
					self.drone1:Spawn()
					self.drone1:SetNoDraw(true)
					timer.Simple(0.3,function() if IsValid(self.drone1) then self.drone1:SetNoDraw(false) end end)
					self.drone1:VJ_ACT_PLAYACTIVITY("digout",true,0.6,true,0,{SequenceDuration=0.6})
					self.drone1:SetOwner(self)
				end

				if !IsValid(self.drone2) then
					self.drone2 = ents.Create("npc_antlion_s")
					self.drone2:SetPos(self:GetPos() - self:GetForward()*85)
					self.drone2:SetAngles(self:GetAngles())
					self.drone2:Spawn()
					self.drone2:SetNoDraw(true)
					timer.Simple(0.3,function() if IsValid(self.drone2) then self.drone2:SetNoDraw(false) end end)
					self.drone2:VJ_ACT_PLAYACTIVITY("digout",true,0.6,true,0,{SequenceDuration=0.6})
					self.drone2:SetOwner(self)
				end
			else
				if !IsValid(self.drone) then
					self.drone = ents.Create("npc_antlion_poison")
					self.drone:SetPos(self:GetPos() +self:GetRight()*85)
					self.drone:SetAngles(self:GetAngles())
					self.drone:Spawn()
					self.drone:SetNoDraw(true)
					timer.Simple(0.3,function() if IsValid(self.drone) then self.drone:SetNoDraw(false) end end)
					self.drone:VJ_ACT_PLAYACTIVITY("digout",true,0.6,true,0,{SequenceDuration=0.6})
					self.drone:SetOwner(self)
				end

				if !IsValid(self.anotherone) then
					self.anotherone = ents.Create("npc_antlion_poison")
					self.anotherone:SetPos(self:GetPos() +self:GetRight()*-85)
					self.anotherone:SetAngles(self:GetAngles())
					self.anotherone:Spawn()
					self.anotherone:SetNoDraw(true)
					timer.Simple(0.3,function() if IsValid(self.anotherone) then self.anotherone:SetNoDraw(false) end end)
					self.anotherone:VJ_ACT_PLAYACTIVITY("digout",true,0.6,true,0,{SequenceDuration=0.6})
					self.anotherone:SetOwner(self)
				end
			end

			self.HaveSpawned = false
			self.NextSummonTime = CurTime() + 13
		end
	end
end
/*-----------------------------------------------
	*** Coded by Homeless_Performer.jpg. None of this code is to be taken and/or modified and uploaded elsewhere without permission. ***

-----------------------------------------------*/
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
VJ.AddNPC("Infested Beast","npc_vj_infested_beast", "Zombies")