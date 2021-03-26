HORDE:CreateClass(
    HORDE.Class_Survivor,
    "Have access to all weapons except for exclusive and special weapons.\n\nLimited access to attachments.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    "survivor_base",
    {
        [1] = {title = "Survival", choices = {"medic_antibiotics", "assault_charge"}},
        [2] = {title = "Improvise", choices = {"berserker_breathing_technique", "demolition_frag_cluster"}},
        [3] = {title = "Inspired Learning", choices = {"heavy_liquid_armor", "ghost_headhunter"}},
    },
    0
)