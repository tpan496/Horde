if CLIENT then return end

concommand.Add("horde_drop_money", function (ply, cmd, args)
    ply:DropMoney()
end)

concommand.Add("horde_drop_weapon", function (ply, cmd, args)
    ply:DropWeapon()
end)

util.AddNetworkString("Horde_BuyItem")
util.AddNetworkString("Horde_BuyItemAmmoPrimary")
util.AddNetworkString("Horde_BuyItemAmmoSecondary")
util.AddNetworkString("Horde_SellItem")
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

function Player:DropMoney()
    if self:GetMoney() >= 50 then
        self:AddMoney(-50)
        local money = ents.Create("money")
        local pos = self:GetPos()
        local dir = (self:GetEyeTrace().HitPos - pos)
        dir:Normalize()
        local drop_pos = pos + dir * 50
        drop_pos.z = pos.z + 15
        money:SetPos(drop_pos)
        --money:DropToFloor()
        money:Spawn()
        self:SyncEconomy()
    end
end

function Player:GetWeight()
    return self.weight
end

function Player:GetClass()
    return self.class
end

function Player:SetClassSkill(variant)
    self.class_variant = variant
end

function Player:GetClassSkill()
    return self.class_variant
end

function Player:SyncEconomy()
    net.Start('Horde_SynchronizeEconomy')
	net.WriteEntity(self)
	net.WriteInt(self.money, 32)
    net.WriteInt(self.weight, 32)
    net.WriteString(self.class.name)
    net.WriteInt(self.class_variant, 8)
	net.Broadcast()
end

hook.Add("PlayerInitialSpawn", "Horde_Economy_Setup", function (ply)
    if not ply:IsValid() then return end
    ply:SetMoney(HORDE.start_money)
    ply:SetWeight(15)
    ply:SetClass(HORDE.classes["Survivor"])
    ply:SetClassSkill(-1)
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
    if not ply:IsValid() then return end
    if ply:GetClass().Name == "Heavy" then
        ply:SetWeight(20)
    else
        ply:SetWeight(15)
    end
    ply:SyncEconomy()
end)

hook.Add("PlayerDroppedWeapon", "Horde_Economy_Drop", function (ply, wpn)
    if not ply:IsValid() then return end
    if ply:IsNPC() then return end
    if HORDE.items[wpn:GetClass()] then
        local item = HORDE.items[wpn:GetClass()]
        ply:AddWeight(item.weight)
        ply:SyncEconomy()
    end
end)

hook.Add("PlayerCanPickupWeapon", "Horde_Economy_Pickup", function (ply, wpn)
    if not ply:IsValid() then return false end
    if ply:IsNPC() then return true end
    if HORDE.items[wpn:GetClass()] then
        local item = HORDE.items[wpn:GetClass()]
        if (ply:GetWeight() - item.weight < 0) or (not item.whitelist[ply:GetClass().name]) then
            return false
        end
    end

    return true
end)

hook.Add("WeaponEquip", "Horde_Economy_Equip", function (wpn, ply)
    if not ply:IsValid() then return end
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
    if not ply:IsValid() then return end
    local class = net.ReadString()
    local price = net.ReadInt(16)
    local weight = net.ReadInt(16)
    if ply:GetMoney() >= price and ply:GetWeight() >= weight then
        if class == "armor" then
            ply:SetArmor(100)
            ply:AddMoney(-price)
            ply:SyncEconomy()
        else
            local wpns = list.Get("Weapon")
            if not wpns[class] then return end
            ply:AddMoney(-price)
            ply:Give(class)
            ply:SelectWeapon(class)
        end
    end
end)

net.Receive("Horde_SellItem", function (len, ply)
    if not ply:IsValid() then return end
    local class = net.ReadString()
    if ply:HasWeapon(class) then
        local item = HORDE.items[class]
        ply:AddMoney(math.floor(item.price * 0.25))
        ply:StripWeapon(class)
        ply:SyncEconomy()
    end
end)

net.Receive("Horde_SelectClass", function (len, ply)
    if not ply:IsValid() then return end
    if HORDE.start_game and HORDE.current_break_time <= 0 then
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
    for _, wpn in pairs(ply:GetWeapons()) do
        ply:DropWeapon(wpn)
    end
    ply:SetWeight(HORDE.max_weight)
    ply:SetMaxHealth(class.max_hp)
    net.Start("Horde_ToggleShop")
    net.Send(ply)

    -- Class Settings
    timer.Remove("Horde_Medic" .. ply:SteamID())
    timer.Remove("Horde_Heavy" .. ply:SteamID())
    --timer.Remove("Horde_Survivor" .. ply:SteamID())
    --timer.Remove("Horde_Assault" .. ply:SteamID())
    timer.Remove("Horde_Demolition" .. ply:SteamID())
    hook.Remove("EntityTakeDamage", "Horde_Demolition" .. ply:SteamID())
    hook.Remove("ScaleNPCDamage", "Horde_Ghost" .. ply:SteamID())


    if class.name == "Assault" then
        --timer.Create("Horde_Assault" .. ply:SteamID(), 0.01, 0, function ()
        --    GAMEMODE:SetPlayerSpeed(ply, class.movespd, class.sprintspd)
        --end)
    elseif class.name == "Medic" then
        timer.Create("Horde_Medic" .. ply:SteamID(), 1, 0, function ()
            if not ply:IsValid() then timer.Remove("Horde_Medic" .. ply:SteamID()) return end
            ply:SetHealth(math.min(ply:GetMaxHealth(), ply:Health() + 0.02 * ply:GetMaxHealth()))
        end)
    elseif class.name == "Heavy" then
        timer.Create("Horde_Heavy" .. ply:SteamID(), 1, 0, function ()
            if not ply:IsValid() then timer.Remove("Horde_Heavy" .. ply:SteamID()) return end
            if ply:Armor() < 25 then
                ply:SetArmor(math.min(25, ply:Armor() + 1))
            end
        end)
        ply:SetWeight(HORDE.max_weight + 5)
    elseif class.name == "Demolition" then
        timer.Create("Horde_Demolition" .. ply:SteamID(), 30, 0, function ()
            if not ply:IsValid() then timer.Remove("Horde_Demolition" .. ply:SteamID()) return end
            if not ply:HasWeapon("weapon_frag") then
                ply:Give("weapon_frag")
            end
        end)
        hook.Add("EntityTakeDamage", "Horde_Demolition" .. ply:SteamID(), function (target, dmg)
            if not ply:IsValid() then hook.Remove("EntityTakeDamage", "Horde_Demolition" .. ply:SteamID()) return end
            if target:IsValid() and target:IsPlayer() and dmg:GetDamageType() ==  DMG_BLAST and target:SteamID() == ply:SteamID() then
                dmg:ScaleDamage(0.25)
            end
        end)
    elseif class.name == "Ghost" then
        hook.Add("ScaleNPCDamage", "Horde_Ghost" .. ply:SteamID(), function (npc, hitgroup, dmg)
            if not ply:IsValid() then hook.Remove("ScaleNPCDamage", "Horde_Ghost" .. ply:SteamID()) return end
            if npc:IsValid() and dmg:GetAttacker():IsPlayer() and dmg:GetAttacker():SteamID() == ply:SteamID() then
                if hitgroup == HITGROUP_HEAD then
                    dmg:ScaleDamage(1.5)
                end
            end
        end)
    end

    net.Start("Horde_LegacyNotification")
    net.WriteString("You changed class to " .. class.name)
    net.WriteInt(0,2)
    net.Send(ply)
    HORDE.player_class_changed[ply:SteamID()] = true
    ply:SyncEconomy()
end)

net.Receive("Horde_SelectClassSkillVariant", function (len, ply)
    if not ply:IsValid() then return end
    local price = net.ReadString()
    local class = net.ReadString()
    local variant = net.ReadInt()

    if ply:GetClassSkill() == variant or ply:GetMoney() < price then return end

    ply:SetClassSkill(variant)
    ply:SyncEconomy()

    if class == "Medic" then
        if variant == 0 then
            ply:SetMaxHealth(150)
        else
            hook.Add("EntityTakeDamage", "Horde_Medic_B", function (target, dmg)
                
            end)
        end
    elseif class == "Demolition" then
        if variant == 0 then
        else
        end
    elseif class == "Assault" then
        if variant == 0 then
        else
        end
    elseif class == "Heavy" then
        if variant == 0 then
        else
        end
    elseif class == "Ghost" then
        if variant == 0 then
        else
        end
    end
end)

net.Receive("Horde_BuyItemAmmoPrimary", function (len, ply)
    if not ply:IsValid() then return end
    local class = net.ReadString()
    local price = net.ReadInt(16)
    local count = net.ReadInt(16)
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
        local clip_size = wpn:GetMaxClip1()
        local ammo_id = wpn:GetPrimaryAmmoType()

        if clip_size > 0 then -- block melee
			ply:GiveAmmo(clip_size * count, ammo_id , false)
        else
            -- Give 1 piece of this ammo since clip size do not apply
            local rpg_round = 8
            local smg1_grenade = 9
            local ar2altfire = 2
            local xbowbolt = 6
            local grenade = 10
            local slam = 11
            if ammo_id == rpg_round or ammo_id == xbowbolt or ammo_id == smg1_grenade or ammo_id == ar2altfire or ammo_id == grenade or ammo_id == slam then
                ply:GiveAmmo(count, ammo_id, false)
            end
		end
        ply:SyncEconomy()
    end
end)

net.Receive("Horde_BuyItemAmmoSecondary", function (len, ply)
    if not ply:IsValid() then return end
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
        local ammo_id = wpn:GetSecondaryAmmoType()
        if ammo_id >= 0 then
			ply:GiveAmmo(1, ammo_id, false)
            ply:SyncEconomy()
        end
    end
end)