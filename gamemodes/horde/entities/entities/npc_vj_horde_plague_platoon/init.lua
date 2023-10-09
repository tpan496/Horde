AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/headcrab.mdl"
ENT.StartHealth = 7750
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.HasMeleeAttack = false

	-- ====== Sound Pitch ====== --
-- Higher number = Higher pitch | Lower number = Lower pitch
-- Highest number is 254
	-- !!! Important variables !!! --
ENT.UseTheSameGeneralSoundPitch = true
	-- If set to true, it will make the game decide a number when the SNPC is created and use it for all sound pitches set to "UseGeneralPitch"
	-- It picks the number between the two variables below:
ENT.GeneralSoundPitch1 = 75
ENT.GeneralSoundPitch2 = 75
ENT.LastHp = 0
ENT.EntitiesToNoCollide = {"npc_vj_horde_platoon_heavy", "npc_vj_horde_platoon_berserker", "npc_vj_horde_platoon_demolitionist"}


function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(0,0,0),Vector(0,0,0))
	self:EmitSound("horde/plague_elite/summon.ogg")
	self.Init = nil
	self:SetRenderMode(RENDERMODE_TRANSCOLOR)
	self:SetColor(Color(0,0,0,0))
	timer.Simple(1, function ()
		ParticleEffect("aurora_shockwave_debris", self:GetPos(), Angle(0,0,0), nil)
		ParticleEffect("aurora_shockwave", self:GetPos(), Angle(0,0,0), nil)
		self.MiniBoss1 = ents.Create("npc_vj_horde_platoon_heavy")
		self.MiniBoss1:SetPos(self:GetPos())
		self.MiniBoss1:SetAngles(self:GetAngles())
		self.MiniBoss1:Spawn()
		self.MiniBoss1:SetOwner(self)
		timer.Simple(0.1, function ()
			self.MiniBoss1:SetMaxHealth(self:GetMaxHealth() * 0.3)
			self.MiniBoss1:SetHealth(self.MiniBoss1:GetMaxHealth())
		end)
		
		self.MiniBoss1.DisableCritical = true

		self.MiniBoss2 = ents.Create("npc_vj_horde_platoon_berserker")
		self.MiniBoss2:SetPos(self:GetPos() + self:GetRight()*-10)
		self.MiniBoss2:SetAngles(self:GetAngles())
		self.MiniBoss2:Spawn()
		self.MiniBoss2:SetOwner(self)
		timer.Simple(0.1, function ()
			self.MiniBoss2:SetMaxHealth(self:GetMaxHealth() * 0.4)
			self.MiniBoss2:SetHealth(self.MiniBoss2:GetMaxHealth())
		end)
		self.MiniBoss2.DisableCritical = true

		self.MiniBoss3 = ents.Create("npc_vj_horde_platoon_demolitionist")
		self.MiniBoss3:SetPos(self:GetPos() + self:GetRight()*10)
		self.MiniBoss3:SetAngles(self:GetAngles())
		self.MiniBoss3:Spawn()
		self.MiniBoss3:SetOwner(self)
		timer.Simple(0.1, function ()
			self.MiniBoss3:SetMaxHealth(self:GetMaxHealth() * 0.3)
			self.MiniBoss3:SetHealth(self.MiniBoss3:GetMaxHealth())
		end)
		self.MiniBoss3.DisableCritical = true
		self.Init = true

		timer.Simple(0.1, function ()
			self:SetMaxHealth(self.MiniBoss1:GetMaxHealth() + self.MiniBoss2:GetMaxHealth() + self.MiniBoss3:GetMaxHealth())
			net.Start("Horde_SyncBossHealth")
			net.WriteInt(self:Health(), 32)
			net.Broadcast()
		end)
	end)
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	dmginfo:SetDamage(0)
	return true
end

function ENT:CustomOnThink_AIEnabled()
	if not self.Init then return end
	local hp = 0
	local dead = 0
	if self.MiniBoss1 and IsValid(self.MiniBoss1) then
		hp = hp + self.MiniBoss1:Health()
	else
		dead = 1
	end
	if self.MiniBoss2 and IsValid(self.MiniBoss2) then
		hp = hp + self.MiniBoss2:Health()
	else
		dead = 1
	end
	if self.MiniBoss3 and IsValid(self.MiniBoss3) then
		hp = hp + self.MiniBoss3:Health()
	else
		dead = 1
	end

	if hp <= 0 then
		self:TakeDamage(self:Health() + 1, self, self)
		net.Start("Horde_SyncBossHealth")
		net.WriteInt(0, 32)
		net.Broadcast()
		HORDE:OnEnemyKilled(self, self)
		return
	end
	self:SetHealth(hp)
	if self.LastHp ~= hp then
		net.Start("Horde_SyncBossHealth")
		net.WriteInt(self:Health(), 32)
		net.Broadcast()
	end
	self.LastHp = hp

	if dead > 0 and not self.Critical then
		self.Critical = true
		if self.MiniBoss1 and IsValid(self.MiniBoss1) then
			self.MiniBoss1.Critical = true
		end
		if self.MiniBoss2 and IsValid(self.MiniBoss2) then
			self.MiniBoss2.Critical = true
			self.AnimationPlaybackRate = 1.25
		end
		if self.MiniBoss3 and IsValid(self.MiniBoss3) then
			self.MiniBoss3.Critical = true
		end
	end
end

/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

VJ.AddNPC("Platoon","npc_vj_horde_plague_platoon", "Zombies")