AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/combine_super_soldier.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 4500
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.MeleeAttackDamage = 30
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
ENT.SightDistance = 10000 -- How far it can see
ENT.SightAngle = 80 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.TurningSpeed = 20 -- How fast it can turn
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasBloodParticle = true -- Does it spawn a particle when damaged?
ENT.HasBloodDecal = true -- Does it spawn a decal when damaged?
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.Flinches = 1 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 12 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {SCHED_FLINCH_PHYSICS} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
ENT.MoveWhenDamagedByEnemy = false -- Should the SNPC move when being damaged by an enemy?
ENT.MoveWhenDamagedByEnemySCHED1 = SCHED_FORCED_GO_RUN -- The schedule it runs when MoveWhenDamagedByEnemy code is ran | The first # in math.random
ENT.MoveWhenDamagedByEnemySCHED2 = SCHED_FORCED_GO_RUN -- The schedule it runs when MoveWhenDamagedByEnemy code is ran | The second # in math.random
ENT.NextMoveWhenDamagedByEnemy1 = 3 -- Next time it moves when getting damaged | The first # in math.random
ENT.NextMoveWhenDamagedByEnemy2 = 3.5 -- Next time it moves when getting damaged | The second # in math.random
ENT.HasAllies = true -- Put to false if you want it not to have any allies
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.HasGrenadeAttack = true -- Should the SNPC have a grenade attack?
ENT.NextThrowGrenadeTime1 = 10 -- Time until it runs the throw grenade code again | The first # in math.random
ENT.NextThrowGrenadeTime2 = 15 -- Time until it runs the throw grenade code again | The second # in math.random
ENT.ThrowGrenadeChance = 1 -- Chance that it will throw the grenade | Set to 1 to throw all the time
ENT.GrenadeAttackThrowDistance = 1000 -- How far it can throw grenades
ENT.GrenadeAttackThrowDistanceClose = 500 -- How close until it stops throwing grenades
ENT.AnimTbl_GrenadeAttack = {"grenThrow"} -- Grenade Attack Animations
ENT.GrenadeAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.GrenadeAttackAnimationStopAttacks = true -- Should it stop attacks for a certain amount of time?
ENT.GrenadeAttackEntity = "horde_vj_platoon_heavy_nade" -- The entity that the SNPC throws | Half Life 2 Grenade: "npc_grenade_frag"
ENT.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.CallForBackUpOnDamage = false -- Should the SNPC call for help when damaged? (Only happens if the SNPC hasn't seen a enemy)
ENT.CanDetectDangers = false
ENT.MoveOrHideOnDamageByEnemy = false
ENT.WeaponSpread = 1.5
ENT.Weapon_FiringDistanceFar = 1500
ENT.WeaponReload_FindCover = false
ENT.Horde_Plague_Soldier = true
ENT.EntitiesToNoCollide = {"npc_vj_horde_platoon_heavy", "npc_vj_horde_platoon_berserker", "npc_vj_horde_platoon_demolitionist"}

ENT.SoundTbl_Pain = {
"npc/combine_soldier/pain1.wav",
"npc/combine_soldier/pain2.wav",
"npc/combine_soldier/pain3.wav"}

ENT.SoundTbl_FootStep = {
	"npc/combine_soldier/gear1.wav",
	"npc/combine_soldier/gear2.wav",
	"npc/combine_soldier/gear3.wav",
	"npc/combine_soldier/gear4.wav",
	"npc/combine_soldier/gear5.wav",
	"npc/combine_soldier/gear6.wav"}
ENT.SoundTbl_Idle = {"zsszombine/idle1.wav","zsszombine/idle2.wav","zsszombine/idle3.wav","zsszombine/idle4.wav","zsszombine/idle5.wav"}
ENT.SoundTbl_Alert = {"zsszombine/alert1.wav","zsszombine/alert2.wav","zsszombine/alert3.wav","zsszombine/alert4.wav","zsszombine/alert5.wav","zsszombine/alert6.wav"}

	-- ====== Sound Pitch ====== --
-- Higher number = Higher pitch | Lower number = Lower pitch
-- Highest number is 254
	-- !!! Important variables !!! --
ENT.UseTheSameGeneralSoundPitch = true
	-- If set to true, it will make the game decide a number when the SNPC is created and use it for all sound pitches set to "UseGeneralPitch"
	-- It picks the number between the two variables below:
ENT.GeneralSoundPitch1 = 75
ENT.GeneralSoundPitch2 = 75
ENT.DisableCritical = nil

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if HORDE:IsPhysicalDamage(dmginfo) then
		dmginfo:ScaleDamage(0.75)
	end

	if (not self.DisableCritical) and self:Health() <= self:GetMaxHealth() * 0.5 then
		self.Critical = true
	end
end

function ENT:CustomOnInitialize()
	self:SetModelScale(1.25)
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
	self:SetColor(Color(100,100,100))

	local p = math.random()
	if p <= 0.5 then
		self.Weaken = true
	else
		self.Hinder = true
	end

	self:Give("weapon_vj_horde_m249")
	local pos = Vector()
	local ang = Angle()
	local attach_id = self:LookupAttachment("eyes")
	local attach = self:GetAttachment(attach_id)
	pos = attach.Pos
	ang = attach.Ang
	pos.x = pos.x - 3
	pos.z = pos.z - 6
	pos.y = pos.y
	self.model = ents.Create("prop_dynamic")
	self.model:SetModel("models/headcrabblack.mdl")
	self.model:SetColor(Color(100, 100, 100))
	self.model:SetSequence("idle01")
	self.model:SetPos(pos)
	self.model:SetAngles(ang)
	self.model:Spawn()
	self.model:SetParent(self, attach_id)
	self.model:SetModelScale(1.5)

	self:EmitSound("npc/combine_gunship/see_enemy.wav", 3000, 100, 2, CHAN_STATIC)
end


/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

VJ.AddNPC("Platoon","npc_vj_horde_platoon_heavy", "Zombies")