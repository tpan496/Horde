local plymeta = FindMetaTable("Player")

function plymeta:Horde_GetMoney()
    return self.Horde_money or 0
end

function plymeta:Horde_GetWeight()
    return self.Horde_weight or 0
end

function plymeta:Horde_GetClass()
    return self.Horde_class
end

function plymeta:Horde_GetDropEntities()
    return self.Horde_drop_entities
end

net.Receive("Horde_SyncEconomy", function(length)
    local ply = net.ReadEntity()
    ply.Horde_money = net.ReadInt(32)
    ply.Horde_weight = net.ReadInt(32)
    ply.Horde_class = HORDE.classes[net.ReadString()]
    ply.Horde_drop_entities = net.ReadTable()
end)