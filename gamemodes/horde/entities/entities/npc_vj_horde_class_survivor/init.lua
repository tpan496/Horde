AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/Combine_Soldier_PrisonGuard.mdl"}

ENT.StartHealth = 360

ENT.BloodColor = "Red"
ENT.Immune_AcidPoisonRadiation = true
ENT.Horde_Immune_Status_All = true

ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY","CLASS_COMBINE"}
ENT.PlayerFriendly = true
ENT.FriendsWithAllPlayerAllies = true

ENT.HasMeleeAttack = true

ENT.HasGrenadeAttack = true
ENT.GrenadeAttackModel = "models/weapons/w_npcnade.mdl"
ENT.ThrowGrenadeChance = 2
ENT.NextThrowGrenadeTime = VJ_Set(5, 5)

ENT.WaitForEnemyToComeOut = false

ENT.WeaponReload_FindCover = false
ENT.DropWeaponOnDeath = false

ENT.MoveRandomlyWhenShooting = false

ENT.SoundTbl_FootStep = {"npc/combine_soldier/gear1.wav","npc/combine_soldier/gear2.wav","npc/combine_soldier/gear3.wav","npc/combine_soldier/gear4.wav","npc/combine_soldier/gear5.wav","npc/combine_soldier/gear6.wav"}
ENT.SoundTbl_MeleeAttack = {"physics/body/body_medium_break2.wav"}
ENT.SoundTbl_Death = {"player/pl_pain5.wav","player/pl_pain6.wav","player/pl_pain7.wav"}
-----------------------------------------------*/
function ENT:CustomOnInitialize()
	self:Give("weapon_vj_horde_ar15")
	self:SetCollisionBounds(Vector(0,0,0), Vector(0,0,0))
end
function ENT:DoRelationshipCheck(ent)
    if ent:IsPlayer() or ent:GetNWEntity("HordeOwner"):IsValid() then return false end
    return true
end
function ENT:CustomOnGrenadeAttack_OnThrow(grenEnt)
	-- Custom grenade model and sounds
	grenEnt.SoundTbl_Idle = {"weapons/grenade/tick1.wav"}
	grenEnt.IdleSoundPitch = VJ_Set(100, 100)
	
	local redGlow = ents.Create("env_sprite")
	redGlow:SetKeyValue("model", "vj_base/sprites/vj_glow1.vmt")
	redGlow:SetKeyValue("scale", "0.07")
	redGlow:SetKeyValue("rendermode", "5")
	redGlow:SetKeyValue("rendercolor", "150 0 0")
	redGlow:SetKeyValue("spawnflags", "1") -- If animated
	redGlow:SetParent(grenEnt)
	redGlow:Fire("SetParentAttachment", "fuse", 0)
	redGlow:Spawn()
	redGlow:Activate()
	grenEnt:DeleteOnRemove(redGlow)
	util.SpriteTrail(grenEnt, 1, Color(200,0,0), true, 15, 15, 0.35, 1/(6+6)*0.5, "VJ_Base/sprites/vj_trial1.vmt")
end
function ENT:CustomOnFootStepSound()
	if self:WaterLevel() > 0 then
		VJ_EmitSound(self,{"player/footsteps/slosh1.wav","player/footsteps/slosh2.wav","player/footsteps/slosh3.wav","player/footsteps/slosh4.wav"},70,math.random(80,100))
	end
end
VJ.AddNPC("Survivor","npc_vj_horde_class_survivor", "Horde")
