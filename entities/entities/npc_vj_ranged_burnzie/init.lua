AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/zombie/burnzie.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_zss_burnzie_h")
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {ACT_MELEE_ATTACK1} -- Range Attack Animations
ENT.RangeAttackEntityToSpawn = "obj_burnzie_fire" -- The entity that is spawned when range attacking
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.RangeUseAttachmentForPos = false -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "Mouth" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.TimeUntilRangeAttackProjectileRelease = 0.8 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 10 -- How much time until it can use a range attack?
ENT.Immune_Fire = true

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"zsszombie/foot1.wav","zsszombie/foot2.wav","zsszombie/foot3.wav","zsszombie/foot4.wav"}
ENT.SoundTbl_Idle = {"zsszombies/zmisc_idle1.wav","zsszombies/zmisc_idle2.wav","zsszombies/zmisc_idle3.wav","zsszombies/zmisc_idle4.wav","zsszombies/zmisc_idle5.wav","zsszombies/zmisc_idle6.wav"}
ENT.SoundTbl_Alert = {"zsszombies/zmisc_alert1.wav","zsszombies/zmisc_alert2.wav"}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/claw_strike1.wav","npc/zombie/claw_strike2.wav","npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_Pain = {"zsszombies/zmisc_pain1.wav","zsszombies/zmisc_pain2.wav","zsszombies/zmisc_pain3.wav","zsszombies/zmisc_pain4.wav","zsszombies/zmisc_pain5.wav","zsszombies/zmisc_pain6.wav"}
ENT.SoundTbl_Death = {"zsszombies/zmisc_die1.wav","zsszombies/zmisc_die2.wav","zsszombies/zmisc_die3.wav"}

-- Custom
ENT.Burnzie_ControllerFire = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(13, 13, 60), Vector(-13, -13, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply)
	ply:ChatPrint("JUMP: Ignite or Extinguish the Fire")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	if self.VJ_IsBeingControlled == true then
		if self.VJ_TheController:KeyDown(IN_JUMP) then
			if self.Burnzie_ControllerFire == false then
				self.Burnzie_ControllerFire = true
				self.VJ_TheController:PrintMessage(HUD_PRINTCENTER,"Igniting!")
			else
				self.Burnzie_ControllerFire = false
				self.VJ_TheController:PrintMessage(HUD_PRINTCENTER,"Extinguishing!")
			end
		end
	else
		self.Burnzie_ControllerFire = false
	end
	
	if !IsValid(self:GetEnemy()) or self.VJ_IsBeingControlled == true then
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_WALK_ON_FIRE}
		self.AnimTbl_IdleStand = {ACT_IDLE}
	else
		self.AnimTbl_Walk = {ACT_WALK_ON_FIRE}
		self.AnimTbl_Run = {ACT_WALK_ON_FIRE}
		self.AnimTbl_IdleStand = {ACT_IDLE_ON_FIRE}
	end
	
	if IsValid(self:GetEnemy()) then
		if ((self.VJ_IsBeingControlled == false) or (self.VJ_IsBeingControlled == true && self.Burnzie_ControllerFire == true)) then
			if !self:IsOnFire() && GetConVarNumber("vj_npc_noidleparticle") == 0 then
				self:Ignite(99999999)
				/*local bloodeffect = ents.Create("info_particle_system")
				bloodeffect:SetKeyValue("effect_name","env_fire_small")
				bloodeffect:SetPos(self:GetPos() + Vector(0,0,10))
				bloodeffect:Spawn()
				bloodeffect:Activate() 
				bloodeffect:Fire("Start", "", 0)
				bloodeffect:Fire("Kill", "", 1)*/
			end
		else
			self:Extinguish()
		end
	else
		self:Extinguish()
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

VJ.AddNPC("Scorcher","npc_vj_ranged_burnzie", "Zombies")