local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddHeadhunterStack()
    self.Horde_HeadhunterStack = math.min((self.Horde_HeadhunterStack or 0) + 1, self:Horde_GetMaxHeadhunterStack())
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

-- Call this function to give a headhunter stack to a player.
function HORDE:HeadhunterStack(ply)
    if ply:Horde_GetClass().name ~= "Ghost" then return end
    ply:Horde_AddHeadhunterStack()
    print(ply:Horde_GetHeadhunterStack())
    timer.Simple(ply:Horde_GetHeadhunterStackDuration(), function ()
        ply:Horde_RemoveHeadhunterStack()
    end)
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
        HORDE:HeadhunterStack(attacker)
    else
        attacker:Horde_RemoveHeadhunterStack()
    end
end)