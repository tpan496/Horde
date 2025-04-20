AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {
	"models/vj_zombies/panic_carrier.mdl",
	"models/vj_zombies/panic_eugene.mdl",
	"models/vj_zombies/panic_jessica.mdl",
	"models/vj_zombies/panic_lea.mdl",
	"models/vj_zombies/panic_marcus.mdl",
	"models/vj_zombies/panic_paul.mdl",
	"models/vj_zombies/panic_vanessa.mdl",
} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 90
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {"vjges_attack1", "vjges_attack2", "vjges_attack3", "vjges_push"}
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 20
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 5 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee
ENT.FootStepTimeRun = 0.5 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.7 -- Next foot step sound when it is walking
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav", "npc/zombie/foot2.wav", "npc/zombie/foot3.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_zombies/panic/Z_Hit-01.wav", "vj_zombies/panic/Z_Hit-02.wav", "vj_zombies/panic/Z_Hit-03.wav", "vj_zombies/panic/Z_Hit-04.wav", "vj_zombies/panic/Z_Hit-05.wav", "vj_zombies/panic/Z_Hit-06.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_zombies/panic/z-swipe-1.wav", "vj_zombies/panic/z-swipe-2.wav", "vj_zombies/panic/z-swipe-3.wav", "vj_zombies/panic/z-swipe-4.wav", "vj_zombies/panic/z-swipe-5.wav", "vj_zombies/panic/z-swipe-6.wav"}

ENT.GeneralSoundPitch1 = 60
ENT.GeneralSoundPitch2 = 60
ENT.CanFlinch = 1
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end

-- Carrier
local sdCarrier_Idle = {"vj_zombies/panic/carrier/Zcarrier_Taunt-01.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-02.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-03.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-06.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-07.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-09.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-12.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-14.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-18.wav"}
local sdCarrier_CombatIdle = {"vj_zombies/panic/carrier/Zcarrier_Taunt-01.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-02.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-03.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-06.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-07.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-09.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-12.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-14.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-18.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-04.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-05.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-08.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-10.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-11.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-13.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-15.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-16.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-17.wav", "vj_zombies/panic/carrier/Zcarrier_Taunt-19.wav"}
local sdCarrier_Alert = {"vj_zombies/panic/carrier/Carrier_Berserk-01.wav", "vj_zombies/panic/carrier/Carrier_Berserk-02.wav", "vj_zombies/panic/carrier/Carrier_Berserk-03.wav", "vj_zombies/panic/carrier/Carrier_Berserk-04.wav", "vj_zombies/panic/carrier/Carrier_Berserk-05.wav", "vj_zombies/panic/carrier/Carrier_Berserk-06.wav", "vj_zombies/panic/carrier/Carrier_Berserk-07.wav"}
local sdCarrier_BeforeMelee = {"vj_zombies/panic/carrier/ZCarrier_Attack-01.wav", "vj_zombies/panic/carrier/ZCarrier_Attack-02.wav", "vj_zombies/panic/carrier/ZCarrier_Attack-03.wav", "vj_zombies/panic/carrier/ZCarrier_Attack-04.wav", "vj_zombies/panic/carrier/ZCarrier_Attack-05.wav", "vj_zombies/panic/carrier/ZCarrier_Attack-06.wav", "vj_zombies/panic/carrier/ZCarrier_Attack-07.wav", "vj_zombies/panic/carrier/ZCarrier_Attack-08.wav", "vj_zombies/panic/carrier/ZCarrier_Attack-09.wav", "vj_zombies/panic/carrier/ZCarrier_Attack-10.wav", "vj_zombies/panic/carrier/ZCarrier_Attack-11.wav"}
local sdCarrier_Pain = {"vj_zombies/panic/carrier/Zcarrier_Pain-01.wav", "vj_zombies/panic/carrier/Zcarrier_Pain-02.wav", "vj_zombies/panic/carrier/Zcarrier_Pain-03.wav", "vj_zombies/panic/carrier/Zcarrier_Pain-04.wav", "vj_zombies/panic/carrier/Zcarrier_Pain-05.wav", "vj_zombies/panic/carrier/Zcarrier_Pain-06.wav", "vj_zombies/panic/carrier/Zcarrier_Pain-07.wav", "vj_zombies/panic/carrier/Zcarrier_Pain-08.wav", "vj_zombies/panic/carrier/Zcarrier_Pain-09.wav", "vj_zombies/panic/carrier/Zcarrier_Pain-10.wav", "vj_zombies/panic/carrier/Zcarrier_Pain-11.wav", "vj_zombies/panic/carrier/Zcarrier_Pain-12.wav", "vj_zombies/panic/carrier/Zcarrier_Pain-13.wav"}
local sdCarrier_Death = {"vj_zombies/panic/carrier/Zcarrier_Death-01.wav", "vj_zombies/panic/carrier/Zcarrier_Death-02.wav", "vj_zombies/panic/carrier/Zcarrier_Death-03.wav", "vj_zombies/panic/carrier/Zcarrier_Death-04.wav", "vj_zombies/panic/carrier/Zcarrier_Death-05.wav", "vj_zombies/panic/carrier/Zcarrier_Death-06.wav", "vj_zombies/panic/carrier/Zcarrier_Death-07.wav", "vj_zombies/panic/carrier/Zcarrier_Death-08.wav", "vj_zombies/panic/carrier/Zcarrier_Death-09.wav", "vj_zombies/panic/carrier/Zcarrier_Death-10.wav", "vj_zombies/panic/carrier/Zcarrier_Death-11.wav", "vj_zombies/panic/carrier/Zcarrier_Death-12.wav", "vj_zombies/panic/carrier/Zcarrier_Death-13.wav", "vj_zombies/panic/carrier/Zcarrier_Death-14.wav", "vj_zombies/panic/carrier/Zcarrier_Death-15.wav"}

-- Female
local sdFemale_Idle = {"vj_zombies/panic/female/taunt-01.wav", "vj_zombies/panic/female/taunt-02.wav", "vj_zombies/panic/female/taunt-03.wav", "vj_zombies/panic/female/taunt-04.wav", "vj_zombies/panic/female/taunt-05.wav", "vj_zombies/panic/female/taunt-06.wav", "vj_zombies/panic/female/taunt-07.wav", "vj_zombies/panic/female/taunt-08.wav", "vj_zombies/panic/female/taunt-09.wav", "vj_zombies/panic/female/taunt-10.wav"}
local sdFemale_Alert = {"vj_zombies/panic/female/taunt-01.wav", "vj_zombies/panic/female/taunt-02.wav", "vj_zombies/panic/female/taunt-03.wav", "vj_zombies/panic/female/taunt-04.wav", "vj_zombies/panic/female/taunt-05.wav", "vj_zombies/panic/female/taunt-06.wav", "vj_zombies/panic/female/taunt-07.wav", "vj_zombies/panic/female/taunt-08.wav", "vj_zombies/panic/female/taunt-09.wav", "vj_zombies/panic/female/taunt-10.wav"}
local sdFemale_BeforeMelee = {"vj_zombies/panic/female/attack-01.wav", "vj_zombies/panic/female/attack-02.wav", "vj_zombies/panic/female/attack-03.wav", "vj_zombies/panic/female/attack-04.wav", "vj_zombies/panic/female/attack-05.wav", "vj_zombies/panic/female/attack-06.wav"}
local sdFemale_Pain = {"vj_zombies/panic/female/pain-01.wav", "vj_zombies/panic/female/pain-02.wav", "vj_zombies/panic/female/pain-03.wav", "vj_zombies/panic/female/pain-04.wav", "vj_zombies/panic/female/pain-05.wav"}
local sdFemale_Death = {"vj_zombies/panic/female/death-01.wav", "vj_zombies/panic/female/death-02.wav", "vj_zombies/panic/female/death-03.wav", "vj_zombies/panic/female/death-04.wav", "vj_zombies/panic/female/death-05.wav", "vj_zombies/panic/female/death-06.wav", "vj_zombies/panic/female/death-07.wav"}

-- Male
local sdMale_Idle = {"vj_zombies/panic/male/ZMale_Taunt1.wav", "vj_zombies/panic/male/ZMale_Taunt2.wav", "vj_zombies/panic/male/ZMale_Taunt3.wav", "vj_zombies/panic/male/ZMale_Taunt4.wav", "vj_zombies/panic/male/ZMale_Taunt5.wav", "vj_zombies/panic/male/ZMale_Taunt6.wav", "vj_zombies/panic/male/ZMale_Taunt7.wav", "vj_zombies/panic/male/ZMale_Taunt8.wav", "vj_zombies/panic/male/ZMale_Taunt9.wav"}
local sdMale_Alert = {"vj_zombies/panic/male/ZMale_Berserk-01.wav", "vj_zombies/panic/male/ZMale_Berserk-02.wav", "vj_zombies/panic/male/ZMale_Berserk-03.wav", "vj_zombies/panic/male/ZMale_Berserk-04.wav", "vj_zombies/panic/male/ZMale_Berserk-05.wav", "vj_zombies/panic/male/ZMale_Berserk-06.wav", "vj_zombies/panic/male/ZMale_Berserk-07.wav", "vj_zombies/panic/male/ZMale_Berserk-08.wav"}
local sdMale_BeforeMelee = {"vj_zombies/panic/male/ZMale_Attack1.wav", "vj_zombies/panic/male/ZMale_Attack2.wav", "vj_zombies/panic/male/ZMale_Attack3.wav", "vj_zombies/panic/male/ZMale_Attack4.wav", "vj_zombies/panic/male/ZMale_Attack5.wav", "vj_zombies/panic/male/ZMale_Attack6.wav", "vj_zombies/panic/male/ZMale_Attack7.wav"}
local sdMale_Pain = {"vj_zombies/panic/male/ZMale_Pain1.wav", "vj_zombies/panic/male/ZMale_Pain2.wav", "vj_zombies/panic/male/ZMale_Pain3.wav", "vj_zombies/panic/male/ZMale_Pain4.wav", "vj_zombies/panic/male/ZMale_Pain5.wav", "vj_zombies/panic/male/ZMale_Pain6.wav"}
local sdMale_Death = {"vj_zombies/panic/male/ZMale_Death1.wav", "vj_zombies/panic/male/ZMale_Death2.wav", "vj_zombies/panic/male/ZMale_Death3.wav", "vj_zombies/panic/male/ZMale_Death4.wav", "vj_zombies/panic/male/ZMale_Death5.wav", "vj_zombies/panic/male/ZMale_Death6.wav"}

local ZOMBIE_TYPE_CARRIER = 0
local ZOMBIE_TYPE_MALE = 1
local ZOMBIE_TYPE_FEMALE = 2

-- Custom
ENT.Zombie_Type = ZOMBIE_TYPE_CARRIER -- 0 = Carrier | 1 = Male | 2 = Female
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	local myModel = self:GetModel()
	if myModel == "models/vj_zombies/panic_carrier.mdl" then
		self.Zombie_Type = ZOMBIE_TYPE_CARRIER
		self.SoundTbl_Idle = sdCarrier_Idle
		self.SoundTbl_CombatIdle = sdCarrier_CombatIdle
		self.SoundTbl_Alert = sdCarrier_Alert
		self.SoundTbl_BeforeMeleeAttack = sdCarrier_BeforeMelee
		self.SoundTbl_Pain = sdCarrier_Pain
		self.SoundTbl_Death = sdCarrier_Death
		self:SetHealth(self:Health() + 40)
	elseif myModel == "models/vj_zombies/panic_jessica.mdl" or myModel == "models/vj_zombies/panic_lea.mdl" or myModel == "models/vj_zombies/panic_vanessa.mdl" then
		self.Zombie_Type = ZOMBIE_TYPE_FEMALE
		self.SoundTbl_Idle = sdFemale_Idle
		self.SoundTbl_Alert = sdFemale_Alert
		self.SoundTbl_BeforeMeleeAttack = sdFemale_BeforeMelee
		self.SoundTbl_Pain = sdFemale_Pain
		self.SoundTbl_Death = sdFemale_Death
	else
		self.Zombie_Type = ZOMBIE_TYPE_MALE
		self.SoundTbl_Idle = sdMale_Idle
		self.SoundTbl_Alert = sdMale_Alert
		self.SoundTbl_BeforeMeleeAttack = sdMale_BeforeMelee
		self.SoundTbl_Pain = sdMale_Pain
		self.SoundTbl_Death = sdMale_Death
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInput(key, activator, caller, data)
	if key == "step" then
		self:PlayFootstepSound()
	elseif key == "melee" then
		self.MeleeAttackDamage = 15
		self:ExecuteMeleeAttack()
	elseif key == "melee_push" then
		self.MeleeAttackDamage = 20
		self:ExecuteMeleeAttack()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if act == ACT_GLIDE then -- Because there is no jumping animation, so just use idle!
		return ACT_IDLE
	elseif act == ACT_RUN && self.Zombie_Type == ZOMBIE_TYPE_CARRIER && self.EnemyData.Distance < 400 && IsValid(self:GetEnemy()) then -- Carriers can go berserk when close to enemy!
		//VJ.EmitSound(self, "vj_zombies/panic/Activate.wav", 50)
		return ACT_SPRINT
	end
	return self.BaseClass.TranslateActivity(self, act)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HandleGibOnDeath(dmginfo, hitgroup)
	if hitgroup == HITGROUP_HEAD && dmginfo:GetDamageForce():Length2D() > 800 then
		self:CreateGibEntity("obj_vj_gib", "UseHuman_Small", {Pos = self:GetAttachment(self:LookupAttachment("anim_attachment_head")).Pos})
		if self.Zombie_Type == ZOMBIE_TYPE_MALE then -- Only males have a single bodygroup set
			self:SetBodygroup(0, math.random(1, 3))
		else
			self:SetBodygroup(0, 1) -- Have to set this otherwise the gibbed heads will NOT show up!
			self:SetBodygroup(1, math.random(1, 3))
		end
		return true, {AllowCorpse = true, AllowAnim = true}
	end
end

VJ.AddNPC("Sprinter","npc_vj_horde_sprinter", "Zombies")