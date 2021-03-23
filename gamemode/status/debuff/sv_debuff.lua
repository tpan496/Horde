local plymeta = FindMetaTable("Player")

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
    return self.Horde_ApplyDebuffMore or 1
end