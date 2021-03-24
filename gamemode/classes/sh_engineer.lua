HORDE:CreateClass(
    HORDE.Class_Engineer,
    "50% increased minion health and damage.\n\n",
    "Turrets you build have 500 base health and deals 18 base damage.\n\nHave access to special weapons and equipment.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [1] = {title = "Clockwork", choices = {
            {name = "Tinkerer", perks = {["engineer_tinkerer"] = {}}, icon="materials/perks/tinkerer.png"},
            {name = "Manhack", perks = {["engineer_manhack"] = {}}, icon="materials/perks/manhack.png"},
        }},
        [2] = {title = "Prototype", choices = {
            {name = "Golem", perks = {["engineer_golem"] = {}}, icon="materials/perks/golem.png"},
            {name = "Spectre", perks = {["engineer_spectre"] = {}}, icon="materials/perks/spectre.png"},
        }},
        [3] = {title = "Extension", choices = {
            {name = "Symbiosis", perks = {["engineer_symbiosis"] = {}}, icon="materials/perks/symbiosis.png"},
            {name = "Kamikaze", perks = {["engineer_kamikaze"] = {}}, icon="materials/perks/volatile_dead.png"},
        }},
    },
    6
)