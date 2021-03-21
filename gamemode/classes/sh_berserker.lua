HORDE:CreateClass(
    HORDE.Class_Berserker,
    "20% increased global resistance.\n\n50% increased Poison resistance.\n\n",
    "Only has access to melee weapons.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {},
    7
)