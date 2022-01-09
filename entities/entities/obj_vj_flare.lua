/*--------------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()
if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end

ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName		= "Flare Round"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectiles for my addons"
ENT.Category		= "VJ Base"
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE
ENT.CollisionGroupType = COLLISION_GROUP_PROJECTILE

ENT.Spawnable = true
ENT.AdminOnly = false
---------------------------------------------------------------------------------------------------------------------------------------------
if (CLIENT) then
	language.Add("obj_vj_flareround", "Flare Round")
	killicon.Add("obj_vj_flareround","HUD/killicons/default",Color(255,80,0,255))

	language.Add("#obj_vj_flareround", "Flare Round")
	killicon.Add("#obj_vj_flareround","HUD/killicons/default",Color(255,80,0,255))
	
	function ENT:Draw() self:DrawModel() end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.IdleSound1 = Sound("weapons/flaregun/burn.wav")
ENT.TouchSound = Sound("weapons/hegrenade/he_bounce-1.wav")
ENT.TouchSoundv = 75
ENT.Decal = "Scorch"
ENT.AlreadyPaintedDeathDecal = false
ENT.Dead = false
ENT.FussTime = 10
ENT.NextTouchSound = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	//print(self:GetModel())
	if self:GetModel() == "models/error.mdl" then
	self:SetModel("models/items/ar2_grenade.mdl") end
	//self:PhysicsInit(SOLID_VPHYSICS)
	//self:SetMoveType(MOVETYPE_VPHYSICS)
	//self:SetMoveCollide(COLLISION_GROUP_INTERACTIVE)
	//self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
	//self:SetSolid(SOLID_VPHYSICS)
	local pb_vert = 1
    local pb_hor = 1
    self:PhysicsInitBox( Vector(-pb_vert,-pb_hor,-pb_hor), Vector(pb_vert,pb_hor,pb_hor) )

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
	self:SetColor(Color(255,0,0))

	-- Physics Functions
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
		phys:EnableGravity(false)
		phys:SetBuoyancyRatio(0)
	end

	if self:GetOwner():IsValid() && (self:GetOwner().FlareAttackFussTime) then
		timer.Simple(self:GetOwner().FlareAttackFussTime,function() if IsValid(self) then self:DoDeath() end end) else
		timer.Simple(5,function() if IsValid(self) then self:DoDeath() end end)
	end

	self.ENVFlare = ents.Create("env_flare")
	self.ENVFlare:SetPos(self:GetPos())
	self.ENVFlare:SetAngles(self:GetAngles())
	self.ENVFlare:SetParent(self)
	self.ENVFlare:SetKeyValue("Scale","5")
	self.ENVFlare:SetKeyValue("spawnflags","4")
	self.ENVFlare:Spawn()
	self.ENVFlare:SetColor(Color(255,0,0))

	self.idlesoundc = CreateSound(self, self.IdleSound1)
	self.idlesoundc:SetSoundLevel(60)
	self.idlesoundc:PlayEx(1, 100)

	timer.Simple(2,function()
	if IsValid(self) then
		local phys = self:GetPhysicsObject()
		if IsValid(phys) && phys:GetVelocity():Length() > 500 then
		phys:SetMass(0.005)
		timer.Simple(10,function()
			if IsValid(self) then
			phys:SetMass(5)
			end
		end)
	 end
	end
 end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
if self.Dead == true && self.idlesoundc then self.idlesoundc:Stop() end
if self:IsValid() then
if self.Dead == false then
	self.idlesoundc = CreateSound(self, self.IdleSound1)
	self.idlesoundc:SetSoundLevel(60)
	self.idlesoundc:PlayEx(1, 100)
	end
 end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnTakeDamage(dmginfo)
	self:GetPhysicsObject():AddVelocity(dmginfo:GetDamageForce() * 0.1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PhysicsCollide(data,physobj)
	if self.Removing then return end
	if IsValid(data.HitEntity) && (data.HitEntity:IsNPC() or data.HitEntity:IsPlayer()) && !self.Removing then
		local dmg = DamageInfo()
		dmg:SetAttacker(self.Owner)
		dmg:SetInflictor(self.Inflictor)
		dmg:SetDamageType(DMG_BURN)
		dmg:SetDamage(150)
		util.BlastDamageInfo(dmg, self:GetPos(), 75)
	end
	if not self.Removing then
		self:Remove()
		self.Removing = true
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoDeath()
	-- Removes
	self.Dead = true
	if self.idlesoundc then self.idlesoundc:Stop() end
	self:StopParticles()

	-- Damages
	timer.Simple(2,function()
	if self != NULL then
		self:Remove()
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
	self.Dead = true
	if self.idlesoundc then self.idlesoundc:Stop() end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/