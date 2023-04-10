ENT.Type = "brush"
ENT.LastThink = CurTime()
ENT.ThinkInterval = 0.5

function ENT:Initialize()
	self.LastThink = CurTime()
	self.Horde_Players_In_Zone = {}
	self.Horde_Progress_Amount = 100/60
	self.Horde_Activated = nil
	self.Horde_Zone_Id = self:GetCreationID()
end

function ENT:Think()
	if not self.Horde_Activated then return end
	if self.LastThink < CurTime() then
		for _, p in pairs(self.Horde_Players_In_Zone) do
			if p:Alive() then
				p:Horde_SetEscapeProgress(p:Horde_GetEscapeProgress() + self.Horde_Progress_Amount)
			end
		end
		self.LastThink = CurTime() + self.ThinkInterval
	end
end

function ENT:Touch(ent)
	if ent:IsPlayer() and ent:Alive() then
		self.Horde_Players_In_Zone[ent:SteamID()] = ent
	end
end

function ENT:EndTouch(ent)
	if ent:IsPlayer() then
		self.Horde_Players_In_Zone[ent:SteamID()] = nil
		ent:Horde_SetEscapeProgress(0)
	end
end

function ENT:KeyValue(key, value)
	key = string.lower(key)
	if key == "group" then
		self.Horde_Zone_Group = tonumber(value) or 0
	end
end