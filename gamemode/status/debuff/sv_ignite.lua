local plymeta = FindMetaTable("Player")

function plymeta:Horde_SetApplyIgniteRadius(radius)
    self.Horde_ApplyIgniteRadius = radius
end

function plymeta:Horde_GetApplyIgniteRadius()
    return self.Horde_ApplyIgniteRadius or 25
end

function plymeta:Horde_SetApplyIgniteDuration(duration)
    self.Horde_ApplyIgniteDuration = duration
end

function plymeta:Horde_GetApplyIgniteDuration()
    return self.Horde_ApplyIgniteDuration or 5
end

function plymeta:Horde_SetApplyIgniteChance(chance)
    self.Horde_ApplyIgniteChance = chance
end

function plymeta:Horde_GetApplyIgniteChance()
    return self.Horde_ApplyIgniteChance or 0
end