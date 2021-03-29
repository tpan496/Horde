local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddSlow(duration, more)
    timer.Remove("Horde_RemoveSlow" .. self:GetCreationID())
    timer.Create("Horde_RemoveSlow" .. self:GetCreationID(), duration, 1, function ()
        self:Horde_RemoveSlow()
    end)

    self.Horde_Slow = 1
    -- VJ
    if (not self.Horde_StoredAnimationPlaybackRate) or (self.Horde_Slow_More < more) then
        if self.Horde_StoredAnimationPlaybackRate and (self.Horde_Slow_More < more) then
            if self.AnimationPlaybackRate then
                self.AnimationPlaybackRate = self.Horde_StoredAnimationPlaybackRate
            else
                self:SetPlaybackRate(self.Horde_StoredAnimationPlaybackRate)
            end
        end
        if self.AnimationPlaybackRate then
            self.Horde_StoredAnimationPlaybackRate = self.AnimationPlaybackRate
            self.AnimationPlaybackRate = self.Horde_StoredAnimationPlaybackRate * (1 - 0.20 * (1 + more))
        else
            self.Horde_StoredAnimationPlaybackRate = self:GetPlaybackRate()
            self:SetPlaybackRate(self.Horde_StoredAnimationPlaybackRate * (1 - 0.20 * (1 + more)))
        end
        self.Horde_Slow_More = more
    end
end

function entmeta:Horde_RemoveSlow()
    if not self:IsValid() then return end
    self.Horde_Slow = 0
    self.Horde_Slow_More = 0
    -- VJ
    if self.Horde_StoredAnimationPlaybackRate then
        self.AnimationPlaybackRate = self.Horde_StoredAnimationPlaybackRate
    else
        self:SetPlaybackRate(self.Horde_StoredAnimationPlaybackRate)
    end
    self.Horde_StoredAnimationPlaybackRate = nil
end

hook.Add("Horde_ResetStatus", "Horde_SlowReset", function(ply)
    ply.Horde_Slow = 0
    ply.Horde_Slow_More = 0
end)