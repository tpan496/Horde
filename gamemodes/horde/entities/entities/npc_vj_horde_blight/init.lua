AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/zombie/classic.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 700
ENT.HeadHealth = 300
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 65 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.8
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee
ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav"}
ENT.SoundTbl_Idle = {"npc/zombie/zombie_voice_idle1.wav","npc/zombie/zombie_voice_idle2.wav","npc/zombie/zombie_voice_idle3.wav","npc/zombie/zombie_voice_idle4.wav","npc/zombie/zombie_voice_idle5.wav","npc/zombie/zombie_voice_idle6.wav"}
ENT.SoundTbl_Alert = {"npc/zombie/zombie_alert1.wav","npc/zombie/zombie_alert2.wav","npc/zombie/zombie_alert3.wav"}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/zo_attack1.wav","npc/zombie/zo_attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_Pain = {"npc/zombie/zombie_pain1.wav","npc/zombie/zombie_pain2.wav","npc/zombie/zombie_pain3.wav","npc/zombie/zombie_pain4.wav","npc/zombie/zombie_pain5.wav","npc/zombie/zombie_pain6.wav"}
ENT.SoundTbl_Death = {"npc/zombie/zombie_die1.wav","npc/zombie/zombie_die2.wav","npc/zombie/zombie_die3.wav"}

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
ENT.HasDeathRagdoll = false
ENT.HasGibOnDeath = true

function ENT:CustomOnInitialize()
    self:SetBodygroup(1,1)
    self:SetColor(Color(50, 50, 50))
    self.HeadHealth = self.HeadHealth * HORDE.difficulty_health_multiplier[HORDE.difficulty]
    self:SetModelScale(1.5, 0)
    self:ManipulateBoneScale(0, Vector(2,2,2))
    self:ManipulateBoneScale(9, Vector(2,2,4))

    self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end

function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
    local e = EffectData()
        e:SetOrigin(self:GetPos())
    util.Effect("blight_explosion", e, true, true)

    local dmg = DamageInfo()
    dmg:SetInflictor(self)
    dmg:SetAttacker(self)
    dmg:SetDamageType(DMG_DISSOLVE)
    dmg:SetDamage(50)
    util.BlastDamageInfo(dmg, self:GetPos(), 300)

    sound.Play("vj_acid/acid_splat.wav", self:GetPos())
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
    if hitgroup == HITGROUP_HEAD then
        self.HeadHealth = self.HeadHealth - dmginfo:GetDamage()
        if self.HeadHealth <= 0 then
            self:SetHealth(1)
        end
        dmginfo:ScaleDamage(2)
    else
        if HORDE:IsBlastDamage(dmginfo) or HORDE:IsFireDamage(dmginfo) then
            dmginfo:ScaleDamage(1.5)
        end
        local e = EffectData()
            e:SetOrigin(self:GetPos())
        util.Effect("blight_mini_explosion", e, true, true)
        for _, ent in pairs(ents.FindInSphere(self:GetPos(), 200)) do
			if ent:IsPlayer() then
				local Trace = util.TraceLine({
		                    start = self:WorldSpaceCenter(),
		                    endpos = ent:WorldSpaceCenter(),
				    mask = MASK_SOLID_BRUSHONLY
		                })
				if not Trace.HitWorld() then
					ent:Horde_AddDebuffBuildup(HORDE.Status_Necrosis, 8, self)
				end
			end
		end
    end
end

VJ.AddNPC("Blight","npc_vj_horde_blight", "Zombies")
