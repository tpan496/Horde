local EXPECTED_HEADER = "Horde_Rank"

local function ScrubSteamID(ply)
	return ply:SteamID():gsub(":", "_")
end

function HORDE:SaveRank(ply)
	if GetConVar("horde_enable_rank"):GetInt() == 0 then return end
	local path, strm

	if not file.IsDir("horde/ranks", "DATA") then
		file.CreateDir("horde/ranks", "DATA")
	end

	path = "horde/ranks/" .. ScrubSteamID(ply) .. ".txt"

	strm = file.Open(path, "wb", "DATA" )
		strm:Write(EXPECTED_HEADER)
        for name, class in pairs(HORDE.classes) do
            strm:WriteShort(class.order)
            strm:WriteLong(ply:Horde_GetExp(name))
			strm:WriteShort(ply:Horde_GetLevel(name))
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
				local exp = strm:ReadLong()
				local level = strm:ReadShort()
				if order == nil then
				else
					local class_name = HORDE.order_to_class_name[order]
					ply:Horde_SetLevel(class_name, level)
					ply:Horde_SetExp(class_name, exp)
				end
            end
		else
			for _, class in pairs(HORDE.classes) do
				ply:Horde_SetLevel(class.name, 0)
                ply:Horde_SetExp(class.name, 0)
            end
		end
	strm:Close()
end

if GetConVar("horde_enable_sandbox"):GetInt() == 0 and GetConVar("horde_enable_rank"):GetInt() == 1 then
	hook.Add("Horde_OnEnemyKilled", "Horde_GiveExp", function(victim, killer, wpn)
		if HORDE.current_wave <= 0 or GetConVar("sv_cheats"):GetInt() == 1 then return end
		if killer:IsPlayer() then
			local class_name = killer:Horde_GetClass().name
			if killer:Horde_GetLevel(class_name) >= HORDE.max_level then return end
			if victim:GetVar("is_elite") then
				killer:Horde_SetExp(class_name, killer:Horde_GetExp(class_name) + 2)
			else
				killer:Horde_SetExp(class_name, killer:Horde_GetExp(class_name) + 1)
			end
		end
	end)
end
