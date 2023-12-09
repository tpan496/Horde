AddCSLuaFile("shared.lua")
include('shared.lua')
ENT.Model = {"models/zombie/zombiecop.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 85
ENT.HullType = HULL_WIDE_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {"attacka"} -- Melee Attack Animations
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 70 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 1 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 1 -- How much time until it can use any attack again? | Counted in Seconds
ENT.MeleeAttackDamage = 15
ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasEntitiesToNoCollide = true -- If set to false, it won't run the EntitiesToNoCollide code
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.EntitiesToNoCollide = {"npc_headcrab","npc_manhack"}
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 2 -- Chance of it flinching from 1 to x | 1 will make it always flinch
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/xzombie/foot1.wav","npc/xzombie/foot2.wav","npc/xzombie/foot3.wav"}
ENT.SoundTbl_Idle = {"npc/xzombie/zombie_voice_idle1.wav","npc/xzombie/zombie_voice_idle2.wav","npc/xzombie/zombie_voice_idle3.wav","npc/xzombie/zombie_voice_idle4.wav","npc/xzombie/zombie_voice_idle5.wav","npc/xzombie/zombie_voice_idle6.wav","npc/xzombie/zombie_voice_idle7.wav","npc/xzombie/zombie_voice_idle8.wav","npc/xzombie/zombie_voice_idle10.wav"}
ENT.SoundTbl_Alert = {"npc/xzombie/zombie_alert1.wav","npc/xzombie/zombie_alert2.wav","npc/xzombie/zombie_alert3.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/xzombie/zo_attack1.wav","npc/xzombie/zo_attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/xzombie/claw_miss1.wav","npc/xzombie/claw_miss2.wav"}
ENT.SoundTbl_MeleeAttack = {"npc/xzombie/zombie_hit.wav"}
ENT.SoundTbl_Pain = {"npc/xzombie/zombie_pain1.wav","npc/xzombie/zombie_pain2.wav","npc/xzombie/zombie_pain3.wav","npc/xzombie/zombie_pain4.wav"}
ENT.SoundTbl_Death = {"npc/xzombie/zombie_die1.wav","npc/xzombie/zombie_die2.wav","npc/xzombie/zombie_die3.wav"}
ENT.Manhack = NULL
ENT.ManhackPullT = 0
ENT.hasmanhack = false
ENT.canhavemanhack = true
---------------------------------------------------------------------------------------------------------------------------------------------
	function ENT:CustomOnInitialize()
	self:SetBodygroup(1,1)
	self.ManhackPullT = 1
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
		end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnFlinch_BeforeFlinch(dmginfo, hitgroup)
	if hitgroup == HITGROUP_LEFTARM && !IsValid(self.Manhack) then
		self.AnimTbl_Flinch = {"vjges_flinch_leftarm"}
end
if hitgroup == HITGROUP_RIGHTARM && !IsValid(self.Manhack) then
		self.AnimTbl_Flinch = {"vjges_flinch_rightarm"}
end
if hitgroup == HITGROUP_LEFTLEG then
		self.AnimTbl_Flinch = {"flinch_leftleg"}
end
if hitgroup == HITGROUP_RIGHTLEG then
		self.AnimTbl_Flinch = {"flinch_rightleg"}
	end
if hitgroup == HITGROUP_CHEST && !IsValid(self.Manhack)  then
		self.AnimTbl_Flinch = {"vjges_flinch1"}
	end
if hitgroup == HITGROUP_HEAD && !IsValid(self.Manhack)  then
	self.AnimTbl_Flinch = {"vjges_flinch_head"}
end
	if IsValid(self.Manhack) && hitgroup != HITGROUP_LEFTLEG &&  hitgroup != HITGROUP_RIGHTLEG then
		self.AnimTbl_Flinch = {"vjges_flinch_grenade_east","vjges_flinch_grenade_west","vjges_flinch_grenade_back","vjges_flinch_grenade_front"}
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self:IsOnFire() then
		self.AnimTbl_Walk = {ACT_WALK_ON_FIRE}
		self.AnimTbl_Run = {ACT_WALK_ON_FIRE}
		self.AnimTbl_IdleStand = {ACT_IDLE_ON_FIRE}
	end
	if self.canhavemanhack && CurTime() > self.ManhackPullT && IsValid(self) && IsValid(self:GetEnemy()) && !IsValid(self.Manhack) && self.NearestPointToEnemyDistance < 200 && self.hasmanhack == false then
	self:VJ_ACT_PLAYACTIVITY("pullgrenade",true,1,true)
	    self.Manhack = ents.Create("npc_manhack")
        self.Manhack:SetPos(self:GetAttachment(self:LookupAttachment("lhand")).Pos)
        self.Manhack:SetAngles(self:GetAttachment(self:LookupAttachment("lhand")).Ang +Angle(0,0,0))
		self:AddEntityRelationship(self.Manhack, D_LI, 0)
        self.Manhack:SetOwner(self)
        self.Manhack:SetParent(self)
        self.Manhack:Fire("SetParentAttachment","lhand")
        self.Manhack:Spawn()
		self.Manhack.Owner = self
        self.Manhack:Activate()
		self.Manhack:SetMoveType(MOVETYPE_NONE)
	    self.Manhack:SetSolid(SOLID_BBOX)
		self.Manhack.Behavior = VJ_BEHAVIOR_PASSIVE_NATURE
		self.hasmanhack = true
if  self.hasmanhack == true then
self.AnimTbl_Run = {VJ_SequenceToActivity(self,"run_all_grenade")}
		self.AnimTbl_Walk = {VJ_SequenceToActivity(self,"walk_all_grenade")}
		self.AnimTbl_IdleStand = {VJ_SequenceToActivity(self,"idle_grenade")}
else
self.AnimTbl_Run = {ACT_RUN}
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_IdleStand = {ACT_IDLE}
end 
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled(dmginfo,hitgroup)
		local randcrab = math.random(1,4)
		local dmgtype = dmginfo:GetDamageType()
		if hitgroup != HITGROUP_HEAD then randcrab = 2 end
		if dmgtype == DMG_CLUB or dmgtype == DMG_SLASH then randcrab = 1 end
	if randcrab == 1 then
		self:SetBodygroup(1,1)
	end
	if randcrab == 2 then
	local pos = self:GetAttachment(self:LookupAttachment("eyes")).Pos
        self:SetBodygroup(1,0)
		self.lion = ents.Create("npc_headcrab")
		self.lion:SetPos(pos)
		self.lion:SetAngles(self:GetAngles())
		self.lion:Spawn()
		self.lion:Activate() 
		self.lion:SetOwner(self)
	end
	if IsValid(self.Manhack) then
	self.lion = ents.Create("npc_manhack")
		self.lion:SetPos(self:GetAttachment(self:LookupAttachment("lhand")).Pos)
		self.lion:SetAngles(self:GetAngles())
		self.lion:Spawn()
		self.lion:Activate() 
		self.lion:SetOwner(self)
		self.lion:SetHealth(self.Manhack:Health())
end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/