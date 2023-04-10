AddCSLuaFile("shared.lua")
include('shared.lua')


-- Core
ENT.Model = {"models/horde/gargantua/gargantua.mdl"}
ENT.StartHealth = 8000
ENT.HullType = HULL_HUMAN

ENT.SightDistance = 10000 -- How far it can see
ENT.SightAngle = 100 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.TurningSpeed = 40 -- How fast it can turn
ENT.MaxJumpLegalDistance = VJ_Set(400, 550) -- The max distance the NPC can jump (Usually from one node to another) | ( UP, DOWN )

-- AI
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.ConstantlyFaceEnemy = true -- Should it face the enemy constantly?
ENT.ConstantlyFaceEnemy_IfAttacking = true -- Should it face the enemy when attacking?
ENT.ConstantlyFaceEnemy_Postures = "Standing" -- "Both" = Moving or standing | "Moving" = Only when moving | "Standing" = Only when standing
ENT.ConstantlyFaceEnemyDistance = 2000 -- How close does it have to be until it starts to face the enemy?
ENT.NoChaseAfterCertainRange = false -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = "UseRangeDistance" -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = "UseRangeDistance" -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "OnlyRange" -- "Regular" = Default behavior | "OnlyRange" = Only does it if it's able to range attack
ENT.InvestigateSoundDistance = 100 -- How far away can the SNPC hear sounds? | This number is timed by the calculated volume of the detectable sound.

ENT.AttackProps = true -- Should it attack props when trying to move?
ENT.PushProps = true -- Should it push props when trying to move?
ENT.PropAP_MaxSize = 2 -- This is a scale number for the max size it can attack/push | x < 1  = Smaller props & x > 1  = Larger props | Default base value: 1
ENT.FindEnemy_CanSeeThroughWalls = true -- Should it be able to see through walls and objects? | Can be useful if you want to make it know where the enemy is at all times

-- Damage/Injured
ENT.BloodColor = "Red"
ENT.Immune_Dissolve = true
ENT.Immune_Physics = true

-- Flinch
ENT.CanFlinch = 0 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.NextFlinchTime = 2
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS} -- If it uses normal based animation, use this
ENT.RunAwayOnUnknownDamage = false
ENT.CallForBackUpOnDamage = false

-- Melee
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 30 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageType = DMG_CLUB -- How close does it have to be until it attacks?
ENT.MeleeAttackDistance = 65 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 100 -- How far does the damage go?
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.MeleeAttackWorldShakeOnMiss = true
ENT.MeleeAttackWorldShakeOnMissAmplitude = 8

-- Ranged
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_gonome_acid_cold" -- The entity that is spawned when range attacking
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 80 -- How close does it have to be until it uses melee?
ENT.NextRangeAttackTime = 5 -- How much time until it can use a range attack?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.RangeAttackPos_Up = 10 -- Up/Down spawning position for range attack
ENT.RangeAttackPos_Forward = 50 -- Forward/Backward spawning position for range attack
ENT.RangeAttackPos_Right = -20 -- Right/Left spawning position for range attack

-- Knockback
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 100 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 100 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 250 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 260 -- How far it will push you up | Second in math.random
ENT.MeleeAttackKnockBack_Right1 = 0 -- How far it will push you right | First in math.random
ENT.MeleeAttackKnockBack_Right2 = 0 -- How far it will push you right | Second in math.random

ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
ENT.PushProps = true -- Should it push props when trying to move?

    -- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"horde/gargantua/gar_step1.ogg","horde/gargantua/gar_step1.ogg"}
ENT.SoundTbl_Breath = {"horde/gargantua/gar_breathe1.ogg","horde/gargantua/gar_breathe2.ogg","horde/gargantua/gar_breathe3.ogg"}
ENT.SoundTbl_Idle = {"horde/gargantua/gar_idle1.ogg","horde/gargantua/gar_idle2.ogg","horde/gargantua/gar_idle3.ogg"}
ENT.SoundTbl_Alert = {"horde/gargantua/gar_alert1.ogg","horde/gargantua/gar_alert2.ogg","horde/gargantua/gar_alert3.ogg"}
ENT.SoundTbl_BeforeMeleeAttack = {"horde/gargantua/gar_attack1.ogg","horde/gargantua/gar_attack2.ogg","horde/gargantua/gar_attack3.ogg"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_Pain = {"horde/gargantua/gar_pain1.ogg","horde/gargantua/gar_pain2.ogg","horde/gargantua/gar_pain3.ogg"}
ENT.SoundTbl_Death = {"horde/gargantua/gar_die1.ogg"}

ENT.Garg_AttackType = -1
ENT.Garg_AbleToFlame = false
ENT.Garg_NextAbleToFlameT = 0
ENT.Garg_NextStompAttackT = 0
ENT.Garg_MeleeLargeKnockback = false
ENT.NextFlashTime = CurTime()
ENT.NextFlashCooldown = 30
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
    //self:SetCollisionBounds(Vector(20, 20, 85), Vector(-20, -20, 0))
    //self:SetSkin(1)
    self:SetCollisionBounds(Vector(70,70,210), Vector(-70,-70,0))
    self:SetModelScale(0.5)
    self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")

    local glow1 = ents.Create("env_sprite")
	glow1:SetKeyValue("model","models/horde/gargantua/gargeye1.vmt")
	glow1:SetKeyValue("GlowProxySize","2.0") -- Size of the glow to be rendered for visibility testing.
	glow1:SetKeyValue("renderfx","14")
	glow1:SetKeyValue("rendermode","3") -- Set the render mode to "3" (Glow)
	glow1:SetKeyValue("disablereceiveshadows","0") -- Disable receiving shadows
	glow1:SetKeyValue("spawnflags","0")
	glow1:SetParent(self)
	glow1:Fire("SetParentAttachment","head")
	glow1:Spawn()
	glow1:Activate()
	self:DeleteOnRemove(glow1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Critical = nil

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if HORDE:IsLightningDamage(dmginfo) or HORDE:IsBlastDamage(dmginfo) then
		dmginfo:ScaleDamage(1.25)
    end
end

function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
    if not self.Critical and (self:Health() < self:GetMaxHealth() * 0.6) then
        self.Critical = true
        local light = ents.Create("light_dynamic")
        light:SetKeyValue("brightness", "5")
        light:SetKeyValue("distance", "200")
        light:Fire("Color", "255 0 0")
        light:SetParent(self)
        light:Fire("SetParentAttachment","head")
        light:Spawn()
        light:Activate()
        light:Fire("TurnOn", "", 0)
        self:DeleteOnRemove(light)
		self.light = light

		self:FlashBang()
		self.NextFlareTime = CurTime() + self.NextFlashCooldown
    end
end

function ENT:FlashBang()
    if !self:IsValid() then return end
    self:EmitSound("arccw_go/flashbang/flashbang_explode1.wav", 100, 100, 1, CHAN_ITEM)
    self:EmitSound("arccw_go/flashbang/flashbang_explode1_distant.wav", 140, 100, 1, CHAN_WEAPON)

    local effectdata = EffectData()
    effectdata:SetOrigin( self:GetPos() )

    util.Effect( "arccw_flashexplosion", effectdata)

    local flashorigin = self:GetPos()

    local flashpower = 2000
    local targets = ents.FindInSphere(flashorigin, flashpower)

    for _, k in pairs(targets) do
        if k:IsPlayer() then
            local dist = k:EyePos():Distance(flashorigin)
            local dp = (k:EyePos() - flashorigin):Dot(k:EyeAngles():Forward())

            local time = Lerp( dp, 2.5, 0.25 )

            time = Lerp( dist / flashpower, time, 0 )

            if k:VisibleVec( flashorigin ) then
                k:ScreenFade( SCREENFADE.IN, Color( 255, 0, 0, 255 ), 2.5, time )
            end

            k:SetDSP( 37, false )
		end
    end
end

function ENT:Garg_ResetFlame()
	self.Garg_AbleToFlame = false
	self.Garg_AttackType = -1
	self.AnimTbl_IdleStand = {ACT_IDLE}
	self.NextIdleStandTime = 0
	self.DisableChasingEnemy = false
	VJ_STOPSOUND(self.Garg_FlameSd)
	self:StopParticles()
end

function ENT:MultipleMeleeAttacks()
	local r = math.random(1, 3)
	if r == 1 then
		self.MeleeAttackDamage = 30
		self.TimeUntilMeleeAttackDamage = 0.8
		self.AnimTbl_MeleeAttack = {"vjseq_smash"}
		self.HasMeleeAttackKnockBack = false
		self.Garg_MeleeLargeKnockback = false
	elseif r == 2 then
		self.MeleeAttackDamage = 30
		self.TimeUntilMeleeAttackDamage = 0.8
		self.AnimTbl_MeleeAttack = {"vjseq_attack"}
		self.HasMeleeAttackKnockBack = true
		self.Garg_MeleeLargeKnockback = false
	elseif r == 3 then
		self.MeleeAttackDamage = 25
		self.TimeUntilMeleeAttackDamage = 0.4
		self.AnimTbl_MeleeAttack = {"vjseq_kickcar"}
		self.HasMeleeAttackKnockBack = true
		self.Garg_MeleeLargeKnockback = true
	end
end

function ENT:CustomOnThink()
	if self.Garg_AbleToFlame == false or self.AttackType != VJ_ATTACK_RANGE or !IsValid(self:GetEnemy()) then
		self:Garg_ResetFlame()
	end
	if self.Critical then
		local p = 30 - (self.NextFlashTime - CurTime())
		if self.NextFlashTime < CurTime() then
			self.light:SetKeyValue("brightness", "15")
        	self.light:SetKeyValue("distance", "800")
			self:VJ_ACT_PLAYACTIVITY("bitehead", true, 1.5, false)
			self.Flashing = true
			self:EmitSound("horde/gargantua/gar_die2.ogg", 2000, 75, 1, CHAN_STATIC)
			timer.Simple(2, function ()
				if not self:IsValid() then return end
				self:FlashBang()
				self.Flashing = nil
				for _, k in pairs(ents.FindInSphere(self:GetPos(), 100)) do
					if k:IsPlayer() then
						local dmg = DamageInfo()
						dmg:SetDamage(k:Health())
						dmg:SetDamageType(DMG_SONIC)
						dmg:SetAttacker(self)
						dmg:SetInflictor(self)
						k:TakeDamageInfo(dmg)
					end
				end
				for _, k in pairs(ents.FindInSphere(self:GetPos(), 800)) do
					if k:IsPlayer() then
						local dmg = DamageInfo()
						dmg:SetDamage(50)
						dmg:SetDamageType(DMG_SONIC)
						dmg:SetAttacker(self)
						dmg:SetInflictor(self)
						k:TakeDamageInfo(dmg)
					elseif k:IsNPC() and k:GetClass() ~= "npc_vj_horde_xen_destroyer_unit" then
						local dmg = DamageInfo()
						dmg:SetDamage(100)
						dmg:SetDamageType(DMG_SONIC)
						dmg:SetAttacker(self)
						dmg:SetInflictor(self)
						k:TakeDamageInfo(dmg)
					end
				end
				self:VJ_ACT_PLAYACTIVITY("run")
				self.light:SetKeyValue("brightness", "2")
        		self.light:SetKeyValue("distance", "200")
			end)
			self.NextFlashTime = CurTime() + self.NextFlashCooldown
		elseif self.Flashing then
		elseif p <= 30 then
			self.light:SetKeyValue("brightness", tostring(0.5 * p))
        	self.light:SetKeyValue("distance", tostring(200 + 20 * p))
		end

		if self:IsOnGround() then
			self:SetLocalVelocity(self:GetMoveVelocity() * 2)
		end
	else
		--self.AnimationPlaybackRate = 1.5
		self:SetLocalVelocity(self:GetMoveVelocity() * 1.5)
	end
	ParticleEffectAttach("vj_rpg1_flare", PATTACH_POINT_FOLLOW, self, 1)
end

function ENT:MultipleRangeAttacks()
	local range = 400
	if self.NearestPointToEnemyDistance <= range then -- Flame attack
		self.Garg_AttackType = 0
		self.Garg_AbleToFlame = true
		self.RangeDistance = range
		self.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1}
		self.TimeUntilRangeAttackProjectileRelease = 0.1
		self.DisableRangeAttackAnimation = true
		self.DisableDefaultRangeAttackCode = true
		self.SoundTbl_BeforeRangeAttack = {"horde/gargantua/gar_flameon1.ogg"}
		self.SoundTbl_RangeAttack = {"horde/gargantua/gar_flameoff1.ogg"}
		self.NextIdleStandTime = 0 -- Reset the idle animation
	elseif self.Garg_NextStompAttackT < CurTime() then -- Laser stomp attack
		self.Garg_AttackType = 1
		self.Garg_AbleToFlame = false
		self.RangeDistance = 2000
		self.AnimTbl_RangeAttack = {"stomp"}
		self.TimeUntilRangeAttackProjectileRelease = false
		self.DisableRangeAttackAnimation = false
		self.DisableDefaultRangeAttackCode = false
		self.SoundTbl_BeforeRangeAttack = {}
		self.SoundTbl_RangeAttack = {"horde/gargantua/gar_stomp1.ogg"}

		local enemy_pos = self:GetEnemy():GetPos()
		local dist = enemy_pos:Distance(self:GetPos())
		local dir = enemy_pos - self:GetPos()
		dir:Normalize()
		local start = 0
		local i = 0
		timer.Simple(1.5, function ()
			if !IsValid(self) and !IsValid(self:GetEnemy()) then return end
			local tr = util.TraceLine({
				start = self:GetPos(),
				endpos = self:GetEnemy():GetPos(),
				filter = {self}
			})

			dir = tr.HitPos - self:GetPos()
			dir:Normalize()

			while (start < dist + 300) do
				local pos = self:GetPos() + dir * start
				timer.Simple(0.25 + i * 0.1, function()
					if !IsValid(self) then return end
					ParticleEffect("striderbuster_explode_core", pos, Angle(0,0,0), nil)
					sound.Play("horde/gargantua/hit_large.ogg", pos)
					local dmg = DamageInfo()
					dmg:SetAttacker(self)
					dmg:SetInflictor(self)
					dmg:SetDamage(50)
					dmg:SetDamageType(DMG_CRUSH)
					util.BlastDamageInfo(dmg, pos, 175)
				end)
				i = i + 1
				start = start + 150
			end
		end)
		
		self.Garg_NextStompAttackT = CurTime() + 5
	else
		self.Garg_AttackType = -1
		self.Garg_AbleToFlame = false
	end
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if HORDE:IsPhysicalDamage(dmginfo) then
		dmginfo:ScaleDamage(0.75)
	elseif HORDE:IsBlastDamage(dmginfo) then
		dmginfo:ScaleDamage(1.25)
	end
end

function ENT:CustomOnRemove()
	VJ_STOPSOUND(self.Garg_FlameSd)
end

function ENT:CustomOnThink_AIEnabled()
	if IsValid(self:GetEnemy()) && (self.NearestPointToEnemyDistance <= 400) && (self.NearestPointToEnemyDistance > self.MeleeAttackDistance) && self.Garg_AbleToFlame == true && self.Garg_NextAbleToFlameT < CurTime() && self.Garg_AttackType == 0 and timer.Exists("timer_range_start"..self:EntIndex()) then
		local range = 550
		self.Garg_NextAbleToFlameT = CurTime() + 0.2
		self.DisableChasingEnemy = true
		self.AnimTbl_IdleStand = {"shootflames2"}
		self.NextIdleStandTime = 0
		self:StopMoving()
		util.VJ_SphereDamage(self, self, self:GetPos() + self:OBBCenter() + self:GetForward()*50, range, 2, DMG_BURN, true, true, {UseCone=true, UseConeDegree=30}, function(ent) if HORDE:IsPlayerOrMinion(ent) then ent:Horde_AddDebuffBuildup(HORDE.Status_Necrosis, 7, self) end end)
		-- COSMETICS: Sound, particle and decal
		self.Garg_FlameSd = VJ_CreateSound(self, "horde/gargantua/gar_flamerun1.ogg")
		self:StopParticles()
		ParticleEffectAttach("xen_destroyer_flame", PATTACH_POINT_FOLLOW, self, 2)
		ParticleEffectAttach("xen_destroyer_flame", PATTACH_POINT_FOLLOW, self, 3)
		local startPos1 = self:GetAttachment(2).Pos
		local startPos2 = self:GetAttachment(3).Pos
		local tr1 = util.TraceLine({start = startPos1, endpos = startPos1 + self:GetForward()*range, filter = self})
		local tr2 = util.TraceLine({start = startPos2, endpos = startPos2 + self:GetForward()*range, filter = self})
		local hitPos1 = tr1.HitPos
		local hitPos2 = tr2.HitPos
		sound.EmitHint(SOUND_DANGER, (hitPos1 + startPos1) / 2, 300, 1, self) -- Pos: Midpoint of start and hit pos, same as Vector((hitPos1.x + startPos1.x ) / 2, (hitPos1.y + startPos1.y ) / 2, (hitPos1.z + startPos1.z ) / 2)
		sound.EmitHint(SOUND_DANGER, (hitPos2 + startPos2) / 2, 300, 1, self)
		--util.Decal("VJ_HLR_Scorch", hitPos1 + tr1.HitNormal, hitPos1 - tr1.HitNormal)
		--util.Decal("VJ_HLR_Scorch", hitPos2 + tr2.HitNormal, hitPos2 - tr2.HitNormal)
		-- Make it constantly delay the range attack timer by 1 second (Which will also successfully play the flame-end sound)
		timer.Adjust("timer_range_start"..self:EntIndex(), 1, 0, function()
			self:RangeAttackCode()
			self:Garg_ResetFlame()
			timer.Remove("timer_range_start"..self:EntIndex())
		end)
	end
end

VJ.AddNPC("Xen Destroyer Unit","npc_vj_horde_xen_destroyer_unit", "Zombies")