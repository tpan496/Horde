local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddNeuronStabilizerStack()
    if self.Horde_NeuronStabilizerStack == self:Horde_GetMaxNeuronStabilizerStack() then return end
    self.Horde_NeuronStabilizerStack = self.Horde_NeuronStabilizerStack + 1
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Neuron_Stabilizer, 8)
        net.WriteUInt(self.Horde_NeuronStabilizerStack, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveNeuronStabilizerStack()
    if not self:IsValid() then return end
    if self.Horde_NeuronStabilizerStack == 0 then return end
    self.Horde_NeuronStabilizerStack = math.max(0, self.Horde_NeuronStabilizerStack - 1)
    if self.Horde_NeuronStabilizerStack == 0 then
        self.Horde_NeuronStabilizerRegenCooldown = self.Horde_NeuronStabilizerRegenTotal + 5
    end
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Neuron_Stabilizer, 8)
        net.WriteUInt(self.Horde_NeuronStabilizerStack, 8)
    net.Send(self)
end

function plymeta:Horde_GetNeuronStabilizerStack()
    return self.Horde_NeuronStabilizerStack or 0
end

function plymeta:Horde_GetMaxNeuronStabilizerStack()
    return 5
end

function plymeta:Horde_GetNeuronStabilizerStackDuration()
    return 5
end

function plymeta:Horde_ClearNeuronStabilizerStack()
    self.Horde_NeuronStabilizerStack = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Neuron_Stabilizer, 8)
        net.WriteUInt(self.Horde_NeuronStabilizerStack, 8)
    net.Send(self)
end

function plymeta:Horde_GetNeuronStabilizerEnabled()
    return self.Horde_NeuronStabilizerEnabled
end

function plymeta:Horde_SetNeuronStabilizerEnabled(enabled)
    self.Horde_NeuronStabilizerEnabled = enabled
    local id = self:SteamID()
    if enabled then
        self.Horde_NeuronStabilizerRegenCooldown = 0
        self.Horde_NeuronStabilizerRegenTotal = 0
        timer.Create("Horde_NeuronStabilizerRegen" .. id, 0.5, 0, function ()
            self.Horde_NeuronStabilizerRegenTotal = self.Horde_NeuronStabilizerRegenTotal + 1
            if not self:IsValid() then timer.Remove("Horde_NeuronStabilizerRegen" .. id) return end
            if self.Horde_NeuronStabilizerRegenCooldown <= self.Horde_NeuronStabilizerRegenTotal then
                self:Horde_AddNeuronStabilizerStack()
                self.Horde_NeuronStabilizerRegenCooldown = self.Horde_NeuronStabilizerRegenTotal + 2
            end
        end)
    else
        timer.Remove("Horde_NeuronStabilizerRegen" .. id)
        self.Horde_NeuronStabilizerStack = 0
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Neuron_Stabilizer, 8)
            net.WriteUInt(self.Horde_NeuronStabilizerStack, 8)
        net.Send(self)
    end
end

hook.Add("Horde_OnPlayerDamage", "Horde_NeuronStabilizerDamage", function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetNeuronStabilizerEnabled() then return end
    if not HORDE:IsBallisticDamage(dmginfo) then return end
    if ply:Horde_GetNeuronStabilizerStack() > 0 then
        bonus.increase = bonus.increase + ply:Horde_GetNeuronStabilizerStack() * 0.06
    end
end)

hook.Add("Horde_OnPlayerDamageTaken", "Horde_NeuronStabilizerDamageTaken", function (ply, dmginfo, bonus)
    if not ply:Horde_GetNeuronStabilizerEnabled() then return end
    if ply:Horde_GetNeuronStabilizerStack() > 0 then
        bonus.block = bonus.block + ply:Horde_GetNeuronStabilizerStack() * 2
    end
end)

hook.Add("Horde_ResetStatus", "Horde_NeuronStabilizerReset", function(ply)
    ply.Horde_NeuronStabilizerStack = 0
end)