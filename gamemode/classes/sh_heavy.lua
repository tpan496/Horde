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
            {name = "Liquid Armor", perks = {["heavy_liquid_armor"] = {}}, icon="materials/perks/liquid_armor.png"},
            {name = "Reactive Armor", perks = {["heavy_reactive_armor"] = {}}, icon="materials/perks/reactive_armor.png"},
        }},
        [3] = {title = "Technology", choices = {
            {name = "Nanomachine", perks = {["heavy_nanomachine"] = {}}, icon="materials/perks/nanomachine.png"},
            {name = "Ballistic Shock", perks = {["heavy_ballistic_shock"] = {}}, icon="materials/perks/ballistic_shock.png"},
        }},
    },
    2
)