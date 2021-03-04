if SERVER then return end

local Player = FindMetaTable("Player")

function Player:GetHordeMoney()
    return self.money or 0
end

function Player:GetHordeWeight()
    return self.weight or 0
end

function Player:GetHordeClass()
    return self.class
end

function Player:GetHordeDropEntities()
    return self.drop_entities
end

net.Receive("Horde_SyncEconomy", function(length)
	local ply = net.ReadEntity()
	ply.money = net.ReadInt(32)
    ply.weight = net.ReadInt(32)
    ply.class = HORDE.classes[net.ReadString()]
    ply.drop_entities = net.ReadTable()
end)