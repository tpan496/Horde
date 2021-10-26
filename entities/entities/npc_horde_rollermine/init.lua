AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/roller.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 600
ENT.SightDistance = 8000
ENT.HullType = HULL_HUMAN
ENT.MovementType = VJ_MOVETYPE_GROUND
ENT.DropWeaponOnDeath = false -- Should it drop its weapon on death?
ENT.SightAngle = 180 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.LastSeenEnemyTimeUntilReset = 60 -- Time until it resets its enemy if its current enemy is not visible
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"} -- NPCs with the same class with be allied to each other
ENT.Bleeds = false -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.HasBloodParticle = false -- Does it spawn a particle when damaged?
ENT.HasBloodDecal = false -- Does it spawn a decal when damaged?
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.Immune_Dissolve = true -- Immune to Dissolving | Example: Combine Ball
ENT.Immune_Bullet = true -- Immune to bullet type damages
ENT.Immune_Fire = true -- Immune to fire-type damages
ENT.Immune_Melee = true -- Immune to melee-type damage | Example: Crowbar, slash damages
ENT.DamageByPlayerDispositionLevel = 1 -- 0 = Run it every time | 1 = Run it only when friendly to player | 2 = Run it only when enemy to player
-- Melee Attack ---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamage = math.random(20,30)
ENT.MeleeAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.MeleeAttackAnimationFaceEnemy = true -- Should it face the enemy while playing the melee attack animation?
ENT.MeleeAttackAnimationDecreaseLengthAmount = 0 -- This will decrease the time until starts chasing again. Use it to fix animation pauses until it chases the enemy.
ENT.MeleeAttackDistance = 60 -- How close does it have to be until it attacks?
ENT.MeleeAttackAngleRadius = 120 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
ENT.MeleeAttackDamageDistance = 82 -- How far does the damage go?
ENT.MeleeAttackDamageAngleRadius = 100 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
ENT.TimeUntilMeleeAttackDamage = 0.5 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 1.10 -- How much time until it can use any attack again? | Counted in Seconds
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 190 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 390 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 0 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = true -- Should the enemy bleed when attacked by melee?
ENT.MeleeAttackBleedEnemyChance = 1 -- How much chance there is that the enemy will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 5 -- How many reps?
-- Miscellaneous ---------------------------------------------------------------------------------------------------------------------------------------------	
ENT.AnimTbl_IdleStand = {ACT_IDLE} -- The idle animation when AI is enabled
ENT.AnimTbl_Walk = {ACT_WALK} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
ENT.AnimTbl_Run = {ACT_RUN} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
ENT.AnimTbl_MeleeAttack = {"throw"} -- Melee Attack Animations
-- ====== Other Variables ====== --
ENT.RunAwayOnUnknownDamage = true -- Should run away on damage
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.DisableDefaultRangeAttackCode = true -- When true, it won't spawn the range attack entity, allowing you to make your own
ENT.DisableRangeAttackAnimation = true -- if true, it will disable the animation code
ENT.AnimTbl_RangeAttack = {ACT_WALKS} -- Range Attack Animations
ENT.RangeToMeleeDistance = 0.1 -- How close does it have to be until it uses melee?
ENT.RangeAttackAngleRadius = 100 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
ENT.RangeDistance = 1200
ENT.HasDeathRagdoll = false 
ENT.FootStepTimeRun = 0.5 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking

ENT.HasFootStepSound = true
	ENT.SoundTbl_FootStep = {"rmine_moveslow_loop1.wav"}
ENT.Stop = true
-- ====== Sounds ====== --
ENT.SoundTbl_MeleeAttackSlowPlayer = {}
ENT.SoundTbl_MeleeAttack = {
"npc/roller/code2.wav",
}
ENT.SoundTbl_LeapAttackJump = {"npc/roller/mine/rmine_blip1.wav",}
ENT.SoundTbl_LeapAttackDamage = {"npc/roller/mine/rmine_explode_shock1.wav"}
ENT.SoundTbl_MeleeAttackMiss = {
"npc/roller/mine/rmine_seek_loop2.wav",
"npc/roller/mine/rmine_tossed1.wav",
}
ENT.SoundTbl_OnKilledEnemy = {
"npc/roller/mine/rmine_taunt1.wav",
"npc/roller/mine/rmine_taunt2.wav",
}
ENT.SoundTbl_CombatIdle = {
"npc/roller/mine/rmine_blip1.wav",
"npc/roller/mine/rmine_chip_answer1.wav",
"npc/roller/mine/rmine_seek_loop2.wav"
}

ENT.SoundTbl_Pain = {
"npc/roller/mine/rmine_tossed1.wav",
}

ENT.SoundTbl_Alert = {

}
ENT.CombatIdleSoundPitch1 = 100
ENT.CombatIdleSoundPitch2 = 100
ENT.AlertSoundPitch1 = 100
ENT.AlertSoundPitch2 = 100
ENT.MeleeAttackSoundPitch1 = 100
ENT.MeleeAttackSoundPitch2 = 100
ENT.PainSoundPitch1 = 100
ENT.PainSoundPitch2 = 100
ENT.DeathSoundPitch1 = 100
ENT.DeathSoundPitch2 = 100
ENT.OnKilledEnemySoundPitch1 = 100
ENT.OnKilledEnemySoundPitch2 = 100
ENT.RangeAttackPitch1 = 100
ENT.RangeAttackPitch2 = 100
ENT.PSYDOG_GoingToSpawnThem = false

function ENT:CustomRangeAttackCode(attacker,tr,dmginfo)
	self:SetPos(self:GetPos() +self:GetUp()*8)
	local ene = self:GetEnemy()
	timer.Simple(0.09,function()
        if ene:GetPos():Distance(self:GetPos()) <= self.RangeDistance then
            if self.PSYDOG_GoingToSpawnThem == false then
                self.PSYDOG_GoingToSpawnThem = true
                timer.Remove( "timer_leap_start"..self:EntIndex(), self.TimeUntilLeapAttackDamage, self.LeapAttackReps, function() self:LeapDamageCode() end)
                timer.Remove( "timer_leap_finished"..self:EntIndex(), self:DecideAttackTimer(self.NextAnyAttackTime_Leap,self.NextAnyAttackTime_Leap_DoRand,self.TimeUntilLeapAttackDamage,self.CurrentAttackAnimationDuration), 1, function()end)
                timer.Remove("timer_range_start"..self:EntIndex(), self.TimeUntilRangeAttackProjectileRelease, self.RangeAttackReps, function() self:RangeAttackCode() end)
                timer.Remove( "timer_range_finished"..self:EntIndex(), self:DecideAttackTimer(self.NextAnyAttackTime_Range,self.NextAnyAttackTime_Range_DoRand,self.TimeUntilRangeAttackProjectileRelease,self.CurrentAttackAnimationDuration), 1, function()end)
                timer.Remove("timer_melee_finished"..self:EntIndex(), self:DecideAttackTimer(self.NextAnyAttackTime_Melee,self.NextAnyAttackTime_Melee_DoRand,self.TimeUntilMeleeAttackDamage,self.CurrentAttackAnimationDuration), 1, function() end)
                timer.Remove("timer_melee_finished_abletomelee"..self:EntIndex(), self:DecideAttackTimer(self.NextMeleeAttackTime,self.NextMeleeAttackTime_DoRand), 1, function() end)

                self.Phantom1 = ents.Create("npc_vj_hl2_roller2")
                self.Phantom1:SetPos(self:GetPos() +self:GetUp()*20)
                self.Phantom1:SetAngles(self:GetAngles())
                self.Phantom1:Spawn()
                self.Phantom1:SetSaveValue("m_bHackedByAlyx",true)
                self:Remove()
                self:OnRemove()
            end
        end
    end)
end

function ENT:CustomOnKilled(dmginfo,hitgroup)

    local effectdata = EffectData()
    effectdata:SetOrigin(self:GetPos() +self:OBBCenter()) -- the vector of were you want the effect to spawn
    effectdata:SetScale(190) -- how big the particles are, can even be 0.1 or 0.6
    util.Effect( "Explosion", effectdata )


    VJ_EmitSound(self,{"weapons/expode1.wav"},75,self:VJ_DecideSoundPitch(110,140))
end
function ENT:CustomOnRemove()

timer.Remove( "timer_leap_start"..self:EntIndex(), self.TimeUntilLeapAttackDamage, self.LeapAttackReps, function() self:LeapDamageCode() end)
timer.Remove( "timer_leap_finished"..self:EntIndex(), self:DecideAttackTimer(self.NextAnyAttackTime_Leap,self.NextAnyAttackTime_Leap_DoRand,self.TimeUntilLeapAttackDamage,self.CurrentAttackAnimationDuration), 1, function()end)
timer.Remove("timer_range_start"..self:EntIndex(), self.TimeUntilRangeAttackProjectileRelease, self.RangeAttackReps, function() self:RangeAttackCode() end)
timer.Remove( "timer_range_finished"..self:EntIndex(), self:DecideAttackTimer(self.NextAnyAttackTime_Range,self.NextAnyAttackTime_Range_DoRand,self.TimeUntilRangeAttackProjectileRelease,self.CurrentAttackAnimationDuration), 1, function()end)
timer.Remove("timer_melee_finished"..self:EntIndex(), self:DecideAttackTimer(self.NextAnyAttackTime_Melee,self.NextAnyAttackTime_Melee_DoRand,self.TimeUntilMeleeAttackDamage,self.CurrentAttackAnimationDuration), 1, function() end)
timer.Remove("timer_melee_finished_abletomelee"..self:EntIndex(), self:DecideAttackTimer(self.NextMeleeAttackTime,self.NextMeleeAttackTime_DoRand), 1, function() end)

end

VJ.AddNPC("Rollermine","npc_horde_rollermine", "Horde")