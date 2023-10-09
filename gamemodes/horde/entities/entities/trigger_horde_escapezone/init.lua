ENT.Type = "brush"
ENT.LastThink = CurTime()
ENT.ThinkInterval = 0.5

function ENT:Initialize()
	self.LastThink = CurTime()
	self.Horde_Players_In_Zone = {}
	self.Horde_Activated = nil
	self.Horde_Zone_Id = self:GetCreationID()
end

function ENT:Think()
	if not self.Horde_Activated then return end
	if self.LastThink < CurTime() then
		local players_in_zone = 0
		for _, p in pairs(self.Horde_Players_In_Zone) do
			if p:Alive() then
				p:Horde_SetEscape(1)
				players_in_zone = players_in_zone + 1
			end
		end
		if players_in_zone == 0 then return end
		local alive_players = 0
		for _, ply in pairs(player.GetAll()) do
			if ply:Alive() and !ply:IsBot() then
				alive_players = alive_players + 1
			end
		end
		if players_in_zone >= players_in_zone then
			if HORDE.game_end then return end
			HORDE:WaveEnd()
			HORDE:GameEnd("VICTORY")
			self.Horde_Activated = nil
			return
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
		ent:Horde_SetEscape(0)
	end
end

function ENT:KeyValue(key, value)
	key = string.lower(key)
	if key == "group" then
		self.Horde_Zone_Group = tonumber(value) or 0
	end
end