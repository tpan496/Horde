ENT.Type = "point"

function ENT:Initialize()
	self.Horde_Activated = nil
	self.Horde_Payload_Spawn_Id = self:GetCreationID()
end

function ENT:KeyValue(key, value)
	key = string.lower(key)
	if key == "disabled" then
		self.Disabled = tonumber(value) == 1
	elseif key == "active" then
		self.Disabled = tonumber(value) == 0
	elseif key == "wave" then
		self.Horde_Active_Wave = tonumber(value) or -1
		if self.Horde_Active_Wave == -1 then
			self.Horde_Active_Wave = 0
		end
	elseif key == "group" then
		self.Horde_Payload_Spawn_Group = tonumber(value) or 0
	elseif key == "label" then
		self.Horde_Payload_Label = value or "the payload"
	elseif key == "model" then
		self.Horde_Payload_Model = value or nil
	elseif key == "icon" then
		self.Horde_Payload_Icon = tonumber(value) or 0
	elseif key == "mass" then
		self.Horde_Payload_Mass = tonumber(value) or 40
	end
end

function ENT:AcceptInput(name, activator, caller, arg)
	name = string.lower(name)
	if name == "enable" or name == "unhide" then
		self.Disabled = false
		return true
	elseif name == "disable" or name == "hide" then
		self.Disabled = true
		return true
	elseif name == "toggle" then
		self.Disabled = not self.Disabled
		return true
	end
end

function ENT:Horde_SpawnPayload()
	if not self.Horde_Activated then return end
	if self.Horde_SpawnedPayload then
		if self.Horde_SpawnedPayload:IsValid() then
			self.Horde_SpawnedPayload:Remove()
		end
	end
	self.Horde_SpawnedPayload = ents.Create("horde_payload")
	self.Horde_SpawnedPayload.Horde_Payload_Spawn = self
	self.Horde_SpawnedPayload:SetPos(self:GetPos())
	self.Horde_SpawnedPayload:SetAngles(self:GetAngles())
	self.Horde_SpawnedPayload:Spawn()
	timer.Simple(0.1, function ()
		if self.Horde_Payload_Model then
			self.Horde_SpawnedPayload:SetModel(self.Horde_Payload_Model)
		end
	end)

	net.Start("Horde_SyncPayloadLocation")
	net.WriteUInt(self.Horde_Payload_Spawn_Id, 4)
	net.WriteVector(self:GetPos())
	net.Broadcast()
end

function ENT:Horde_RemovePayload()
	if self.Horde_SpawnedPayload and IsValid(self.Horde_SpawnedPayload) then
		self.Horde_SpawnedPayload:Remove()
	end
end