/*--------------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()
if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Tank Shell"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectiles for my addons"
ENT.Category		= "Projectiles"
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.Model = {"models/items/ar2_grenade.mdl"}
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_BURN -- Damage type
ENT.RadiusDamageForce = 90 -- Put the force amount it should apply | false = Don't apply any force
ENT.ShakeWorldOnDeath = false -- Should the world shake when the projectile hits something?
ENT.ShakeWorldOnDeathAmplitude = 16 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
ENT.ShakeWorldOnDeathRadius = 3000 -- How far the screen shake goes, in world units
ENT.ShakeWorldOnDeathFrequency =  200 -- The frequency
ENT.DecalTbl_DeathDecals = {"Scorch"}
ENT.SoundTbl_Idle = nil
ENT.SoundTbl_OnCollide = {"ambient/explosions/explode_9.wav"}
ENT.CollisionGroupType = COLLISION_GROUP_PROJECTILE
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetColor(Color(250, 0, 0))
	local pb_vert = 1
    local pb_hor = 1
    self:PhysicsInitBox( Vector(-pb_vert,-pb_hor,-pb_hor), Vector(pb_vert,pb_hor,pb_hor) )

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:DeathEffects(data,phys)
	local effectdata = EffectData()
	effectdata:SetOrigin(data.HitPos)
	effectdata:SetScale(2)
	effectdata:SetEntity(self.Owner)
	util.Effect("m2_flame_explosion", effectdata )

	local expLight = ents.Create("light_dynamic")
	expLight:SetKeyValue("brightness", "4")
	expLight:SetKeyValue("distance", "300")
	expLight:SetLocalPos(data.HitPos)
	expLight:SetLocalAngles(self:GetAngles())
	expLight:Fire("Color", "255 150 0")
	expLight:SetParent(self)
	expLight:Spawn()
	expLight:Activate()
	expLight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(expLight)
end

function ENT:CustomOnPhysicsCollide(data, phys)
	self.Dead = true
	local dmg = DamageInfo()
	dmg:SetAttacker(self.Owner)
	dmg:SetInflictor(self.Inflictor)
	dmg:SetDamageType(DMG_BURN)
	dmg:SetDamage(125)
	util.BlastDamageInfo(dmg, self:GetPos(), 150)
	self:OnCollideSoundCode()
	if self.PaintDecalOnDeath == true && VJ_PICK(self.DecalTbl_DeathDecals) != false && self.AlreadyPaintedDeathDecal == false then 
		self.AlreadyPaintedDeathDecal = true 
		util.Decal(VJ_PICK(self.DecalTbl_DeathDecals), data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
	end
	if self.ShakeWorldOnDeath == true then util.ScreenShake(data.HitPos, self.ShakeWorldOnDeathAmplitude, self.ShakeWorldOnDeathFrequency, 0.5, self.ShakeWorldOnDeathRadius) end
	self:SetDeathVariablesTrue(data, phys, true)
	if self.DelayedRemove > 0 then
		self:SetNoDraw(true)
		self:SetMoveType(MOVETYPE_NONE)
		self:AddSolidFlags(FSOLID_NOT_SOLID)
		self:SetLocalVelocity(Vector())
		SafeRemoveEntityDelayed(self, self.DelayedRemove)
		self:OnRemove()
	else
		self:Remove()
	end
end

/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/