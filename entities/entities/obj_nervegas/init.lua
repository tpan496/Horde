AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by Mayhem, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/weapons/w_bugbait.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 120 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 25 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_NERVEGAS -- Damage type
ENT.DecalTbl_DeathDecals = {"BeerSplash"}
ENT.SoundTbl_Idle = {"npc/antlion/antlion_poisonball1.wav"}
ENT.SoundTbl_OnCollide = {"npc/antlion/antlion_shoot1.wav"}

ENT.IdleSoundLevel = 200
ENT.GeneralSoundPitch1 = 80
ENT.GeneralSoundPitch1 = 8060
--------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	//phys:SetMass(1)
	phys:SetBuoyancyRatio(0)
	phys:EnableDrag(false)
	phys:EnableGravity(false)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
ParticleEffectAttach("blood_impact_red_01", PATTACH_ABSORIGIN_FOLLOW, self, 0)
ParticleEffectAttach("blood_zombie_split_spray", PATTACH_ABSORIGIN_FOLLOW, self, 0)
self:SetModelScale(1.5)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
	ParticleEffect("blood_zombie_split_spray", data.HitPos, Angle(0,0,0), nil)
	ParticleEffect("vj_impact1_black", data.HitPos, Angle(0,0,0), nil)
	ParticleEffect("blood_impact_red_01", data.HitPos, Angle(0,0,0), nil)
		local bloodspray = EffectData()
		bloodspray:SetOrigin(self:GetPos())
		bloodspray:SetScale(100)
		bloodspray:SetFlags(3)
		bloodspray:SetColor(0)
		util.Effect("nervegas",bloodspray)
		util.Effect("nervegas",bloodspray)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
ParticleEffectAttach("blood_impact_red_01", PATTACH_ABSORIGIN_FOLLOW, self, 0)
ParticleEffectAttach("vj_impact1_black", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		local bloodspray = EffectData()
		bloodspray:SetOrigin(self:GetPos())
		bloodspray:SetScale(25)
		bloodspray:SetFlags(3)
		bloodspray:SetColor(0)
		util.Effect("nervegastrail",bloodspray)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/