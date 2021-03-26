HORDE:CreateClass(
    HORDE.Class_Berserker,
    "Only has access to melee weapons.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    "berserker_base",
    {
        [1] = {title = "Fundamentals", choices = {"berserker_breathing_technique", "berserker_bloodlust"}},
        [2] = {title = "Technique", choices = {"berserker_bushido", "berserker_savagery"}},
        [3] = {title = "Combat Arts", choices = {"berserker_mindeye", "berserker_rip_and_tear"}},
    },
    7
)