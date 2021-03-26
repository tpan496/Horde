HORDE:CreateClass(
    HORDE.Class_Engineer,
    "50% increased minion health and damage.\n\n",
    "Turrets you build have 500 base health and deals 18 base damage.\n\nHave access to special weapons and equipment.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [1] = {title = "Clockwork", choices = {"engineer_tinkerer", "engineer_manhack"}},
        [2] = {title = "Prototype", choices = {"engineer_golem", "engineer_spectre"}},
        [3] = {title = "Extension", choices = {"engineer_symbiosis", "engineer_kamikaze"}},
    },
    6
)