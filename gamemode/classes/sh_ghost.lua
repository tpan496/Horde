HORDE:CreateClass(
    HORDE.Class_Ghost,
    "30% more headshot damage.\n\nCrouch to activate Camoflague, granting 15% evasion.\n\nRunning or jumping removes Camoflague.",
    "Have access to sniper rifles and selected light weapons.\n\nHave access to suppressors and sniper scopes.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [1] = {title = "Tactics", choices = {"ghost_headhunter", "ghost_sniper"}},
        [2] = {title = "Reposition", choices = {"ghost_phase_walk", "ghost_ghost_veil"}},
        [3] = {title = "Disposal", choices = {"ghost_coup", "ghost_decapacitate"}},
    },
    5
)