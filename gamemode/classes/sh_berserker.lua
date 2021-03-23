HORDE:CreateClass(
    HORDE.Class_Berserker,
    "20% increased global resistance.\n\n25% increased Poison resistance.\n\n",
    "Only has access to melee weapons.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [1] = {title = "Fundamentals", choices = {
            {name = "Breathing Technique", perks = {["berserker_breathing_technique"] = {}}, icon="materials/perks/breathing_technique.png"},
            {name = "Bloodlust", perks = {["berserker_bloodlust"] = {}}, icon="materials/perks/bloodlust.png"},
        }},
        [2] = {title = "Technique", choices = {
            {name = "Bushido", perks = {["berserker_bushido"] = {}}, icon="materials/perks/bushido.png"},
            {name = "Savagery", perks = {["berserker_savagery"] = {}}, icon="materials/perks/savagery.png"},
        }},
        [3] = {title = "Combat Arts", choices = {
            {name = "Mind's Eye", perks = {["berserker_mindeye"] = {}}, icon="materials/perks/mindeye.png"},
            {name = "Rip and Tear", perks = {["berserker_rip_and_tear"] = {}}, icon="materials/perks/rip_and_tear.png"},
        }},
    },
    7
)