HORDE:CreateClass(
    "Heavy",
    "+5 to maximum carrying capacity.\n\nRegenerate 1 armor per second, up to 25.\n\n",
    "Have full access to Machine Guns and heavier weapons.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [2] = {title = "Shotgun Munitions", choices = {
            {name = "Salvo", perks = {["arccw_shotgun_damage"] = {}}},
            {name = "Punch", perks = {["arccw_shotgun_penetration"] = {}}},
        }},
        [3] = {title = "Magazine Mods", choices = {
            {name = "Loaded", perks = {["arccw_mg_magazine"] = {}}},
            {name = "Agile", perks = {["arccw_mg_reload"] = {}}},
        }},
    }
)