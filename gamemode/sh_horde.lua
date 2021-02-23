CreateConVar("horde_default_enemy_config", 1, SERVER_CAN_EXECUTE, "Use default enemy wave config settings.")
CreateConVar("horde_default_item_config", 1, SERVER_CAN_EXECUTE, "Use default item config settings.")
CreateConVar("horde_default_class_config", 1, SERVER_CAN_EXECUTE, "Use default class config settings.")
CreateConVar("horde_max_wave", 10, SERVER_CAN_EXECUTE, "Max waves." )
CreateConVar("horde_difficulty", 0, SERVER_CAN_EXECUTE, "Difficulty.")
CreateConVar("horde_break_time", 60, SERVER_CAN_EXECUTE, "Break time between waves.")
CreateConVar("horde_enable_shop", 1, SERVER_CAN_EXECUTE, "Enables shop menu or not.")
CreateConVar("horde_enable_client_gui", 1, SERVER_CAN_EXECUTE, "Enables client information ui or not.")
--CreateConVar("horde_enable_respawn", 0, SERVER_CAN_EXECUTE, "Players can respawn after death during a wave.")
CreateConVar("horde_max_spawn_distance", 2000, SERVER_CAN_EXECUTE, "Maximum enenmy respawn distance.")
CreateConVar("horde_min_spawn_distance", 500, SERVER_CAN_EXECUTE, "Minimum enenmy respawn distance.")
CreateConVar("horde_start_money", 1000, SERVER_CAN_EXECUTE, "Money given at start.")
CreateConVar("horde_npc_cleanup", 1, SERVER_CAN_EXECUTE, "Kills all NPCs after a wave.")
CreateConVar("horde_enable_scoreboard", 1, SERVER_CAN_EXECUTE, "Enables built-in scoreboard.")
CreateConVar("horde_external_lua_config", "", SERVER_CAN_EXECUTE, "Name of external config to load. This will take over the configs if exists.")

CreateConVar("horde_director_interval", 5, SERVER_CAN_EXECUTE, "Game director execution interval in seconds. Decreasing this increases spawn rate.")
CreateConVar("horde_max_enemies_alive_base", 20, SERVER_CAN_EXECUTE, "Maximum number of living enemies (base).")
CreateConVar("horde_max_enemies_alive_scale_factor", 5, SERVER_CAN_EXECUTE, "Scale factor of the maximum number of living enemies for multiplayer.")
CreateConVar("horde_max_enemies_alive_max", 50, SERVER_CAN_EXECUTE, "Maximum number of maximum living enemies.")

CreateConVar("horde_base_walkspeed", 180, SERVER_CAN_EXECUTE, "Base walkspeed.")
CreateConVar("horde_base_runspeed", 220, SERVER_CAN_EXECUTE, "Base runspeed.")

if SERVER then
util.AddNetworkString("Horde_SyncItems")
util.AddNetworkString("Horde_SyncEnemies")
util.AddNetworkString("Horde_SyncClasses")
end

HORDE = {}
HORDE.__index = HORDE
HORDE.version = "1.0.0.1"
print("[HORDE] HORDE Version is 1.0.0.1") -- Sanity check

HORDE.color_crimson = Color(220, 20, 60, 225)
HORDE.color_crimson_dim = Color(200, 0, 40)
HORDE.color_crimson_dark = Color(100,0,0)
HORDE.color_hollow = Color(40,40,40,225)
HORDE.start_game = false
HORDE.total_enemies_per_wave = {15, 19, 23, 27, 30, 33, 36, 39, 42}
HORDE.total_enemies_this_wave = 0
HORDE.alive_enemies_this_wave = 0
HORDE.killed_enemies_this_wave = 0
HORDE.current_wave = 0
HORDE.total_break_time = math.max(10, GetConVarNumber("horde_break_time"))
HORDE.first_break_time = 10
HORDE.current_break_time = HORDE.first_break_time
HORDE.max_spawn_distance = math.max(100, GetConVarNumber("horde_max_spawn_distance"))
HORDE.min_spawn_distance = math.max(100, GetConVarNumber("horde_min_spawn_distance"))
HORDE.max_enemies_alive = 20
HORDE.spawned_enemies = {}
HORDE.ai_nodes = {}
HORDE.found_ai_nodes = false
HORDE.enemy_spawn_z = 6
HORDE.player_ready = {}
HORDE.max_waves = math.min(10, math.max(1, GetConVarNumber("horde_max_wave")))
HORDE.difficulty = math.min(2, math.max(0, GetConVarNumber("horde_difficulty")))
HORDE.enable_shop = GetConVarNumber("horde_enable_shop")
HORDE.start_money = math.max(0, GetConVarNumber("horde_start_money"))
HORDE.total_enemies_this_wave_fixed = 0
HORDE.kill_reward_base = 100

-- Statistics
HORDE.player_damage = {}
HORDE.player_damage_taken = {}
HORDE.player_money_earned = {}
HORDE.player_headshots = {}
HORDE.player_elite_kills = {}