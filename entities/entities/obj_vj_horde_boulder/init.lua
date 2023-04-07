AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by Mayhem, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/props_lab/bigrock.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 175 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 250 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = false -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_CLUB -- Damage type
--ENT.DecalTbl_DeathDecals = {"BeerSplash"}
--ENT.SoundTbl_Idle = {"npc/antlion/antlion_poisonball1.wav"}
ENT.SoundTbl_OnCollide = {"physics/concrete/boulder_impact_hard1.wav","physics/concrete/boulder_impact_hard2.wav", "physics/concrete/boulder_impact_hard3.wav"}

ENT.IdleSoundLevel = 200
ENT.OnCollideSoundPitch1 = 150
ENT.OnCollideSoundPitch1 = 140
--------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	--phys:SetMass(1)
	phys:SetBuoyancyRatio(0)
	phys:EnableDrag(false)
	--phys:EnableGravity(true)
	timer.Simple(10, function ()
		if self:IsValid() then self:Remove() end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
--ParticleEffectAttach("blood_impact_yellow_01", PATTACH_ABSORIGIN_FOLLOW, self, 0)
--ParticleEffectAttach("antlion_spit_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
	for i = 1, math.random(10,20) do
		local debris = ents.Create("base_gmodentity")
		local mat = "debris/debris" .. tostring(math.random(1, 4))
		
		debris:SetPos(self:GetPos())
		debris:SetAngles(VectorRand():Angle())
		debris:SetModel("models/props_junk/rock001a.mdl")
		debris:SetCollisionGroup(COLLISION_GROUP_WORLD)
		debris:PhysicsInit(SOLID_VPHYSICS)
		
		local physobj = debris:GetPhysicsObject()
		local force = 1000
		
		physobj:AddVelocity(Vector(math.random(-force, force), math.random(-force, force), math.random(-force, force)))
		physobj:AddAngleVelocity(Vector(math.random(-force, force), math.random(-force, force), math.random(-force, force)))
		
		timer.Simple(5, function()
		
			if IsValid(debris) then
				local effect = EffectData()
				local debrisPos = debris:GetPos()
				effect:SetStart(debrisPos)
				effect:SetOrigin(debrisPos)
				effect:SetEntity(debris)
				util.Effect("entity_remove", effect)
				debris:Remove()
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
--ParticleEffectAttach("blood_impact_yellow_01", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/