local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddFrostbiteEffect(duration)
    if self:IsPlayer() then
    else
        timer.Remove("Horde_RemoveFrostbite" .. self:GetCreationID())
        timer.Create("Horde_RemoveFrostbite" .. self:GetCreationID(), 4, 1, function ()
            self:Horde_RemoveFrostbite()
        end)

        self.Horde_Frostbite = 1

        -- VJ
        if self:IsNPC() then
            self:SetSchedule(SCHED_IDLE_STAND)
            timer.Simple(0, function ()
                if not self:IsValid() then return end
                if not self.Horde_StoredAnimationPlaybackRateFrostbite then
                    if self.AnimationPlaybackRate then
                        self.Horde_StoredAnimationPlaybackRateFrostbite = self.AnimationPlaybackRate
                        self.AnimationPlaybackRate = 0.6
                    else
                        self.Horde_StoredAnimationPlaybackRateFrostbite = self:GetPlaybackRate()
                        self:SetPlaybackRate(0.6)
                    end
                end
            end)
        end
    end

    local id = self:EntIndex()
    local bones = self:GetBoneCount()
    timer.Create("FrostbiteEffect" .. id, 0.5, 0, function ()
        if !self:IsValid() or (self:IsPlayer() and !self:Alive()) or not self.Horde_Debuff_Active or not self.Horde_Debuff_Active[HORDE.Status_Frostbite] then timer.Remove("FrostbiteEffect" .. id) return end
        for bone = 1, bones-1 do
            local pos, angle = self:GetBonePosition(bone)
            local effectdata = EffectData()
            effectdata:SetOrigin(pos)
            effectdata:SetScale( 1 )
            effectdata:SetMagnitude( 1 )
            effectdata:SetRadius( 18 )
            util.Effect( "GlassImpact", effectdata, true, true )
            util.Effect("horde_status_frostbite", effectdata, true, true)
        end
    end)
end

hook.Add("Horde_PlayerMoveBonus", "Horde_FrostbiteMovespeed", function(ply, bonus_walk, bonus_run)
    if ply.Horde_Debuff_Active and ply.Horde_Debuff_Active[HORDE.Status_Frostbite] then
        bonus_walk.more = bonus_walk.more * HORDE.Difficulty[HORDE.CurrentDifficulty].frostbiteSlow
        bonus_run.more = bonus_run.more * 0.5 * HORDE.Difficulty[HORDE.CurrentDifficulty].frostbiteSlow
    end
end)

function entmeta:Horde_RemoveFrostbite()
    if not self:IsValid() then return end
    local id = self:EntIndex()
    timer.Remove("FrostbiteEffect" .. id)
    if self:IsNPC() then
        if self.Horde_StoredAnimationPlaybackRateFrostbite then
            self.AnimationPlaybackRate = self.Horde_StoredAnimationPlaybackRateFrostbite
        else
            self:SetPlaybackRate(self.Horde_StoredAnimationPlaybackRateFrostbite)
        end
        self.Horde_StoredAnimationPlaybackRateFrostbite = nil
    end
end