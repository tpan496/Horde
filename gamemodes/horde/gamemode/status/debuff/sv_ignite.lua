local plymeta = FindMetaTable("Player")
local entmeta = FindMetaTable("Entity")

function plymeta:Horde_SetApplyIgniteDuration(duration)
    self.Horde_ApplyIgniteDuration = duration
end

function plymeta:Horde_GetApplyIgniteDuration()
    return self.Horde_ApplyIgniteDuration or 4
end

function plymeta:Horde_SetApplyIgniteChance(chance)
    self.Horde_ApplyIgniteChance = chance
end

function plymeta:Horde_GetApplyIgniteChance()
    return self.Horde_ApplyIgniteChance or 0
end

function entmeta:Horde_SetMostRecentFireAttacker(attacker, dmginfo)
	self.Horde_MostRecentFireAttacker = attacker
    if self.Horde_IgniteDamageTaken then
        self.Horde_IgniteDamageTaken = math.max(self.Horde_IgniteDamageTaken, dmginfo:GetDamage() * 0.025)
    else
        self.Horde_IgniteDamageTaken = math.max(1, dmginfo:GetDamage() * 0.03)
    end
end

function entmeta:Horde_SetIgniteDamage(dmg)
    self.Horde_IgniteDamageTaken = dmg
end

function entmeta:Horde_GetMostRecentFireAttacker()
	return self.Horde_MostRecentFireAttacker
end

function entmeta:Horde_GetIgniteDamageTaken()
    return self.Horde_IgniteDamageTaken or 1
end

function entmeta:Horde_AddIgniteEffect(duration)
    if self:IsPlayer() then
        self:Ignite(duration)
        timer.Remove("Horde_RemoveIgnite" .. self:SteamID())
        timer.Create("Horde_RemoveIgnite" .. self:SteamID(), duration, 1, function ()
            self:Horde_RemoveIgnite()
        end)
    end
end

function entmeta:Horde_RemoveIgnite()
    if not self:IsValid() then return end
    if self:IsPlayer() then
        self:Extinguish()
    end
end