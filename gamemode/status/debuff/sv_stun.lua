local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddStun(damage)
    if self.Stunned then return end
    if self:Horde_IsOnStunCooldown() then return end
    if not self.Horde_StunPower then self.Horde_StunPower = 0 end
    self.Horde_StunPower = self.Horde_StunPower + damage
    if self.Horde_StunPower >= 300 then
        self:SetSchedule(SCHED_NPC_FREEZE)
        timer.Simple(0.2, function() if not self:IsValid() then return end self:SetSchedule(SCHED_NPC_FREEZE) end)
        self.Stunned = true
        timer.Create("Horde_RemoveStun" .. self:GetCreationID(), 2, 1, function()
            if not self:IsValid() then return end
            self:SetCondition(68)
            self.Horde_StunPower = 0
            self.Horde_OnStunCooldown = true
            self.Stunned = nil
            timer.Simple(10, function()
                if self:IsValid() then
                    self.Horde_OnStunCooldown = nil
                end
            end)
        end)
    end
end

function entmeta:Horde_IsOnStunCooldown()
    return self.Horde_OnStunCooldown or nil
end

hook.Add("Horde_ResetStatus", "Horde_StunReset", function(ply)
    ply.Horde_Stun = 0
end)