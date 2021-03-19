HORDE:CreateClass(
    "Ghost",
    "50% increased headshot damage.\n\n",
    "Increased headshot damage applies to headshot-immune enemies.\n\nHave access to sniper rifles and selected light weapons.\n\nHave access to suppressors and sniper scopes.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [1] = {title = "Mindset", choices = {
            {name = "Headhunter", perks = {["ghost_headhunter"] = {}}},
            {name = "Headhunter", perks = {["ghost_headhunter"] = {}}},
        }},
    }
)