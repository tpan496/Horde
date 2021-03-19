-- Stackable poison
-- Path of Horde Poison SLAM Demolition build
-- Yes, currently I have nothing to do, new Satisfactory update is only in 4 days and a few month for new PoE league
local metapoison = {}
metapoison.__index = metapoison

local ENTITY = FindMetaTable("Entity")

function ENTITY:RegisterPoisonStack(poisonstack)
    self.poisonStacks = self.poisonStacks or {}
    table.insert(self.poisonStacks, poisonstack)
end

function ENTITY:GetPoisonStacks()
    return self.poisonStacks or {}
end

function ENTITY:IsPoisoned()
    return #self:GetPoisonStacks() > 0
end

function ENTITY:CleansePoison(poisonstack)
    if not self:IsPoisoned() then return end
    local stacks = self:GetPoisonStacks()

    for k,v in pairs(stacks) do
        if not poisonstack then
            table.RemoveByValue(v.targets, self)
            stacks[k] = nil
        elseif poisonstack == v then
            table.RemoveByValue(v.targets, self)
            stacks[k] = nil
            return
        end
    end
end

function metapoison:Die()
    self.active = nil
    for k,v in pairs(self.targets) do
        local stacks = v:GetPoisonStacks()
        for idx,poison in pairs(stacks) do
            if poison == self then
                self.targets[k] = nil
                stacks[idx] = nil
            end
        end
    end
end

function metapoison:RemoveTarget(ent)
    table.RemoveByValue(self.targets, ent)
    local stacks = ent:GetPoisonStacks()

    for idx,v in pairs(stacks) do
        if v == self then
            stacks[idx] = nil
            return
        end
    end
end

function metapoison:ApplyDamage()
    if not IsValid(self.attacker) then
        self:Die()
        return
    end

    if not IsValid(self.inflictor) then
        self.inflictor = self.attacker
    end

    local dmginfo = DamageInfo()
    --dmginfo:SetDamageType(DMG_POISON)
    dmginfo:SetDamageType(DMG_RADIATION)
    dmginfo:SetDamage(self.damage)
    dmginfo:SetAttacker(self.attacker)
    dmginfo:SetInflictor(self.inflictor)

    if #self.targets > 0 then
        for k,v in pairs(self.targets) do
            if not self:IsValidTarget(v) then
                self:RemoveTarget(v)
                goto cont
            end
            v:TakeDamageInfo(dmginfo)
            ::cont::
        end
    else
        self:Die()
    end
end

function metapoison:Think()
    local ct = CurTime()
    if self.nextTick > ct then return end
    if ct >= self.endTime then
        self:Die()
        return
    end
    self.nextTick = ct + self.delay
    self:ApplyDamage()
end

function metapoison:IsValid()
    return self.active
end

function metapoison:IsValidTarget(ent)
    return IsValid(ent) and ent:Health() > 0 and (ent:IsPlayer() or ent:IsNPC())
end

function metapoison:Activate()
    for k,v in pairs(self.targets) do
        if not self:IsValidTarget(v) then
            self.targets[k] = nil
            goto cont
        end
        v:RegisterPoisonStack(self)
        ::cont::
    end
    self.active = true
    hook.Add("Think", self, self.Think)
end

function HORDE.Poison(targets, inflictor, attacker, damage, duration, delay)
    if not targets then return end
    if isentity(targets) then targets = {targets} end
    if #targets < 1 then return end
    if not IsValid(attacker) then return end

    local poisonstack = {}
    setmetatable(poisonstack, metapoison)
    poisonstack.targets = targets
    poisonstack.inflictor = inflictor
    poisonstack.attacker = attacker
    poisonstack.damage = damage or 10
    poisonstack.endTime = CurTime() + (duration or 10)
    poisonstack.delay = delay or 1

    poisonstack.nextTick = CurTime()
    poisonstack:Activate()
    return poisonstack
end

hook.Add("PlayerDeath", "Horde_RemovePoisonOnDeath", function(ply)
    if ply:IsPoisoned() then ply:CleansePoison() end
end)