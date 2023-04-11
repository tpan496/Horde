ENT.Type = "point"

function ENT:Initialize()
end

function ENT:KeyValue(key, value)
	key = string.lower(key)
	if key == "disabled" then
		self.Disabled = tonumber(value) == 1
	elseif key == "active" then
		self.Disabled = tonumber(value) == 0
	end
end

function ENT:AcceptInput(name, activator, caller, arg)
	name = string.lower(name)
	if name == "enable" or name == "unhide" then
		self.Disabled = false
		HORDE:AddBossNode(self:GetPos())
		return true
	elseif name == "disable" or name == "hide" then
		self.Disabled = true
		HORDE:RemoveBossNode(self:GetPos())
		return true
	elseif name == "toggle" then
		self.Disabled = not self.Disabled
		if self.Disabled then HORDE:RemoveBossNode(self:GetPos()) else HORDE:AddBossNode(self:GetPos()) end
		return true
	end
end
