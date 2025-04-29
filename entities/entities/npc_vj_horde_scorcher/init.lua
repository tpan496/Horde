AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/horde/bloodsquid/bloodsquid.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 250
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {"bite"} -- Melee Attack Animations
ENT.MeleeAttackDistance = 45 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.8 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 30
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee
ENT.FootStepTimeRun = 0.5 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.AnimTbl_Walk = {ACT_WALK} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
ENT.AnimTbl_Run = {ACT_WALK} -- Set the running animations | Put multiple to let the base pick a random animation when it moves

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {"range"} -- Range Attack Animations
ENT.RangeAttackEntityToSpawn = "obj_vj_horde_scorcher_projectile" -- The entity that is spawned when range attacking
ENT.RangeDistance = 850 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 200 -- How close does it have to be until it uses melee?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "attach_mouth" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.TimeUntilRangeAttackProjectileRelease = 0.5 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 7 -- How much time until it can use a range attack?

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav"}
--ENT.SoundTbl_Breath = {"npc/zombie_poison/pz_breathe_loop1.wav"}
ENT.SoundTbl_Alert = {"horde/bloodsquid/bc_attackgrowl1.ogg","horde/bloodsquid/bc_attackgrowl2.ogg","horde/bloodsquid/bc_attackgrowl3.ogg"}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/claw_strike1.wav","npc/zombie/claw_strike2.wav","npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_zombies/slow/miss1.wav", "vj_zombies/slow/miss2.wav", "vj_zombies/slow/miss3.wav", "vj_zombies/slow/miss4.wav"}
ENT.SoundTbl_Pain = {"horde/bloodsquid/bc_pain1.ogg","horde/bloodsquid/bc_pain2.ogg","horde/bloodsquid/bc_pain3.ogg"}
ENT.SoundTbl_Death = {"horde/bloodsquid/bc_die1.ogg","horde/bloodsquid/bc_die2.ogg"}

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
ENT.CanFlinch = 1
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetRenderMode(RENDERMODE_TRANSCOLOR)
	self:SetColor(Color(50, 50, 0))
    --self:Ignite(99999999)
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
	self:SetModelScale(1.25)
end

function ENT:TranslateActivity(act)
    if act == ACT_RUN or act == ACT_WALK then
        return ACT_WALK
	end
	return self.BaseClass.TranslateActivity(self, act)
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if HORDE:IsFireDamage(dmginfo) then
		dmginfo:ScaleDamage(0.75)
	elseif HORDE:IsColdDamage(dmginfo) or HORDE:IsMeleeDamage(dmginfo) then
		dmginfo:ScaleDamage(1.25)
	end
end

ENT.Garg_AbleToFlame = false
ENT.Garg_NextAbleToFlameT = 0
function ENT:Garg_ResetFlame()
	self.Garg_AbleToFlame = false
	self.Garg_AttackType = -1
	self.AnimTbl_IdleStand = {ACT_IDLE}
	self.NextIdleStandTime = 0
	--self.DisableChasingEnemy = false
	VJ_STOPSOUND(self.Garg_FlameSd)
	self:StopParticles()
end


local attackTimers = {
	[VJ.ATTACK_TYPE_MELEE] = function(self, skipStopAttacks)
		if !skipStopAttacks then
			timer.Create("attack_melee_reset" .. self:EntIndex(), self:GetAttackTimer(self.NextAnyAttackTime_Melee, self.TimeUntilMeleeAttackDamage, self.AttackAnimDuration), 1, function()
				self:StopAttacks()
				self:MaintainAlertBehavior()
			end)
		end
		timer.Create("attack_melee_reset_able" .. self:EntIndex(), self:GetAttackTimer(self.NextMeleeAttackTime), 1, function()
			self.IsAbleToMeleeAttack = true
		end)
	end,
	[VJ.ATTACK_TYPE_RANGE] = function(self, skipStopAttacks)
		if !skipStopAttacks then
			timer.Create("attack_range_reset" .. self:EntIndex(), self:GetAttackTimer(self.NextAnyAttackTime_Range, self.TimeUntilRangeAttackProjectileRelease, self.AttackAnimDuration), 1, function()
				self:StopAttacks()
				self:MaintainAlertBehavior()
			end)
		end
		timer.Create("attack_range_reset_able" .. self:EntIndex(), self:GetAttackTimer(self.NextRangeAttackTime), 1, function()
			self.IsAbleToRangeAttack = true
		end)
	end,
	[VJ.ATTACK_TYPE_LEAP] = function(self, skipStopAttacks)
		if !skipStopAttacks then
			timer.Create("attack_leap_reset" .. self:EntIndex(), self:GetAttackTimer(self.NextAnyAttackTime_Leap, self.TimeUntilLeapAttackDamage, self.AttackAnimDuration), 1, function()
				self:StopAttacks()
				self:MaintainAlertBehavior()
			end)
		end
		timer.Create("attack_leap_reset_able" .. self:EntIndex(), self:GetAttackTimer(self.NextLeapAttackTime), 1, function()
			self.IsAbleToLeapAttack = true
		end)
	end
}

function ENT:ExecuteRangeAttack()
	local selfData = self:GetTable()
	if selfData.Dead or selfData.PauseAttacks or selfData.Flinching or selfData.AttackType == VJ.ATTACK_TYPE_MELEE then return end
	local ene = self:GetEnemy()
	local eneValid = IsValid(ene)
	if eneValid then
		selfData.AttackType = VJ.ATTACK_TYPE_RANGE
		//self:PointAtEntity(ene)
		-- Create projectile
		if !self:OnRangeAttackExecute("Init", ene) then
			local projectileClass = selfData.RangeAttackEntityToSpawn
			if projectileClass then
				local projectile = ents.Create(self.RangeAttackEntityToSpawn)
				local EnemyDistanceAngle = math.max(150, self.EnemyData.Distance * 0.2)
                local target_pos = self:GetEnemy():GetPos() + Vector(0, 0, EnemyDistanceAngle)
				projectile:SetPos(self:GetAttachment(1).Pos)
				projectile:SetAngles((target_pos - projectile:GetPos()):Angle())
				projectile:SetOwner(self)
				projectile:SetPhysicsAttacker(self)
				projectile:Spawn()
				projectile:Activate()
				//constraint.NoCollide(self, projectile, 0, 0)
				local phys = projectile:GetPhysicsObject()
				if IsValid(phys) then
					phys:Wake()
					--local vel = self:RangeAttackProjVel(projectile)
					local vel = (target_pos - self:GetAttachment(1).Pos) * 1.5
					phys:SetVelocity(vel)
					projectile:SetAngles(vel:GetNormal():Angle())
				else
					local vel = self:RangeAttackProjVel(projectile)
					projectile:SetVelocity(vel)
					projectile:SetAngles(vel:GetNormal():Angle())
				end
				self:OnRangeAttackExecute("PostSpawn", ene, projectile)
			end
		end
	end
	if selfData.AttackState < VJ.ATTACK_STATE_EXECUTED then
		if eneValid then -- Play range attack only once, otherwise it will spam it for every projectile!
			self:PlaySoundSystem("RangeAttack")
		end
		selfData.AttackState = VJ.ATTACK_STATE_EXECUTED
		if selfData.TimeUntilRangeAttackProjectileRelease then
			attackTimers[VJ.ATTACK_TYPE_RANGE](self)
		end
	end
end

ENT.FlamethrowerCD = 0
function ENT:MultipleRangeAttacks()
	local range = 500
	if self.EnemyData.Distance <= range and self.EnemyData.Distance >= self.RangeToMeleeDistance and self.FlamethrowerCD < CurTime() then -- Flame attack 
		self.Garg_AttackType = 0
		self.Garg_AbleToFlame = true
		self.RangeDistance = range
		self.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1}
		self.TimeUntilRangeAttackProjectileRelease = 0.1
		--self.DisableRangeAttackAnimation = true
		--self.DisableDefaultRangeAttackCode = true
        self.HasRangeAttack = false
        self.HasMeleeAttack = false
		self.SoundTbl_BeforeRangeAttack = {"horde/gargantua/gar_flameon1.ogg"}
		self.SoundTbl_RangeAttack = {"horde/gargantua/gar_flameoff1.ogg"}
		self.NextIdleStandTime = 0 -- Reset the idle animation
	else
		self.Garg_AttackType = -1
		self.Garg_AbleToFlame = false
        self.HasRangeAttack = true
        self.HasMeleeAttack = true
	end
end

function ENT:CustomOnThink_AIEnabled()
	if IsValid(self:GetEnemy()) && (self.EnemyData.Distance <= 500) && (self.EnemyData.Distance >= self.RangeToMeleeDistance) && (self.EnemyData.Distance > self.MeleeAttackDistance) && self.Garg_AbleToFlame == true && self.Garg_NextAbleToFlameT < CurTime() && self.Garg_AttackType == 0 && self.FlamethrowerCD < CurTime() then
		local range = 550
		self.Garg_NextAbleToFlameT = CurTime() + 0.2
		--self.DisableChasingEnemy = true
		self.AnimTbl_IdleStand = {"shootflames2"}
		self.NextIdleStandTime = 0
		self:StopMoving()
		util.VJ_SphereDamage(self, self, self:GetPos() + self:OBBCenter() + self:GetForward() * 50, range, 2, DMG_BURN, true, true, {UseCone=true, UseConeDegree=30}, function(ent) if HORDE:IsPlayerOrMinion(ent) then ent:Horde_AddDebuffBuildup(HORDE.Status_Ignite, 2, self) end end)
		-- COSMETICS: Sound, particle and decal
		self.Garg_FlameSd = VJ_CreateSound(self, "horde/gargantua/gar_flamerun1.ogg")
		self:StopParticles()
		ParticleEffectAttach("scorcher_flame", PATTACH_POINT_FOLLOW, self, 1)
		local startPos1 = self:GetAttachment(1).Pos
		local tr1 = util.TraceLine({start = startPos1, endpos = startPos1 + self:GetForward()*range, filter = self})
		local hitPos1 = tr1.HitPos
		sound.EmitHint(SOUND_DANGER, (hitPos1 + startPos1) / 2, 300, 1, self) -- Pos: Midpoint of start and hit pos, same as Vector((hitPos1.x + startPos1.x ) / 2, (hitPos1.y + startPos1.y ) / 2, (hitPos1.z + startPos1.z ) / 2)
		--util.Decal("VJ_HLR_Scorch", hitPos1 + tr1.HitNormal, hitPos1 - tr1.HitNormal)
		--util.Decal("VJ_HLR_Scorch", hitPos2 + tr2.HitNormal, hitPos2 - tr2.HitNormal)
		-- Make it constantly delay the range attack timer by 1 second (Which will also successfully play the flame-end sound)
		local id = self:EntIndex()
        timer.Create("timer_range_start" .. id, 1, 0, function()
			if not self:IsValid() then timer.Remove("timer_range_start" .. id) return end
            --self:RangeAttackCode()
			self:Garg_ResetFlame()
            self.FlamethrowerCD = CurTime() + 10
			timer.Remove("timer_range_start" .. id)
		end)
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

VJ.AddNPC("Scorcher","npc_vj_horde_scorcher", "Zombies")