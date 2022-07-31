local plymeta = FindMetaTable("Player")
local entmeta = FindMetaTable("Entity")

HORDE.Debuff_Notifications = {
    [HORDE.Status_Bleeding] = "You are inflicted by Bleeding.\nYour health is removed over time.",
    [HORDE.Status_Ignite] = "You are inflicted by Ignite.\nYou take Fire damage over time.",
    [HORDE.Status_Frostbite] = "You are inflicted by Frostbite.\nYour movement speed is reduced.",
    [HORDE.Status_Shock] = "You are inflicted by Shock.\nYou take increased damage from all sources.",
    [HORDE.Status_Break] = "You are inflicted by Break.\nYour health is reduced drastically and will recover slowly.",
    [HORDE.Status_Decay] = "You are inflicted by Decay.\nYou cannot heal.",
    [HORDE.Status_Psychosis] = "Y'ai 'ng'ngah, Yog-Sothoth h'ee - l'geb f'ai throdog uaaah.",
    [HORDE.Status_Necrosis] = "You are killed by Necrosis."
}

function HORDE:ApplyDebuffInRadius(debuff, pos, radius, buildup, inflictor, callback)
    for _, ent in pairs(ents.FindInSphere(pos, radius)) do
        if ent:IsNPC() and HORDE:IsPlayerOrMinion(ent) ~= true then
            ent:Horde_AddDebuffBuildup(debuff, buildup, inflictor)
        end
    end
end

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

function plymeta:Horde_ReduceDebuffBuildup(debuff, amount)
    if not self.Horde_Debuff_Buildup[debuff] or self.Horde_Debuff_Buildup[debuff] <= 0 or self.Horde_Debuff_Active[debuff] then return end
    self.Horde_Debuff_Buildup[debuff] = math.max(0, self.Horde_Debuff_Buildup[debuff] - amount)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(debuff, 8)
        net.WriteUInt(self.Horde_Debuff_Buildup[debuff], 8)
    net.Send(self)
end

function entmeta:Horde_HasDebuff(debuff)
    if self.Horde_Debuff_Active then
        return self.Horde_Debuff_Active[debuff]
    end
    return nil
end
function entmeta:Horde_AddDebuffBuildup(debuff, buildup, inflictor, pos)
    if not IsValid(self) or (self:IsPlayer() and not self:Alive()) then return end
    if inflictor and (HORDE:IsPlayerOrMinion(inflictor) == true) and (HORDE:IsPlayerOrMinion(self) == true) and inflictor ~= self then return end
    if not self.Horde_Debuff_Active then self.Horde_Debuff_Active = {} end
    if not self.Horde_Debuff_Buildup then self.Horde_Debuff_Buildup = {} end
    if not self.Horde_Debuff_Cooldown then self.Horde_Debuff_Cooldown = {} end
    if self.Horde_Debuff_Cooldown[debuff] then return end
    if self.Horde_Debuff_Active[debuff] then return end
    if not self.Horde_Debuff_Buildup[debuff] then self.Horde_Debuff_Buildup[debuff] = 0 end
    if self.Horde_Debuff_Buildup[debuff] >= 100 then return end

    if self:IsPlayer() then
        local bonus = {apply = 1, less = 1}
        hook.Run("Horde_OnPlayerDebuffApply", self, debuff, bonus, inflictor)
        if bonus.apply == 0 then return end
        buildup = buildup * bonus.less
        if buildup < 1  then return end

        if HORDE.Status_Buildup_Sounds[debuff] then
            sound.Play(HORDE.Status_Buildup_Sounds[debuff], self:GetPos(), 100, math.random(80,110))
        end
        self.Horde_Debuff_Buildup[debuff] = math.min(100, self.Horde_Debuff_Buildup[debuff] + buildup)

        local str = "Horde_RemoveBuildup_" .. tostring(debuff) .. "_" .. self:SteamID()
        timer.Create(str, 1, 0, function ()
            if not self:IsValid() then return end
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
    else
        local bonus = {apply = 1, more = 1, increase = 0}
        if inflictor and inflictor:IsValid() and inflictor:IsPlayer() then
            hook.Run("Horde_OnEnemyDebuffApply", self, debuff, bonus, inflictor)
        end
        if bonus.apply == 0 then return end
        buildup = buildup * bonus.more * (1 + bonus.increase)

        if HORDE.Status_Buildup_Sounds[debuff] then
            sound.Play(HORDE.Status_Buildup_Sounds[debuff], self:GetPos(), 100, math.random(80,110))
        end
        self.Horde_Debuff_Buildup[debuff] = math.min(100, self.Horde_Debuff_Buildup[debuff] + buildup)

        if not pos then pos = self:GetPos() + self:OBBCenter() end
        if (debuff == HORDE.Status_Frostbite) or (debuff == HORDE.Status_Freeze) then
            local effectdata = EffectData()
                effectdata:SetOrigin(pos)
                effectdata:SetScale(10)
                effectdata:SetMagnitude(10)
            util.Effect("GlassImpact", effectdata, true, true)
            util.Effect("GlassImpact", effectdata, true, true)
        elseif debuff == HORDE.Status_Shock then
            local data = EffectData();
            data:SetOrigin(pos)
            util.Effect("StunstickImpact", data);
        elseif debuff == HORDE.Status_Bleeding then
            local data = EffectData()
            data:SetOrigin(pos)
            data:SetRadius(50)
            util.Effect("hemo_mist", data, true, true)
        end
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
            self:Horde_AddBleedingEffect(inflictor)
        elseif debuff == HORDE.Status_Frostbite then
            self:Horde_AddFrostbiteEffect(duration)
        elseif debuff == HORDE.Status_Ignite then
            self:Horde_AddIgniteEffect(duration, inflictor)
        elseif debuff == HORDE.Status_Break then
            timer.Simple(0, function() self:Horde_AddBreakEffect(duration, inflictor) end)
        elseif debuff == HORDE.Status_Necrosis then
            timer.Simple(0.5, function ()
                self:Kill()
            end)
        elseif debuff == HORDE.Status_Freeze then
            self:Horde_AddFreezeEffect(duration)
        end
    else
        local duration = 5
        local str = "Horde_Remove_" .. tostring(debuff) .. "_" .. self:GetCreationID()
        timer.Remove(str)
        timer.Create(str, duration, 1, function ()
            self:Horde_RemoveDebuff(debuff)
        end)

        -- Apply debuff effect
        if debuff == HORDE.Status_Bleeding then
            self:Horde_AddBleedingEffect(inflictor)
        elseif debuff == HORDE.Status_Frostbite then
            self:Horde_AddFrostbiteEffect(3)
        elseif debuff == HORDE.Status_Ignite then
            self:Horde_AddIgniteEffect(duration, inflictor)
        elseif debuff == HORDE.Status_Break then
            self:Horde_AddBreakEffect(duration, inflictor)
        elseif debuff == HORDE.Status_Necrosis then
            timer.Simple(0.5, function ()
                self:SetHealth(1)
            end)
        --elseif debuff == HORDE.Status_Psychosis then
        --    self:TakeDamage(50, self, self)
        end
    end

    if self:IsPlayer() and not self.Horde_Debuff_Active[debuff] then
        net.Start("Horde_LegacyNotification")
            net.WriteString(translate.ClientGet(self, "Notification_" .. debuff))
            net.WriteInt(0,2)
        net.Send(self)
    end

    self.Horde_Debuff_Active[debuff] = true
end

function entmeta:Horde_RemoveDebuff(debuff)
    if not self:IsValid() or not self.Horde_Debuff_Active[debuff] then return end
    self.Horde_Debuff_Active[debuff] = nil
    self.Horde_Debuff_Buildup[debuff] = 0
    if self:IsPlayer() then
        net.Start("Horde_SyncStatus")
            net.WriteUInt(debuff, 8)
            net.WriteUInt(0, 8)
        net.Send(self)
    else
        self.Horde_Debuff_Cooldown[debuff] = true
        timer.Simple(3, function ()
            if not self:IsValid() then return end
            self.Horde_Debuff_Cooldown[debuff] = nil
        end)
    end
end

hook.Add("Horde_ResetStatus", "Horde_PlayerStatusReset", function(ply)
    ply.Horde_Debuff_Active = {}
    ply.Horde_Debuff_Buildup = {}
end)