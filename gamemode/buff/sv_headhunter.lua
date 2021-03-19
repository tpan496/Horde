local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddHeadhunterStack()
    self.Horde_HeadhunterStack = math.min((self.Horde_HeadhunterStack or 0) + 1, self:Horde_GetMaxHeadhunterStack())
    timer.Simple(self:Horde_GetHeadhunterStackDuration(), function ()
        self:Horde_RemoveHeadhunterStack()
    end)
end

function plymeta:Horde_RemoveHeadhunterStack()
    self.Horde_HeadhunterStack = math.max(0, self.Horde_HeadhunterStack - 1)
end

function plymeta:Horde_GetHeadhunterStack()
    return self.Horde_HeadhunterStack or 0
end

function plymeta:Horde_GetMaxHeadhunterStack()
    return 5
end

function plymeta:Horde_GetHeadhunterStackDuration()
    return self.Horde_HeadhunterStack
end

function plymeta:Horde_ClearHeadhunterStack()
    self.Horde_HeadhunterStack = 0
end

hook.Add("Horde_ApplyAdditionalDamage", "Horde_HeadhunterDamage", function (ply, increase, more, hitgroup)
    if ply:Horde_GetClass().name ~= "Ghost" then return increase, more end
    if hitgroup ~= HITGROUP_HEAD then return increase, more end
    increase = increase + ply:Horde_GetHeadhunterStack() * 0.08
    return increase, more
end)

hook.Add("ScaleNPCDamage", "Horde_test", function(npc, hitgroup, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if IsValid(attacker) and attacker:IsPlayer() and hitgroup == HITGROUP_HEAD then
        attacker:Horde_AddHeadhunterStack()
    else
        attacker:Horde_RemoveHeadhunterStack()
    end
end)