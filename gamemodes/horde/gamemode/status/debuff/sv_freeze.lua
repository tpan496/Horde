local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddFreezeEffect(duration)
    if self:IsPlayer() then
    else
        timer.Remove("Horde_RemoveFreeze" .. self:GetCreationID())
        timer.Create("Horde_RemoveFreeze" .. self:GetCreationID(), 2, 1, function ()
            self:Horde_RemoveFreeze()
        end)

        self.Horde_Freeze = 1

        -- VJ
        if self:IsNPC() then
            self:SetSchedule(SCHED_IDLE_STAND)
            timer.Simple(0, function ()
                if not self:IsValid() then return end
                if not self.Horde_StoredAnimationPlaybackRateFreeze then
                    if self.AnimationPlaybackRate then
                        self.Horde_StoredAnimationPlaybackRateFreeze = self.AnimationPlaybackRate
                        self.AnimationPlaybackRate = 0
                    else
                        self.Horde_StoredAnimationPlaybackRateFreeze = self:GetPlaybackRate()
                        self:SetPlaybackRate(0)
                    end
                end
            end)
        end
    end
end

function entmeta:Horde_RemoveFreeze()
    if not self:IsValid() then return end
    if self:IsNPC() then
        if self.Horde_StoredAnimationPlaybackRateFreeze then
            self.AnimationPlaybackRate = self.Horde_StoredAnimationPlaybackRateFreeze
        else
            self:SetPlaybackRate(self.Horde_StoredAnimationPlaybackRateFreeze)
        end
        self.Horde_StoredAnimationPlaybackRateFreeze = nil
    end
end