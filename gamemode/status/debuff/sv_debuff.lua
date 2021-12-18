local plymeta = FindMetaTable("Player")
local entmeta = FindMetaTable("Entity")

HORDE.Debuff_Notifications = {
    [HORDE.Status_Bleeding] = "You are inflicted by Bleeding.\nYou take physical damage over time.",
    [HORDE.Status_Ignite] = "You are inflicted by Ignite.\nYou take fire damage over time.",
    [HORDE.Status_Frostbite] = "You are inflicted by Frostbite.\nYour movement speed is reduced.",
    [HORDE.Status_Shock] = "You are inflicted by Shock.\nYou take increased damage from all sources.",
    [HORDE.Status_Break] = "You are inflicted by Break.\nYour health is reduced drastically and will recover slowly.",
    [HORDE.Status_Psychosis] = "Y'ai 'ng'ngah, Yog-Sothoth h'ee - l'geb f'ai throdog uaaah.",
}

function plymeta:Horde_SetApplyDebuffDuration(duration)
    self.Horde_ApplyDebuffDuration = duration
end

function plymeta:Horde_GetApplyDebuffDuration()
    return self.Horde_ApplyDebuffDuration or 5
end

function plymeta:Horde_SetApplyDebuffMore(more)
    self.Horde_ApplyDebuffMore = more
end

function plymeta:Horde_GetApplyDebuffMore()
    return self.Horde_ApplyDebuffMore or 0
end

function entmeta:Horde_AddDebuffBuildup(debuff, buildup)
    if not IsValid(self) or not self:Alive() then return end
    if buildup < 2 then return end
    if not self.Horde_Debuff_Active then self.Horde_Debuff_Active = {} end
    if not self.Horde_Debuff_Buildup then self.Horde_Debuff_Buildup = {} end
    if self.Horde_Debuff_Active[debuff] then return end
    if not self.Horde_Debuff_Buildup[debuff] then self.Horde_Debuff_Buildup[debuff] = 0 end
    if self.Horde_Debuff_Buildup[debuff] >= 100 then return end
    if HORDE.Status_Buildup_Sounds[debuff] then
        sound.Play(HORDE.Status_Buildup_Sounds[debuff], self:GetPos(), 100, math.random(80,110))
    end
    self.Horde_Debuff_Buildup[debuff] = math.min(100, self.Horde_Debuff_Buildup[debuff] + buildup)
    if self:IsPlayer() then
        local str = "Horde_RemoveBuildup_" .. tostring(debuff) .. "_" .. self:SteamID()
        timer.Create(str, 1, 0, function ()
            if not self.Horde_Debuff_Buildup[debuff] or self.Horde_Debuff_Buildup[debuff] <= 0 or self.Horde_Debuff_Active[debuff] then timer.Remove(str) return end
            self.Horde_Debuff_Buildup[debuff] = math.max(0, self.Horde_Debuff_Buildup[debuff] - 5)
            net.Start("Horde_SyncStatus")
                net.WriteUInt(debuff, 8)
                net.WriteUInt(self.Horde_Debuff_Buildup[debuff], 8)
            net.Send(self)
        end)

        net.Start("Horde_SyncStatus")
            net.WriteUInt(debuff, 8)
            net.WriteUInt(self.Horde_Debuff_Buildup[debuff], 8)
        net.Send(self)
    end
    if self.Horde_Debuff_Buildup[debuff] < 100 then return end
    if HORDE.Status_Trigger_Sounds[debuff] then
        sound.Play(HORDE.Status_Trigger_Sounds[debuff], self:GetPos())
    end
    if self:IsPlayer() then
        local duration = 5 + HORDE.difficulty_status_duration_bonus[HORDE.difficulty]
        local str = "Horde_Remove_" .. tostring(debuff) .. "_" .. self:SteamID()
        timer.Remove(str)
        timer.Create(str, duration, 1, function ()
            self:Horde_RemoveDebuff(debuff)
        end)

        -- Apply debuff effect
        if debuff == HORDE.Status_Bleeding then
            self:Horde_AddBleedingEffect()
        elseif debuff == HORDE.Status_Frostbite then
            self:Horde_AddFrostbiteEffect()
        elseif debuff == HORDE.Status_Ignite then
            self:Horde_AddIgniteEffect(duration)
        elseif debuff == HORDE.Status_Break then
            timer.Simple(0, function() self:Horde_AddBreakEffect(duration) end)
        elseif debuff == HORDE.Status_Psychosis then
            self:TakeDamage(50, self, self)
        end
    end

    if self:IsPlayer() and not self.Horde_Debuff_Active[debuff] then
        net.Start("Horde_LegacyNotification")
            net.WriteString(HORDE.Debuff_Notifications[debuff])
            net.WriteInt(0,2)
        net.Send(self)
    end

    self.Horde_Debuff_Active[debuff] = true
end

function entmeta:Horde_RemoveDebuff(debuff)
    if not self.Horde_Debuff_Active[debuff] then return end
    self.Horde_Debuff_Active[debuff] = nil
    self.Horde_Debuff_Buildup[debuff] = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(debuff, 8)
        net.WriteUInt(0, 8)
    net.Send(self)

    -- Unapply debuff effect
end

hook.Add("Horde_ResetStatus", "Horde_PlayerStatusReset", function(ply)
    ply.Horde_Debuff_Active = {}
    ply.Horde_Debuff_Buildup = {}
end)