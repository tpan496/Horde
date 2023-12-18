AddCSLuaFile("shared.lua")
include('shared.lua')

--[[-----------------------------------------------
	*** Copyright (c) 2012-2022 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = {"models/zombie/vj_weapbie_hev.mdl"}

ENT.StartHealth = 175
ENT.HullType = HULL_HUMAN
ENT.MoveType = MOVETYPE_STEP
ENT.HasManhack = false
ENT.NextManhack = 0
ENT.Leader = nil
ENT.HasAllies = true -- Put to false if you want it not to have any allies
ENT.AnimTbl_WeaponReload = {"vjges_gesture_reload_smg1"}
ENT.AnimTbl_WeaponReloadBehindCover = {"vjges_gesture_reload_smg1"}
ENT.WeaponReload_FindCover = false
ENT.HasDeathRagdoll = true
ENT.HasEntitiesToNoCollide = false -- If set to false, it won't run the EntitiesToNoCollide code
ENT.EntitiesToNoCollide = {"npc_manhack"}
ENT.HasWeaponBackAway = false
ENT.WeaponBackAway_Distance = 0
--ENT.Weapon_FiringDistanceClose = 0.1 -- How close until it stops shooting
ENT.WaitForEnemyToComeOut = false
ENT.SightDistance = 10000 -- How far it can see
ENT.SightAngle = 80 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.TurningSpeed = 20 -- How fast it can turn
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasBloodParticle = true -- Does it spawn a particle when damaged?
ENT.HasBloodDecal = true -- Does it spawn a decal when damaged?
ENT.HasBloodPool = false -- Does it have a blood pool?
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasGrenadeAttack = false -- Should the SNPC have a grenade attack?
ENT.AnimTbl_GrenadeAttack = {"ThrowItem"} -- Grenade Attack Animations
ENT.GrenadeAttackEntity = "npc_grenade_frag" -- The entity that the SNPC throws | Half Life 2 Grenade: "npc_grenade_frag"
ENT.DropWeaponOnDeath = false
ENT.HasItemDropsOnDeath = true 
ENT.ItemDropsOnDeathChance = 15
ENT.ItemDropsOnDeath_EntityList = {"item_battery"}

-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.HasOnPlayerSightSounds = true -- If set to false, it won't play the saw player sounds
ENT.IdleSounds_PlayOnAttacks = true -- It will be able to continue and play idle sounds when it performs an attack
ENT.SoundTbl_FootStep = {"npc/xenbie/foot1.wav", "npc/xenbie/foot2.wav", "npc/xenbie/foot3.wav"}
ENT.SoundTbl_Idle = {"npc/xenbie/zo_idle1.wav", "npc/xenbie/zo_idle2.wav", "npc/xenbie/zo_idle3.wav", "npc/xenbie/zo_idle4.wav", "npc/hevzombie/zvox2.wav", "npc/hevzombie/zvox3.wav", "npc/hevzombie/zvox4.wav", "npc/hevzombie/zvox5.wav", "npc/hevzombie/zvox6.wav", "npc/hevzombie/zvox7.wav", "npc/hevzombie/zvox8.wav", "npc/hevzombie/zvox9.wav", "npc/hevzombie/zvox13.wav", "npc/hevzombie/zvox14.wav", "npc/hevzombie/zvox15.wav"}
ENT.SoundTbl_Alert = {"npc/zombie_poison/pz_alert1.wav", "npc/zombie_poison/pz_alert2.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/xenbie/zo_attack1.wav", "npc/xenbie/zo_attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/xenbie/claw_miss1.wav", "npc/xenbie/claw_miss2.wav"}
ENT.SoundTbl_OnPlayerSight = {"npc/xenbie/zombie_alert1.wav", "npc/xenbie/zombie_alert2.wav", "npc/xenbie/zombie_alert3.wav"}
ENT.SoundTbl_CombatIdle = {"npc/fast_zombie/fz_alert_close1.wav", "npc/hevzombie/zvox2.wav", "npc/hevzombie/zvox3.wav", "npc/hevzombie/zvox4.wav", "npc/hevzombie/zvox5.wav", "npc/hevzombie/zvox6.wav", "npc/hevzombie/zvox7.wav", "npc/hevzombie/zvox8.wav", "npc/hevzombie/zvox9.wav", "npc/hevzombie/zvox13.wav", "npc/hevzombie/zvox14.wav", "npc/hevzombie/zvox15.wav"}
ENT.SoundTbl_WeaponReload = {"npc/fast_zombie/fz_frenzy1.wav"}
ENT.SoundTbl_Pain = {"npc/xenbie/zo_pain1.wav", "npc/xenbie/zo_pain2.wav", "npc/xenbie/zo_pain3.wav", "npc/xenbie/zo_pain4.wav", "npc/xenbie/zo_pain5.wav", "npc/xenbie/zo_pain7.wav", "npc/xenbie/zo_pain8.wav"}
ENT.SoundTbl_Death = {"npc/xenbie/zombie_die1.wav", "npc/xenbie/zombie_die2.wav", "npc/xenbie/zombie_die3.wav"}
ENT.CombatIdleSoundChance = 1
ENT.IdleSoundChance = 1
ENT.NextSoundTime_Idle = {2, 3}
ENT.WeaponReloadSoundPitch = {70,85}
ENT.NoWeapon_UseScaredBehavior = false
ENT.FlinchChance = 1
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.TimeUntilMeleeAttackDamage = 1
ENT.WeaponSpread = 300
ENT.Weapon_FiringDistanceFar = 500
ENT.Weapon_FiringDistanceClose = 10 -- How close until it stops shooting
ENT.CallForBackUpOnDamage = false -- Should the SNPC call for help when damaged? (Only happens if the SNPC hasn't seen a enemy)
ENT.MoveWhenDamagedByEnemy = false -- Should the SNPC move when being damaged by an enemy?
ENT.CanDetectDangers = false
ENT.MoveOrHideOnDamageByEnemy = false
ENT.Horde_Plague_Soldier = true
ENT.CallForHelp = false
ENT.CanInvestigate = false
function ENT:CustomOnInitialize()
	self:SetSkin(math.random(0, 2))
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
	local p = math.random()

	if p <= 0.5 then
		self:Give("weapon_vj_horde_9mm")
	else
		self:Give("weapon_vj_horde_mac10")
	--	self.Weapon_FiringDistanceFar = 50
--	self.Weapon_FiringDistanceFar = 14 -- How far away it can shoot
--	self.Weapon_FiringDistanceClose = 3 -- How close until it stops shooting
	end
end

-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	local effectdata = EffectData()
	effectdata:SetOrigin(dmginfo:GetDamagePosition())

	if hitgroup ~= HITGROUP_HEAD and dmginfo:GetDamageType() then
		dmginfo:ScaleDamage(0.54)
		util.Effect("StunstickImpact", effectdata)
		VJ_EmitSound(self, self.armor, 75, 100)
		VJ_EmitSound(self, self.armorimpact, 90, 100)
	end
end

function ENT:CustomOnFlinch_BeforeFlinch(dmginfo, hitgroup)
	if hitgroup == HITGROUP_LEFTLEG then
		self.AnimTbl_Flinch = {"flinch_leftleg"}
	end

	if hitgroup == HITGROUP_RIGHTLEG then
		self.AnimTbl_Flinch = {"flinch_rightleg"}
	end

	if hitgroup ~= HITGROUP_RIGHTLEG and hitgroup ~= HITGROUP_LEFTLEG then
		local vec = (dmginfo:GetInflictor():GetPos() - self:GetPos()):GetNormal():Angle().y
		local targetAngle = self:EyeAngles().y

		if targetAngle > 360 then
			targetAngle = targetAngle - 360
		end

		if targetAngle < 0 then
			targetAngle = targetAngle + 360
		end

		local angleAround = vec - targetAngle

		if angleAround > 360 then
			angleAround = angleAround - 360
		end

		if angleAround < 0 then
			angleAround = angleAround + 360
		end

		if angleAround <= 45 or angleAround > 315 then
			self.AnimTbl_Flinch = {"vjges_flinch_grenade_back"}
		end

		if angleAround > 45 and angleAround <= 135 then
			self.AnimTbl_Flinch = {"vjges_flinch_grenade_east"}
		end

		if angleAround > 135 and angleAround <= 225 then
			self.AnimTbl_Flinch = {"vjges_flinch_grenade_front"}
		end

		if angleAround > 225 and angleAround <= 315 then
			self.AnimTbl_Flinch = {"vjges_flinch_grenade_west"}
		end
	end
end

function ENT:MultipleMeleeAttacks()
	self.MeleeAttackDistance = 35
	self.TimeUntilMeleeAttackDamage = 0.7
	self.NextAnyAttackTime_Melee = 0.7
	self.MeleeAttackAngleRadius = 100
	self.MeleeAttackAnimationFaceEnemy = false
	self.MeleeAttackDamageAngleRadius = 80

	self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}

	self.MeleeAttackExtraTimers = {}
	self.MeleeAttackDamage = 30
	self.MeleeAttackDamageDistance = 75
	self.MeleeAttackDamageType = DMG_SLASH
end

---------------------------------------------------------------------------------------------------------------------------------------------	  
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, GetCorpse)
	VJ_EmitSound(self, "npc/hevzombie/zvoxflatline.wav", 90, 100) --
end