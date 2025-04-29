local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddFrostbiteEffect(duration)
    if self:IsPlayer() then
    else
        timer.Remove("Horde_RemoveFrostbite" .. self:GetCreationID())
        timer.Create("Horde_RemoveFrostbite" .. self:GetCreationID(), 4, 1, function ()
            self:Horde_RemoveFrostbite()
        end)

        self.Horde_Frostbite = true
        self.Horde_Frostbitten = true -- for VJank Base

        -- VJ
        if self:IsNPC() then
            --self:SetSchedule(SCHED_IDLE_STAND)
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
            local id = self:EntIndex()
            timer.Create("FrostbiteSlowEffect" .. id, 0.1, 40, function ()
                if not self:IsValid() then return end
                self:SetMoveVelocity(self:GetMoveVelocity() * 0.8)
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
        bonus_walk.more = bonus_walk.more * HORDE.difficulty_frostbite_slow[HORDE.difficulty]
        bonus_run.more = bonus_run.more * HORDE.difficulty_frostbite_slow[HORDE.difficulty]
    end
end)

function entmeta:Horde_RemoveFrostbite()
    if not self:IsValid() then return end
    self.Horde_Frostbite = nil
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