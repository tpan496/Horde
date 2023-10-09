local plymeta = FindMetaTable("Player")

function plymeta:Horde_SetApplyBuffDuration(duration)
    self.Horde_ApplyBuffDuration = duration
end

function plymeta:Horde_GetApplyBuffDuration()
    return self.Horde_ApplyBuffDuration or 5
end

function plymeta:Horde_SetApplyBuffMore(more)
    self.Horde_ApplyBuffMore = more
end

function plymeta:Horde_GetApplyBuffMore()
    return self.Horde_ApplyBuffMore or 0
end