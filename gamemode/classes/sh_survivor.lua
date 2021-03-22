HORDE:CreateClass(
    HORDE.Class_Survivor,
    "No bonus.\n\n",
    "Have access to all weapons except for exclusive and special weapons.\n\nLimited access to attachments.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [1] = {title = "Survival", choices = {
            {name = "Antibiotics", perks = {["medic_antibiotics"] = {}}, icon="materials/perks/antibiotics.png"},
            {name = "Charge", perks = {["assault_charge"] = {}}, icon="materials/perks/charge.png"},
        }},
        [2] = {title = "Improvise", choices = {
            {name = "Breathing Technique", perks = {["berserker_breathing_technique"] = {}}, icon="materials/perks/breathing_technique.png"},
            {name = "Cluster Bombs", perks = {["demolition_frag_cluster"] = {}}, icon="materials/perks/frag_cluster.png"},
        }},
        [3] = {title = "Inspired Learning", choices = {
            {name = "Liquid Armor", perks = {["heavy_liquid_armor"] = {}}, icon="materials/perks/nanomachine.png"},
            {name = "Headhunter", perks = {["ghost_headhunter"] = {}}, icon="materials/perks/headhunter.png"},
        }},
    },
    0
)