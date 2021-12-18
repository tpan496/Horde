local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddFrostbiteEffect()
    if self:IsPlayer() then
    else
        timer.Remove("Horde_RemoveFrostbite" .. self:GetCreationID())
        timer.Create("Horde_RemoveFrostbite" .. self:GetCreationID(), 5, 1, function ()
            self:Horde_RemoveFrostbite()
        end)

        self.Horde_Frostbite = 1
        -- VJ
        if self:IsNPC() then
            if (not self.Horde_StoredAnimationPlaybackRateFrostbite) or (self.Horde_Frostbite_More < more) then
                if self.Horde_StoredAnimationPlaybackRateFrostbite and (self.Horde_Frostbite_More < more) then
                    if self.AnimationPlaybackRate then
                        self.AnimationPlaybackRate = self.Horde_StoredAnimationPlaybackRateFrostbite
                    else
                        self:SetPlaybackRate(self.Horde_StoredAnimationPlaybackRateFrostbite)
                    end
                end
                if self.AnimationPlaybackRate then
                    self.Horde_StoredAnimationPlaybackRateFrostbite = self.AnimationPlaybackRate
                    self.AnimationPlaybackRate = self.Horde_StoredAnimationPlaybackRateFrostbite * 0.6
                else
                    self.Horde_StoredAnimationPlaybackRateFrostbite = self:GetPlaybackRate()
                    self:SetPlaybackRate(self.Horde_StoredAnimationPlaybackRateFrostbite *  0.6)
                end
            end
        end
    end
end

hook.Add("Horde_PlayerMoveBonus", "Horde_FrostbiteMovespeed", function(ply, bonus)
    if ply.Horde_Debuff_Active and ply.Horde_Debuff_Active[HORDE.Status_Frostbite] then
        bonus.walkspd = bonus.walkspd * 0.5
        bonus.sprintspd = bonus.sprintspd * 0.5
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