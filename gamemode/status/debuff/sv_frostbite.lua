local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddFrostbiteEffect(duration)
    if self:IsPlayer() then
    else
        timer.Remove("Horde_RemoveFrostbite" .. self:GetCreationID())
        timer.Create("Horde_RemoveFrostbite" .. self:GetCreationID(), duration, 1, function ()
            self:Horde_RemoveFrostbite()
        end)

        self.Horde_Frostbite = 1
        self:SetSchedule(SCHED_IDLE_STAND)

        -- VJ
        if self:IsNPC() then
            timer.Simple(0, function ()
                if not self:IsValid() then return end
                if not self.Horde_StoredAnimationPlaybackRateFrostbite then
                    if self.Horde_StoredAnimationPlaybackRateFrostbite then
                        if self.AnimationPlaybackRate then
                            self.AnimationPlaybackRate = self.Horde_StoredAnimationPlaybackRateFrostbite
                        else
                            self:SetPlaybackRate(self.Horde_StoredAnimationPlaybackRateFrostbite)
                        end
                    end
                    if self.AnimationPlaybackRate then
                        self.Horde_StoredAnimationPlaybackRateFrostbite = self.AnimationPlaybackRate
                        self.AnimationPlaybackRate = 0.1
                    else
                        self.Horde_StoredAnimationPlaybackRateFrostbite = self:GetPlaybackRate()
                        self:SetPlaybackRate(0.1)
                    end
                end
            end)
        end
    end
end

hook.Add("Horde_PlayerMoveBonus", "Horde_FrostbiteMovespeed", function(ply, bonus)
    if ply.Horde_Debuff_Active and ply.Horde_Debuff_Active[HORDE.Status_Frostbite] then
        bonus.walkspd = bonus.walkspd * HORDE.difficulty_frostbite_slow[HORDE.difficulty]
        bonus.sprintspd = bonus.sprintspd * 0.5 * HORDE.difficulty_frostbite_slow[HORDE.difficulty]
    end
end)

function entmeta:Horde_RemoveFrostbite()
    if not self:IsValid() then return end
    if self:IsNPC() then
        if self.Horde_StoredAnimationPlaybackRateFrostbite then
            self.AnimationPlaybackRate = self.Horde_StoredAnimationPlaybackRateFrostbite
        else
            self:SetPlaybackRate(self.Horde_StoredAnimationPlaybackRateFrostbite)
        end
        self.Horde_StoredAnimationPlaybackRateFrostbite = nil
    end
end