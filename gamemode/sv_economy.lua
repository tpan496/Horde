if CLIENT then return end

concommand.Add("horde_drop_money", function (ply, cmd, args)
    ply:DropHordeMoney()
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

function Player:SetHordeWeight(weight)
    self.weight = weight
end

function Player:SetHordeMoney(money)
    self.money = money
end

function Player:SetHordeClass(class)
    self.class = class
end

function Player:AddHordeMoney(money)
    self.money = self.money + money
end

function Player:AddHordeWeight(weight)
    self.weight = self.weight + weight
end

function Player:GetHordeMoney()
    return self.money
end

function Player:GiveHordeAmmoBox()
    print("ok")
    return
end

function Player:DropHordeMoney()
    if self:GetHordeMoney() >= 50 then
        self:AddHordeMoney(-50)
        local money = ents.Create("horde_money")
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

function Player:GetHordeWeight()
    return self.weight
end

function Player:GetHordeClass()
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

-- Player Spawn Initialize
net.Receive("Horde_PlayerInit", function (len, ply)
    net.Start("Horde_SyncItems")
    net.WriteTable(HORDE.items)
    net.Send(ply)

    net.Start("Horde_SyncEnemies")
    net.WriteTable(HORDE.enemies)
    net.Send(ply)

    net.Start("Horde_SyncClasses")
    net.WriteTable(HORDE.classes)
    net.Send(ply)

    if not HORDE.start_game then
        HORDE.player_ready[ply] = 0
        net.Start("Horde_PlayerReadySync")
        net.WriteTable(HORDE.player_ready)
        net.Broadcast()
    end
    
    if HORDE.start_game then
        ply:SetHordeMoney(HORDE.start_money + math.max(0, HORDE.current_wave - 1) * 150)
    else
        ply:SetHordeMoney(HORDE.start_money)
    end
    
    ply:SetHordeWeight(15)
    ply:SetHordeClass(HORDE.classes["Survivor"])
    ply:SetClassSkill(-1)
    HORDE.player_class_changed[ply:SteamID()] = false
    ply:SyncEconomy()
    ply:PrintMessage(HUD_PRINTTALK, "Use '!help' to see special commands!")
    
    if HORDE.start_game then return end
    
    local ready_count = 0
    local total_player = 0
    for _, ply in pairs(player.GetAll()) do
        if HORDE.player_ready[ply] == 1 then
            ready_count = ready_count + 1
        end
        total_player = total_player + 1
    end
    
    if total_player == ready_count then
        HORDE.start_game = true
    end

    BroadcastMessage("Players Ready: " .. tostring(ready_count) .. "/" .. tostring(total_player))
end)

hook.Add("PlayerDisconnected", "Horde_PlayerDisconnect", function(ply)
    if HORDE.player_vote_map_change[ply] then
        HORDE.player_vote_map_change[ply] = nil
    end
    if (not HORDE.start_game) and HORDE.player_ready[ply] then
        HORDE.player_ready[ply] = nil
        net.Start("Horde_PlayerReadySync")
        net.WriteTable(HORDE.player_ready)
        net.Broadcast()
    end
    
    if not ply:IsValid() then return end

    -- Remove all his class abilities
    timer.Remove("Horde_Medic" .. ply:SteamID())
    timer.Remove("Horde_Heavy" .. ply:SteamID())
    timer.Remove("Horde_Demolition" .. ply:SteamID())
    hook.Remove("EntityTakeDamage", "Horde_Demolition" .. ply:SteamID())
    hook.Remove("ScaleNPCDamage", "Horde_Ghost" .. ply:SteamID())
end)

hook.Add("PlayerSpawn", "Horde_Economy_Sync", function (ply)
    if not ply:IsValid() then return end
    if not ply:GetHordeClass() then return end
    if ply:GetHordeClass().Name == "Heavy" then
        ply:SetHordeWeight(20)
    else
        ply:SetHordeWeight(15)
    end
    ply:SyncEconomy()
end)

hook.Add("PlayerDroppedWeapon", "Horde_Economy_Drop", function (ply, wpn)
    if not ply:IsValid() then return end
    if ply:IsNPC() then return end
    if HORDE.items[wpn:GetClass()] then
        local item = HORDE.items[wpn:GetClass()]
        ply:AddHordeWeight(item.weight)
        ply:SyncEconomy()
    end
end)

hook.Add("PlayerCanPickupWeapon", "Horde_Economy_Pickup", function (ply, wpn)
    if not ply:IsValid() then return false end
    if ply:IsNPC() then return true end
    if HORDE.items[wpn:GetClass()] then
        local item = HORDE.items[wpn:GetClass()]
        if (ply:GetHordeWeight() - item.weight < 0) or (not item.whitelist[ply:GetHordeClass().name]) then
            return false
        end
    end

    return true
end)

hook.Add("WeaponEquip", "Horde_Economy_Equip", function (wpn, ply)
    if not ply:IsValid() then return end
    if HORDE.items[wpn:GetClass()] then
        local item = HORDE.items[wpn:GetClass()]
        if (ply:GetHordeWeight() - item.weight < 0) or (not item.whitelist[ply:GetHordeClass().name]) then
            timer.Simple(0, function ()
                ply:DropWeapon(wpn)
            end)
            return
        end
        ply:AddHordeWeight(-item.weight)
        ply:SyncEconomy()
        return
    end
end)

net.Receive("Horde_BuyItem", function (len, ply)
    if not ply:IsValid() then return end
    local class = net.ReadString()
    local price = net.ReadInt(16)
    local weight = net.ReadInt(16)
    if ply:GetHordeMoney() >= price and ply:GetHordeWeight() >= weight then
        if class == "armor" then
            ply:SetArmor(100)
            ply:AddHordeMoney(-price)
            ply:SyncEconomy()
        else
            local wpns = list.Get("Weapon")
            if not wpns[class] then return end
            ply:AddHordeMoney(-price)
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
        ply:AddHordeMoney(math.floor(item.price * 0.25))
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
    ply:SetHordeClass(class)
    for _, wpn in pairs(ply:GetWeapons()) do
        ply:DropWeapon(wpn)
    end
    ply:SetHordeWeight(HORDE.max_weight)
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
            if not ply:IsValid() then return end
            ply:SetHealth(math.min(ply:GetMaxHealth(), ply:Health() + 0.02 * ply:GetMaxHealth()))
        end)
    elseif class.name == "Heavy" then
        timer.Create("Horde_Heavy" .. ply:SteamID(), 1, 0, function ()
            if not ply:IsValid() then return end
            if ply:Armor() < 25 then
                ply:SetArmor(math.min(25, ply:Armor() + 1))
            end
        end)
        ply:SetHordeWeight(HORDE.max_weight + 5)
    elseif class.name == "Demolition" then
        timer.Create("Horde_Demolition" .. ply:SteamID(), 30, 0, function ()
            if not ply:IsValid() then return end
            if not ply:HasWeapon("weapon_frag") then
                ply:Give("weapon_frag")
            end
        end)
        hook.Add("EntityTakeDamage", "Horde_Demolition" .. ply:SteamID(), function (target, dmg)
            if not ply:IsValid() then return end
            if target:IsValid() and target:IsPlayer() and dmg:GetDamageType() ==  DMG_BLAST and target:SteamID() == ply:SteamID() then
                dmg:ScaleDamage(0.25)
            end
        end)
    elseif class.name == "Ghost" then
        hook.Add("ScaleNPCDamage", "Horde_Ghost" .. ply:SteamID(), function (npc, hitgroup, dmg)
            if not ply:IsValid() then return end
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

    if ply:GetClassSkill() == variant or ply:GetHordeMoney() < price then return end

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
    
    if ply:GetHordeMoney() >= price then
        ply:AddHordeMoney(-price)
        local wpn = ply:GetWeapon(class)
        HORDE.GiveAmmo(ply, wpn, count)
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
    
    if ply:GetHordeMoney() >= price then
        ply:AddHordeMoney(-price)
        local wpn = ply:GetWeapon(class)
        local ammo_id = wpn:GetSecondaryAmmoType()
        if ammo_id >= 0 then
			ply:GiveAmmo(1, ammo_id, false)
            ply:SyncEconomy()
        end
    end
end)