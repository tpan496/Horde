HORDE:CreateClass(
    HORDE.Class_Assault,
    "Have full access to Rifles.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt() * 1.20,
    GetConVar("horde_base_runspeed"):GetInt() * 1.20,
    "assault_base",
    {
        [1] = {title = "Maneuver", choices = {"assault_ambush", "assault_charge"}},
        [2] = {title = "Adaptability", choices = {"assault_drain", "assault_overclock"}},
        [3] = {title = "Conditioning", choices = {"assault_heightened_reflex", "assault_cardiac_overload"}},
    },
    1
)