AddCSLuaFile("shared.lua")
include('shared.lua')

game.AddParticles( "particles/vortigaunt_fx.pcf" )

PrecacheParticleSystem( "vortigaunt_beam" )
PrecacheParticleSystem( "vortigaunt_beam_charge" )
PrecacheParticleSystem( "vortigaunt_charge_token" )
PrecacheParticleSystem( "vortigaunt_beam_b" )

/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vortigaunt.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 550
ENT.SightDistance = 8000
ENT.HullType = HULL_HUMAN
ENT.PlayerFriendly = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY", "CLASS_COMBINE"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.AllowIgnition = false -- Can this SNPC be set on fire?
ENT.Immune_AcidPoisonRadiation = false -- Immune to Acid, Poison and Radiation
ENT.Immune_Electricity = true -- Immune to Electrical
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.MeleeAttackDistance = 35 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 90 -- How far does the damage go?
ENT.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.6 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.NextRangeAttackTime = 1.75
ENT.NextAnyAttackTime_Range = 3
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "mouth" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.RangeAttackEntityToSpawn = nil -- The entity that is spawned when range attacking
ENT.TimeUntilRangeAttackProjectileRelease = 0
ENT.HasRangeAttack = true
ENT.RangeToMeleeDistance = 30
ENT.RangeDistance = 4000
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.FootStepSoundLevel = 60
ENT.RunAwayOnUnknownDamage = false -- Should run away on damage
 
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/vort/vort_foot1.wav","npc/vort/vort_foot2.wav","npc/vort/vort_foot3.wav","npc/vort/vort_foot4.wav"}
ENT.SoundTbl_Idle = {
"vo/npc/vortigaunt/affirmed.wav",
"vo/npc/vortigaunt/alldear.wav",
"vo/npc/vortigaunt/allinoneinall.wav",
"vo/npc/vortigaunt/gloriousend.wav",
"vo/npc/vortigaunt/hopeless.wav",
"vo/npc/vortigaunt/livetoserve.wav",
"vo/npc/vortigaunt/mutual.wav",
"vo/npc/vortigaunt/poet.wav",
"vo/npc/vortigaunt/seenworse.wav",
"vo/npc/vortigaunt/vmono_15.wav",
}
ENT.SoundTbl_Alert = {
"vo/npc/vortigaunt/caution.wav",
}
ENT.SoundTbl_CombatIdle = {
"vo/npc/vortigaunt/allowme.wav",
"vo/npc/vortigaunt/calm.wav",
"vo/npc/vortigaunt/cannotfire.wav",
"vo/npc/vortigaunt/followfm.wav",
"vo/npc/vortigaunt/forfreedom.wav",
"vo/npc/vortigaunt/forward.wav",
}
ENT.SoundTbl_FollowPlayer = {
"vo/npc/vortigaunt/accompany.wav",
"vo/npc/vortigaunt/assent.wav",
"vo/npc/vortigaunt/bodyyours.wav",
"vo/npc/vortigaunt/certainly.wav",
"vo/npc/vortigaunt/dedicate.wav",
"vo/npc/vortigaunt/fminway.wav",
}
ENT.SoundTbl_UnFollowPlayer = {
"vo/npc/vortigaunt/allfornow.wav",
"vo/npc/vortigaunt/asyouwish.wav",
"vo/npc/vortigaunt/canconvince.wav",
"vo/npc/vortigaunt/done.wav",
"vo/npc/vortigaunt/fearfailed.wav",
"vo/npc/vortigaunt/fmknowsbest.wav",
}
ENT.SoundTbl_OnPlayerSight = {
"vo/npc/vortigaunt/allwehave.wav",
"vo/npc/vortigaunt/beofservice.wav",
"vo/npc/vortigaunt/corporeal.wav",
"vo/npc/vortigaunt/fmhonorsus.wav",
"vo/npc/vortigaunt/putaside.wav",
}
ENT.DisableDefaultRangeAttackCode = true
ENT.DisableMakingSelfEnemyToNPCs = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
    self:SetCollisionBounds(Vector(0,0,0), Vector(0,0,0))
end

function ENT:OnRemove()
    self:StopSound("npc/vort/attack_charge.wav")
end

function ENT:DoRelationshipCheck(ent)
    if ent:IsPlayer() or ent:GetNWEntity("HordeOwner"):IsValid() then return false end
    return true
end

---------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
	local ene = self:GetEnemy()
    if not ene:IsValid() or ene:IsPlayer() then return false end
	if ene:GetPos():Distance(self:GetPos()) <= self.RangeDistance then
        local chargeSound = CreateSound(self, "npc/vort/attack_charge.wav");
        chargeSound:Play()
        local pos = ene:GetPos() + ene:OBBCenter()
        timer.Simple(1.5 / self.AnimationPlaybackRate, function ()
            if not self:IsValid() then
                chargeSound:Stop()
                return
            end
            chargeSound:Stop()
            if ene:IsValid() then
                pos = ene:GetPos() + ene:OBBCenter()
            end
            local tr = util.QuickTrace(self:EyePos(), pos - self:EyePos(), self);
            util.ParticleTracerEx("vortigaunt_beam", self:GetAttachment(self:LookupAttachment("leftclaw")).Pos,tr.HitPos, true, self:EntIndex(), self:LookupAttachment("leftclaw"));
            util.ParticleTracerEx("vortigaunt_beam", self:GetAttachment(self:LookupAttachment("rightclaw")).Pos,tr.HitPos, true, self:EntIndex(), self:LookupAttachment("rightclaw"));
            util.ParticleTracerEx("vortigaunt_beam_b", self:GetAttachment(self:LookupAttachment("leftclaw")).Pos,tr.HitPos, true, self:EntIndex(), self:LookupAttachment("leftclaw"));
            util.ParticleTracerEx("vortigaunt_beam_b", self:GetAttachment(self:LookupAttachment("rightclaw")).Pos,tr.HitPos, true, self:EntIndex(), self:LookupAttachment("rightclaw"));
            local dmg = DamageInfo()
            dmg:SetAttacker(self)
            dmg:SetInflictor(self)
            dmg:SetDamageType(DMG_SHOCK)
            dmg:SetDamage(175)
            util.BlastDamageInfo(dmg, tr.HitPos, 150)
            local data = EffectData();
            data:SetOrigin(tr.HitPos)
            data:SetNormal(tr.HitNormal)
            data:SetScale(50)
            util.Effect("StunstickImpact", data);
            if CLIENT then return end
            local blastspr = ents.Create("env_sprite");
            blastspr:SetPos(tr.HitPos);
            blastspr:SetKeyValue("model", "sprites/vortring1.vmt")
            blastspr:SetKeyValue("scale", 5)
            blastspr:SetKeyValue("framerate",60)
            blastspr:SetKeyValue("spawnflags","1")
            blastspr:SetKeyValue("brightness","255")
            blastspr:SetKeyValue("angles","0 0 0")
            blastspr:SetKeyValue("rendermode","9")
            blastspr:SetKeyValue("renderamt","255")
            blastspr:Spawn()
            blastspr:Fire("kill","",0.45)
            self:EmitSound("npc/vort/attack_shoot.wav")
            sound.Play("horde/vortigaunt/vort_explode1.ogg",tr.HitPos)
        end)
        local energy = ents.Create("info_particle_system")
		energy:SetKeyValue("effect_name","vortigaunt_hand_glow")
		energy:SetPos(self:GetAttachment(self:LookupAttachment("rightclaw")).Pos)
		energy:SetAngles(self:GetAttachment(self:LookupAttachment("rightclaw")).Ang)
		energy:SetParent(self)
		energy:Fire("SetParentAttachment","rightclaw")
		energy:Spawn()
		energy:Activate()
		energy:Fire("Start","",0.3)
		energy:Fire("Kill","",1.5)
		
		energy = ents.Create("info_particle_system")
		energy:SetKeyValue("effect_name","vortigaunt_hand_glow")
		energy:SetPos(self:GetAttachment(self:LookupAttachment("leftclaw")).Pos)
		energy:SetAngles(self:GetAttachment(self:LookupAttachment("leftclaw")).Ang)
		energy:SetParent(self)
		energy:Fire("SetParentAttachment","leftclaw")
		energy:Spawn()
		energy:Activate()
		energy:Fire("Start","",0.3)
		energy:Fire("Kill","",1.5)

        return true
    end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
VJ.AddNPC("Vortigaunt","npc_vj_horde_vortigaunt", "Horde")