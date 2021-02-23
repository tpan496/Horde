# Horde Gamemode
## Workshop Link
https://steamcommunity.com/sharedfiles/filedetails/?id=2401598805
## Full Console Command List
Client:
- horde_shop: Console variant for !shop.
- horde_ready: Console variant for !ready.
- horde_drop_weapon: Console variant for !drop.
- horde_drop_money: Console variant for !donate.
- horde_item_config: Console variant for !itemconfig.
- horde_enemy_config: Console variant for !enemyconfig.
- horde_class_config: Console variant for !classconfig.
- horde_start: Console variant for !start.
- horde_enable_halo(0/1): Enable highlight for last 10 enemies. 1 by default.

Server:
You need to change these BEFORE your game/server starts to take effect.
- horde_default_enemy_config(0/1) - Use default enemy wave config settings. 1 by default.
- horde_default_item_config(0/1) - Use default item config settings. 1 by default.
- horde_default_class_config(0/1) - Use default class config settings. 1 by default.
- horde_external_lua_config("") - Name of the lua config file to use. Leave this empty if you do not have one.

- horde_max_wave(1-10) - Max waves. 10 by default.
- horde_break_time(10-60) - Break time between waves. 60 by default.
- horde_enable_shop(0/1) - Enables shop menu or not. 1 by default.
- horde_enable_client_gui(0/1) - Enables client information ui or not. 1 by default.
- horde_start_money - Money given at start. 1000 by default.
- horde_npc_cleanup(0/1) - Kills all NPCs after a wave. 1 by default.
- horde_enable_scoreboard(0/1) - Enables built-in scoreboard. 1 by default.
- horde_base_player_walkspeed - Base walkspeed. 180 by default.
- horde_base_player_runspeed - Base runspeed. 220 by default.
- horde_enable_sandbox(0/1) - Enable sandbox/cheat features or not. 0 by default.

Change these with caution:
- horde_difficulty(0/1/2) - Difficulty. 0 by default. *experimental*
- horde_max_spawn_distance - Maximum enemy respawn distance. 2000 by default.
- horde_min_spawn_distance - Minimum enemy respawn distance. 500 by default.
- horde_max_spawn_z_distance - Maximum enemy respawn height difference from players. 500 by default. If your map is huge and enemies spawn in extreme positions, turn this smaller.

- horde_director_interval - How often the game director checks the state of the game (e.g. spawns stuff) in seconds. Default is 5.

- True maximum number of enemies alive = Minimum of (Max, Base + Scale Factor * PlayerCount)
- horde_max_enemies_alive_base - Base. Default is 20.
- horde_max_enemies_alive_scale_factor - Scale factor. Default is 5.
- horde_max_enemies_alive_max - Max. Default is 50.

## Creating Config Addons
Besides the client-side GUI configs, you can create lua config addons! This allows you to create multiple configurations easily.

You config addons should stay in `garrysmod/addons/your-config/lua/horde/gamemode/custom`, and have the following (example) format:
```
-- Example your-custom-config.lua
-- If you just want to configure items, leave enemies as empty. Vice versa.

CONFIG = {}
CONFIG.name = "custom_config" -- YOU MUST NAME IT! Used for horde_external_lua_config.
CONFIG.items = {
    -- key and class must be the same!
    weapon_crowbar = {
        class="weapon_crowbar",
        category="Melee", -- You can find out the full list in !itemconfig
        name="Cheap Crowbar",
        price=50, weight=1,
        description="A cheap crowbar",
        whitelist = {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true},
        ammo_price=0,           -- Leave it as 0 if it does not have primary ammo
        secondary_ammo_price=-1 -- Leave it as -1 if it does not have secondary ammo
    }
}

CONFIG.enemies = {
    -- key and name must be the same!
    HugeZombie = {
        name = "Huge Zombie",
        class = "npc_zombie",
        weight = 1, -- Relative weight to other enemies in the same wave.
        wave = 1,
        is_elite = true,
        health_scale = 2,
        damage_scale = 1,
        reward_scale = 100,
        model_scale = 2,
        color = Color(0,255,0),
        weapon = ""
    }
}
```
To use your config, simply set `horde_external_lua_config` to the name you used for the config (`CONFIG.name`). You can also do that directly in the gmod start menu.

## Dedicated Server Instructions

As you might already know there are two ways of setting up configs:
1. Client UI. To use this on a dedicated server, you need to put
```
horde_default_item_config = 0
horde_default_enemy_config = 0
```
In `autoexec.cfg` and `server.cfg`. Then you can edit stuff in your shop. A quick way to setup the config is just to put your `item.txt` or `enemy.txt` into your server's `data` folder.

2. Lua Scripting, as shown above.
