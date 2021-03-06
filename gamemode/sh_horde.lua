CreateConVar("horde_default_enemy_config", 1, FCVAR_SERVER_CAN_EXECUTE, "Use default enemy wave config settings.")
CreateConVar("horde_default_item_config", 1, FCVAR_SERVER_CAN_EXECUTE, "Use default item config settings.")
CreateConVar("horde_default_class_config", 1, FCVAR_SERVER_CAN_EXECUTE, "Use default class config settings.")
CreateConVar("horde_max_wave", 10, FCVAR_SERVER_CAN_EXECUTE, "Max waves.")
CreateConVar("horde_break_time", 60, FCVAR_SERVER_CAN_EXECUTE, "Break time between waves.")
CreateConVar("horde_enable_shop", 1, FCVAR_SERVER_CAN_EXECUTE, "Enables shop menu or not.")
CreateConVar("horde_enable_client_gui", 1, FCVAR_SERVER_CAN_EXECUTE, "Enables client information ui or not.")
--CreateConVar("horde_enable_respawn", 0, FCVAR_SERVER_CAN_EXECUTE, "Players can respawn after death during a wave.")
CreateConVar("horde_max_spawn_distance", 2000, FCVAR_SERVER_CAN_EXECUTE, "Maximum enenmy respawn distance.")
CreateConVar("horde_min_spawn_distance", 400, FCVAR_SERVER_CAN_EXECUTE, "Minimum enenmy respawn distance.")
CreateConVar("horde_max_spawn_z_distance", 500, FCVAR_SERVER_CAN_EXECUTE, "Maximum enemy respawn height difference with players.")

CreateConVar("horde_start_money", 1000, FCVAR_SERVER_CAN_EXECUTE, "Money given at start.")
CreateConVar("horde_round_bonus", 500, FCVAR_SERVER_CAN_EXECUTE, "Round bonus given at the end of the round.")
CreateConVar("horde_enable_ammobox", 1, FCVAR_SERVER_CAN_EXECUTE, "Enable ammobox spawns.")
CreateConVar("horde_npc_cleanup", 1, FCVAR_SERVER_CAN_EXECUTE, "Kills all NPCs after a wave.")
CreateConVar("horde_enable_scoreboard", 1, FCVAR_SERVER_CAN_EXECUTE, "Enables built-in scoreboard.")
CreateConVar("horde_external_lua_config", "", FCVAR_SERVER_CAN_EXECUTE, "Name of external config to load. This will take over the configs if exists.")

CreateConVar("horde_director_interval", 5, FCVAR_SERVER_CAN_EXECUTE, "Game director execution interval in seconds. Decreasing this increases spawn rate.")
CreateConVar("horde_max_enemies_alive_base", 20, FCVAR_SERVER_CAN_EXECUTE, "Maximum number of living enemies (base).")
CreateConVar("horde_max_enemies_alive_scale_factor", 5, FCVAR_SERVER_CAN_EXECUTE, "Scale factor of the maximum number of living enemies for multiplayer.")
CreateConVar("horde_max_enemies_alive_max", 50, FCVAR_SERVER_CAN_EXECUTE, "Maximum number of maximum living enemies.")
CreateConVar("horde_corpse_cleanup", 0, FCVAR_SERVER_CAN_EXECUTE, "Remove corpses.")

CreateConVar("horde_base_walkspeed", 180, FCVAR_SERVER_CAN_EXECUTE, "Base walkspeed.")
CreateConVar("horde_base_runspeed", 220, FCVAR_SERVER_CAN_EXECUTE, "Base runspeed.")

CreateConVar("horde_difficulty", 0, FCVAR_SERVER_CAN_EXECUTE, "Difficulty.")
CreateConVar("horde_disable_difficulty_voting", 0, FCVAR_SERVER_CAN_EXECUTE, "Disable difficulty voting.")
CreateConVar("horde_endless", 0, FCVAR_SERVER_CAN_EXECUTE, "Endless.")
CreateConVar("horde_total_enemies_scaling", 0, FCVAR_SERVER_CAN_EXECUTE, "Forces the gamemode to multiply maximum enemy count by this.")

CreateConVar("horde_arccw_attinv_free", 0, FCVAR_SERVER_CAN_EXECUTE, "Free ArcCW attachments.")

if SERVER then
util.AddNetworkString("Horde_PlayerInit")
util.AddNetworkString("Horde_SyncItems")
util.AddNetworkString("Horde_SyncEnemies")
util.AddNetworkString("Horde_SyncClasses")
util.AddNetworkString("Horde_PlayerReadySync")
util.AddNetworkString("Horde_AmmoboxCountdown")
end

HORDE = {}
HORDE.__index = HORDE
HORDE.version = "1.0.2.0"
print("[HORDE] HORDE Version is " .. HORDE.version) -- Sanity check

HORDE.color_crimson = Color(220, 20, 60, 225)
HORDE.color_crimson_dim = Color(200, 0, 40)
HORDE.color_crimson_dark = Color(100,0,0)
HORDE.color_hollow = Color(40,40,40,225)
HORDE.color_hollow_dim = Color(80, 80, 80, 225)
HORDE.start_game = false
HORDE.total_enemies_per_wave = {15, 19, 23, 27, 30, 33, 36, 39, 42, 45}
-- HORDE.total_enemies_per_wave = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

-- Director
HORDE.difficulty = 1
HORDE.total_enemies_this_wave = 0
HORDE.alive_enemies_this_wave = 0
HORDE.killed_enemies_this_wave = 0
HORDE.current_wave = 0
HORDE.total_break_time = math.max(10, GetConVarNumber("horde_break_time"))
HORDE.current_break_time = HORDE.total_break_time

HORDE.max_spawn_distance = math.max(100, GetConVarNumber("horde_max_spawn_distance"))
HORDE.min_spawn_distance = math.max(100, GetConVarNumber("horde_min_spawn_distance"))
HORDE.max_enemies_alive = 20
HORDE.spawned_enemies = {}
HORDE.ai_nodes = {}
HORDE.found_ai_nodes = false
HORDE.enemy_spawn_z = 6
HORDE.min_base_enemy_spawns_per_think = 4
HORDE.max_base_enemy_spawns_per_think = 5
HORDE.spawn_radius = 75
HORDE.max_max_waves = 10
HORDE.max_waves = math.min(HORDE.max_max_waves, math.max(1, GetConVarNumber("horde_max_wave")))
HORDE.start_money = math.max(0, GetConVarNumber("horde_start_money"))
HORDE.total_enemies_this_wave_fixed = 0
HORDE.kill_reward_base = 90
HORDE.round_bonus_base = GetConVar("horde_round_bonus"):GetInt()
HORDE.game_ended = false

-- Ammobox
HORDE.ammobox_max_count_limit = 9
HORDE.ammobox_refresh_interval = 60
HORDE.enable_ammobox = GetConVar("horde_enable_ammobox"):GetInt()

-- Statistics
-- Keep track of entities separately, so we don't have to network entities across
-- the network.
HORDE.player_drop_entities = {}
HORDE.player_ready = {}
HORDE.player_damage = {}
HORDE.player_damage_taken = {}
HORDE.player_money_earned = {}
HORDE.player_headshots = {}
HORDE.player_elite_kills = {}
HORDE.player_vote_map_change = {}

-- Render / Gui
HORDE.render_highlight_disable = 0
HORDE.render_highlight_enemies = 1
HORDE.render_highlight_ammoboxes = 2
HORDE.enable_shop = GetConVarNumber("horde_enable_shop")
HORDE.difficulty_text = {"NORMAL", "HARD", "REALISM"}

-- Functions required on both sides
HORDE.GiveAmmo = function (ply, wpn, count)
    local clip_size = wpn:GetMaxClip1()
    local ammo_id = wpn:GetPrimaryAmmoType()

    if clip_size > 0 then -- block melee
        ply:GiveAmmo(clip_size * count, ammo_id, false)
        return true
    else
        -- Give 1 piece of this ammo since clip size do not apply
        local rpg_round = 8
        local smg1_grenade = 9
        local ar2altfire = 2
        local xbowbolt = 6
        local grenade = 10
        local slam = 11

        -- Some ammo type from mods
        local rust_syringe = 40
        if ammo_id == rpg_round or ammo_id == xbowbolt or ammo_id == smg1_grenade or ammo_id == ar2altfire or ammo_id == grenade or ammo_id == slam or ammo_id == rust_syringe then
            ply:GiveAmmo(count, ammo_id, false)
            return true
        end
    end
    return false
end

-- Why the fuck does lua not even have round function?
HORDE.Round2 = function(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

-- ArcCW Attachments
if GetConVar("horde_arccw_attinv_free"):GetInt() == 0 then
    RunConsoleCommand("arccw_attinv_free", "0")
else
    RunConsoleCommand("arccw_attinv_free", "1")
end