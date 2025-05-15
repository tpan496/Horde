AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/Combine_Soldier_PrisonGuard.mdl"}

ENT.StartHealth = 300

ENT.SightAngle = 180

ENT.EntitiesToNoCollide = {"npc_vj_horde_class_assault","npc_vj_horde_class_survivor","npc_vj_horde_vortigaunt"}

ENT.FriendsWithAllPlayerAllies = true
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY","CLASS_COMBINE"}

ENT.PlayerFriendly = true

ENT.ConstantlyFaceEnemy = true

ENT.CanThrowBackDetectedGrenades = false

ENT.BloodColor = "Red"

ENT.MoveOrHideOnDamageByEnemy_OnlyMove = true

ENT.DropWeaponOnDeath = false

ENT.HasMeleeAttack = true

ENT.WeaponReload_FindCover = false

ENT.WaitForEnemyToComeOut = false

ENT.HasGrenadeAttack = true
ENT.GrenadeAttackModel = "models/weapons/w_npcnade.mdl"

ENT.ThrowGrenadeChance = 2
ENT.NextThrowGrenadeTime = VJ_Set(5, 5)

ENT.SoundTbl_FootStep = {"npc/combine_soldier/gear1.wav","npc/combine_soldier/gear2.wav","npc/combine_soldier/gear3.wav","npc/combine_soldier/gear4.wav","npc/combine_soldier/gear5.wav","npc/combine_soldier/gear6.wav"}
ENT.SoundTbl_MeleeAttack = {"physics/body/body_medium_break2.wav"}

ENT.SoundTbl_IdleDialogue = {"npc/combine_soldier/vo/prison_soldier_fullbioticoverrun.wav","npc/combine_soldier/vo/prison_soldier_negativecontainment.wav","npc/combine_soldier/vo/prison_soldier_tohighpoints.wav"}
ENT.SoundTbl_IdleDialogueAnswer = {"npc/combine_soldier/vo/copy.wav","npc/combine_soldier/vo/copythat.wav"}
ENT.SoundTbl_OnReceiveOrder = {"npc/combine_soldier/vo/affirmative.wav","npc/combine_soldier/vo/affirmative2.wav"}
ENT.SoundTbl_FollowPlayer = {"npc/combine_soldier/vo/affirmative.wav","npc/combine_soldier/vo/affirmative2.wav"}
ENT.SoundTbl_UnFollowPlayer = {"npc/combine_soldier/vo/affirmative.wav","npc/combine_soldier/vo/affirmative2.wav"}
ENT.SoundTbl_CombatIdle = {"npc/combine_soldier/vo/unitisclosing.wav","npc/combine_soldier/vo/unitisinbound.wav","npc/combine_soldier/vo/unitismovingin.wav"}
ENT.SoundTbl_Alert = {"npc/combine_soldier/vo/contact.wav","npc/combine_soldier/vo/contactconfim.wav","npc/combine_soldier/vo/engaging.wav","npc/combine_soldier/vo/necrotics.wav","npc/combine_soldier/vo/necroticsinbound.wav","npc/combine_soldier/vo/targetmyradial.wav","npc/combine_soldier/vo/viscon.wav","npc/combine_soldier/vo/visualonexogens.wav"}
ENT.SoundTbl_GrenadeAttack = {"npc/combine_soldier/vo/extractoraway.wav","npc/combine_soldier/vo/extractorislive.wav"}
ENT.SoundTbl_OnGrenadeSight = {"npc/combine_soldier/vo/displace.wav","npc/combine_soldier/vo/displace2.wav"}
ENT.SoundTbl_Pain = {"npc/combine_soldier/pain1.wav","npc/combine_soldier/pain2.wav","npc/combine_soldier/pain3.wav"}
ENT.SoundTbl_Death = {"npc/combine_soldier/die1.wav","npc/combine_soldier/die2.wav","npc/combine_soldier/die3.wav"}

ENT.IdleSoundChance = 5
ENT.CombatIdleSoundChance = 5
ENT.OnReceiveOrderSoundChance = 5
ENT.AlertSoundChance = 5
ENT.GrenadeAttackSoundChance = 5
ENT.OnGrenadeSightSoundChance = 5

function ENT:CustomOnInitialize()
	self:Give("weapon_vj_horde_survivor_ar15")
end

function ENT:OnPlayCreateSound(sdData, sdFile)
	if VJ_HasValue(self.SoundTbl_MeleeAttack, sdFile) or VJ_HasValue(self.SoundTbl_IdleDialogue, sdFile) or VJ_HasValue(self.SoundTbl_Pain, sdFile) or VJ_HasValue(self.SoundTbl_Death, sdFile) then 
		return 
	end
	VJ_EmitSound(self, {"npc/combine_soldier/vo/on1.wav","npc/combine_soldier/vo/on2.wav"}, 75, math.random(90,100))
	timer.Simple(SoundDuration(sdFile), function() 
		if IsValid(self) && sdData:IsPlaying() then 
			VJ_EmitSound(self,{"npc/combine_soldier/vo/off1.wav","npc/combine_soldier/vo/off2.wav"}, 75, math.random(90,100)) 
		end 
	end)
end

function ENT:CustomOnFootStepSound()
	if self:WaterLevel() > 0 then
		VJ_EmitSound(self,{"player/footsteps/slosh1.wav","player/footsteps/slosh2.wav","player/footsteps/slosh3.wav","player/footsteps/slosh4.wav"}, 70, math.random(80,100))
	end
end

function ENT:CustomOnGrenadeAttack_OnThrow(grenEnt)
	grenEnt.RemoveOnHit = true
	local redGlow = ents.Create("env_sprite")
	redGlow:SetKeyValue("model", "vj_base/sprites/vj_glow1.vmt")
	redGlow:SetKeyValue("scale", "0.07")
	redGlow:SetKeyValue("rendermode", "5")
	redGlow:SetKeyValue("rendercolor", "150 0 0")
	redGlow:SetKeyValue("spawnflags", "1")
	redGlow:SetParent(grenEnt)
	redGlow:Fire("SetParentAttachment", "fuse", 0)
	redGlow:Spawn()
	redGlow:Activate()
	grenEnt:DeleteOnRemove(redGlow)
	util.SpriteTrail(grenEnt, 1, Color(200,0,0), true, 15, 15, 0.35, 1/(6+6)*0.5, "VJ_Base/sprites/vj_trial1.vmt")
end

function ENT:DoRelationshipCheck(ent)
    if ent:IsPlayer() or ent:GetNWEntity("HordeOwner"):IsValid() then return false end
    return true
end

ENT.Horde_Immune_Status_All = true

VJ.AddNPC("Assault","npc_vj_horde_class_survivor", "Horde")
