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

net.Receive("Horde_SynchronizeEconomy", function(length)
	local ply = net.ReadEntity()
	ply.money = net.ReadInt(32)
    ply.weight = net.ReadInt(32)
    ply.class = HORDE.classes[net.ReadString()]
end)