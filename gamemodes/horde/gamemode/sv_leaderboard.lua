util.AddNetworkString("Horde_SyncTopTen")
util.AddNetworkString("Horde_SyncLeaderBoard")
-- 1={name, steamid, level}
HORDE.top_tens = {}
local EXPECTED_HEADER = "Horde_Stats"

function HORDE:TryAddTopTen(ply)
    local level = ply:Horde_GetLevel(ply:Horde_GetCurrentSubclass())
    for l, p in pairs(HORDE.top_tens) do
        if p.steamid == ply:SteamID64() then
            if level > l then
                HORDE.top_tens[l] = nil
                break
            else
                return
            end
        end
    end
    if table.Count(HORDE.top_tens) < 10 then
        HORDE.top_tens[level] = {steamid=ply:SteamID64(), class=ply:Horde_GetCurrentSubclass()}
        net.Start("Horde_SyncTopTen")
            net.WriteString(util.TableToJSON(HORDE.top_tens))
        net.Broadcast()
        HORDE:SaveTopTen()
        return true
    else
        for l, obj in pairs(HORDE.top_tens) do
            if l < level then
                HORDE.top_tens[l] = nil
                HORDE.top_tens[level] = {steamid=ply:SteamID64(), class=ply:Horde_GetCurrentSubclass()}
                HORDE:SaveTopTen()
                return true
            end
        end
    end
end

function HORDE:SaveTopTen()
	if GetConVar("horde_enable_rank"):GetInt() == 0 then return end

	local path, strm

	if not file.IsDir("horde/stats", "DATA") then
		file.CreateDir("horde/stats", "DATA")
	end

	path = "horde/stats/top_ten.txt"

	strm = file.Open(path, "wb", "DATA" )
		strm:Write(EXPECTED_HEADER)
        for level, obj in pairs(HORDE.top_tens) do
            strm:WriteULong(level)
            strm:WriteULong(HORDE.subclass_name_to_crc[obj.class])
            local s = util.SteamIDFrom64(obj.steamid)
            strm:WriteULong(string.len(s))
            strm:Write(s)
        end
	strm:Close()
end

function HORDE:LoadTopTen()
	if GetConVar("horde_enable_rank"):GetInt() == 0 then return end

	local path, strm

	if not file.IsDir("horde/stats", "DATA") then
		file.CreateDir("horde/stats", "DATA")
        return
	end

	path = "horde/stats/top_ten.txt"

	strm = file.Open(path, "rb", "DATA")
    if not strm then return end
    local header = strm:Read(#EXPECTED_HEADER)

    if header == EXPECTED_HEADER then
        for i = 1, 10 do
            local level = strm:ReadULong()
            local class_o = strm:ReadULong()
            if not class_o then break end
            local class =  HORDE.order_to_subclass_name[tostring(class_o)]
            local steamid_len = strm:ReadULong()
            if not steamid_len then break end
            local steamid = strm:Read(steamid_len)
            local steamid64 = util.SteamIDTo64(steamid)
            HORDE.top_tens[level] = {steamid=steamid64, class=class}
        end
    end
	strm:Close()

    local has_steam_id = {}
    for level, ply in SortedPairs(HORDE.top_tens, true) do
        if has_steam_id[ply.steamid] then
            HORDE.top_tens[level] = nil
        else
            has_steam_id[ply.steamid] = true
        end
    end
end

HORDE:LoadTopTen()
timer.Simple(5, function ()
    net.Start("Horde_SyncTopTen")
        net.WriteString(util.TableToJSON(HORDE.top_tens))
    net.Broadcast()
end)