HORDE:CreateClass(
    "Survivor",
    "No bonus.\n\n",
    "Have access to all weapons except for exclusive and special weapons.\n\nLimited access to attachments.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [1] = {title = "Mindset", choices = {
            {name = "Live to Fight", perks = {["resistance_all"] = {percent = 0.2}}},
            {name = "Fight to Live", perks = {["damage_bonus_all"] = {percent = 0.2}}},
        }},
        [2] = {title = "Strategy", choices = {
            {name = "Lead Down Range", perks = {["damage_bonus_bullet"] = {percent = 0.25}}},
            {name = "Fire And Brimstone", perks = {["damage_bonus_fire"] = {percent = 0.5}, ["damage_bonus_blast"] = {percent = 0.3}}},
        }},
    }
)