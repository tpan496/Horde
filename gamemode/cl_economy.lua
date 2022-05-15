local plymeta = FindMetaTable("Player")

function plymeta:Horde_GetMoney()
    return self.Horde_money or 0
end

function plymeta:Horde_GetSkullTokens()
    return self.Horde_skull_tokens or 0
end

function plymeta:Horde_GetWeight()
    return self.Horde_weight or 0
end

function plymeta:Horde_GetMaxWeight()
    return self.Horde_max_weight or 0
end

function plymeta:Horde_GetDropEntities()
    return self.Horde_drop_entities
end

net.Receive("Horde_SyncEconomy", function(length)
    local ply = net.ReadEntity()
    ply.Horde_money = net.ReadInt(32)
    ply.Horde_skull_tokens = net.ReadInt(32)
    ply.Horde_weight = net.ReadInt(32)

    local subclass = net.ReadString()
    local class = HORDE.subclasses_to_classes[subclass]
    ply.Horde_class = HORDE.classes[class]
    if not ply.Horde_subclasses then ply.Horde_subclasses = {} end
    ply.Horde_subclasses[class] = subclass
    ply.Horde_drop_entities = net.ReadTable()
end)

net.Receive("Horde_SyncMaxWeight", function (len, ply)
    local max_weight = net.ReadUInt(5)
    LocalPlayer().Horde_max_weight = max_weight
end)