# Horde Gamemode
## Workshop Link
https://steamcommunity.com/sharedfiles/filedetails/?id=2401598805
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
