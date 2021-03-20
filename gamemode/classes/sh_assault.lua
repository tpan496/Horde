HORDE:CreateClass(
    HORDE.Class_Assault,
    "20% increased movement speed.\n\nGain Adrenaline when you kill an enemy, increasing damage and speed by 5%.\n\n",
    "Have full access to Rifles.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt() * 1.20,
    GetConVar("horde_base_runspeed"):GetInt() * 1.20,
    {
        [1] = {title = "Maneuver", choices = {
            {name = "Ambush", perks = {["assault_ambush"] = {}}, icon="materials/perks/ambush.png"},
            {name = "Charge", perks = {["assault_charge"] = {}}, icon="materials/perks/charge.png"},
        }},
        [2] = {title = "Adaptability", choices = {
            {name = "Drain", perks = {["assault_drain"] = {}}, icon="materials/perks/drain.png"},
            {name = "Overclock", perks = {["assault_overclock"] = {}}, icon="materials/perks/overclock.png"},
        }},
        [3] = {title = "Conditioning", choices = {
            {name = "Hightened Reflex", perks = {["assault_heightened_reflex"] = {}}, icon="materials/perks/heightened_reflex.png"},
            {name = "Cardiac Overload", perks = {["assault_cardiac_overload"] = {}}, icon="materials/perks/cardiac_overload.png"},
        }},
    },
    1
)