ENT.Type = "point"

function ENT:Think()
end

function ENT:AcceptInput(name, activator, caller, args)
	name = string.lower(name)
	if string.sub(name, 1, 2) == "on" then
		self:FireOutput(name, activator, caller, args)
	elseif name == "activateachievement" then
		local ent = ents.FindByName(args[1])
        if ent and ent:IsValid() and ent:IsPlayer() then
			if not self.Achievement or self.Achievement == "" then return end
            net.Start("Horde_SaveExtraAchievements")
				net.WriteString(self.Achievement)
			net.Send(ent)
        end
    end
end

function ENT:KeyValue(key, value)
	key = string.lower(key)
	if string.sub(key, 1, 2) == "on" then
		self:AddOnOutput(key, value)
	elseif key == "achievement" then
		self.Achievement = self.Achievement or ""
	elseif key == "description" then
		self.Description = self.Description or ""
	end
end