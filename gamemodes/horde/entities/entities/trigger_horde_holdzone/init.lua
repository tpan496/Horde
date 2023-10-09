ENT.Type = "brush"
ENT.LastThink = CurTime()
ENT.ThinkInterval = 0.5
ENT.Horde_HalfNotification = true

function ENT:Initialize()
	self.LastThink = CurTime()
	self.Horde_Players_In_Zone = {}

	self.Horde_Hold_Progress = 0
	self.Horde_Progress_Amount = 1
	self.Horde_Activated = nil

	self.Horde_Zone_Id = self:GetCreationID()
	self.Horde_Player_Count = player.GetCount()
	self.Horde_Last_Holding = 0

	self.Horde_Total_Progress = 100
end

function ENT:Horde_SetActivated(activated)
	self.Horde_Activated = activated
	self.Horde_Player_Count = player.GetCount()
	self.Horde_Progress_Amount = 1
	if self.Horde_Player_Count == 1 then
		self.Horde_Progress_Amount = self.Horde_Progress_Amount * 1
	elseif self.Horde_Player_Count == 2 then
		self.Horde_Progress_Amount = self.Horde_Progress_Amount * 0.65
	elseif self.Horde_Player_Count == 3 then
		self.Horde_Progress_Amount = self.Horde_Progress_Amount * 0.5
	elseif self.Horde_Player_Count >= 4 then
		self.Horde_Progress_Amount = self.Horde_Progress_Amount * 0.35
	end
end

function ENT:Think()
	if HORDE.game_end or not self.Horde_Activated then return end
	if self.LastThink < CurTime() and (HORDE.current_wave == self.Horde_Active_Wave or self.Horde_Active_Wave <= 0) and HORDE.current_break_time <= 0 then
		if self.Horde_Hold_Progress >= self.Horde_Total_Progress then
			self.Horde_Hold_Progress = 0
			self.Horde_Activated = nil
			self.Horde_HalfNotification = true
			HORDE:SyncHoldZoneProgress(self.Horde_Zone_Id, self.Horde_Hold_Progress)
			HORDE:EndObjective(HORDE.OBJECTIVE_HOLD, {zone=self})
			for _, p in pairs(self.Horde_Players_In_Zone) do
				if p:IsValid() then
					p:Horde_AddMoney(HORDE.round_bonus_base * 0.2)
					p:Horde_SyncEconomy()
					net.Start("Horde_SyncStatus")
						net.WriteUInt(HORDE.Status_CanHold, 8)
						net.WriteUInt(0, 8)
					net.Send(p)
				end
			end
			self.Horde_Players_In_Zone = {}
			return
		end
		if self.Horde_Hold_Progress >= 50 and self.Horde_HalfNotification then
			HORDE:SendNotificationObjective(HORDE.OBJECTIVE_HOLD, "You have defended " .. (self.Horde_Zone_Label or "the area") .. " for 50%!")
			self.Horde_HalfNotification = nil
		end
		if self.Horde_Last_Holding + 5 <= CurTime() and table.Count(self.Horde_Players_In_Zone) == 0 then
			if self.Horde_Hold_Progress >= 50 then
				-- Regress
				self.Horde_Hold_Progress = math.max(1, self.Horde_Hold_Progress - self.Horde_Progress_Amount / 2)
				HORDE:SyncHoldZoneProgress(self.Horde_Zone_Id, self.Horde_Hold_Progress)
			end
		else
			local progress = 0
			for _, p in pairs(self.Horde_Players_In_Zone) do
				if p:IsValid() and p:Alive() then
					progress = progress + self.Horde_Progress_Amount
					if self.Horde_Hold_Progress < 50 then
						p:Horde_AddMoney(1)
						p:Horde_SyncEconomy()
					end
				end
			end
			progress = math.min(1, progress)
			self.Horde_Hold_Progress = self.Horde_Hold_Progress + progress
			HORDE:SyncHoldZoneProgress(self.Horde_Zone_Id, self.Horde_Hold_Progress)
			if progress > 0 then
				self.Horde_Last_Holding = CurTime()
			end
		end

		self.LastThink = CurTime() + self.ThinkInterval
	end
end

function ENT:StartTouch(ent)
	if self.Horde_Activated and ent:IsPlayer() then
		self.Horde_Players_In_Zone[ent:SteamID()] = ent
		net.Start("Horde_SyncStatus")
			net.WriteUInt(HORDE.Status_CanHold, 8)
			net.WriteUInt(1, 8)
		net.Send(ent)
	end
end


function ENT:Touch(ent)
	if self.Horde_Activated and ent:IsPlayer() and ent:Alive() then
		self.Horde_Players_In_Zone[ent:SteamID()] = ent
	end
end

function ENT:EndTouch(ent)
	if self.Horde_Activated and ent:IsPlayer() then
		self.Horde_Players_In_Zone[ent:SteamID()] = nil
		net.Start("Horde_SyncStatus")
			net.WriteUInt(HORDE.Status_CanHold, 8)
			net.WriteUInt(0, 8)
		net.Send(ent)
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
		self.Horde_Zone_Group = tonumber(value) or 0
	elseif key == "label" then
		self.Horde_Zone_Label = value or "the area"
	end
end