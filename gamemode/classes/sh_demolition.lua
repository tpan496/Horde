HORDE:CreateClass(
    HORDE.Class_Demolition,
    "75% less explosive damage taken.\n\nRegenerate 1 frag grenade every 30 seconds, if you do not have one.\n\n",
    "Have full access to Explosive weapons.",
    100,
    GetConVar("horde_base_walkspeed"):GetInt(),
    GetConVar("horde_base_runspeed"):GetInt(),
    {
        [1] = {title = "Grenade", choices = {
            {name = "Impact Detonation", perks = {["demolition_frag_impact"] = {}}, icon="materials/perks/frag_impact.png"},
            {name = "Cluster Bombs", perks = {["demolition_frag_cluster"] = {}}, icon="materials/perks/frag_cluster.png"},
        }},
        [2] = {title = "Approach", choices = {
            {name = "Fragmentation", perks = {["demolition_fragmentation"] = {}}, icon="materials/perks/fragmentation.png"},
            {name = "Napalm", perks = {["demolition_napalm"] = {}}, icon="materials/perks/napalm.png"},
        }},
        [3] = {title = "Destruction", choices = {
            {name = "Pressurized Warhead", perks = {["demolition_pressurized_warhead"] = {}}, icon="materials/perks/pressurized_warhead.png"},
            {name = "Chain Reaction", perks = {["demolition_chain_reaction"] = {}}, icon="materials/perks/chain_reaction.png"},
        }},
    },
    4
)