AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/horde/hulk/hulk.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 100
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY", "CLASS_COMBINE"} -- NPCs with the same class with be allied to each other
ENT.FriendsWithAllPlayerAllies = true
ENT.PlayerFriendly = true
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 35 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 95 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.8 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 30
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee
ENT.HasLeapAttack = false -- Should the SNPC have a leap attack?
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.4 -- Next foot step sound when it is walking
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 100 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 130 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 250 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 260 -- How far it will push you up | Second in math.random
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav"}
ENT.SoundTbl_Breath = nil
--EN--T.SoundTbl_Idle = {"npc/zombie_poison/pz_idle2.wav","npc/zombie_poison/pz_idle3.wav","npc/zombie_poison/pz_idle4.wav"}
--ENT.SoundTbl_Alert = {"npc/zombie_poison/pz_warn1.wav","npc/zombie_poison/pz_warn2.wav"}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/claw_strike1.wav","npc/zombie/claw_strike2.wav","npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_Pain = nil

ENT.GeneralSoundPitch1 = 75
ENT.GeneralSoundPitch2 = 75
ENT.HasAllies = true

ENT.VJFriendly = false
ENT.Abyssal_Roar = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Shockwave(delay)
	if self.Horde_Stunned then return end
	timer.Simple(delay, function()
		if not self:IsValid() then return end
		local dmg = DamageInfo()
		dmg:SetAttacker(self)
		dmg:SetInflictor(self)
		dmg:SetDamageType(DMG_GENERIC)
		dmg:SetDamage(self.MeleeAttackDamage / 2)

		for _, ent in pairs(ents.FindInSphere(self:GetPos(), 250)) do
			if HORDE:IsEnemy(ent) then
				ent:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, 8, self:GetNWEntity("HordeOwner"))
				ent:TakeDamageInfo(dmg)
				dmg:SetDamagePosition(ent:GetPos())
			end
		end

		local e = EffectData()
			e:SetOrigin(self:GetPos())
		util.Effect("abyssal_roar", e, true, true)
	end)
end

function ENT:Roar()
	if not self:IsValid() then return end
    sound.Play("horde/spectres/abyssal_roar.ogg", self:GetPos(), 75, 100)
    self:VJ_ACT_PLAYACTIVITY("FireWalk", true, 1.5, false)
	-- Deals heavy Physical damage to nearby enemies
	self:Shockwave(0.2)
	self:Shockwave(0.4)
	self:Shockwave(0.6)
	self:Shockwave(0.8)
	self:Shockwave(1.0)
end

function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(0, 0, 0), Vector(0, 0, 0))
	self.AnimTbl_Run = ACT_RUN
    if self.properties.abyssal_might == true then
		local id = self:GetCreationID()
		self.Abyssal_Roar = true
		timer.Simple(0.5, function() self:Roar() end)
		timer.Remove("Horde_FlayerRoar" .. id)
		timer.Create("Horde_FlayerRoar" .. id, 10, 0, function ()
			if not IsValid(self) then return end
			self:Roar()
		end)
    end
	local e = EffectData()
		e:SetOrigin(self:GetPos())
		e:SetNormal(Vector(0,0,1))
		e:SetScale(0.25)
	util.Effect("abyssal_roar", e, true, true)
    self:SetRenderMode(RENDERMODE_TRANSCOLOR)
    self:SetColor(Color(0, 0, 50, 200))
	self.MeleeAttackDamage = 2.75 * (self.MeleeAttackDamage + 6 * self.properties.level)
	self:SetHealth(2 * (90 + 32 * self.properties.level))
	self:AddRelationship("npc_turret_floor D_LI 99")
	self:AddRelationship("npc_vj_horde_combat_bot D_LI 99")
	self:AddRelationship("npc_manhack D_LI 99")
	self:AddRelationship("npc_vj_horde_vortigaunt D_LI 99")
	self:AddRelationship("npc_vj_horde_rocket_turret D_LI 99")
	self:AddRelationship("npc_vj_horde_antlion D_LI 99")
    --self:EmitSound("horde/lesion/lesion_roar.ogg", 1500, 80, 1, CHAN_STATIC)
end

function ENT:DoEntityRelationshipCheck()
    if self.Behavior == VJ_BEHAVIOR_PASSIVE_NATURE then return false end
	local posEnemies = self.CurrentPossibleEnemies
	if posEnemies == nil then return false end
	self.ReachableEnemyCount = 0
	local eneSeen = false
	local myPos = self:GetPos()
	local nearestDist = nil
	local mySDir = self:GetSightDirection()
	local mySAng = math.cos(math.rad(self.SightAngle))
	local plyControlled = self.VJ_IsBeingControlled
	local sdHintBullet = sound.GetLoudestSoundHint(SOUND_BULLET_IMPACT, myPos)
	local sdHintBulletOwner = nil;
	if sdHintBullet then
		sdHintBulletOwner = sdHintBullet.owner
	end
	local it = 1
	while it <= #posEnemies do
		local v = posEnemies[it]
		if !IsValid(v) then
			table.remove(posEnemies, it)
		else
			it = it + 1
			if self:VJ_HasNoTarget(v) == true then
				if IsValid(self:GetEnemy()) && self:GetEnemy() == v then
					self:ResetEnemy(false)
				end
				continue
			end
			local vPos = v:GetPos()
			local vDistanceToMy = vPos:Distance(myPos)
			local sightDist = self.SightDistance
			if vDistanceToMy > sightDist then continue end
			local entFri = false
			local vClass = v:GetClass()
			local vNPC = v:IsNPC()
			local vPlayer = v:IsPlayer()
			if vClass != self:GetClass() then
				for _,friClass in ipairs(self.VJ_NPC_Class) do
					if friClass == varCPly && self.PlayerFriendly == false then self.PlayerFriendly = true end -- If player ally then set the PlayerFriendly to true
					if (friClass == varCCom && NPCTbl_Combine[vClass]) or (friClass == varCZom && NPCTbl_Zombies[vClass]) or (friClass == varCAnt && NPCTbl_Antlions[vClass]) or (friClass == varCXen && NPCTbl_Xen[vClass]) then
						v:AddEntityRelationship(self, D_LI, 99)
						self:AddEntityRelationship(v, D_LI, 99)
						entFri = true
					end
					if (v.VJ_NPC_Class && VJ_HasValue(v.VJ_NPC_Class, friClass)) or (entFri == true) then
						if friClass == varCPly then -- If we have the player ally class then check if we both of us are supposed to be friends
							if self.FriendsWithAllPlayerAllies == true && v.FriendsWithAllPlayerAllies == true then
								entFri = true
								if vNPC then v:AddEntityRelationship(self, D_LI, 99) end
								self:AddEntityRelationship(v, D_LI, 99)
							end
						else
							entFri = true
							-- If I am enemy to it, then reset it!
							if IsValid(self:GetEnemy()) && self:GetEnemy() == v then
								self.EnemyReset = true
								self:ResetEnemy(false)
							end
							if vNPC then v:AddEntityRelationship(self, D_LI, 99) end
							self:AddEntityRelationship(v, D_LI, 99)
						end
					end
				end
				
				if vPlayer then
					entFri = true
					self:AddEntityRelationship(v, D_LI, 99)
				end
				if vClass == "npc_turret_floor" or vClass == "npc_vj_horde_combat_bot" or vClass == "npc_vj_horde_vortigaunt" or vClass == "npc_manhack" then
					entFri = true
					self:AddEntityRelationship(v, D_LI, 99)
				else
					if !entFri && vNPC then v:AddEntityRelationship(self, D_HT, 99) end
				end
				-- Investigation detection systems, including sound, movement and flashlight
				if (!self.IsVJBaseSNPC_Tank) && !IsValid(self:GetEnemy()) && entFri == false then
					if vPlayer then
						self:AddEntityRelationship(v, D_NU, 99) -- Make the player neutral since it's not supposed to be a friend
						if v:Crouching() && v:GetMoveType() != MOVETYPE_NOCLIP then
							sightDist = self.VJ_IsHugeMonster == true and 5000 or 2000
						end
						if vDistanceToMy < 350 && v:FlashlightIsOn() == true && (v:GetForward():Dot((myPos - vPos):GetNormalized()) > math_cos(math_rad(20))) then
							//			   Asiga hoser ^ (!v:Crouching() && v:GetVelocity():Length() > 0 && v:GetMoveType() != MOVETYPE_NOCLIP && ((!v:KeyDown(IN_WALK) && (v:KeyDown(IN_FORWARD) or v:KeyDown(IN_BACK) or v:KeyDown(IN_MOVELEFT) or v:KeyDown(IN_MOVERIGHT))) or (v:KeyDown(IN_SPEED) or v:KeyDown(IN_JUMP)))) or
							self:SetTarget(v)
							self:VJ_TASK_FACE_X("TASK_FACE_TARGET")
						end
					end
					if self.NextInvestigateSoundMove < CurTime() then
						-- When a sound is detected
						if v.VJ_LastInvestigateSdLevel && vDistanceToMy < (self.InvestigateSoundDistance * v.VJ_LastInvestigateSdLevel) && ((CurTime() - v.VJ_LastInvestigateSd) <= 1) then
							if self:Visible(v) then
								self:StopMoving()
								self:SetTarget(v)
								self:VJ_TASK_FACE_X("TASK_FACE_TARGET")
							elseif self.FollowingPlayer == false then
								self:SetLastPosition(vPos)
								self:VJ_TASK_GOTO_LASTPOS("TASK_WALK_PATH")
							end
							self:CustomOnInvestigate(v)
							self:PlaySoundSystem("InvestigateSound")
							self.NextInvestigateSoundMove = CurTime() + 2
						-- When a bullet hit is detected
						elseif IsValid(sdHintBulletOwner) && sdHintBulletOwner == v then
							self:StopMoving()
							self:SetLastPosition(sdHintBullet.origin)
							self:VJ_TASK_FACE_X("TASK_FACE_LASTPOSITION")
							self:CustomOnInvestigate(v)
							self:PlaySoundSystem("InvestigateSound")
							self.NextInvestigateSoundMove = CurTime() + 0.3 -- Shorter delay because many bullets could hit
						end
					end
				end
			end

			-- Check in order: Can find enemy + Neutral or not + Is visible + In sight
			if self.DisableFindEnemy == false && (self.Behavior != VJ_BEHAVIOR_NEUTRAL or self.Alerted) && (self.FindEnemy_CanSeeThroughWalls or self:Visible(v)) && (self.FindEnemy_UseSphere or (mySDir:Dot((vPos - myPos):GetNormalized()) > mySAng)) then
				local check = self:DoRelationshipCheck(v)
				if check == true then -- Is enemy
					eneSeen = true
					self.ReachableEnemyCount = self.ReachableEnemyCount + 1
					self:AddEntityRelationship(v, D_HT, 99)
					-- If the detected enemy is closer than the previous enemy, the set this as the enemy!
					if (nearestDist == nil) or (vDistanceToMy < nearestDist) then
						nearestDist = vDistanceToMy
						self:VJ_DoSetEnemy(v, true, true)
					end
				-- If the current enemy is a friendly player, then reset the enemy!
				elseif check == false && vPlayer && IsValid(self:GetEnemy()) && self:GetEnemy() == v then
					self.EnemyReset = true
					self:ResetEnemy(false)
				end
			end
			if vPlayer then
				if entFri == true && self.MoveOutOfFriendlyPlayersWay == true && self.IsGuard == false && !self:IsMoving() && CurTime() > self.TakingCoverT && !plyControlled && (!self.IsVJBaseSNPC_Tank) && self:BusyWithActivity() == false then
					local dist = 20
					if self.FollowingPlayer == true then dist = 10 end
					if /*self:Disposition(v) == D_LI &&*/ (self:VJ_GetNearestPointToEntityDistance(v) < dist) && v:GetVelocity():Length() > 0 && v:GetMoveType() != MOVETYPE_NOCLIP then
						self.NextFollowPlayerT = CurTime() + 2
						self:PlaySoundSystem("MoveOutOfPlayersWay")
						self:SetMovementActivity(VJ_PICK(self.AnimTbl_Run))
						local vsched = ai_vj_schedule.New("vj_move_away")
						vsched:EngTask("TASK_MOVE_AWAY_PATH", 120)
						vsched:EngTask("TASK_RUN_PATH", 0)
						vsched:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
						vsched.IsMovingTask = true
						vsched.MoveType = 1
						self:StartSchedule(vsched)
						self.TakingCoverT = CurTime() + 0.2
					end
				end
				
				-- HasOnPlayerSight system, used to do certain actions when it sees the player
				if self.HasOnPlayerSight == true && v:Alive() &&(CurTime() > self.OnPlayerSightNextT) && (vDistanceToMy < self.OnPlayerSightDistance) && self:Visible(v) && (mySDir:Dot((v:GetPos() - myPos):GetNormalized()) > mySAng) then
					-- 0 = Run it every time | 1 = Run it only when friendly to player | 2 = Run it only when enemy to player
					local disp = self.OnPlayerSightDispositionLevel
					if (disp == 0) or (disp == 1 && (self:Disposition(v) == D_LI or self:Disposition(v) == D_NU)) or (disp == 2 && self:Disposition(v) != D_LI) then
						self:CustomOnPlayerSight(v)
						self:PlaySoundSystem("OnPlayerSight")
						if self.OnPlayerSightOnlyOnce == true then -- If it's only suppose to play it once then turn the system off
							self.HasOnPlayerSight = false
						else
							self.OnPlayerSightNextT = CurTime() + math.Rand(self.OnPlayerSightNextTime.a, self.OnPlayerSightNextTime.b)
						end
					end
				end
			end
		end
	end
	if eneSeen == true then return true else return false end
end

local finishAttack = {
	[VJ_ATTACK_MELEE] = function(self, skipStopAttacks)
		if skipStopAttacks != true then
			timer.Create("timer_melee_finished"..self:EntIndex(), self:DecideAttackTimer(self.NextAnyAttackTime_Melee, self.NextAnyAttackTime_Melee_DoRand, self.TimeUntilMeleeAttackDamage, self.CurrentAttackAnimationDuration), 1, function()
				self:StopAttacks()
				self:DoChaseAnimation()
			end)
		end
		timer.Create("timer_melee_finished_abletomelee"..self:EntIndex(), self:DecideAttackTimer(self.NextMeleeAttackTime, self.NextMeleeAttackTime_DoRand), 1, function()
			self.IsAbleToMeleeAttack = true
		end)
	end,
	[VJ_ATTACK_RANGE] = function(self, skipStopAttacks)
		if skipStopAttacks != true then
			timer.Create("timer_range_finished"..self:EntIndex(), self:DecideAttackTimer(self.NextAnyAttackTime_Range, self.NextAnyAttackTime_Range_DoRand, self.TimeUntilRangeAttackProjectileRelease, self.CurrentAttackAnimationDuration), 1, function()
				self:StopAttacks()
				self:DoChaseAnimation()
			end)
		end
		timer.Create("timer_range_finished_abletorange"..self:EntIndex(), self:DecideAttackTimer(self.NextRangeAttackTime, self.NextRangeAttackTime_DoRand), 1, function()
			self.IsAbleToRangeAttack = true
		end)
	end,
	[VJ_ATTACK_LEAP] = function(self, skipStopAttacks)
		if skipStopAttacks != true then
			timer.Create("timer_leap_finished"..self:EntIndex(), self:DecideAttackTimer(self.NextAnyAttackTime_Leap, self.NextAnyAttackTime_Leap_DoRand, self.TimeUntilLeapAttackDamage, self.CurrentAttackAnimationDuration), 1, function()
				self:StopAttacks()
				self:DoChaseAnimation()
			end)
		end
		timer.Create("timer_leap_finished_abletoleap"..self:EntIndex(), self:DecideAttackTimer(self.NextLeapAttackTime, self.NextLeapAttackTime_DoRand), 1, function()
			self.IsAbleToLeapAttack = true
		end)
	end
}

function ENT:MeleeAttackCode(isPropAttack, attackDist, customEnt)
	if self.Dead == true or self.vACT_StopAttacks == true or self.Flinching == true or (self.StopMeleeAttackAfterFirstHit == true && self.AlreadyDoneMeleeAttackFirstHit == true) then return end
	isPropAttack = isPropAttack or self.MeleeAttack_DoingPropAttack -- Is this a prop attack?
	attackDist = attackDist or self.MeleeAttackDamageDistance -- How far should the attack go?
	local curEnemy = customEnt or self:GetEnemy()
	if self.MeleeAttackAnimationFaceEnemy == true && isPropAttack == false then self:FaceCertainEntity(curEnemy, true) end
	self:CustomOnMeleeAttack_BeforeChecks()
	if self.DisableDefaultMeleeAttackCode == true then return end
	local myPos = self:GetPos()
	local hitRegistered = false
	for _,v in pairs(ents.FindInSphere(self:SetMeleeAttackDamagePosition(), attackDist)) do
		if v != self && v:GetClass() != self:GetClass() && (((v:IsNPC() or (v:IsPlayer() && v:Alive() && GetConVar("ai_ignoreplayers"):GetInt() == 0)) && self:Disposition(v) != D_LI)) && self:GetSightDirection():Dot((Vector(v:GetPos().x, v:GetPos().y, 0) - Vector(myPos.x, myPos.y, 0)):GetNormalized()) > math.cos(math.rad(self.MeleeAttackDamageAngleRadius)) then
			if isPropAttack == true && (v:IsPlayer() or v:IsNPC()) && self:VJ_GetNearestPointToEntityDistance(v) > self.MeleeAttackDistance then continue end //if (self:GetPos():Distance(v:GetPos()) <= self:VJ_GetNearestPointToEntityDistance(v) && self:VJ_GetNearestPointToEntityDistance(v) <= self.MeleeAttackDistance) == false then
			if self:CustomOnMeleeAttack_AfterChecks(v, vProp) == true then continue end
			-- Knockback
			if self.HasMeleeAttackKnockBack == true && v.MovementType != VJ_MOVETYPE_STATIONARY && (v.VJ_IsHugeMonster != true or v.IsVJBaseSNPC_Tank == true) then
				v:SetGroundEntity(NULL)
				v:SetVelocity(self:GetForward()*math.random(self.MeleeAttackKnockBack_Forward1, self.MeleeAttackKnockBack_Forward2) + self:GetUp()*math.random(self.MeleeAttackKnockBack_Up1, self.MeleeAttackKnockBack_Up2))
			end
			-- Damage
            local applyDmg = DamageInfo()
            applyDmg:SetDamage(self.MeleeAttackDamage)
            applyDmg:SetDamageType(self.MeleeAttackDamageType)
            if v:IsNPC() or v:IsPlayer() then applyDmg:SetDamageForce(self:GetForward()*((applyDmg:GetDamage()+100)*70)) end
            applyDmg:SetInflictor(self)
            applyDmg:SetAttacker(self)
			applyDmg:SetDamagePosition(v:GetPos())
            if self:GetNWEntity("HordeOwner"):IsValid() then
                applyDmg:SetAttacker(self:GetNWEntity("HordeOwner"))
            end
            v:TakeDamageInfo(applyDmg)
			v:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, self.MeleeAttackDamage / 2, self:GetNWEntity("HordeOwner"))
			if v:IsPlayer() then
				-- Apply DSP
				if self.MeleeAttackDSPSoundType != false && ((self.MeleeAttackDSPSoundUseDamage == false) or (self.MeleeAttackDSPSoundUseDamage == true && self.MeleeAttackDamage >= self.MeleeAttackDSPSoundUseDamageAmount && GetConVar("vj_npc_nomeleedmgdsp"):GetInt() == 0)) then
					v:SetDSP(self.MeleeAttackDSPSoundType, false)
				end
				v:ViewPunch(Angle(math.random(-1, 1)*self.MeleeAttackDamage, math.random(-1, 1)*self.MeleeAttackDamage, math.random(-1, 1)*self.MeleeAttackDamage))
			end
		end
	end
	if self.AttackStatus < VJ_ATTACK_STATUS_EXECUTED then
		self.AttackStatus = VJ_ATTACK_STATUS_EXECUTED
		if self.TimeUntilMeleeAttackDamage != false then
			finishAttack[VJ_ATTACK_MELEE](self)
		end
	end
	if hitRegistered == true then
		self:PlaySoundSystem("MeleeAttack")
		self.AttackStatus = VJ_ATTACK_STATUS_EXECUTED_HIT
	else
		self:CustomOnMeleeAttack_Miss()
		-- !!!!!!!!!!!!!! DO NOT USE THESE !!!!!!!!!!!!!! [Backwards Compatibility!]
		if self.MeleeAttackWorldShakeOnMiss then util.ScreenShake(myPos, self.MeleeAttackWorldShakeOnMissAmplitude or 16, 100, self.MeleeAttackWorldShakeOnMissDuration or 1, self.MeleeAttackWorldShakeOnMissRadius or 2000) end
		-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!
		self:PlaySoundSystem("MeleeAttackMiss", {}, VJ_EmitSound)
	end
end

VJ.AddNPC("Shadow Hulk","npc_vj_horde_shadow_hulk", "Horde")