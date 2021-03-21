HORDE:CreateClass(
    HORDE.Class_Ghost,
    "30% more headshot damage.\n\n",
    "Have access to sniper rifles and selected light weapons.\n\nHave access to suppressors and sniper scopes.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [1] = {title = "Tactics", choices = {
            {name = "Headhunter", perks = {["ghost_headhunter"] = {}}, icon="materials/perks/headhunter.png"},
            {name = "Sniper", perks = {["ghost_sniper"] = {}}, icon="materials/perks/sniper.png"},
        }},
        [2] = {title = "Reposition", choices = {
            {name = "Phase Walk", perks = {["ghost_phase_walk"] = {}}, icon="materials/perks/phase_walk.png"},
            {name = "Ghost Veil", perks = {["ghost_ghost_veil"] = {}}, icon="materials/perks/ghost_veil.png"},
        }},
        [3] = {title = "Disposal", choices = {
            {name = "Coup De Grace", perks = {["ghost_coup"] = {}}, icon="materials/perks/coup.png"},
            {name = "Decapacitate", perks = {["ghost_decapacitate"] = {}}, icon="materials/perks/decapacitate.png"},
        }},
    },
    5
)