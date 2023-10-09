/*--------------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()
if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Blaster Rod"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectiles for my addons"
ENT.Category		= "Projectiles"
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	local Name = "Blaster Rod"
	local LangName = "obj_vj_blasterrod"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.Model = {"models/items/AR2_Grenade.mdl"} -- The models it should spawn with | Picks a random one from the table
/*ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 10 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 10 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_SHOCK -- Damage type
ENT.RadiusDamageForce = 50 -- Put the force amount it should apply | false = Don't apply any force
ENT.RadiusDamageForceTowardsPhysics = 1000 -- How much force should it deal to props?*/
ENT.DoesDirectDamage = true -- Should it do a direct damage when it hits something?
ENT.DirectDamage = 5 -- How much damage should it do when it hits something
ENT.DirectDamageType = DMG_BULLET -- Damage type
ENT.TracerColor = Color(255,255,128)
ENT.TracerWidth = 5
ENT.Horde_Plague_Soldier = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	--self:SetMaterial("models/effects/vol_light001.mdl")
	self:DrawShadow(false)
	self:SetRenderMode(RENDERMODE_TRANSCOLOR)
	self:SetColor(Color(255,255,255,0))
	util.SpriteTrail(self, 0, self.TracerColor, false, self.TracerWidth, self.TracerWidth, 0.1, 1/(8+8)*0.5, "VJ_Base/sprites/vj_trial1.vmt")

	timer.Simple(4, function ()
		if !IsValid(self) then return end
		self:Remove()
	end)
end

function ENT:CustomOnDoDamage_Direct(data, phys, hitEnt)
	if hitEnt:IsNPC() then
		local damagecode = DamageInfo()
		damagecode:SetDamage(self.DirectDamage / 2)
		damagecode:SetDamageType(self.DirectDamageType)
		damagecode:SetAttacker(self)
		damagecode:SetInflictor(self)
		damagecode:SetDamagePosition(self:GetPos())
		hitEnt:TakeDamageInfo(damagecode, self)
	end

	if self.Weaken then
		hitEnt:Horde_AddWeaken(self, 3, 1)
	elseif self.Hinder then
		hitEnt:Horde_AddHinder(self, 3, 1)
	end
end