HORDE:CreateClass(
    HORDE.Class_Heavy,
    "+5 to maximum carrying capacity.\n\nRegenerate 1 armor per second, up to 25.\n\n",
    "Have full access to Machine Guns and heavier weapons.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [1] = {title = "Suppression", choices = {
            {name = "Sticky Compound", perks = {["heavy_sticky_compound"] = {}}, icon="materials/perks/sticky_compound.png"},
            {name = "Crude Casing", perks = {["heavy_crude_casing"] = {}}, icon="materials/perks/crude_casing.png"},
        }},
        [2] = {title = "Armor Protection", choices = {
            {name = "Fluid Armor", perks = {["heavy_fluid_armor"] = {}}, icon="materials/perks/fluid_armor.png"},
            {name = "Nanomachine", perks = {["heavy_nanomachine"] = {}}, icon="materials/perks/nanomachine.png"},
        }},
        [3] = {title = "Psychology", choices = {
            {name = "Vanguard", perks = {["heavy_vanguard"] = {}}, icon="materials/perks/vanguard.png"},
            {name = "Dominator", perks = {["heavy_dominator"] = {}}, icon="materials/perks/dominator.png"},
        }},
    },
    2
)