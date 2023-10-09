ENT.Type = "point"

function ENT:Initialize()
end

function ENT:Think()
end

function ENT:AcceptInput(name, activator, caller, args)
	name = string.lower(name)
	if name == "setstartingmoney" then
		self:SetKeyValue("startingmoney", args)
    elseif name == "setkillrewardbase" then
        self:SetKeyValue("killrewardbase", args)
    elseif name == "setroundbonusbase" then
        self:SetKeyValue("roundbonusbase", args)
	end
end

function ENT:KeyValue(key, value)
	key = string.lower(key)
    if not value then return end
    local v = tonumber(value)
    if not v then return end
    if v <= 0 then return end
	if key == "startingmoney" then
		HORDE.start_money = v or GetConVarNumber("horde_start_money")
        HORDE.start_money = math.floor(HORDE.start_money * HORDE.difficulty_start_money_multiplier[HORDE.difficulty])
        for _, ply in pairs(player.GetAll()) do
            ply:Horde_SetMoney(HORDE.start_money)
        end
    elseif key == "killrewardbase" then
        HORDE.kill_reward_base = v or HORDE.kill_reward_base
        HORDE.kill_reward_base = math.floor(tonumber(value) * HORDE.difficulty_reward_base_multiplier[HORDE.difficulty])
    elseif key == "roundbonusbase" then
        HORDE.round_bonus_base = v or HORDE.round_bonus_base
        HORDE.round_bonus_base = math.floor(tonumber(value) * HORDE.difficulty_reward_base_multiplier[HORDE.difficulty])
	end
end