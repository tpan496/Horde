
local math = math
local bit = bit
local IN_JUMP = IN_JUMP
local IN_DUCK = IN_DUCK
local IN_ZOOM = IN_ZOOM
local FrameTime = FrameTime

local function PressingJump(cmd)
	return bit.band(cmd:GetButtons(), IN_JUMP) ~= 0
end

local function PressingDuck(cmd)
	return bit.band(cmd:GetButtons(), IN_DUCK) ~= 0
end

local function PressJump(cmd, press)
	if press then
		cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_JUMP))
	elseif PressingJump(cmd) then
		cmd:SetButtons(cmd:GetButtons() - IN_JUMP)
	end
end

local function PressDuck(cmd, press)
	if press then
		cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_DUCK))
	elseif PressingDuck(cmd) then
		cmd:SetButtons(cmd:GetButtons() - IN_DUCK)
	end
end

--local DuckTime = 0

function GM:CreateMove(cmd)
	if MySelf:IsPlayingTaunt() and MySelf:Alive() then
		self:CreateMoveTaunt(cmd)
		return
	end

	--[[if MySelf:Team() == TEAM_SPECTATOR then return end

	if MySelf:OnGround() then
		DuckTime = 0	
	elseif PressingDuck(cmd) then
		DuckTime = 0
	elseif DuckTime > 0 then
		DuckTime = DuckTime - FrameTime()
		PressDuck(cmd, true)
	end]]

end
