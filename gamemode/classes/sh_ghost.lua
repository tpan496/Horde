HORDE:CreateClass(
    HORDE.Class_Ghost,
    "Have access to sniper rifles and selected light weapons.\n\nHave access to suppressors and sniper scopes.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    "ghost_base",
    {
        [1] = {title = "Tactics", choices = {"ghost_headhunter", "ghost_sniper"}},
        [2] = {title = "Reposition", choices = {"ghost_phase_walk", "ghost_ghost_veil"}},
        [3] = {title = "Disposal", choices = {"ghost_coup", "ghost_decapacitate"}},
    },
    5
)