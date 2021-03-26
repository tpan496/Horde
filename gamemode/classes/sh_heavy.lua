HORDE:CreateClass(
    HORDE.Class_Heavy,
    "+5 to maximum carrying capacity.\n\nRegenerate 1 armor per second, up to 25.\n\n",
    "Have full access to Machine Guns and heavier weapons.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [1] = {title = "Suppression", choices = {"heavy_sticky_compound", "heavy_crude_casing"}},
        [2] = {title = "Armor Protection", choices = {"heavy_liquid_armor", "heavy_reactive_armor"}},
        [3] = {title = "Technology", choices = {"heavy_nanomachine", "heavy_ballistic_shock"}},
    },
    2
)