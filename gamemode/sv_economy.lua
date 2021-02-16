if CLIENT then return end

util.AddNetworkString("Horde_BuyItem")
util.AddNetworkString("Horde_BuyItemAmmoPrimary")
util.AddNetworkString("Horde_BuyItemAmmoSecondary")
util.AddNetworkString("Horde_SelectClass")
util.AddNetworkString("Horde_SynchronizeEconomy")
util.AddNetworkString("Horde_LegacyNotification")

local Player = FindMetaTable('Player')

function Player:SetWeight(weight)
    self.weight = weight
end

function Player:SetMoney(money)
    self.money = money
end

function Player:SetClass(class)
    self.class = class
end

function Player:AddMoney(money)
    self.money = self.money + money
end

function Player:AddWeight(weight)
    self.weight = self.weight + weight
end

function Player:GetMoney()
    return self.money
end

function Player:GetWeight()
    return self.weight
end

function Player:GetClass()
    return self.class
end

function Player:SyncEconomy()
    net.Start('Horde_SynchronizeEconomy')
	net.WriteEntity(self)
	net.WriteInt(self.money, 32)
    net.WriteInt(self.weight, 32)
    net.WriteString(self.class.name)
	net.Broadcast()
end

hook.Add("PlayerInitialSpawn", "Horde_Economy_Setup", function (ply)
    ply:SetMoney(10000)
    ply:SetWeight(15)
    ply:SetClass(HORDE.classes["Survivor"])
    hook.Add("SetupMove", ply, function( self, ply, _, cmd )
		if self == ply and not cmd:IsForced() then
			hook.Run( "PlayerFullLoad", self )
			hook.Remove( "SetupMove", self )
            HORDE.player_class_changed[ply:SteamID()] = false
            ply:SyncEconomy()
		end
	end )
end)

hook.Add("PlayerSpawn", "Horde_Economy_Sync", function (ply)
    ply:SyncEconomy()
end)

hook.Add("PlayerDroppedWeapon", "Horde_Economy_Drop", function (ply, wpn)
    if HORDE.items[wpn:GetClass()] then
        local item = HORDE.items[wpn:GetClass()]
        ply:AddWeight(item.weight)
        ply:SyncEconomy()
    end
end)

hook.Add("PlayerCanPickupWeapon", "Horde_Economy_Pickup", function (ply, wpn)
    if HORDE.items[wpn:GetClass()] then
        local item = HORDE.items[wpn:GetClass()]
        if (ply:GetWeight() - item.weight < 0) or (not item.whitelist[ply:GetClass().name]) then
            return false
        end
    end

    return true
end)

hook.Add("WeaponEquip", "Horde_Economy_Equip", function (wpn, ply)
    if HORDE.items[wpn:GetClass()] then
        local item = HORDE.items[wpn:GetClass()]
        if (ply:GetWeight() - item.weight < 0) or (not item.whitelist[ply:GetClass().name]) then
            timer.Simple(0, function ()
                ply:DropWeapon(wpn)
            end)
            return
        end
        ply:AddWeight(-item.weight)
        ply:SyncEconomy()
        return
    end
end)

net.Receive("Horde_BuyItem", function (len, ply)
    local class = net.ReadString()
    local price = net.ReadInt(16)
    local weight = net.ReadInt(16)
    if ply:GetMoney() >= price and ply:GetWeight() >= weight then
        ply:AddMoney(-price)
        ply:Give(class)
        ply:SelectWeapon(class)
    end
end)

net.Receive("Horde_SelectClass", function (len, ply)
    PrintTable(HORDE.player_class_changed)
    if HORDE.start_game then
        net.Start("Horde_LegacyNotification")
        net.WriteString("You cannot change class after a wave has started.")
        net.WriteInt(1,2)
        net.Send(ply)
        return
    end
    if HORDE.player_class_changed[ply:SteamID()] then
        net.Start("Horde_LegacyNotification")
        net.WriteString("You cannot change class more than once per wave.")
        net.WriteInt(1,2)
        net.Send(ply)
        return
    end
    local name = net.ReadString()
    local class = HORDE.classes[name]
    ply:SetClass(class)
    ply:StripWeapons()
    ply:SetWeight(HORDE.max_weight)
    net.Start("Horde_ToggleShop")
    net.Send(ply)

    -- Class Settings
    timer.Remove("Horde_Medic" .. ply:SteamID())
    timer.Remove("Horde_Heavy" .. ply:SteamID())
    --timer.Remove("Horde_Survivor" .. ply:SteamID())
    timer.Remove("Horde_Assault" .. ply:SteamID())
    timer.Remove("Horde_Demolition" .. ply:SteamID())


    if class.name == "Assault" then
        timer.Create("Horde_Assault" .. ply:SteamID(), 0.01, 0, function ()
            GAMEMODE:SetPlayerSpeed(ply, class.movespd, class.sprintspd)
        end)
    elseif class.name == "Medic" then
        timer.Create("Horde_Medic" .. ply:SteamID(), 1, 0, function ()
            ply:SetHealth(math.min(ply:GetMaxHealth(), ply:Health() + 2))
        end)
    elseif class.name == "Heavy" then
        timer.Create("Horde_Heavy" .. ply:SteamID(), 1, 0, function ()
            if ply:Armor() < 25 then
                ply:SetArmor(math.min(25, ply:Armor() + 1))
            end
        end)
        ply:SetWeight(HORDE.max_weight + 5)
    elseif class.name == "Demolition" then
        timer.Create("Horde_Demolition" .. ply:SteamID(), 30, 0, function ()
            if not ply:HasWeapon("weapon_frag") then
                ply:Give("weapon_frag")
            end
        end)
    end

    net.Start("Horde_LegacyNotification")
    net.WriteString("You changed class to " .. class.name)
    net.WriteInt(0,2)
    net.Send(ply)
    HORDE.player_class_changed[ply:SteamID()] = true
    PrintTable(HORDE.player_class_changed)
    ply:SyncEconomy()
end)

net.Receive("Horde_BuyItemAmmoPrimary", function (len, ply)
    local class = net.ReadString()
    local price = net.ReadInt(16)
    if not ply:HasWeapon(class) then
        net.Start("Horde_LegacyNotification")
        net.WriteString("You don't have this weapon!")
        net.WriteInt(0,2)
        net.Send(ply)
        return
    end
    
    if ply:GetMoney() >= price then
        ply:AddMoney(-price)
        local wpn = ply:GetWeapon(class)
        local clipSize = wpn:GetMaxClip1()

        if clipSize > 0 then -- block melee
			local nClips = 1
			local AmmoID = wpn:GetPrimaryAmmoType()
			local AmmoNeeded = clipSize * nClips
			ply:GiveAmmo(AmmoNeeded , AmmoID , false)
		end
    end
end)

net.Receive("Horde_BuyItemAmmoSecondary", function (len, ply)
    local class = net.ReadString()
    local price = net.ReadString()
    if not ply:HasWeapon(class) then
        net.Start("Horde_LegacyNotification")
        net.WriteString("You don't have this weapon!")
        net.WriteInt(0,2)
        net.Send(ply)
        return
    end
    
    if ply:GetMoney() >= price then
        ply:AddMoney(-price)
        local wpn = ply:GetWeapon(class)
        local clipSize = wpn:GetMaxClip2()

        if clipSize > 0 then -- block melee
			local AmmoID = wpn:GetSecondaryAmmoType()
			ply:GiveAmmo(1 , AmmoID , false)
		end
    end
end)