AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/zombie/zombie_fast02.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 6500
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.2 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 30
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee
ENT.NextAnyAttackTime_Melee = 0.6
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.AnimTbl_LeapAttack = {"leapstrike"} -- Melee Attack Animations
ENT.LeapDistance = 400 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 150 -- How close does it have to be until it uses melee?
ENT.TimeUntilLeapAttackDamage = 0.2 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 10 -- How much time until it can use a leap attack?
ENT.NextAnyAttackTime_Leap = 0.4 -- How much time until it can use any attack again? | Counted in Seconds
ENT.LeapAttackExtraTimers = {0.4,0.6,0.8,1} -- Extra leap attack timers | it will run the damage code after the given amount of seconds
ENT.TimeUntilLeapAttackVelocity = 0.2 -- How much time until it runs the velocity code?
ENT.LeapAttackVelocityForward = 300 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 250 -- How much upward force should it apply?
ENT.LeapAttackDamage = 40
ENT.LeapAttackDamageDistance = 100 -- How far does the damage go?
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.6 -- Next foot step sound when it is walking
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/fast_zombie/foot1.wav","npc/fast_zombie/foot2.wav","npc/fast_zombie/foot3.wav","npc/fast_zombie/foot4.wav"}
ENT.SoundTbl_Breath = {"npc/fast_zombie/breathe_loop1.wav"}
ENT.SoundTbl_Alert = {"npc/fast_zombie/fz_alert_close1.wav","npc/fast_zombie/fz_alert_far1.wav"}
ENT.SoundTbl_MeleeAttack = {"npc/fast_zombie/claw_strike1.wav","npc/fast_zombie/claw_strike2.wav","npc/fast_zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_LeapAttackJump = {"npc/fast_zombie/fz_scream1.wav"}
ENT.SoundTbl_LeapAttackDamage = {"npc/fast_zombie/claw_strike1.wav","npc/fast_zombie/claw_strike2.wav","npc/fast_zombie/claw_strike3.wav"}
ENT.SoundTbl_Pain = {"npc/fast_zombie/idle1.wav","npc/fast_zombie/idle2.wav","npc/fast_zombie/idle3.wav"}
ENT.SoundTbl_Death = {"npc/fast_zombie/wake1.wav"}

ENT.GeneralSoundPitch1 = 70
ENT.GeneralSoundPitch2 = 75

ENT.Raging = nil
ENT.Raged = nil
ENT.DamageReceived = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Rage()
    if self.Raging or self.Raged then return end
    self.Raging = true
    self:Ignite(99999999)
    sound.Play("npc/fast_zombie/fz_frenzy1.wav", self:GetPos())
    self:VJ_ACT_PLAYACTIVITY("BR2_Roar", true, 1.5, false)
    timer.Simple(1.5, function ()
        if not IsValid(self) then return end
        self.AnimTbl_Run = ACT_RUN
        self.HasLeapAttack = true
        self.Raged = true
        self.Raging = false
        self:SetColor(Color(125, 50, 50))
    end)
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if HORDE:IsFireDamage(dmginfo) then
		dmginfo:ScaleDamage(0.75)
	elseif HORDE:IsColdDamage(dmginfo) or HORDE:IsMeleeDamage(dmginfo) or HORDE:IsBlastDamage(dmginfo) then
		dmginfo:ScaleDamage(1.25)
	end
end

function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(13, 13, 50), Vector(-13, -13, 0))
    self:SetModelScale(1.75)
    self.HasLeapAttack = false
    self.AnimTbl_Run = ACT_WALK
    self:SetColor(Color(25, 25, 25))
    self:Ignite(99999999)

    local id = self:GetCreationID()
    timer.Remove("Horde_FlayerRage" .. id)
    timer.Create("Horde_FlayerRage" .. id, 10, 1, function ()
        if not IsValid(self) then return end
        self:Rage()
    end)
    self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end

function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
    if isProp then return end
    if not self.Raged then return end
    if hitEnt and IsValid(hitEnt) and hitEnt:IsPlayer() then
        self:UnRage()
        hitEnt:Horde_AddDebuffBuildup(HORDE.Status_Ignite, 35, self)
    end
end

function ENT:UnRage()
    self.Raged = nil
    self.Raging = nil
    self.DamageReceived = 0
    self.HasLeapAttack = false
    self.AnimTbl_Run = ACT_WALK
    self:SetColor(Color(25, 25, 25))
    local id = self:GetCreationID()
    timer.Remove("Horde_FlayerRage" .. id)
    timer.Create("Horde_FlayerRage" .. id, 10, 1, function ()
        if not IsValid(self) then return end
        self:Rage()
    end)
end

function ENT:CustomOnLeapAttack_AfterChecks(hitEnt, isProp)
    if isProp then return end
    if not self.Raged then return end
    if hitEnt and IsValid(hitEnt) and hitEnt:IsPlayer() then
        self:UnRage()
        hitEnt:Horde_AddDebuffBuildup(HORDE.Status_Ignite, 50, self)
    end
end

function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
    self.DamageReceived = self.DamageReceived + dmginfo:GetDamage()
    if self.DamageReceived >= self:GetMaxHealth() * 0.10 then
        self:Rage()
        self.DamageReceived = 0
    end
end

VJ.AddNPC("Hell Knight","npc_vj_horde_hellknight", "Zombies")