HORDE:CreateClass(
    HORDE.Class_Engineer,
    "100% increased minion health and damage.\n\n",
    "Turrets you build have 500 base health and deals 18 base damage.\n\nHave access to special weapons and equipment.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [1] = {title = "Tools", choices = {
            {name = "Repair Kit", perks = {["engineer_repair"] = {}}, icon="materials/perks/repair_kit.png"},
            {name = "Device Carrier", perks = {["engineer_carrier"] = {}}, icon="materials/perks/carrier.png"},
        }},
        [2] = {title = "Development", choices = {
            {name = "Berserk", perks = {["engineer_"] = {}}, icon="materials/perks/berserk.png"},
            {name = "Sentinel", perks = {["engineer_sentinel"] = {}}, icon="materials/perks/fortify.png"},
        }},
        [3] = {title = "Natural Selection", choices = {
            {name = "Cellular Implosion", perks = {["medic_cellular_implosion"] = {}}, icon="materials/perks/cellular_implosion.png"},
            {name = "Accelerated Healing Factor", perks = {["medic_xcele"] = {}}, icon="materials/perks/xcele.png"},
        }},
    },
    6
)