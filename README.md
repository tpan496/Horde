# Horde Gamemode
## Workshop Link
## Creating Config Addons
Besides the client-side GUI configs, you can create lua config addons! You config addons should stay in `garrrysmod/your-config/lua/custom/your-config.lua`, and have the following (example) format:
```
CONFIG = {}
CONFIG.name = "custom_config"
CONFIG.items = {
    -- key and class must be the same
    weapon_crowbar = {
        class="weapon_crowbar",
        category="Melee",
        name="Cheap Crowbar",
        price=50, weight=1,
        description="A cheap crowbar",
        whitelist = {Medic=true, Assault=true, Heavy=true, Demolition=true, Survivor=true, Ghost=true},
        ammo_price=0,
        secondary_ammo_price=-1
    }
}

CONFIG.enemies = {
    -- key and name must be the same!
    HugeZombie = {
        name = "Huge Zombie",
        class = "npc_zombie",
        weight = 1,
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
