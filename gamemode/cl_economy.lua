local plymeta = FindMetaTable("Player")

function plymeta:Horde_GetMoney()
    return self.money or 0
end

function plymeta:Horde_GetWeight()
    return self.weight or 0
end

function plymeta:Horde_GetClass()
    return self.class
end

function plymeta:GetHordeDropEntities()
    return self.drop_entities
end

net.Receive("Horde_Horde_SyncEconomy", function(length)
    local ply = net.ReadEntity()
    ply.money = net.ReadInt(32)
    ply.weight = net.ReadInt(32)
    ply.class = HORDE.classes[net.ReadString()]
    ply.drop_entities = net.ReadTable()
end)