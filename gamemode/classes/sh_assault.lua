HORDE:CreateClass(
    "Assault",
    "25% increased movement speed.\n\n",
    "Have full access to Rifles.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt() * 1.25,
    GetConVar("horde_base_runspeed"):GetInt() * 1.25,
    {L = "25% chance to not consume ammo while firing.",
    R = "Each enemy you kill grants you 1 Frenzy charge.\nEach frenzy charge increases your damage and movespeed by 6%."}
)