local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddStun(duration)
    if self.Horde_Stunned then return end
    self:SetSchedule(SCHED_NPC_FREEZE)
    timer.Simple(0.2, function() if not self:IsValid() then return end self:SetSchedule(SCHED_NPC_FREEZE) end)
    self.Horde_Stunned = true
    timer.Create("Horde_RemoveStun" .. self:GetCreationID(), 5, 1, function()
        if not self:IsValid() then return end
        self:SetCondition(68)
        self.Horde_Stunned = nil
    end)
end