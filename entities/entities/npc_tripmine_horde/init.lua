AddCSLuaFile("cl_init.lua")
include("shared.lua")

ENT.Damage = 200
ENT.Radius = 200

function ENT:Detonate()
	local eff = EffectData()
    eff:SetStart(self:GetPos())
    eff:SetOrigin(self:GetPos())
    util.Effect("Explosion", eff)

	util.BlastDamage(self, self:GetHordeOwner(), self:GetPos(), self.Radius, self.Damage)
	self:Remove()
end

local snd = Sound("npc/roller/mine/rmine_predetonate.wav")
function ENT:Trigger()
	self:SetTriggered(true)
	self:EmitSound(snd)
	timer.Simple(1, function()
		if IsValid(self) then self:Detonate() end
	end)
end

function ENT:OnTakeDamage(dmginfo)
	if not self.Armed then return end
	local attacker, inflictor = dmginfo:GetAttacker(), dmginfo:GetInflictor()

	if not IsValid(inflictor) or inflictor == self then return end

	local owner = self:GetHordeOwner()
	if not IsValid(owner) then
		self:Detonate()
		return
	end

	if IsValid(attacker) and (attacker:IsNPC() or attacker == owner) then
		self:Detonate()
	end
end

hook.Add("OnEntityCreated", "Horde_TripMineReplacement", function(ent)
	if ent:GetClass() == "npc_tripmine" then
		timer.Simple(0, function()
			if not IsValid(ent) then return end
			local owner = ent:GetInternalVariable("m_hOwner")
			local ent2 = ents.Create("npc_tripmine_horde")
			ent2:SetPos(ent:GetPos())
			ent2:SetAngles(ent:GetAngles())
			ent:Remove()
			--ent2:SetOwner(owner)
			--ent2:SetHordeOwner(owner)
			ent2.HordeOwner = owner
			ent2:Spawn()
		end)
	end
end)

local reuse = CreateConVar("horde_tripmine_reusable", 1, FCVAR_SERVER_CAN_EXECUTE, "Can tripwire mines(SLAM's) be picked up after being armed?")
function ENT:Use(ply)
	local owner = self:GetHordeOwner()
	if reuse:GetBool() == false then return end
	if self:GetTriggered() then return end
	if IsValid(owner) and owner != ply then return end	-- feel free to steal disconnected player mines

	-- I don't want player to be able to difuse mines with wrong class >:c
	-- btw, saboteur class when?
	local item = HORDE.items[self.SWEP]
	if not item or ply:GetHordeWeight() - item.weight < 0 or not item.whitelist[ply:GetHordeClass().name] then return end

	self:Remove()
	ply:GiveAmmo(1, "slam")
	if not IsValid(ply:GetWeapon(self.SWEP)) then
		ply:Give(self.SWEP, true)
	end
end