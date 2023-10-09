if SERVER then
util.AddNetworkString("Horde_SetMapsWhitelistData")
util.AddNetworkString("Horde_SetMapsBlacklistData")
util.AddNetworkString("Horde_SyncMaps")
end

-- Maps
HORDE.map_whitelist = {}
HORDE.map_blacklist = {}

function HORDE:GetNextMaps()
    local map_list = {}

    -- If there is a whitelist, only use maps in the whitelist.
    HORDE:GetMapWhitelist()
    if HORDE.map_whitelist and not table.IsEmpty(HORDE.map_whitelist) then
        return HORDE.map_whitelist
    end

    -- If there is a blacklist, filter off these maps.
    HORDE:GetMapBlacklist()
    local maps = file.Find( "maps/*.bsp", "GAME")
    for _, map in ipairs( maps ) do
        map = map:sub(1, -5) -- Take off .bsp
        if HORDE.map_blacklist then
            for _, blacklist_map in pairs(HORDE.map_blacklist) do
                if map == blacklist_map then goto cont end
            end
        end
        table.insert(map_list, map)
        ::cont::
    end
    
    return map_list
end

function HORDE:SetMapWhitelist()
    if not file.IsDir("horde", "DATA") then
        file.CreateDir("horde")
    end

    file.Write("horde/map_whitelist.txt", util.TableToJSON(HORDE.map_whitelist))
end

function HORDE:SetMapBlacklist()
    if not file.IsDir("horde", "DATA") then
        file.CreateDir("horde")
    end

    file.Write("horde/map_blacklist.txt", util.TableToJSON(HORDE.map_whitelist))
end

function HORDE:GetMapWhitelist()
    if not file.IsDir("horde", "DATA") then
        file.CreateDir("horde")
        return
    end

    if file.Read("horde/map_whitelist.txt", "DATA") then
        local t = util.JSONToTable(file.Read("horde/map_whitelist.txt", "DATA"))
        HORDE.map_whitelist = t
        print("[HORDE] - Loaded map whitelist.")
    end
end

function HORDE:GetMapBlacklist()
    if not file.IsDir("horde", "DATA") then
        file.CreateDir("horde")
        return
    end

    if file.Read("horde/map_blacklist.txt", "DATA") then
        local t = util.JSONToTable(file.Read("horde/map_blacklist.txt", "DATA"))
        HORDE.map_blacklist = t
        print("[HORDE] - Loaded map blacklist.")
    end
end

-- We don't need to send maps informatio nto every player.
-- Just the ones who want to edit maps.
function HORDE:SyncMapsTo(ply)
    net.Start("Horde_SyncMaps")
        net.WriteTable(HORDE.map_whitelist)
        net.WriteTable(HORDE.map_blacklist)
    net.Send(ply)
end

-- Startup
if SERVER then
    HORDE:GetMapWhitelist()
    HORDE:GetMapBlacklist()
    
    net.Receive("Horde_SetMapsWhitelistData", function(len, ply)
        if not ply:IsSuperAdmin() then return end
        HORDE.map_whitelist = net.ReadTable()
        HORDE:SetMapWhitelist()
        HORDE:SyncMapsTo(ply)
    end)

    net.Receive("Horde_SetMapsBlacklistData", function(len, ply)
        if not ply:IsSuperAdmin() then return end
        HORDE.map_blacklist = net.ReadTable()
        HORDE:SetMapBlacklist()
        HORDE:SyncMapsTo(ply)
    end)
end
