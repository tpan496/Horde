local EXPECTED_HEADER = "Horde_Rank"

local function ScrubSteamID(ply)
	return ply:SteamID():gsub(":", "_")
end

function HORDE:SaveRank(ply)
	if GetConVar("horde_enable_rank"):GetInt() == 0 then return end
	local path, strm

	if not file.IsDir("horde", "DATA") then
		file.CreateDir("horde/ranks", "DATA")
	end

	path = "horde/ranks/" .. ScrubSteamID(ply) .. ".txt"

	strm = file.Open(path, "wb", "DATA" )
		strm:Write(EXPECTED_HEADER)
        for name, class in pairs(HORDE.classes) do
            strm:WriteShort(class.order)
            strm:WriteLong(ply:Horde_GetExp(name))
        end
	strm:Close()
end

function HORDE:LoadRank(ply)
	if GetConVar("horde_enable_rank"):GetInt() == 0 then return end
	local path, strm

	if not file.IsDir("horde/ranks", "DATA") then
		file.CreateDir("horde/ranks", "DATA")
	end

	path = "horde/ranks/" .. ScrubSteamID(ply) .. ".txt"

	if not file.Exists(path, "DATA") then
		print("Path", path, "does not exist!")
		return
	end

	strm = file.Open(path, "rb", "DATA")
		local header = strm:Read(#EXPECTED_HEADER)

		if header == EXPECTED_HEADER then
			for _, _ in pairs(HORDE.classes) do
                local order = strm:ReadShort()
                ply:Horde_SetExp(strm:ReadLong(HORDE.order_to_class_name[order]))
            end
		else
			for _, _ in pairs(HORDE.classes) do
                ply:Horde_SetExp(0)
            end
		end
	strm:Close()
end

if GetConVar("horde_enable_rank"):GetInt() == 1 then
    timer.Create("Horde_Rank_Autosave", 30, 0, function( )
        for _, ply in pairs(player.GetHumans()) do
            if not ply:IsValid() then goto cont end
            HORDE:SaveRank(ply)
            ::cont::
        end
    end)
end