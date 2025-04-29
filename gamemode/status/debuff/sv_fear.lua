local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddFearStack(ply)
    if self:IsPlayer() then return end -- Failsafe incase this debuff gets applied to players
    if not self.Horde_FearStack then
        self.Horde_FearStack = 0
    end
    if ply:Horde_GetPerk("overlord_doomed_presence") then
        self.Is_Doomed = true
    end
    
    if ply:Horde_GetPerk("overlord_deatheater") then
        self.Horde_FearStack = ply:Horde_GetMaxFearStack()
    end
    
    self.Horde_FearStack = math.max(self.Horde_FearStack, math.min(ply:Horde_GetMaxFearStack(), self.Horde_FearStack + 1))
    --hook.Run("Horde_PostFearApply", self, ply, HORDE.Status_Fear, self:GetPos(), self.Horde_FearStack)
    self.Horde_FearStackAdded = true
    
    if ply:Horde_GetPerk("overlord_dispersion") then
        for debuff, buildup in pairs(ply.Horde_Debuff_Buildup) do
            ply:Horde_ReduceDebuffBuildup(debuff, 10)
        end
    end
    
    if ply:Horde_GetPerk("overlord_militant") then
        self:Horde_SetFear_Agony_Multiplier(0.5)
    end
    
    if ply:Horde_GetPerk("overlord_oppressor") then
        self:Horde_SetFear_Suffering_Multiplier(0.5)
    end
    
    if ply.Horde_Special_Upgrades and ply.Horde_Special_Upgrades["module_agony"] then
        self:Horde_SetFearUpgrade_Agony_Multiplier(0.25)
    end
    
    if ply.Horde_Special_Upgrades and ply.Horde_Special_Upgrades["module_suffering"] then
        self:Horde_SetFearUpgrade_Suffering_Multiplier(0.25)
    end
    
    if ply.Is_Death_Incarnate_LoS then
        self:Horde_AddDebuffBuildup(HORDE.Status_Necrosis, 500, ply, self:GetPos())
    end
    
    if ply.Horde_Special_Upgrades and ply.Horde_Special_Upgrades["module_terror"] then
        self:Horde_AddDebuffBuildup(HORDE.Status_Stun, 10, ply, self:GetPos())
    end
    
    if ply.Horde_Special_Upgrades and ply.Horde_Special_Upgrades["module_nightmare"] then
        if not self.Is_Nightmare then
            self.Is_Nightmare = true
            local dmg = DamageInfo()
            dmg:SetAttacker(ply)
            dmg:SetInflictor(ply)
            dmg:SetDamageType(DMG_DIRECT)
            dmg:SetDamageCustom(HORDE.DMG_CALCULATED)
            dmg:SetDamagePosition(self:GetPos())
            dmg:SetDamage(self:GetMaxHealth() * 0.08)
            self:TakeDamageInfo(dmg)
        end
        if self:Health() <= self:GetMaxHealth() * 0.1 then
            local dmg = DamageInfo()
            dmg:SetAttacker(ply)
            dmg:SetInflictor(ply)
            dmg:SetDamageType(DMG_DIRECT)
            dmg:SetDamageCustom(HORDE.DMG_CALCULATED)
            dmg:SetDamagePosition(self:GetPos())
            dmg:SetDamage(self:Health() + 1)
            self:TakeDamageInfo(dmg)
            self:EmitSound("horde/status/bleeding_trigger.ogg")
        end
    end
    
    local ef = EffectData()
    if self:IsValid() then
        ef:SetEntity(self)
        util.Effect("horde_fear03", ef)
    end
    
    local id = self:GetCreationID()
    timer.Remove("Horde_FearEffect" .. id)
    timer.Create("Horde_FearEffect" .. id, 0.75, 0, function()
        if not self:IsValid() then return end
        if self:Horde_GetFearStack() <= 0 then timer.Remove("Horde_FearEffect" .. id) return end
        ef:SetEntity(self)
        util.Effect("horde_fear03", ef)
    end)
    
    if self.Is_Doomed then return end 
    timer.Remove("Horde_FearTracker" .. self:GetCreationID())
    timer.Create("Horde_FearTracker" .. self:GetCreationID(), self:Horde_GetFearStackDuration(), 1, function()
        if not self:IsValid() then return end
        self.Horde_FearStackAdded = nil
        self:Horde_RemoveFearStack()
    end)
end

function entmeta:Horde_RemoveFearStack()
    if not self:IsValid() then return end
    if self.Is_Doomed then return end
    if self.Horde_FearStack <= 0 then return end
    if self.Horde_FearStackAdded then return end
    self.Horde_FearStack = math.max(0, self.Horde_FearStack - 1)
    timer.Create("Horde_FearTracker" .. self:GetCreationID(), self:Horde_GetFearStackDuration(), 1, function()
        self:Horde_RemoveFearStack()
    end)
end

function entmeta:Horde_GetFearStack()
    return self.Horde_FearStack or 0
end

function entmeta:Horde_SetMaxFearStack(stack)
    self.Horde_MaxFearStack = math.max(0, stack)
end

function entmeta:Horde_GetMaxFearStack()
    return self.Horde_MaxFearStack or 0
end

function entmeta:Horde_SetFearStackDuration(duration)
    self.Horde_FearStackDuration = duration
end

function entmeta:Horde_GetFearStackDuration()
    return self.Horde_FearStackDuration or 5
end

function entmeta:Horde_GetFearEnabled()
    return self.Horde_FearEnabled
end

function entmeta:Horde_SetFearEnabled(enabled)
    self.Horde_FearEnabled = enabled
end

----------------- Perk Skills -----------------
function entmeta:Horde_SetFear_Agony_Multiplier(value)
    self.Horde_Fear_Agony_Multi = value
end

function entmeta:Horde_GetFear_Agony_Multiplier()
    return self.Horde_Fear_Agony_Multi or 0
end

function entmeta:Horde_SetFear_Suffering_Multiplier(value)
    self.Horde_Fear_Suffering_Multi = value
end

function entmeta:Horde_GetFear_Suffering_Multiplier()
    return self.Horde_Fear_Suffering_Multi or 0
end

----------------- Upgrade -----------------
function entmeta:Horde_SetFearUpgrade_Agony_Multiplier(value)
    self.Horde_FearUprade_Agony_Multi = value
end

function entmeta:Horde_GetFearUpgrade_Agony_Multiplier()
    return self.Horde_FearUprade_Agony_Multi or 0
end

function entmeta:Horde_SetFearUpgrade_Suffering_Multiplier(value)
    self.Horde_FearUprade_Suffering_Multi = value
end

function entmeta:Horde_GetFearUpgrade_Suffering_Multiplier()
    return self.Horde_FearUprade_Suffering_Multi or 0
end

hook.Add("Horde_OnPlayerDamage", "Horde_FearStackDamage", function(ply, npc, bonus, hitgroup)
    if npc:Horde_GetFearStack() > 0 then
        local Agonizing_Death_Multi = 0
        if npc.Is_Death then
            local Suffering_Multi = 0
            local Suffering_Multi2 = 0
            if npc.Is_Suffering then
                Suffering_Multi = 0.5
            end
            if ply.Horde_Special_Upgrades and ply.Horde_Special_Upgrades["module_suffering"] then
                Suffering_Multi2 = 0.25
            end
            Agonizing_Death_Multi = (0.04 * (1 + (Suffering_Multi + Suffering_Multi2)))
        end
        
        bonus.more = bonus.more * math.max(1, 1 + npc:Horde_GetFearStack() * ((0.04 * (1 + (npc:Horde_GetFear_Agony_Multiplier() + npc:Horde_GetFearUpgrade_Agony_Multiplier()))) + Agonizing_Death_Multi))
    end
end)

hook.Add("Horde_OnPlayerDamageTaken", "Horde_FearStackDamageTaken", function(ply, dmg, bonus)
    local npc = dmg:GetInflictor()
    if npc and npc:IsNPC() and npc:Horde_GetFearStack() > 0 then
        bonus.less = bonus.less * math.max(0, 1 - npc:Horde_GetFearStack() * (0.04 * (1 + (npc:Horde_GetFear_Suffering_Multiplier() + npc:Horde_GetFearUpgrade_Suffering_Multiplier()))))
    end
end)

hook.Add("Horde_ResetStatus", "Horde_FearReset", function(ply)
    ply.Horde_FearStack = 0
    ply.Horde_MaxFearStack = 0
    ply.Horde_FearStackDuration = 5
    ply.Horde_FearStackAdded = nil
end)
