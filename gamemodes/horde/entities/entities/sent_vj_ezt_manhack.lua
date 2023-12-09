/*--------------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()
if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName 		= "Zombie Manhack"
ENT.Author 			= "C0Mb0STR3Kx20"
ENT.Purpose 		= "Spawn it and destroy it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "Entropy : Zero 2"

ENT.Spawnable = false
ENT.AdminOnly = false
ENT.BloodColor = "Yellow"
---------------------------------------------------------------------------------------------------------------------------------------------
if (CLIENT) then
	function ENT:Draw()
		self:DrawModel()
	end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !(SERVER) then return end

ENT.VJ_AddEntityToSNPCAttackList = false
ENT.Model = {"models/manhack.mdl"}
ENT.StartHealth = 25
ENT.AllowedToGib = true -- Is it allowed to gib in general? This can be on death or when shot in a certain place
ENT.HasGibOnDeath = true -- Is it allowed to gib on death?
ENT.Owner = nil
ENT.NextIdleSd = 0
ENT.IdleSd = {"npc/manhack/mh_engine_loop1.wav","npc/manhack/mh_engine_loop2.wav"}
ENT.Idle2Sd = {"npc/manhack/mh_blade_loop1.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	if self:GetModel() == "models/error.mdl" then
	self:SetModel(Model(VJ_PICK(self.Model))) end
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.attack = {"npc/manhack/grind_flesh1.wav","npc/manhack/grind_flesh2.wav","npc/manhack/grind_flesh3.wav"}
	//self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetUseType(SIMPLE_USE)
	self:SetHealth(self.StartHealth)	
	self.idlesd = VJ_CreateSound(self, self.IdleSd, 75, 100)
	self.idle2sd = VJ_CreateSound(self, self.Idle2Sd, 75, 100)
	self:SetBodygroup(1,1)
	self:ResetSequence("deploy")
	self:SetBodygroup(2,1)
	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:Wake()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PhysicsCollide(data, physobj)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
for _,v in ipairs(ents.FindInSphere(self:GetPos(),20)) do
	if v != self.Owner && v != self && (v:IsNPC() or v:IsPlayer()) then
v:TakeDamage(5)
VJ_EmitSound(self,self.attack)
end
end
local lamp2 = ents.Create("env_sprite")
					lamp2:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
					lamp2:SetKeyValue("scale","0.050")
					lamp2:SetKeyValue("rendermode","5")
					lamp2:SetKeyValue("rendercolor","150 0 0")
					lamp2:SetKeyValue("spawnflags","1") -- If animated
					lamp2:SetParent(self)
					lamp2:Fire("SetParentAttachment","Eye",0)
					lamp2:Spawn()
					lamp2:Activate()
					lamp2:Fire("Kill","",0.2)
					self:DeleteOnRemove(lamp2)	


										local lamp = ents.Create("env_sprite")
					lamp:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
					lamp:SetKeyValue("scale","0.050")
					lamp:SetKeyValue("rendermode","5")
					lamp:SetKeyValue("rendercolor","150 0 0")
					lamp:SetKeyValue("spawnflags","1") -- If animated
					lamp:SetParent(self)
					lamp:Fire("SetParentAttachment","Light",0)
					lamp:Spawn()
					lamp:Activate()
					lamp:Fire("Kill","",0.2)
					self:DeleteOnRemove(lamp)
					timer.Simple(2,function()
					if IsValid(self) then
					self:ResetSequence("fly")
end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Use(activator, caller)

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnTakeDamage(dmginfo)
if dmginfo:GetDamageType() != DMG_SLASH then
	self:SetHealth(self:Health() - dmginfo:GetDamage())
	if self:Health() <= 0 then self:DoDeath() end
	self.spar = ents.Create( "env_spark" )
self.spar:SetPos( self:GetPos() + Vector(0,0,0) )
self.spar:SetParent( self )
self.spar:SetKeyValue( "Magnitude", "1" )
self.spar:SetKeyValue( "TrailLength", "1" )
self.spar:SetKeyValue( "spawnflags", "128" )
self.spar:Fire("SparkOnce")
self.spar:Fire("kill",self.spar,0.1)
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoDeath()
VJ_EmitSound(self,"weapons/expode1.wav",75,100)
local corpsess5 = ents.Create("prop_physics")
	corpsess5:SetModel("models/manhack.mdl")
	corpsess5:SetPos(self:GetPos() +self:GetUp()*10 +self:GetRight()*0)
	corpsess5:SetAngles(self:GetAngles()+Angle(0,0,0))
	corpsess5:Spawn()
	corpsess5:SetColor(self:GetColor())
	corpsess5:SetMaterial(self:GetMaterial())
	corpsess5:GetPhysicsObject():AddVelocity( Vector( math.Rand( -0, 0 ), math.Rand( -0, 0 ), 0 ) )
		self:Remove()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
	self:StopParticles()
	VJ_STOPSOUND(self.idle2sd)
	VJ_STOPSOUND(self.idlesd)
	if IsValid(self.Owner) && self.Owner.hasmanhack == true then
	self.Owner.hasmanhack = false
	self.Owner.canhavemanhack = false
	end
end
/*--------------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/