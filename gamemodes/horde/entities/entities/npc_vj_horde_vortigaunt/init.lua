AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/vortigaunt.mdl"}

ENT.StartHealth = 550

ENT.SightAngle = 180

ENT.EntitiesToNoCollide = {"npc_vj_horde_class_assault","npc_vj_horde_class_survivor","npc_vj_horde_vortigaunt"}

ENT.FriendsWithAllPlayerAllies = true
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY", "CLASS_COMBINE"}

ENT.PlayerFriendly = true

ENT.ConstantlyFaceEnemy = true

ENT.BloodColor = "Yellow"

ENT.RunAwayOnUnknownDamage = false

ENT.HasMeleeAttack = false

ENT.HasRangeAttack = true
ENT.RangeAttackEntityToSpawn = nil

ENT.AnimTbl_RangeAttack = {"vjges_g_zapattack1"}
ENT.RangeAttackAnimationStopMovement = false

ENT.RangeDistance = 5000
ENT.RangeToMeleeDistance = 10

ENT.TimeUntilRangeAttackProjectileRelease = 0
ENT.NextRangeAttackTime = 1.75
ENT.NextAnyAttackTime_Range = 3

ENT.RangeUseAttachmentForPos = true
ENT.RangeUseAttachmentForPosID = "mouth"

ENT.DisableDefaultRangeAttackCode = true

ENT.FootStepTimeRun = 0.25
ENT.FootStepTimeWalk = 0.75

ENT.SoundTbl_FootStep = {"npc/vort/vort_foot1.wav","npc/vort/vort_foot2.wav","npc/vort/vort_foot3.wav","npc/vort/vort_foot4.wav"}

ENT.SoundTbl_Idle = {"vo/npc/vortigaunt/vortigese02.wav","vo/npc/vortigaunt/vortigese03.wav","vo/npc/vortigaunt/vortigese04.wav","vo/npc/vortigaunt/vortigese05.wav","vo/npc/vortigaunt/vortigese07.wav","vo/npc/vortigaunt/vortigese08.wav"}
ENT.SoundTbl_IdleDialogue = {"vo/npc/vortigaunt/vques01.wav","vo/npc/vortigaunt/vques03.wav","vo/npc/vortigaunt/vques04.wav","vo/npc/vortigaunt/vques05.wav","vo/npc/vortigaunt/vques06.wav","vo/npc/vortigaunt/vques07.wav","vo/npc/vortigaunt/vques09.wav","vo/npc/vortigaunt/vques10.wav"}
ENT.SoundTbl_IdleDialogueAnswer = {"vo/npc/vortigaunt/vanswer01.wav","vo/npc/vortigaunt/vanswer02.wav","vo/npc/vortigaunt/vanswer03.wav","vo/npc/vortigaunt/vanswer04.wav","vo/npc/vortigaunt/vanswer05.wav","vo/npc/vortigaunt/vanswer06.wav","vo/npc/vortigaunt/vanswer07.wav","vo/npc/vortigaunt/vanswer08.wav","vo/npc/vortigaunt/vanswer09.wav","vo/npc/vortigaunt/vanswer10.wav","vo/npc/vortigaunt/vanswer11.wav","vo/npc/vortigaunt/vanswer12.wav","vo/npc/vortigaunt/vanswer13.wav","vo/npc/vortigaunt/vanswer14.wav","vo/npc/vortigaunt/vanswer15.wav","vo/npc/vortigaunt/vanswer16.wav","vo/npc/vortigaunt/vanswer17.wav","vo/npc/vortigaunt/vanswer18.wav"}
ENT.SoundTbl_CombatIdle = {"vo/npc/vortigaunt/vortigese02.wav","vo/npc/vortigaunt/vortigese03.wav","vo/npc/vortigaunt/vortigese04.wav","vo/npc/vortigaunt/vortigese05.wav","vo/npc/vortigaunt/vortigese07.wav","vo/npc/vortigaunt/vortigese08.wav"}
ENT.SoundTbl_OnReceiveOrder = {"vo/npc/vortigaunt/affirmed.wav"}
ENT.SoundTbl_FollowPlayer = {"vo/npc/vortigaunt/leadon.wav","vo/npc/vortigaunt/onward.wav","vo/npc/vortigaunt/yesforward.wav"}
ENT.SoundTbl_UnFollowPlayer = {"vo/npc/vortigaunt/servebetterhere.wav","vo/npc/vortigaunt/willremain.wav"}
ENT.SoundTbl_Alert = {"vo/npc/vortigaunt/caution.wav","vo/npc/vortigaunt/forward.wav","vo/npc/vortigaunt/standclear.wav","vo/npc/vortigaunt/ware.wav"}
ENT.SoundTbl_OnKilledEnemy = {"vo/npc/vortigaunt/passon.wav","vo/npc/vortigaunt/returntoall.wav","vo/npc/vortigaunt/returnvoid.wav","vo/npc/vortigaunt/tethercut.wav","vo/npc/vortigaunt/tothevoid.wav","vo/npc/vortigaunt/troubleus.wav","vo/npc/vortigaunt/undeserving.wav"}

ENT.IdleSoundChance = 5
ENT.CombatIdleSoundChance = 5
ENT.OnReceiveOrderSoundChance = 5
ENT.AlertSoundChance = 5
ENT.OnKilledEnemySoundChance = 5

function ENT:CustomRangeAttackCode()
	local ene = self:GetEnemy()
    if not ene:IsValid() or ene:IsPlayer() then return false end
	if ene:GetPos():Distance(self:GetPos()) <= self.RangeDistance then
        local chargeSound = CreateSound(self, "npc/vort/attack_charge.wav");
        chargeSound:Play()
        local pos = ene:GetPos() + ene:OBBCenter()
        timer.Simple(0.5 / self.AnimationPlaybackRate, function ()
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
            dmg:SetDamage(250)
            util.BlastDamageInfo(dmg, tr.HitPos, 250)
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

function ENT:CustomOnFootStepSound()
    if self:WaterLevel() > 0 then
        VJ_EmitSound(self,{"player/footsteps/slosh1.wav","player/footsteps/slosh2.wav","player/footsteps/slosh3.wav","player/footsteps/slosh4.wav"}, 70, math.random(80,100))
    end
end

function ENT:OnRemove()
    self:StopSound("npc/vort/attack_charge.wav")
end

function ENT:DoRelationshipCheck(ent)
    if ent:IsPlayer() or ent:GetNWEntity("HordeOwner"):IsValid() then return false end
    return true
end

ENT.Horde_Immune_Status_All = true

VJ.AddNPC("Vortigaunt","npc_vj_horde_vortigaunt", "Horde")

game.AddParticles("particles/vortigaunt_fx.pcf")

PrecacheParticleSystem("vortigaunt_beam")
PrecacheParticleSystem("vortigaunt_beam_charge")
PrecacheParticleSystem("vortigaunt_charge_token")
PrecacheParticleSystem("vortigaunt_beam_b")
