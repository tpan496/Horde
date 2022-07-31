ENT.Type = "point"

function ENT:Initialize()
	self.Wave = self.Wave or -1
end

function ENT:Think()
end

function ENT:AcceptInput(name, activator, caller, args)
	name = string.lower(name)
	if string.sub(name, 1, 2) == "on" then
		self:FireOutput(name, activator, caller, args)
	elseif name == "advancewave" then
		HORDE:WaveStart()
		return true
	elseif name == "endwave" then
        if !HORDE:InBreak() then
		    HORDE:WaveEnd()
        end
		return true
	elseif name == "setwave" then
		HORDE.current_wave = tonumber(args) or HORDE.current_wave
		return true
	elseif name == "setwaves" then
		HORDE.max_waves = tonumber(args) or HORDE.max_waves
		return true
    elseif name == "setwavestart" then
		local time = tonumber(args) or HORDE.total_break_time
        HORDE.total_break_time = time
        if !HORDE:InBreak() then
            HORDE:WaveEnd()
        end
        HORDE.total_break_time = GetConVarNumber("horde_break_time")
		return true
    end
	--[[elseif name == "setwaveend" then
		local time = tonumber(args) or 0
		gamemode.Call("SetWaveEnd", time == -1 and time or (CurTime() + time))
		return true
	end]]--
end

function ENT:KeyValue(key, value)
	key = string.lower(key)
	if string.sub(key, 1, 2) == "on" then
		self:AddOnOutput(key, value)
	elseif key == "wave" then
		self.Wave = tonumber(value) or -1
	end
end