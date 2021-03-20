HORDE:CreateClass(
    HORDE.Class_Medic,
    "Regenerate 2% health per second.\n\n",
    "Have acesss to most light weapons and medic grenades.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [1] = {title = "Medicine", choices = {
            {name = "Antibiotics", perks = {["medic_antibiotics"] = {}}, icon="materials/perks/antibiotics.png"},
            {name = "Steroid", perks = {["medic_steroid"] = {}}, icon="materials/perks/steroid.png"},
        }},
        [2] = {title = "Bio-Engineering", choices = {
            {name = "Berserk", perks = {["medic_berserk"] = {}}, icon="materials/perks/fluid_armor.png"},
            {name = "Nanomachine", perks = {["heavy_nanomachine"] = {}}, icon="materials/perks/nanomachine.png"},
        }},
        [3] = {title = "Evolution", choices = {
            {name = "Decay", perks = {["heavy_vanguard"] = {}}, icon="materials/perks/vanguard.png"},
            {name = "Natural Selection", perks = {["medic_"] = {}}, icon="materials/perks/dominator.png"},
        }},
    },
    3
)