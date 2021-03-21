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
            {name = "Berserk", perks = {["medic_berserk"] = {}}, icon="materials/perks/berserk.png"},
            {name = "Fortify", perks = {["medic_fortify"] = {}}, icon="materials/perks/fortify.png"},
        }},
        [3] = {title = "Natural Selection", choices = {
            {name = "Cellular Implosion", perks = {["medic_cellular_implosion"] = {}}, icon="materials/perks/cellular_implosion.png"},
            {name = "Accelerated Healing Factor", perks = {["medic_xcele"] = {}}, icon="materials/perks/xcele.png"},
        }},
    },
    3
)