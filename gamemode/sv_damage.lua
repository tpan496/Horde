local plymeta = FindMetaTable("Player")

-- All damage output
function plymeta:Horde_SetGlobalDamageIncrease(increase)
    self.Horde_GlobalDamageIncrease = increase
end

function plymeta:Horde_SetGlobalDamageMore(more)
    self.GlobalDamageMore = more
end

function plymeta:Horde_GetGlobalDamageIncrease()
    return self.GlobalDamageIncrease or 0
end

function plymeta:Horde_GetGlobalDamageMore()
    return self.GlobalDamageMore or 0
end

-- Headshot damage
function plymeta:Horde_SetHeadshotDamageIncrease(increase)
    self.Horde_HeadshotDamageIncrease = increase
end

function plymeta:Horde_SetHeadshotDamageMore(more)
    self.Horde_HeadshotDamageMore = more
end

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

-- Player damage.
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
    local bonus = {increase=increase, more=more}
    hook.Run("Horde_ApplyAdditionalDamage", ply, npc, bonus, hitgroup)
    dmginfo:ScaleDamage(bonus.more * (1 + bonus.increase))
    --print(more * (1 + increase), dmginfo:GetDamage())
end)

hook.Add("Horde_ResetStatus", "Horde_ResetDamage", function(ply)
    ply:Horde_SetGlobalDamageIncrease(0)
    ply:Horde_SetGlobalDamageMore(0)
    ply:Horde_SetHeadshotDamageIncrease(0)
    ply:Horde_SetHeadshotDamageMore(0)
    ply.Horde_DamageIncrease = {}
    ply.Horde_DamageMore = {}
end)

-- Evasion
function plymeta:Horde_SetEvasion(evasion)
    self.Horde_Evasion = evasion
end

function plymeta:Horde_GetEvasion()
    return self.Horde_Evasion or 0
end

-- All damage resistance
function plymeta:Horde_SetGlobalDamageResistance(resistance)
    self.Horde_GlobalDamageResistance = resistance
end

function plymeta:Horde_GetGlobalDamageResistance()
    return self.GlobalDamageResistance or 0
end

-- Certain damage type
function plymeta:Horde_SetDamageResistance(dmgtype, resistance)
    self.Horde_DamageResistance[dmgtype] = resistance
end

function plymeta:Horde_GetDamageResistance(dmgtype)
    return self.Horde_DamageResistance[dmgtype] or 0
end

-- Player damage taken
hook.Add("EntityTakeDamage", "Horde_ApplyDamageTaken", function (target, dmg)
    if not target:IsValid() or not target:IsPlayer() then return end
    local ply = target

    -- Apply evasion
    local evade = math.random()
    if evade <= ply:Horde_GetEvasion() then return true end

    -- Apply resistance
    local total_resistance = ply:Horde_GetGlobalDamageResistance() + ply:Horde_GetDamageResistance(dmg:GetDamageType())

    hook.Run("Horde_ApplyAdditionalDamageTaken", ply, dmg, {resistance=total_resistance})

    dmg:ScaleDamage(1 - total_resistance)
end)

hook.Add("Horde_ResetStatus", "Horde_ResetDamageTaken", function(ply)
    ply:Horde_SetEvasion(0)
    ply:Horde_SetGlobalDamageResistance(0)
    ply.Horde_DamageResistance = {}
end)

-- Enemy damage.
-- Hulk hitbox fix
hook.Add("ScaleNPCDamage", "Horde_HulkDamage", function (npc, hitgroup, dmg)
    if npc:IsValid() and npc:GetClass() == "npc_vj_zss_zhulk" then
        if hitgroup == HITGROUP_GENERIC then
            dmg:ScaleDamage(1.5)
        end
    end
end)

-- Hulk hitbox fix
hook.Add("ScaleNPCDamage", "Horde_MutatedHulkDamage", function (npc, hitgroup, dmg)
    if npc:IsValid() and npc:GetClass() == "npc_vj_mutated_hulk" then
        if hitgroup == HITGROUP_GENERIC then
            dmg:ScaleDamage(1.5)
        end
    end
end)

-- Gonome headshot multiplier reduction
hook.Add("ScaleNPCDamage", "Horde_GonomeDamage", function (npc, hitgroup, dmg)
    if npc:IsValid() and npc:GetClass() == "npc_vj_alpha_gonome" then
        if hitgroup == HITGROUP_HEAD then
            dmg:ScaleDamage(0.5)
        end
    end
end)