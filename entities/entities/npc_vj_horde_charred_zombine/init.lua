AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/vj_zombies/zombine.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 350
ENT.HullType = HULL_WIDE_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = ACT_MELEE_ATTACK2
ENT.TimeUntilMeleeAttackDamage = false
ENT.MeleeAttackDamage = 35
ENT.MeleeAttackDistance = 30 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 70 -- How far does the damage go?
ENT.MeleeAttackDamageAngleRadius = 180 -- We need this because its eye position ends up rotating too much on melee!
ENT.SlowPlayerOnMeleeAttack = false -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 5 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.6 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS} -- If it uses normal based animation, use this
ENT.FlinchAnimationDecreaseLengthAmount = 0.4 -- This will decrease the time it can move, attack, etc. | Use it to fix animation pauses after it finished the flinch animation
ENT.HitGroupFlinching_Values = {{HitGroup = {HITGROUP_HEAD}, Animation = {ACT_FLINCH_HEAD}}, {HitGroup = {HITGROUP_LEFTARM}, Animation = {ACT_FLINCH_LEFTARM}}, {HitGroup = {HITGROUP_RIGHTARM}, Animation = {ACT_FLINCH_RIGHTARM}}, {HitGroup = {HITGROUP_LEFTLEG}, Animation = {ACT_FLINCH_LEFTLEG}}, {HitGroup = {HITGROUP_RIGHTLEG}, Animation = {ACT_FLINCH_RIGHTLEG}}}
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_zombies/zombine/gear1.wav", "vj_zombies/zombine/gear2.wav", "vj_zombies/zombine/gear3.wav"}
ENT.SoundTbl_Idle = {"vj_zombies/zombine/idle1.wav", "vj_zombies/zombine/idle2.wav", "vj_zombies/zombine/idle3.wav", "vj_zombies/zombine/idle4.wav", "vj_zombies/zombine/idle5.wav"}
ENT.SoundTbl_Alert = {"vj_zombies/zombine/alert1.wav", "vj_zombies/zombine/alert2.wav", "vj_zombies/zombine/alert3.wav", "vj_zombies/zombine/alert4.wav", "vj_zombies/zombine/alert5.wav", "vj_zombies/zombine/alert6.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_zombies/zombine/attack1.wav", "vj_zombies/zombine/attack2.wav", "vj_zombies/zombine/attack3.wav", "vj_zombies/zombine/attack4.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_zombies/slow/miss1.wav", "vj_zombies/slow/miss2.wav", "vj_zombies/slow/miss3.wav", "vj_zombies/slow/miss4.wav"}
ENT.SoundTbl_Pain = {"vj_zombies/zombine/pain1.wav", "vj_zombies/zombine/pain2.wav", "vj_zombies/zombine/pain3.wav", "vj_zombies/zombine/pain4.wav"}
ENT.SoundTbl_Death = {"vj_zombies/zombine/die1.wav", "vj_zombies/zombine/die2.wav"}

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100

-- Custom
ENT.Zombine_GrenadeOut = false
ENT.Zombie_LastAnimSet = 0 -- 0 = Regular no grenade
ENT.Immune_Fire = true
ENT.CanFlinch = 1
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(13, 13, 60), Vector(-13, -13, 0))
	self:Ignite(9999999)
	self:SetColor(Color(125,50,50))
	self:SetBodygroup( 1,1 )
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInput(key, activator, caller, data)
	if key == "step" then
		self:PlayFootstepSound()
	elseif key == "melee" then
		self:ExecuteMeleeAttack()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply)
	ply:ChatPrint("JUMP: To Pull Grenade (One time event!)")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
    -- We have an active grenade
    if IsValid(self.Zombine_Grenade) then
        if act == ACT_IDLE then
            return ACT_HANDGRENADE_THROW1
        elseif (act == ACT_WALK or act == ACT_RUN) && IsValid(self:GetEnemy()) then
            if self.EnemyData.Distance < 1024 then -- Make it run when close to the enemy
                return ACT_HANDGRENADE_THROW3
            else
                return ACT_HANDGRENADE_THROW2
            end
        end
    elseif (act == ACT_WALK or act == ACT_RUN) then
        if IsValid(self:GetEnemy()) then
            if self.EnemyData.Distance < 1024 then -- Make it run when close to the enemy
                return ACT_RUN
            else
                return ACT_WALK
            end
        end
    end
    return self.BaseClass.TranslateActivity(self, act)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThinkActive()
    -- Pull out the grenade
    if !self.Zombine_GrenadeOut then
        if self.VJ_IsBeingControlled then
            if  self.VJ_TheController:KeyDown(IN_JUMP) then
                self.VJ_TheController:PrintMessage(HUD_PRINTCENTER, "Pulling Grenade Out!")
                self:Zombine_CreateGrenade()
            end
        elseif IsValid(self:GetEnemy()) && self.EnemyData.Distance <= 384 && self:Health() <= 65 then
            self:Zombine_CreateGrenade()
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombine_CreateGrenade()
	self.Zombine_GrenadeOut = true
	self:VJ_ACT_PLAYACTIVITY("pullgrenade", true, false, true)
	timer.Simple(0.6, function()
		if IsValid(self) then
			self.Zombine_Grenade = ents.Create("npc_grenade_frag")
			self.Zombine_Grenade:SetOwner(self)
			self.Zombine_Grenade:SetParent(self)
			self.Zombine_Grenade:Fire("SetParentAttachment", "grenade_attachment", 0)
			self.Zombine_Grenade:Spawn()
			self.Zombine_Grenade:Activate()
			self.Zombine_Grenade:Input("SetTimer", self:GetOwner(), self:GetOwner(), 3)
			self.Zombine_Grenade.VJ_IsPickedUpDanger = true -- So humans detect as picked up and they won't pick it up
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
--[[
function ENT:MultipleMeleeAttacks()
    self.AnimTbl_MeleeAttack = {"vjseq_fastattack"}
    self.TimeUntilMeleeAttackDamage = 0.4
    self.MeleeAttackDamage = 25
end
]]
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled(dmginfo,hitgroup)
	if IsValid(self.Zombine_Grenade) then
		local att = self:GetAttachment(self:LookupAttachment("grenade_attachment"))
		self.Zombine_Grenade:SetOwner(NULL)
		self.Zombine_Grenade:SetParent(NULL)
		self.Zombine_Grenade:Fire("ClearParent")
		self.Zombine_Grenade:SetMoveType(MOVETYPE_VPHYSICS)
		self.Zombine_Grenade:SetPos(att.Pos)
		self.Zombine_Grenade:SetAngles(att.Ang)
		local phys = self.Zombine_Grenade:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableGravity(true)
			phys:Wake()
		end
	end
end

function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
    if isProp then return end
    if hitEnt and IsValid(hitEnt) and hitEnt:IsPlayer() then
        hitEnt:Horde_AddDebuffBuildup(HORDE.Status_Ignite, 35)
    end
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if HORDE:IsFireDamage(dmginfo) then
		dmginfo:ScaleDamage(0.75)
	elseif HORDE:IsColdDamage(dmginfo) or HORDE:IsMeleeDamage(dmginfo) then
		dmginfo:ScaleDamage(1.25)
	end
end

VJ.AddNPC("Charred Zombine","npc_vj_horde_charred_zombine", "Zombies")