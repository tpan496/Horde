ENT.Type = "brush"
ENT.LastThink = CurTime()

function ENT:Initialize()
	self.Horde_Activated = nil
	self.Horde_Payload_Destination_Id = self:GetCreationID()
end

function ENT:StartTouch(ent)
	if HORDE.game_end or not self.Horde_Activated then return end
	if ent:IsPlayer() and ent:Horde_HasPayload() and ent:Alive() then
		ent:Horde_DeliverPayload()
		self:Input("ondelivered", self, self)
	end
end

function ENT:KeyValue(key, value)
	key = string.lower(key)
	if key == "wave" then
		self.Horde_Active_Wave = tonumber(value) or -1
		if self.Horde_Active_Wave == -1 then
			self.Horde_Active_Wave = 0
		end
	elseif key == "group" then
		self.Horde_Payload_Destination_Group = tonumber(value) or 0
	end
end