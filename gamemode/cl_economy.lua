if SERVER then return end

local Player = FindMetaTable('Player')

function Player:GetMoney()
    return self.money or 0
end

function Player:GetWeight()
    return self.weight or 0
end

function Player:GetClass()
    return self.class
end

net.Receive('Horde_SynchronizeEconomy', function(length)
	local ply = net.ReadEntity()
	ply.money = net.ReadInt(32)
    ply.weight = net.ReadInt(32)
    ply.class = HORDE.classes[net.ReadString()]
end)