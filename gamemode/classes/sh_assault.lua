HORDE:CreateClass(
    HORDE.Class_Assault,
    "20% increased movement speed.\n\nGain Adrenaline when you kill an enemy, increasing damage and speed by 5%.\n\n",
    "Have full access to Rifles.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt() * 1.20,
    GetConVar("horde_base_runspeed"):GetInt() * 1.20,
    {
        [1] = {title = "Maneuver", choices = {"assault_ambush", "assault_charge"}},
        [2] = {title = "Adaptability", choices = {"assault_drain", "assault_overclock"}},
        [3] = {title = "Conditioning", choices = {"assault_heightened_reflex", "assault_cardiac_overload"}},
    },
    1
)