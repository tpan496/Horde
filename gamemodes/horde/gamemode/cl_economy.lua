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
    return self.Horde_drop_entities or {}
end

net.Receive( "horde_sync_money", function()
    local ply = net.ReadEntity()
    if not IsValid( ply ) then return end

    local prev_money = ply.Horde_money or 0
    ply.Horde_money = net.ReadInt( 16 )
    if MySelf == ply then
        HORDE:PlayMoneyNotification( ply.Horde_money - prev_money, ply.Horde_money )
    end
end )

net.Receive( "horde_sync_weight", function()
    MySelf.Horde_weight = net.ReadUInt( 5 )
end )

net.Receive( "horde_sync_skull_tokens", function()
    MySelf.Horde_skull_tokens = net.ReadUInt( 14 )
end )

net.Receive( "horde_sync_drop_entities", function()
    MySelf.Horde_drop_entities = net.ReadTable()
end )

net.Receive( "horde_sync_subclass", function()
    local ply = net.ReadEntity()
    local subclass = net.ReadString()
    local class = HORDE.subclasses_to_classes[subclass]
    ply.Horde_class = HORDE.classes[class]
    if not ply.Horde_subclasses then ply.Horde_subclasses = {} end
    ply.Horde_subclasses[class] = subclass
end )

net.Receive( "Horde_SyncMaxWeight", function()
    local max_weight = net.ReadUInt(5)
    MySelf.Horde_max_weight = max_weight
end )
