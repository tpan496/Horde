local EXPECTED_HEADER = "HordeAchievements"

HORDE.achievements_map = {}
HORDE.achievemnts_class = {}

local path
local strm

hook.Add("InitPostEntity", "Horde_PlayerInitAchievements", function()
    MySelf = LocalPlayer()
    EXPECTED_HEADER = util.SHA256("HordeAchievements" .. MySelf:SteamID())
    HORDE:CheckUpdate()
end)

HORDE.MapAchievements = {
    normal = "Normal Completion",
    hard = "Hard Completion",
    realism = "Realism Completion",
    nightmare = "Nightmare Completion",
    apocalypse = "Apocalpyse Completion",
    coop = "Coop Completion",
    horde = "Horde Completion",
    hardcore_horde = "Hardcore Completion",
    coop_horde = "Coop Horde Completion",
    hardcore_coop_horde = "Hardcore Coop Completion",
    endless_20 = "Endless Wave 20",
    endless_30 = "Endless Wave 30",
}

HORDE.MapAchievement_Descriptions = {
    [HORDE.MapAchievements.normal] = "Complete 10 waves on NORMAL difficulty.",
    [HORDE.MapAchievements.hard] = "Complete 10 waves on HARD difficulty.",
    [HORDE.MapAchievements.realism] = "Complete 10 waves on REALISM difficulty.",
    [HORDE.MapAchievements.nightmare] = "Complete 10 waves on NIGHTMARE difficulty.",
    [HORDE.MapAchievements.apocalypse] = "Complete 10 waves on APOCALYPSE difficulty.",
    [HORDE.MapAchievements.coop] = "Complete 10 waves with at least 4 players.",
    [HORDE.MapAchievements.horde] = "Complete 10 waves on NIGHTMARE difficulty with default config and settings.",
    [HORDE.MapAchievements.coop_horde] = "Complete 10 waves on NIGHTMARE difficulty with at least 4 players, default config and settings.",
    [HORDE.MapAchievements.hardcore_horde] = "Complete 10 waves on APOCALYPSE difficulty with default config and settings.",
    [HORDE.MapAchievements.hardcore_coop_horde] = "Complete 10 waves on APOCALYPSE difficulty with at least 4 players, default config and settings.",
    [HORDE.MapAchievements.endless_20] = "Complete 20 waves on Endless mode.",
    [HORDE.MapAchievements.endless_30] = "Complete 30 waves on Endless mode.",
}

function HORDE:GetMapAchievements(map)
    local count = 0
    local stats = HORDE.achievements_map[map]
    if not stats then return end
    local achievements = {}
    if stats.players and stats.players >= 4 then
        achievements[HORDE.MapAchievements.coop] = true
        count = count + 1
    end
    if stats.diffculty and stats.diffculty >= 1 then
        achievements[HORDE.MapAchievements.normal] = true
        count = count + 1
        if stats.diffculty >= 2 then
            achievements[HORDE.MapAchievements.hard] = true
            count = count + 1
            if stats.diffculty >= 3 then
                achievements[HORDE.MapAchievements.realism] = true
                count = count + 1
                if stats.diffculty >= 4 then
                    achievements[HORDE.MapAchievements.nightmare] = true
                    count = count + 1
                    if stats.diffculty >= 5 then
                        achievements[HORDE.MapAchievements.apocalypse] = true
                        count = count + 1
                        if stats.config >= 1 then
                            achievements[HORDE.MapAchievements.hardcore_horde] = true
                            count = count + 1
                            if stats.players_apocalypse and stats.players_apocalypse >= 4 then
                                achievements[HORDE.MapAchievements.hardcore_coop_horde] = true
                                count = count + 1
                            end
                        end
                    end
                    if stats.config >= 1 then
                        achievements[HORDE.MapAchievements.horde] = true
                        count = count + 1
                        if stats.players_nightmare and stats.players_nightmare >= 4 then
                            achievements[HORDE.MapAchievements.coop_horde] = true
                            count = count + 1
                        end
                    end
                end
            end
        end
    end
    if stats.wave and stats.wave >= 20 then
        achievements[HORDE.Achievements.endless_20] = true
        count = count + 1
        if stats.wave >= 30 then
            achievements[HORDE.Achievements.endless_30] = true
            count = count + 1
        end
    end

    -- get extra achievements
    local extra = stats.extra
    if extra then
        for extra_achievement, achieved in pairs(extra) do
            if achieved == 1 and not achievements[extra_achievement] then
                achievements[extra_achievement] = true
                count = count + 1
            end
        end
    end

    achievements["completion_count"] = count
    return achievements
end

function HORDE:SaveMapAchievements()
    if GetConVarNumber("horde_enable_sandbox") == 1 then return end
    if HORDE.current_wave < 10 then return end
    local map = game.GetMap()
    local ply = MySelf
    if not ply:IsValid() then return end

	if not file.IsDir("horde/achievements/", "DATA") then
		file.CreateDir("horde/achievements/", "DATA")
	end

    if not HORDE.achievements_map[map] then
        HORDE.achievements_map[map] = {}
    end

    local old_achievements = HORDE:GetMapAchievements(map)
    local count_old = old_achievements["completion_count"]
    if HORDE.achievements_map[map] then
        HORDE.achievements_map[map].diffculty = HORDE.achievements_map[map].diffculty or -1
        HORDE.achievements_map[map].players = HORDE.achievements_map[map].players or 0
        HORDE.achievements_map[map].config = HORDE.achievements_map[map].config or 0
        HORDE.achievements_map[map].wave = HORDE.achievements_map[map].wave or 0
        HORDE.achievements_map[map].extra = HORDE.achievements_map[map].extra or {}
        HORDE.achievements_map[map].players_nightmare = HORDE.achievements_map[map].players_nightmare or 0
        HORDE.achievements_map[map].players_apocalypse = HORDE.achievements_map[map].players_apocalypse or 0


        HORDE.achievements_map[map].diffculty = math.max(HORDE.achievements_map[map].diffculty, HORDE.CurrentDifficulty)
        HORDE.achievements_map[map].players = math.max(HORDE.achievements_map[map].players, #player.GetHumans())
        if HORDE.CurrentDifficulty >= 4 then
            HORDE.achievements_map[map].players_nightmare = math.max(HORDE.achievements_map[map].players_nightmare, #player.GetHumans())
        end
        if HORDE.CurrentDifficulty >= 5 then
            HORDE.achievements_map[map].players_apocalypse = math.max(HORDE.achievements_map[map].players_apocalypse, #player.GetHumans())
        end
        if GetConVarNumber("horde_default_item_config") == 1
        and GetConVarNumber("horde_default_class_config") == 1
        and GetConVarNumber("horde_default_enemy_config") == 1
        and GetConVarNumber("horde_start_money") <= 1000
        and GetConVarNumber("horde_round_bonus") <= 500
        and GetConVarNumber("horde_base_walkspeed") <= 180
        and GetConVarNumber("horde_base_runspeed") <= 220 then
            HORDE.achievements_map[map].config = 1
        else
            HORDE.achievements_map[map].config = math.max(0, HORDE.achievements_map[map].config)
        end
        HORDE.achievements_map[map].wave = math.max(HORDE.achievements_map[map].wave, HORDE.current_wave)
    end

    -- Grab extra achievements
    local achievements = ents.FindByClass("logic_horde_achievement")
    local extra = {}
    for _, ent in pairs(achievements) do
        if ent.Achievement and ent.Achievement ~= "" then
            extra[ent.Achievement] = HORDE.achievements_map[map].extra[ent.Achievement] or 0
            if ent.Description then
                HORDE.MapAchievement_Descriptions[ent.Achievement] = ent.Description
            end
        end
    end

    HORDE.achievements_map[map].extra = extra

	path = "horde/achievements/maps.txt"

	strm = file.Open(path, "wb", "DATA" )
		strm:Write(EXPECTED_HEADER)
        strm:Write(util.TableToJSON(HORDE.achievements_map))
	strm:Close()

    local new_achievements = HORDE:GetMapAchievements(map)
    local count_new = new_achievements["completion_count"]
    if count_new > count_old then
        local str = "You have unlocked new achievements for " .. map .. "! Press F2 to view."
        HORDE:PlayNotification(str)
    end
end

function HORDE:ActivateExtraMapAchievement(map, achievement)
    HORDE:LoadMapAchievements()
    if HORDE.achievements_map[map].extra[achievement] and HORDE.achievements_map[map].extra[achievement] == 1 then return end
    HORDE.achievements_map[map].extra[achievement] = 1
    HORDE:SaveMapAchievements()
end

HORDE.has_new_update = nil
function HORDE:CheckUpdate()
    path = "horde/achievements/update.txt"
    if not file.IsDir("horde/achievements/", "DATA") then
		file.CreateDir("horde/achievements/", "DATA")
        HORDE.has_new_update = true
        RunConsoleCommand("horde_stats")
        strm = file.Open(path, "wb", "DATA" )
            strm:Write(HORDE.version)
        strm:Close()
        return
	end

    if file.Exists(path, "DATA") == false then
        HORDE.has_new_update = true
        RunConsoleCommand("horde_stats")
        strm = file.Open(path, "wb", "DATA" )
            strm:Write(HORDE.version)
        strm:Close()
    else
        strm = file.Open(path, "rb", "DATA" )
		local header = strm:Read(#HORDE.version)
        if header ~= HORDE.version then
            HORDE.has_new_update = true
            RunConsoleCommand("horde_stats")
            strm:Close()

            strm = file.Open(path, "wb", "DATA" )
                strm:Write(HORDE.version)
            strm:Close()
        end
        strm:Close()
    end
end

function HORDE:SaveClassAchievemnts()
    local class = ply:Horde_GetClass().name
    local difficulty = HORDE.CurrentDifficulty
    local ply = MySelf
    if not ply:IsValid() then return end

	if not file.IsDir("horde/achievements/classes", "DATA") then
		file.CreateDir("horde/achievements/classes", "DATA")
	end

    if HORDE.achievemnts_class[class] then
        if HORDE.achievemnts_class[class][difficulty] then return end
        HORDE.achievemnts_class[class][difficulty] = true
    else
        HORDE.achievemnts_class[class] = {}
        HORDE.achievemnts_class[class][difficulty] = true
    end

	path = "horde/achievements/classes.txt"

	strm = file.Open(path, "wb", "DATA" )
		strm:Write(EXPECTED_HEADER)
        strm:WriteString(util.TableToJSON(HORDE.achievemnts_class))
	strm:Close()
end

function HORDE:LoadMapAchievements()
    local ply = MySelf
    if not ply:IsValid() then return end

	if not file.IsDir("horde/achievements/", "DATA") then
		file.CreateDir("horde/achievements/", "DATA")
        return
	end

	path = "horde/achievements/maps.txt"
    if file.Exists(path, "DATA") == false then
        strm = file.Open(path, "wb", "DATA" )
            strm:Write(EXPECTED_HEADER)
            strm:Write(util.TableToJSON(HORDE.achievements_map))
        strm:Close()
    end

	strm = file.Open(path, "rb", "DATA" )
		local header = strm:Read(#EXPECTED_HEADER)
        local f = strm:Read()
        if header == EXPECTED_HEADER then
            if f then
                HORDE.achievements_map = util.JSONToTable(f)
            end
        else
            HORDE.achievements_map = {}
            HORDE.achievements_map[game.GetMap()] = {}
            HORDE.achievements_map[game.GetMap()]["extra"] = {}
        end
	strm:Close()
end

function HORDE:LoadClassAchievements()
    local ply = MySelf
    if not ply:IsValid() then return end

	if not file.IsDir("horde/achievements/classes", "DATA") then
		file.CreateDir("horde/achievements/classes", "DATA")
        return
	end

	path = "horde/achievements/classes" .. HORDE:ScrubSteamID(ply) .. ".txt"

	strm = file.Open(path, "wb", "DATA" )
		local header = strm:Read(EXPECTED_HEADER)
        if header == EXPECTED_HEADER then
            HORDE.achievemnts_class = util.JSONToTable(strm:ReadString())
        else
            return
        end
	strm:Close()
end

net.Receive("Horde_SaveAchievements", function ()
    HORDE:LoadMapAchievements()
    HORDE:SaveMapAchievements()
    --HORDE:SaveClassAchievemnts()
end)

net.Receive("Horde_SaveExtraAchievements", function ()
    local achievement = net.ReadString()
    HORDE:ActivateExtraMapAchievement(game.GetMap(), achievement)
    --HORDE:SaveClassAchievemnts()
end)

HORDE.map_achievement_whitelisted = {
    "zs_heat",
    "hr_mobius",
    "hr_desolate",
    "zs_antarctic_hospital",
    "gm_fogisland",
    "de_stad",
    "hr_shipment",
    "gm_nuketown",
    "zs_sludge",
    "hr_swamp",
    "gm_csgoagency",
    "gm_csgohalocrater",
    "hr_secluded",
    "kf2_abandoned_labs_v2",
    "gm_dumpit",
    "zs_deviations",
    "gm_csgoinsertion",
    "zs_snowedin",
    "gm_breach",
    "zs_closure",
    "hr_dust2",
    "hr_test_labs_v2",
    "gm_memory",
    "gm_last",
    "zs_blighted",
    "hr_metro_bunker",
    "hr_brickcircumstance",
    "hr_bloodshedmall",
    "hr_concrete",
    "hr_raunchierhouse_8",
    "hr_tf2_well",
    "hr_tuscan",
    "de_mentalhospital_beta",
}

table.sort(HORDE.map_achievement_whitelisted, function(a, b)
    return a < b
end)
