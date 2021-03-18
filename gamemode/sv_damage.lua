local plymeta = FindMetaTable("Player")

-- All damage
function plymeta:Horde_SetGlobalDamageIncrease(increase)
    self.Horde_Damage_Increase = increase
end

function plymeta:Horde_SetGlobalDamageMore(more)
    self.Horde_Damage_More = more
end

function plymeta:Horde_GetGlobalDamageIncrease()
    return self.Horde_Damage_Increase or 0
end

function plymeta:Horde_GetGlobalDamageMore()
    return self.Horde_Damage_More or 0
end

-- Headshot damage
function plymeta:Horde_GetHeadshotDamageIncrease()
    return self.Horde_HeadshotDamageIncrease or 0
end

function plymeta:Horde_GetHeadshotDamageMore()
    return self.Horde_HeadshotDamageMore or 0
end

-- Certain damage type
function plymeta:Horde_SetDamageIncrease(dmgtype, increase)
    self.Horde_DamageIncrease[dmgtype] = increase
end

function plymeta:Horde_SetDamageMore(dmgtype, increase)
    self.Horde_DamageMore[dmgtype] = increase
end

function plymeta:Horde_GetDamageIncrease(dmgtype)
    return self.Horde_DamageIncrease[dmgtype] or 0
end

function plymeta:Horde_GetDamageMore(dmgtype)
    return self.Horde_DamageMore[dmgtype] or 0
end

hook.Add("ScaleNPCDamage", "Horde_ApplyDamage", function (npc, hitgroup, dmginfo)
    local ply = dmginfo:GetAttacker()
    if not npc:IsValid() or not ply:IsPlayer() then return end

    local increase = ply:Horde_GetGlobalDamageIncrease()
    local more = 1 + ply:Horde_GetGlobalDamageMore()
    
    if hitgroup == HITGROUP_HEAD then
        increase = increase + ply:Horde_GetHeadshotDamageIncrease()
        more = more * (1 + ply:Horde_GetHeadshotDamageMore())
    end

    local dmgtype = dmginfo:GetDamageType()
    increase = increase + ply:Horde_GetDamageIncrease(dmgtype)
    more = more * (1 + ply:Horde_GetDamageMore(dmgtype))

    -- Now find buffs that will affect damage.
    increase, more = hook.Run("Horde_ApplyAdditionalDamage", ply, increase, more, hitgroup)
    dmginfo:ScaleDamage(more * (1 + increase))
    --print(more * (1 + increase), dmginfo:GetDamage())
end)